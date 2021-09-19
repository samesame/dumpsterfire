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
	ply:SetupTeam(0)
	local plyClass = PLAYER_KILLERS[ply:GetNWInt("playerClass")]

	ply:SetWalkSpeed(plyClass.walkspeed)
	ply:SetRunSpeed(plyClass.runspeed)
	ply:SetModelScale(plyClass.modelscale, 0)
	ply:SetModel("models/player/Group01/male_0" .. math.random(1,7) .. ".mdl")

	ply:StripWeapons()

	hook.Call("PlayerLoadout", GAMEMODE, ply)
	hook.Call("PlayerSetModel", GAMEMODE, ply)
end

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

	if (ply:GetPData("playerSwins") == nil) then
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

--[[

local ply = FindMetaTable("Player")
local sprinting = ply:IsSprinting()

	if IsValid(Player:IsSprinting())then
		trail = util.SpriteTrail(ply, 0, Color(255, 0, 0, 60), false, 20, 0, 10, 1/(100)*0.5, "effects/arrowtrail_red")
	elseif
		SafeRemoveEntity(trail)
	end
end

function GM:PlayerDeath(ply)
	SafeRemoveEntity(trail)
end 

--]]

-- Fall damage adjustment

hook.Add( "GetFallDamage", "RealisticDamage", function( ply, speed )
    return (0)
end )

function GM:GravGunPunt(player, entity)
	return false
end

-- Player events

function GM:OnNPCKilled(npc, attacker, inflictor)
	inflictor:SetArmor(inflictor:Armor() + 1)
	attacker:SetNWInt("playerPoints", attacker:GetNWInt("playermoney") + 100)
end

function GM:PlayerDeath(victim, inflictor, attacker)
	inflictor:SetArmor(inflictor:Armor() + 1)
	attacker:SetNWInt("playerPoints", attacker:GetNWInt("playermoney") + 100)

end