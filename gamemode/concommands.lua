function buyEntity(ply, cmd, args)
	if(args[1]!=nil)then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTrace()

		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
			if (!tr.Hit) then return end

			local entCount = ply:GetNWInt(ClassName .. "count")

			if (entCount < ent.Limit) then
				local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

				ent.Owner = ply

				ent:SetPos(SpawnPos)
				ent:Spawn()
				ent:Activate()

				ply:SetNWInt(ClassName .. "count", entCount + 1)

				return ent
			end

			return
		end
	end
end

concommand.Add("buy", buyEntity)

concommand.Add("become", setPlayerClass)
function setPlayerClass(ply, cmd, args)
	ply:SetNWInt("playerClass", tonumber(args[1]))
	ply:Spawn()
end

concommand.Add("team", function(ply, cmd, args)
	ply:SetTeam(args[1])
	ply:Spawn()
end )