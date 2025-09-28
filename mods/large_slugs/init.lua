--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It calls the rest of the mod's code.

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

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath .. "/api.lua")

dofile(modpath .. "/compat.lua")

if minetest.settings:get_bool("large_slugs_do_behavior", true) then
	dofile(modpath .. "/behavior.lua")
end

dofile(modpath .. "/slugs.lua")

dofile(modpath .. "/mapgen.lua")
