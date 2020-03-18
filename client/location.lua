local old_pos
Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if (old_pos ~= pos) then
            print("CLIENT: SENDING LOCATION TO SERVER")
            TriggerServerEvent('update_position', pos.x, pos.y, pos.z)
            old_pos = pos
        end
        Citizen.Wait(5000)
    end
end)