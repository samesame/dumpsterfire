concommand.Add("become", setPlayerClass)
function setPlayerClass(ply, cmd, args)
	ply:SetNWInt("playerClass", tonumber(args[1]))
	ply:Spawn()
end

concommand.Add("team", function(ply, cmd, args)
	local Team = args[1] or 1
	ply:SetTeam(Team)
	ply:Spawn()
end )