-- Scoreboard Settings

local ScoreboardDerma = nil
local PlayerList = nil

function GM:ScoreboardShow()

	if!IsValid(ScoreboardDerma)then
		ScoreboardDerma = vgui.Create("DFrame")
		ScoreboardDerma:SetSize(400, 825)
		ScoreboardDerma:SetPos(30, 500)
		ScoreboardDerma:SetTitle("Survivor report")
		ScoreboardDerma:SetDraggable(false)
		ScoreboardDerma:ShowCloseButton(false)
		ScoreboardDerma.Paint = function()
			draw.RoundedBox(5, 0, 0, ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall(), Color(30, 30, 30, 230))
		end
		
		local PlayerScrollPanel = vgui.Create("DScrollPanel", ScoreboardDerma)
		PlayerScrollPanel:SetSize(ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall() - 20)
		PlayerScrollPanel:SetPos(0, 25)
		
		PlayerList = vgui.Create("DListLayout", PlayerScrollPanel)
		PlayerList:SetSize(PlayerScrollPanel:GetWide(), PlayerScrollPanel:GetTall())
		PlayerList:SetPos(0, 0)
	end
	
	if IsValid(ScoreboardDerma)then
		PlayerList:Clear()
		
		for k, v in pairs(player.GetAll())do
			local PlayerPanel = vgui.Create("DPanel", PlayerList)
			PlayerPanel:SetSize(PlayerList:GetWide(), 54)
			PlayerPanel:SetPos(0, 0)
			PlayerPanel.Paint = function()
				draw.RoundedBox(0, 0, 0, PlayerPanel:GetWide(), PlayerPanel:GetTall(), Color(50, 50, 50, 255))
				draw.RoundedBox(0, 0, 53, PlayerPanel:GetWide(), 1, Color(255, 255, 255, 255))
				
				draw.SimpleText(v:GetName(), "DermaLarge", 20, 10, color_white)
				draw.SimpleText((HealthState), "DermaLarge", 375, 10, HealthColor, TEXT_ALIGN_RIGHT)

--				draw.SimpleText("Bloodpoints: "..v:Frags(), "DermaDefault", PlayerList:GetWide() - 20, 12, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
--				draw.SimpleText("Deaths: "..v:Deaths(), "DermaDefault", PlayerList:GetWide() - 20, 27, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
				
			end
		end
		ScoreboardDerma:Show()
		ScoreboardDerma:SetKeyboardInputEnabled(true)
	end
end

function GM:ScoreboardHide()
	if IsValid(ScoreboardDerma)then
		ScoreboardDerma:Hide()
	end
end

-- HUD Settings

function HUD()
	local client = LocalPlayer()
	
	if !client:Alive() then
		return
	end
	if client:Health() > 300 then
		HealthState = "the Killer"
		HealthColor = Color(255, 90, 255, 255)
	elseif client:Health() > 150 then
		HealthState = "Healthy"
		HealthColor = Color(0, 255, 0, 255)
	elseif client:Health() > 100 then
		HealthState = "Injured"
		HealthColor = Color(255, 165, 0, 255)
	elseif client:Health() > 50 then
		HealthState = "Downed"
		HealthColor = Color(255, 0, 0, 255)
	elseif client:Health() > 0 then
		HealthState = "Dead"
		HealthColor = Color(90, 90, 90, 255)
	end
	
	draw.RoundedBox(5, 30, ScrH() - 105, 400, 75, Color(30, 30, 30, 230))
	draw.SimpleText("You are ", "DermaLarge", 50, ScrH() - 83, Color(255, 255, 255, 255), 0, 0)
	draw.SimpleText(HealthState, "DermaLarge", 148, ScrH() - 83, (HealthColor), 0, 0)

	draw.RoundedBox(0, 280, ScrH() - 85, 130 * 1, 35, Color(0, 0, 255, 30))
	draw.RoundedBox(0, 280, ScrH() - 85, math.Clamp(client:Armor(), 0, 100) * 1.29, 35, Color(0, 0, 255, 255))
	draw.RoundedBox(0, 280, ScrH() - 85, math.Clamp(client:Armor(), 0, 100) * 1.29, 5, Color(120, 120, 255, 255))

end
hook.Add("HUDPaint", "TestHud", HUD)

function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudCrosshair", "CHudZoom"}) do
		if name == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)