AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("ui.lua")
AddCSLuaFile("perspective.lua")
AddCSLuaFile("teams.lua")

include("shared.lua")
include("teams.lua")

-- Initial spawn settings

function GM:PlayerSpawn(ply)
	ply:SetupTeam(0)
	ply:SetupHands()
	ply:SetViewOffsetDucked(Vector(0, 0, 64))
end

-- Fall damage adjustment

hook.Add( "GetFallDamage", "RealisticDamage", function( ply, speed )
    return (0)
end )

