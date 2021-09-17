local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
	name = "Survivors",
	color = Vector(0, 0, 0.3),
	weapons = {} }
teams[1] = {
	name = "Killers",
	color = Vector(0.4, 0, 0.4),
	weapons = {"weapon_crowbar", "weapon_physcannon"} }

-- Global attributes

function ply:SetupTeam(n)
	if (not teams[n]) then return end

	self:SetTeam(n)
	self:SetPlayerColor(teams[n].color)
	self:SetHealth(200)
	self:SetWalkSpeed(150)
	self:SetRunSpeed(250)
	self:SetModel("models/player/Group01/male_0" .. math.random(1,7) .. ".mdl")
	self:GiveWeapons(n)

end

-- Weapons

function ply:GiveWeapons(n)
	for k, weapon in pairs(teams[n].weapons) do
		self:Give(weapon)
	end
end
