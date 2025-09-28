--[[
   Copyright (C) 2022  Jude Melton-Houghton

   This file is part of large_slugs. It provides stuff for compatibility.

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

if minetest.get_modpath("default") then
	-- Minetest Game (or similar)

	minetest.register_alias("large_slugs:dirt", "default:dirt")
	minetest.register_alias("large_slugs:dirt_grass",
		"default:dirt_with_grass")
	minetest.register_alias("large_slugs:dirt_pine",
		"default:dirt_with_coniferous_litter")
	minetest.register_alias("large_slugs:dirt_rainforest",
		"default:dirt_with_rainforest_litter")
	minetest.register_alias("large_slugs:tree_pine", "default:pine_tree")
	minetest.register_alias("large_slugs:tree_rainforest",
		"default:jungletree")
	minetest.register_alias("large_slugs:cobble", "default:cobble")
	minetest.register_alias("large_slugs:cobble_moss",
		"default:mossycobble")
	minetest.register_alias("large_slugs:stone", "default:stone")
	minetest.register_alias("large_slugs:stone_coal",
		"default:stone_with_coal")
	minetest.register_alias("large_slugs:stone_iron",
		"default:stone_with_iron")
	minetest.register_alias("large_slugs:stone_mese",
		"default:stone_with_mese")
	minetest.register_alias("large_slugs:mese", "default:mese")

	minetest.register_alias("large_slugs:piece_coal", "default:coal_lump")
	minetest.register_alias("large_slugs:piece_iron", "default:iron_lump")
	minetest.register_alias("large_slugs:piece_mese",
		"default:mese_crystal_fragment")
else
	-- Zero modpack

	if minetest.get_modpath("zr_dirt") then
		minetest.register_alias("large_slugs:dirt", "zr_dirt:dirt")
		minetest.register_alias("large_slugs:dirt_grass",
			"zr_dirt:grass")
		minetest.register_alias("large_slugs:dirt_pine",
			"zr_dirt:dry_litter")
		minetest.register_alias("large_slugs:dirt_rainforest",
			"zr_dirt:litter")
	end
	if minetest.get_modpath("zr_pine") then
		minetest.register_alias("large_slugs:tree_pine", "zr_pine:tree")
	end
	if minetest.get_modpath("zr_jungle") then
		minetest.register_alias("large_slugs:tree_rainforest",
			"zr_jungle:tree")
	end
	if minetest.get_modpath("zr_stone") then
		minetest.register_alias("large_slugs:cobble", "zr_stone:cobble")
		minetest.register_alias("large_slugs:cobble_moss",
			"zr_stone:mossycobble")
		minetest.register_alias("large_slugs:stone", "zr_stone:stone")
	end
	if minetest.get_modpath("zr_coal") then
		minetest.register_alias("large_slugs:stone_coal", "zr_coal:ore")
	end
	if minetest.get_modpath("zr_iron") then
		minetest.register_alias("large_slugs:stone_iron", "zr_iron:ore")
	end
	if minetest.get_modpath("zr_mese") then
		minetest.register_alias("large_slugs:stone_mese", "zr_mese:ore")
		minetest.register_alias("large_slugs:mese", "zr_mese:block")
	end

	if minetest.get_modpath("zr_coal") then
		minetest.register_alias("large_slugs:piece_coal",
			"zr_coal:lump")
	end
	if minetest.get_modpath("zr_iron") then
		minetest.register_alias("large_slugs:piece_iron",
			"zr_iron:lump")
	end
	if minetest.get_modpath("zr_mese") then
		minetest.register_alias("large_slugs:piece_mese",
			"zr_mese:crystal_fragment")
	end
end
