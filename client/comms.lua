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

RegisterNetEvent("data:config")
AddEventHandler(
    "data:config",
    function(jsonData)
        print("CLIENT: RECEIVED CONFIG FROM SERVER")
        pass_to_nui(jsonData, "config")
    end
)

RegisterNetEvent("data:units")
AddEventHandler(
    "data:units",
    function(jsonData)
        print("CLIENT: RECEIVED UNITS FROM SERVER")
        pass_to_nui(jsonData, "units")
    end
)

RegisterNetEvent("data:unit_states")
AddEventHandler(
    "data:unit_states",
    function(jsonData)
        print("CLIENT: RECEIVED UNIT STATES FROM SERVER")
        pass_to_nui(jsonData, "unit_states")
    end
)

RegisterNetEvent("data:citizen_markers")
AddEventHandler(
    "data:citizen_markers",
    function(jsonData)
        print("CLIENT: RECEIVED CITIZEN MARKERS FROM SERVER")
        pass_to_nui(jsonData, "citizen_markers")
    end
)

RegisterNetEvent("data:vehicle_markers")
AddEventHandler(
    "data:vehicle_markers",
    function(jsonData)
        print("CLIENT: RECEIVED VEHICLE FROM SERVER")
        pass_to_nui(jsonData, "vehicle_markers")
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

RegisterNetEvent("data:user_units")
AddEventHandler(
    "data:user_units",
    function(jsonData)
        print("CLIENT: RECEIVED USER_UNITS FROM SERVER")
        pass_to_nui(jsonData, "user_units")
    end
)

RegisterNetEvent("data:user_ranks")
AddEventHandler(
    "data:user_ranks",
    function(jsonData)
        print("CLIENT: RECEIVED USER_RANKS FROM SERVER")
        pass_to_nui(jsonData, "user_ranks")
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
