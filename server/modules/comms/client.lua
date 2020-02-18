local user_helpers = module("server/modules/helpers/users")
local citizens = module("server/modules/citizens")

local client = {}

-- Generic "pass some data to all clients"
function client.pass_data(data, type, source)
    print("SERVER: SENDING " .. type .. " TO CLIENTS")
    TriggerClientEvent("data:" .. type, source or -1, data)
end

function client.client_event_handlers()
    -- Incoming events from client

    -- Send initialisation data
    RegisterNetEvent("send_init")
    AddEventHandler(
        "send_init",
        function()
            print("SERVER: RECEIVED REQUEST FROM CLIENT FOR INIT DATA")
            client.pass_data(state_get("users"), "users")
            client.pass_data(state_get("calls"), "calls")
            client.pass_data(state_get("units"), "units")
            client.pass_data(user_helpers.get_steam_id(source), "steam_id")
        end
    )

    -- Perform citizen search
    RegisterNetEvent("search_citizens")
    AddEventHandler(
        "search_citizens",
        function(data)
            print("SERVER: RECEIVED REQUEST FROM CLIENT TO SEND CITIZEN SEARCH")
            citizens.search_citizens(data, client.pass_data)
        end
    )

    -- Get citizen offences
    RegisterNetEvent("get_citizen_offences")
    AddEventHandler(
        "get_citizen_offences",
        function(data)
            print("SERVER: RECEIVED REQUEST FROM CLIENT TO GET CITIZEN OFFENCES")
            citizens.get_citizen_offences(data, client.pass_data)
        end
    )
end

return client
