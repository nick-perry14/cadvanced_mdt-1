local api = {}

function api.request(query, callback)
    local conf = module("server/modules/config")
    PerformHttpRequest(
        conf.val("cad_url") .. "/api",
        function(errorCode, resultData)
            if errorCode ~= 200 then
                print("CADvanced: ERROR - Unable to perform query " .. query .. ", error " .. errorCode)
                callback({error = errorCode})
            end
            local result = json.decode(resultData)
            local whitelisted = {}
            for _, wl in ipairs(result.data.allWhitelisted) do
                table.insert(whitelisted, wl.steamId)
            end
            callback({result = whitelisted})
        end,
        "POST",
        query,
        {["Content-Type"] = "application/json"}
    )
end

return api
