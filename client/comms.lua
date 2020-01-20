-- Blindly receive data and pass it to NUI
function pass_to_nui(data, object)
    print("CLIENT: SENDING " .. object .. " TO NUI")
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
        print("CLIENT: RECEIVED UNITS FROM SERVER")
        pass_to_nui(jsonData, "units")
    end
)

RegisterNetEvent("data:calls")
AddEventHandler(
    "data:calls",
    function(jsonData)
        print("CLIENT: RECEIVED CALLS FROM SERVER")
        pass_to_nui(jsonData, "calls")
    end
)

RegisterNetEvent("data:users")
AddEventHandler(
    "data:users",
    function(jsonData)
        print("CLIENT: RECEIVED USERS FROM SERVER")
        pass_to_nui(jsonData, "users")
    end
)
