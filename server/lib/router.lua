local users = module("server/modules/users")
local units = module("server/modules/units")

SetHttpHandler(
    function(req, res)
        print("SERVER: ROUTER RECEIVED REQUEST TO " .. req.path)
        if req.method == "POST" then
            if (req.path == "/update") then
                req.setDataHandler(
                    function(body)
                        local data = json.decode(body)
                        if (data.object == "user") then
                            -- We will receive the Steam ID of a user we
                            -- need to update our cache of
                            users.populate_player(data.payload.steamId)
                        elseif (data.object == "unit") then
                            units.update_unit(data.payload.unitId)
                        end
                        res.send(json.encode({result = "OK"}))
                    end
                )
            end
        elseif req.method == "GET" then
        end
    end
)
