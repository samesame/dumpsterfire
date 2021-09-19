if CLIENT then

local on = false

function togglethirdperson()
    on = not on
end

function CalcThirdperson(ply, pos, angles, fov)
    if ply:Team() == 0 then return end
    local view = {}
        view.origin = pos-(angles:Forward()*80)
        view.angles = angles
        view.fov = fov
 
    return view
end

hook.Add("CalcView", "CalcThirdperson", CalcThirdperson)
 
hook.Add("ShouldDrawLocalPlayer", "Survivor view", function(ply)
        return true
end)
end