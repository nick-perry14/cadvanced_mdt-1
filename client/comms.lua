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

RegisterNetEvent("data:steam_id")
AddEventHandler(
    "data:steam_id",
    function(jsonData)
        print("CLIENT: RECEIVED STEAM ID FROM SERVER")
        pass_to_nui(jsonData, "steam_id")
    end
)

RegisterNetEvent("data:search_results")
AddEventHandler(
    "data:search_results",
    function(jsonData)
        print("CLIENT: RECEIVED SEARCH RESULTS FROM SERVER")
        pass_to_nui(jsonData, "search_results")
    end
)

RegisterNetEvent("data:citizen_offences")
AddEventHandler(
    "data:citizen_offences",
    function(jsonData)
        print("CLIENT: RECEIVED CITIZEN OFFENCES FROM SERVER")
        pass_to_nui(jsonData, "citizen_offences")
    end
)
