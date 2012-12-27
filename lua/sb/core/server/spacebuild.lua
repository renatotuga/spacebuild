--[[
Copyright (C) 2012-2013 Spacebuild Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 ]]

local sb = sb
local timer = timer
local core = sb.core;
local time_to_next_sync = 1

local time = 0;
local function sendData()
    time = CurTime();
    for _, ply in pairs(player.GetAll()) do
        if not ply.lastrdupdate or ply.lastrdupdate + time_to_next_sync < time then
            if ply.ls_suit then
                ply.ls_suit:send(ply.lastrdupdate or 0)
            end
            for k, v in pairs(core.device_table) do
                v:send(ply.lastrdupdate or 0, ply)
            end
            ply.lastrdupdate = time
        end
    end
end
hook.Add( "Think", "spacebuild_think", sendData )

local function spawn( ply )
    if not ply.ls_suit then
       ply.ls_suit = core.class.create("PlayerSuit", ply)
    end
    ply.ls_suit:reset()
end
hook.Add( "PlayerSpawn", "spacebuild_spawn", spawn )





-- Spacebuild

local environment_data = {}
local environment_classes = { "env_sun", "logic_case" }

local function getKey(key)
    if key == "Case01" then
        return 1
    elseif key == "Case02" then
        return 2
    elseif key == "Case03" then
        return 3
    elseif key == "Case04" then
        return 4
    elseif key == "Case05" then
        return 5
    elseif key == "Case06" then
        return 6
    elseif key == "Case07" then
        return 7
    elseif key == "Case08" then
        return 8
    elseif key == "Case09" then
        return 9
    elseif key == "Case10" then
        return 10
    elseif key == "Case11" then
        return 11
    elseif key == "Case12" then
        return 12
    elseif key == "Case13" then
        return 13
    elseif key == "Case14" then
        return 14
    elseif key == "Case15" then
        return 15
    elseif key == "Case16" then
        return 16
    else
        return key
    end
end

local function Register_Environments_Data()
    MsgN("Registering environment info")
    --Load the planets/stars/bloom/color/... data. The actual creation of the environments will be handled by the "engine"
    local entities;
    local data
    local values
    for k, v in pairs(environment_classes) do
        entities = ents.FindByClass(v)
        for _, ent in ipairs(entities) do
            data = {}
            data["_environment_class"] = v;
            values = ent:GetKeyValues()
            for key, value in pairs(values) do
                data[getKey(key)] = value
            end
            table.insert(environment_data, data)
        end
    end
    PrintTable(environment_data)
end

hook.Add("InitPostEntity", "sb4_load_data", Register_Environments_Data)