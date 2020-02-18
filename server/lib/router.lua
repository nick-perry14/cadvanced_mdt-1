local users = module("server/modules/users")
local units = module("server/modules/units")

SetHttpHandler(
    function(req, res)
        print("SERVER: ROUTER RECEIVED REQUEST TO " .. req.path)
        if req.method == "POST" then
            if (req.path == "/update") then
                req.setDataHandler(
                    function(body)
                        print("SERVER: ROUTER RECEIVED " .. body)
                        local data = json.decode(body)
                        if next(data) ~= nil then
                            print("SERVER: HANDLING UPDATED " .. data.object)
                            if (data.object == "user") then
                                -- We will receive the Steam ID of a user we
                                -- need to update our cache of
                                users.populate_player(data.payload.steamId)
                            elseif (data.object == "unit") then
                                -- Update a given unit
                                units.update_unit(data.payload.unitId)
                            elseif (data.object == "user_units") then
                                -- Repopulate all user / unit assignments
                                units.repopulate_user_units()
                            end
                        end
                        res.send(json.encode({result = "OK"}))
                    end
                )
            end
        elseif req.method == "GET" then
        end
    end
)
