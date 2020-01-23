local user_helpers = module("server/modules/helpers/users")

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
end

return client
