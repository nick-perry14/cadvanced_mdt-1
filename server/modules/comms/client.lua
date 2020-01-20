local client = {}

-- Generic "pass some data to all clients"
function client.pass_data(data, type)
    print("SERVER: SENDING " .. type .. " TO CLIENTS")
    TriggerClientEvent("data:" .. type, -1, data)
end

function client.client_event_handlers()
    -- Incoming events from client

    -- Send initialisation data
    RegisterNetEvent("send_init")
    AddEventHandler(
        "send_init",
        function()
        end
    )
end

return client
