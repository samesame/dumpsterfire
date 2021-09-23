local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
	name = "Survivors",
	health = 200,
	color = Vector(0, 0, 0.3),
	weapons = {},
--  model = "models/player/Group01/male_0" .. math.random(1,7) .. ".mdl"
	}
			
teams[1] = {
	name = "Killers",
	health = 500,
	color = Vector(0.4, 0, 0.4),
	weapons = {},
--  model = "models/player/breen.mdl"
	}

-- Global attributes

function ply:SetupTeam(n)
	if (not teams[n]) then return end

	self:SetTeam(n)
	self:SetPlayerColor(teams[n].color)
	self:SetHealth(teams[n].health)
	self:GiveWeapons(n)
--	self:SetWalkSpeed(150)
--	self:SetRunSpeed(250)
--	self:SetModel(teams[n].model)

end

-- Function to search weapon table

function ply:GiveWeapons(n)
	for k, weapon in pairs(teams[n].weapons) do
		self:Give(weapon)
	end
end

