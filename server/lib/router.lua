local users = module("server/modules/users")

SetHttpHandler(
    function(req, res)
        if req.method == "POST" then
            if (req.path == "/update") then
                local data = json.decode(body)
                if (data.object == "user") then
                    users.update_player(data.payload)
                end
            end
        elseif req.method == "GET" then
        end
    end
)
