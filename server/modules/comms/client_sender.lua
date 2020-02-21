local client_sender = {}

-- Generic "pass some data to all clients"
function client_sender.pass_data(data, type, source)
    if (source) then
        print("SERVER: SENDING " .. type .. " TO CLIENT " .. source)
    else
        print("SERVER: SENDING " .. type .. " TO ALL CLIENTS")
    end
    TriggerClientEvent("data:" .. type, source or -1, data)
end

return client_sender
