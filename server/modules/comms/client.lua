local client = {}

-- Generic "pass some data to all clients"
function client.pass_data(data, type)
    TriggerClientEvent("data:" .. type, -1, data)
end

return client
