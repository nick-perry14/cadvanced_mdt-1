local api = {}

function api.request(query, callback)
    print("SERVER: MAKING API CALL")
    local conf = module("server/modules/config")
    local token = conf.val("api_token")
    PerformHttpRequest(
        conf.val("cad_url") .. "/api",
        function(errorCode, resultData)
            if errorCode ~= 200 then
                print("CADvanced: ERROR - Unable to perform query " .. query .. ", error " .. errorCode)
                callback({error = errorCode})
            end
            callback({result = json.decode(resultData)})
        end,
        "POST",
        query,
        {
            ["Content-Type"] = "application/json",
            ["cadvanced-token"] = token
        }
    )
end

return api
