--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It implements slug behavior.

   large_slugs is free software: you can redistribute it and/or modify it
   under the terms of the GNU Lesser General Public License as published
   by the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   large_slugs is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with large_slugs. If not, see <https://www.gnu.org/licenses/>.
]]

local UPDATE_INTERVAL =
	tonumber(minetest.settings:get("large_slugs_update_interval")) or 5
local UPDATE_CHANCE =
	tonumber(minetest.settings:get("large_slugs_update_chance")) or 5
local BIRTH_CHANCE =
	tonumber(minetest.settings:get("large_slugs_birth_chance")) or 6
local DEATH_CHANCE =
	tonumber(minetest.settings:get("large_slugs_death_chance")) or 6
local UNDERPOPULATION =
	tonumber(minetest.settings:get("large_slugs_underpopulation")) or 1
local OVERPOPULATION =
	tonumber(minetest.settings:get("large_slugs_overpopulation")) or 3
local CHECK_RADIUS =
	tonumber(minetest.settings:get("large_slugs_check_radius")) or 5

-- Keep the ground nodes as a set for each kind of slug.
local slug_grounds = {}
minetest.after(0, function()
	-- Fill sets after all mods are finished loading.
	for name, def in pairs(large_slugs.registered_slugs) do
		local ground = {}
		for _, nodename in ipairs(def.ground) do
			local nodedef = minetest.registered_nodes[nodename]
			if nodedef then ground[nodedef.name] = true end
		end
		slug_grounds[name] = ground
	end
end)

-- With the given vectors, computes a = b + c.
local function set_add(a, b, c)
	a.x = b.x + c.x
	a.y = b.y + c.y
	a.z = b.z + c.z
end

-- A map of wallmounted directions to their perpendicular directions.
local WALLMOUNT_TO_PERPS = {}
WALLMOUNT_TO_PERPS[0] = {4, 2, 5, 3}
WALLMOUNT_TO_PERPS[2] = {4, 0, 5, 1}
WALLMOUNT_TO_PERPS[4] = {2, 0, 3, 1}
WALLMOUNT_TO_PERPS[1] = WALLMOUNT_TO_PERPS[0]
WALLMOUNT_TO_PERPS[3] = WALLMOUNT_TO_PERPS[2]
WALLMOUNT_TO_PERPS[5] = WALLMOUNT_TO_PERPS[4]

-- A map of wallmounted directions to their opposites.
local WALLMOUNT_TO_OPP = {[0] = 1, 0, 3, 2, 5, 4}

-- All possible direction check orders from which to choose randomly.
local CHECK_ORDERS = {
	{1, 2, 3, 4}, {1, 2, 4, 3}, {1, 3, 2, 4}, {1, 3, 4, 2},
	{1, 4, 2, 3}, {1, 4, 3, 2}, {2, 1, 3, 4}, {2, 1, 4, 3},
	{2, 3, 1, 4}, {2, 3, 4, 1}, {2, 4, 1, 3}, {2, 4, 3, 1},
	{3, 1, 2, 4}, {3, 1, 4, 2}, {3, 2, 1, 4}, {3, 2, 4, 1},
	{3, 4, 1, 2}, {3, 4, 2, 1}, {4, 1, 2, 3}, {4, 1, 3, 2},
	{4, 2, 1, 3}, {4, 2, 3, 1}, {4, 3, 1, 2}, {4, 3, 2, 1},
}

-- Update a slug, having it randomly try to move, give birth, or die.
local function update_slug(pos)
	local node = minetest.get_node(pos)
	local ground = slug_grounds[node.name]
	if not ground then return end

	local try_death = math.random(DEATH_CHANCE) == 1
	local try_birth = math.random(BIRTH_CHANCE) == 1
	local area_count = (try_death or try_birth) and
		#minetest.find_nodes_in_area(
			vector.subtract(pos, CHECK_RADIUS),
			vector.add(pos, CHECK_RADIUS), node.name)

	if try_death and area_count >= OVERPOPULATION then
		minetest.remove_node(pos)
		return
	end

	local old_wallmount = node.param2
	local old_dir = minetest.wallmounted_to_dir(old_wallmount)
	if not old_dir then return end

	-- Used in multiple places.
	local check_pos = vector.new(0, 0, 0)

	-- Check that the slug can move on its current surface:
	set_add(check_pos, pos, old_dir)
	if not ground[minetest.get_node(check_pos).name] then return end

	-- Determine whether this action is a move or a birth:
	local move = not try_birth or area_count > UNDERPOPULATION

	-- Decide how to move, checking directions in a random order:
	local perp_wallmounts = WALLMOUNT_TO_PERPS[old_wallmount]
	for _, i in ipairs(CHECK_ORDERS[math.random(#CHECK_ORDERS)]) do
		local perp_wallmount = perp_wallmounts[i]
		local perp_dir = minetest.wallmounted_to_dir(perp_wallmount)
		set_add(check_pos, pos, perp_dir)
		local adj_nodename = minetest.get_node(check_pos).name
		if move and ground[adj_nodename] then
			-- Move to new face around the old slug position:
			node.param2 = perp_wallmount
			minetest.swap_node(pos, node)
			break
		elseif adj_nodename == "air" then
			set_add(check_pos, check_pos, old_dir)
			local diag_nodename = minetest.get_node(check_pos).name
			if ground[diag_nodename] then
				-- Move to a new position on the flat surface:
				if move then minetest.remove_node(pos) end
				set_add(pos, pos, perp_dir)
				minetest.set_node(pos, node)
				break
			elseif diag_nodename == "air" then
				-- Move to a new face of the ground node:
				if move then minetest.remove_node(pos) end
				node.param2 = WALLMOUNT_TO_OPP[perp_wallmount]
				minetest.set_node(check_pos, node)
				break
			end
		end
	end
end

-- Maximum number of seconds a slug update can be delayed.
local MAX_DELAY = math.max(0, math.floor(UPDATE_INTERVAL) - 1)

minetest.register_abm({
	label = "Scheduling slug updates",
	nodenames = "group:large_slug",
	interval = UPDATE_INTERVAL,
	chance = UPDATE_CHANCE,
	catch_up = false,
	action = function(pos)
		minetest.after(math.random(0, MAX_DELAY), update_slug, pos)
	end,
})
