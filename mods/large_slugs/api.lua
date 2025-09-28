--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It implements the public/private API.

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

large_slugs = {}

large_slugs.registered_slugs = {}

function large_slugs.register_slug(name, def)
	minetest.register_node(name, {
		description = def.description,
		drawtype = "signlike",
		tiles = {def.texture},
		visual_scale = 0.5,
		inventory_image = def.texture,
		wield_image = def.texture,
		selection_box = {
			type = "wallmounted",
			wall_top = {-8/16, 8/16, -8/16, 8/16, 7/16, 8/16},
			wall_bottom = {-8/16, -8/16, -8/16, 8/16, -7/16, 8/16},
			wall_side = {-8/16, -8/16, -8/16, -7/16, 8/16, 8/16},
		},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		groups = {large_slug = 1, dig_immediate = 3, attached_node = 1},
		walkable = false,
		buildable_to = true,
		floodable = true,
	})
	large_slugs.registered_slugs[name] = def
end
