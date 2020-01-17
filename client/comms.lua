-- Blindly receive data and pass it to NUI

function pass_to_nui(data, object)
    SendNUIMessage(
        {
            object = object,
            data = data
        }
    )
end

RegisterNetEvent("data:units")
AddEventHandler(
    "data:units",
    function(jsonData)
        pass_to_nui(jsonData, "units")
    end
)

RegisterNetEvent("data:calls")
AddEventHandler(
    "data:calls",
    function(jsonData)
        pass_to_nui(jsonData, "calls")
    end
)
