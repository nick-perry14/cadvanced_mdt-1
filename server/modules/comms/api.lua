local api = {}

function api.request(query, callback)
    local conf = module("server/modules/config")
    local token = conf.val("api_token")
    local url = conf.val("cad_url") .. "/api"
    print("SERVER: MAKING API CALL TO " .. url)
    print("SERVER: CALL BODY: " .. query)
    PerformHttpRequest(
        url,
        function(errorCode, resultData)
            print(resultData)
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
