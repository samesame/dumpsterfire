if SERVER then

	util.AddNetWorkString("F1_Menu")

	function F1Menu(ply)
		net.Start("F1_Menu")
			--empty message
		net.Send(ply)
	end
	hook.Add("ShowHelp", "Open the F1 Menu...", F1Menu)

elseif CLIENT then

	function openF1Menu()
		local f = vgui.Create("DFrame")
		f:SetSize(256+64, 256+64)
		f:SetTitle("F1 Menu")
		f:SetVisible(true)
		f:SetDraggable(true)
		

	net.Receive("F1_Menu", function(len)
		OpenF1Menu()
	end

end