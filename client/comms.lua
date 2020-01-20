-- Blindly receive data and pass it to NUI

function pass_to_nui(data, object)
    print('SENDING ' .. object .. ' TO NUI')
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
        print('RECEIVED UNITS FROM SERVER')
        pass_to_nui(jsonData, "units")
    end
)

RegisterNetEvent("data:calls")
AddEventHandler(
    "data:calls",
    function(jsonData)
        print('RECEIVED CALLS FROM SERVER')
        pass_to_nui(jsonData, "calls")
    end
)
