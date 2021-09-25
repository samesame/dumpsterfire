AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("ui.lua")
AddCSLuaFile("perspective.lua")
AddCSLuaFile("teams.lua")
AddCSLuaFile("menu.lua")
AddCSLuaFile("config/killers.lua")

include("shared.lua")
include("teams.lua")
include("config/killers.lua")
include("concommands.lua")

local open = false

-- Initial spawn settings

function GM:PlayerInitialSpawn(ply)

	local plyClass = PLAYER_KILLERS[ply:GetNWInt("playerClass")]
	ply:SetupTeam(1)

	ply:SetNWInt("playerClass", 1)

	if (ply:GetPData("playerKwins") == nil) then
		ply:SetNWInt("playerKwins", 1)
	else
		ply:SetNWInt("playerKwins", tonumber(ply:GetPData("playerKwins")))
	end
	
	if (ply:GetPData("playerSwins") == nil) then
		ply:SetNWInt("playerSwins", 0)
	else
		ply:SetNWInt("playerSwins", tonumber(ply:GetPData("playerSwins")))
	end
	
	if (ply:GetPData("playerBPoints") == nil) then
		ply:SetNWInt("playerBPoints", 0)
	end
end

function GM:PlayerSpawn(ply)

	local plyClass = PLAYER_KILLERS[ply:GetNWInt("playerClass")]

	ply:SetWalkSpeed(plyClass.walkspeed)
	ply:SetRunSpeed(plyClass.runspeed)
	ply:SetModelScale(plyClass.modelscale, 0)
	ply:StripWeapons()
	hook.Call("PlayerLoadout", GAMEMODE, ply)
	hook.Call("PlayerSetModel", GAMEMODE, ply)

end

--hook.Add ("StartCommand", "StartCommandExample", function(ply, cmd)
--	if (!ply:IsSprinting() then return 
--
--	else trail = util.SpriteTrail(ply, 0, Color(100, 0, 0, 200), false, 10, 10, 10, 1/(20)*0.5, "effects/arrowtrail_red.vmt")
--
--	end)

local teamsToApply = { -- This should be done in some kind of config file
    "Killers",
    "Survivors", 
    "1"
}

hook.Add("Move", "Trails.ApplyMove", function(ply, mv) -- Move hook, everytime when player moves

    if not IsValid(ply.TeamTrail) and ply:IsSprinting() and table.HasValue(teamsToApply, tostring(ply:Team())) then -- When player is sprinting and the variable teamsToApply contains the players team

        ply.TeamTrail = util.SpriteTrail(ply, 0, Color(100, 0, 0, 200), false, 10, 10, 10, 1/(20)*0.5, "trails/plasma") -- Apply trail and save it to player, so it doesnt get created 1000 times

    elseif IsValid(ply.TeamTrail) then -- If the trail is active and the player is not sprinting, then remove it

        ply.TeamTrail:Remove() -- Remove the saved trail

    end
end)


function GM:PlayerLoadout(ply)
	local plyClass = PLAYER_KILLERS[ply:GetNWInt("playerClass")]

	for k, v in pairs(plyClass.weapons) do
		ply:Give(v)
	end

	return true
end

function GM:PlayerSetModel(ply)
	local plyClass = PLAYER_KILLERS[ply:GetNWInt("playerClass")]

	ply:SetModel(plyClass.model)
	ply:SetupHands()
	ply:SetViewOffsetDucked(Vector(0, 0, 64))
end

--[[ Stat recording

	if (ply:GetPData("playerKwins") == nil) then
		ply:SetNWInt("playerKwins, 1")
	else
		ply:SetNWInt("playerKwins", ply:GetPData("playerKwins"))
	end	

		ply:SetNWInt("playerSwins, 1")
	else
		ply:SetNWInt("playerSwins", ply:GetPData("playerSwins"))
	end

	if (ply:GetPData("playerBPoints") == nil) then
		ply:SetNWInt("playerBPoints, 1")
	else
		ply:SetNWInt("playerBPoints", ply:GetPData("playerBPoints"))
	end

--]]

function GM:PlayerDisconnected(ply)
	ply:SetPData("playerKwins", ply:GetNWInt("playerKwins"))
	ply:SetPData("playerSwins", ply:GetNWInt("playerSwins"))
	ply:SetPData("playerBPoints", ply:GetNWInt("playerBPoints"))
end

function GM:ShutDown()
	for k, v in pairs(player.GetAll()) do
	v:SetPData("playerKwins", v:GetNWInt("playerKwins"))
	v:SetPData("playerSwins", v:GetNWInt("playerSwins"))
	v:SetPData("playerBPoints", v:GetNWInt("playerBPoints"))
	end
end

-- F4 Menu network implementation

util.AddNetworkString("FMenu")

function GM:ShowSpare2(ply)
	if (open == false) then
		open = true
	else
		open = false
	end

	net.Start("FMenu")
		net.WriteBit(open)
	net.Broadcast()
end

function GM:PlayerDeath(ply)
	SafeRemoveEntity(trail)
end 

-- Fall damage adjustment

hook.Add( "GetFallDamage", "RealisticDamage", function( ply, speed )
    return (0)
end )

function GM:GravGunPunt(player, entity)
	return false
end

-- Player events

function GM:OnNPCKilled(npc, attacker, inflictor)
	inflictor:SetArmor(inflictor:Armor() + 10)
	attacker:SetNWInt("playerPoints", attacker:GetNWInt("playermoney") + 100)
end

function GM:PlayerDeath(victim, inflictor, attacker)
	inflictor:SetArmor(inflictor:Armor() + 10)
	attacker:SetNWInt("playerPoints", attacker:GetNWInt("playermoney") + 100)

end