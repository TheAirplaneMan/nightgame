--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It registers slugs with the mapgen.

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

minetest.register_decoration({
	name = "large_slugs:grass_slug",
	deco_type = "simple",
	place_on = {"large_slugs:dirt_grass"},
	fill_ratio = 0.005,
	y_max = 200,
	y_min = 0,
	decoration = "large_slugs:grass_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:pine_slug",
	deco_type = "simple",
	place_on = {"large_slugs:dirt_pine"},
	fill_ratio = 0.005,
	y_max = 250,
	y_min = 0,
	decoration = "large_slugs:pine_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:rainforest_slug",
	deco_type = "simple",
	place_on = {"large_slugs:dirt_rainforest"},
	fill_ratio = 0.01,
	y_max = 200,
	y_min = 0,
	decoration = "large_slugs:rainforest_slug",
	param2 = 1,
})

if minetest.registered_nodes["large_slugs:stone_coal"] then
	minetest.register_decoration({
		name = "large_slugs:cave_slug",
		deco_type = "simple",
		place_on = {"large_slugs:stone"},
		fill_ratio = 0.01,
		flags = "all_floors",
		y_max = -32,
		y_min = -31000,
		decoration = "large_slugs:cave_slug",
		param2 = 1,
	})
end

if minetest.registered_nodes["large_slugs:stone_iron"] then
	minetest.register_decoration({
		name = "large_slugs:iron_slug",
		deco_type = "simple",
		place_on = {"large_slugs:stone"},
		fill_ratio = 0.005,
		flags = "all_floors",
		y_max = -128,
		y_min = -31000,
		decoration = "large_slugs:iron_slug",
		param2 = 1,
	})
end

if minetest.registered_nodes["large_slugs:stone_mese"] then
	minetest.register_decoration({
		name = "large_slugs:mese_slug",
		deco_type = "simple",
		place_on = {"large_slugs:stone"},
		fill_ratio = 0.001,
		flags = "all_floors",
		y_max = -512,
		y_min = -31000,
		decoration = "large_slugs:mese_slug",
		param2 = 1,
	})
end
