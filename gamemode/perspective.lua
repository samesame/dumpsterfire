if CLIENT then

local on = false

function togglethirdperson()
    on = not on
end

function CalcThirdperson(ply, pos, angles, fov)
    if ply:Team() == 1 then return end

    local view = {}
        view.origin = pos-(angles:Forward()*80)
        view.angles = angles
        view.fov = fov
 
    return view
end

    --for k, y in pairs(player:GetAll()) do
    --y:SetViewOffset(Vector(0, 300, 0)) -- First val = X, 2nd = Y, third = Z???
    --end


hook.Add("CalcView", "CalcThirdperson", CalcThirdperson)
 
hook.Add("ShouldDrawLocalPlayer", "Survivor view", function(ply)
        if ply:Team() == 1 then return end
        return true
end)
end