local Menu

net.Receive("FMenu", function()
	if (Menu == nil) then
		Menu = vgui.Create("DFrame")
		Menu:SetSize(500, 910)
		Menu:SetPos(440, 500)
		Menu:SetTitle("Character preferences")
		Menu:SetDraggable(false)
		Menu:ShowCloseButton(false)
		Menu:SetDeleteOnClose(false)
		Menu.Paint = function()
			draw.RoundedBox(5, 0, 0, Menu:GetWide(), Menu:GetTall(), Color(30, 30, 30, 230))
		end
	end

	addButtons(Menu)

	if (net.ReadBit() == 0) then
		Menu:Hide()
		gui.EnableScreenClicker(false)
	else 
		Menu:Show()
		gui.EnableScreenClicker(true)
	end
end)

function addButtons(Menu)

	local CharButton = vgui.Create("DButton")
	CharButton:SetParent(Menu)
	CharButton:SetText("")
	CharButton:SetSize(132, 50)
	CharButton:SetPos(13, 845)
	CharButton.Paint = function()
		-- Button color
		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawRect(0, 0, CharButton:GetWide(), 1)
		-- Button border
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0, 49, CharButton:GetWide(), CharButton:GetTall()) -- Top/bottom borders
		surface.DrawRect(131, 0, 1, CharButton:GetTall()) -- Right border
		surface.DrawRect(0, 0, 1, CharButton:GetTall()) -- Left border
		-- Button Text
		draw.DrawText("Characters", "DermaDefaultBold", CharButton:GetWide()/2, 17, Color(255, 255, 255, 255), 1)
	end
	CharButton.DoClick = function(CharButton)
		local CharPanel = Menu:Add("CharPanel")
	end

	local ShopButton = vgui.Create("DButton")
	ShopButton:SetParent(Menu)
	ShopButton:SetText("")
	ShopButton:SetSize(200, 50)
	ShopButton:SetPos(150, 845)
	ShopButton.Paint = function()
		-- Button color
		surface.SetDrawColor(255, 204, 0, 40)
		surface.DrawRect(0, 0, ShopButton:GetWide(), 1)
		-- Button border
		surface.SetDrawColor(255, 204, 0, 40)
		surface.DrawRect(0, 49, ShopButton:GetWide(), ShopButton:GetTall()) -- Top/bottom borders
		surface.DrawRect(199, 0, 1, ShopButton:GetTall()) -- Right border
		surface.DrawRect(0, 0, 1, ShopButton:GetTall()) -- Left border
		-- Button Text
		draw.DrawText("Points shop", "DermaDefaultBold", ShopButton:GetWide()/2, 17, Color(255, 255, 255, 255), 1)
	end
	ShopButton.DoClick = function(ShopButton)
		local ShopPanel = Menu:Add("ShopPanel")
	end

	local CreditsButton = vgui.Create("DButton")
	CreditsButton:SetParent(Menu)
	CreditsButton:SetText("")
	CreditsButton:SetSize(132, 50)
	CreditsButton:SetPos(355, 845)
	CreditsButton.Paint = function()
		-- Button color
		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawRect(0, 0, CreditsButton:GetWide(), 1)
		-- Button border
		surface.SetDrawColor(40, 40, 40, 255)
		surface.DrawRect(0, 49, CreditsButton:GetWide(), CreditsButton:GetTall()) -- Top/bottom borders
		surface.DrawRect(131, 0, 1, CreditsButton:GetTall()) -- Right border
		surface.DrawRect(0, 0, 1, CreditsButton:GetTall()) -- Left border
		-- Button Text
		draw.DrawText("Credits", "DermaDefaultBold", CreditsButton:GetWide()/2, 17, Color(255, 255, 255, 255), 1)
	end
	CreditsButton.DoClick = function(CreditsButton)
		local CreditsPanel = Menu:Add("CreditsPanel")
	end

end

-- Characters panel

PANEL = {}

function PANEL:Init()
	self:SetSize(500, 805)
	self:SetPos(0, 25)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100, 255))
	draw.DrawText("The killer is chosen at random each round\nChoose which killer you would like to play when chosen:", "DermaDefault", 10, 10, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
		draw.RoundedBox(5, 10, 50, 75, 75, Color(70, 70, 70, 255))
		draw.RoundedBox(5, 95, 50, 75, 75, Color(70, 70, 70, 255))
		draw.RoundedBox(5, 180, 50, 75, 75, Color(70, 70, 70, 255))
	draw.DrawText("You can pick the survivor skin you would like to use\nNote that this will not affect gameplay.", "DermaDefault", 10, 300, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT)
		draw.RoundedBox(5, 10, 50, 75, 75, Color(70, 70, 70, 255))
end

vgui.Register("CharPanel", PANEL, "Panel")

-- Shop panel

PANEL = {}

function PANEL:Init()
	self:SetSize(500, 805)
	self:SetPos(0, 25)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(40, 40, 40, 255))

	draw.RoundedBox(0, 0, 300, 300, Color(255, 255, 255))
	draw.SimpleText("Bloodpoints: " .."CURPOINTS", "DermaDefaultBold", 10, 10, Color(200, 200, 200), 0)

	draw.RoundedBox(0, 0, 300, 300, Color(50, 50, 50))
	draw.SimpleText("$" .. client:GetNWInt("playerPoints"), "DermaDefaultBold", 250, 250, Color(100, 100, 100), 0)

end

vgui.Register("ShopPanel", PANEL, "Panel")

-- Credits panel

PANEL = {}

function PANEL:Init()
	self:SetSize(500, 805)
	self:SetPos(0, 25)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 255))
	draw.DrawText("Code\n \n \n \n \n \nDesign\n \n \n \n \n \nMusic\n \n \n \n \n \nMapping\n \n \n \n \n \nSpecial thanks", "CloseCaption_Bold", 250, 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
	draw.DrawText("\n \nsamdav, bunub\n \n \n \n \n \nsamdav, CoffeeWaffee\n \n  \n \n \n \nCoffeeWaffee\n \n \n \n \n \nsamdav, Pandaaaaa\n \n \n \n \n \nBadall", "CloseCaption_Normal", 250, 50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
end

vgui.Register("CreditsPanel", PANEL, "Panel") 