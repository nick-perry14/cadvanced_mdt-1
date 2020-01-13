local api = {}

function api.request(query, callback)

    -- load config
    local cfg = require "../config.lua"
    
    PerformHttpRequest(
        url .. '/api',
        function (errorCode, resultData, resultHeaders)
            if errorCode ~= 200 then
                print('CADvanced: ERROR - Unable to perform query '
                    .. query .. ', error ' .. errorCode)
                callback({ error = errorCode })
            end
            callback({ result = json.decode(resultData) })
        end,
        'POST',
        query,
        { ["Content-Type"] = 'application/json' }
    )
end

return api
