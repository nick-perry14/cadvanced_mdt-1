local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")
local client = module("server/modules/comms/client")
local conf = module("server/modules/config")

local users = {}

-- Get the table of whitelisted users
function users.get_whitelisted()
    if conf.val("enable_whitelist") then
        local q_whitelisted = queries.get_whitelisted()
        api.request(
            q_whitelisted,
            function(response)
                if response.error == nil then
                    local whitelist = {}
                    for _, wl in ipairs(response.result.data.allWhitelisted) do
                        table.insert(whitelist, wl.steamId)
                    end
                    state_set("whitelist", whitelist)
                else
                    print(response.error)
                end
            end
        )
    else
        return {}
    end
end

-- Get the player's Steam ID
function users.get_steam_id(source)
    local id = nil
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            local trimmed = v:gsub("steam:", "")
            id = trimmed
            break
        end
    end
    return id
end

-- Get a user's server Id from their Steam ID
function users.get_user_from_steam_id(steamId)
    local players = GetPlayers()
    -- Iterate all players until we find the one we want
    for _, player in ipairs(players) do
        local id = users.get_steam_id(player)
        if id and id == steamId then
            return player
        end
    end
    return nil
end

-- Check if a user has a SteamID
function users.validate(source, setKickReason)
    local id = users.get_steam_id(source)
    if not id then
        setKickReason(
            "Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open"
        )
        CancelEvent()
    end
    if conf.val("enable_whitelist") and not hasValue(whitelisted, id) then
        setKickReason("You are not whitelisted for this server")
        CancelEvent()
    end
end

-- Player connect handler
---- Validate a user when they connect
---- Update state
-- and pass to the client
function users.handler_playerConnecting()
    if conf.val("enable_whitelist") then
        AddEventHandler(
            "playerConnecting",
            function(name, setKickReason)
                users.validate(source, setKickReason)
            end
        )
    end
    AddEventHandler(
        "playerConnecting",
        function()
            local id = users.get_steam_id(source)
            local q_user = queries.get_user(id)
            api.request(
                q_user,
                function(response)
                    if response.error == nil then
                        local usr = state_get("users")
                        table.insert(usr, response.result.data.getUser)
                        state_set("users", usr)
                        -- Send client the updated user list
                        print("SERVER: PLAYER CONNECTED " .. source)
                        print("SERVER: SENDING CLIENT UPDATED USERS")
                        client.pass_data(usr, "users")
                    else
                        print(response.error)
                    end
                end
            )
        end
    )
end

-- Player dropped handler
---- Remove the user table from state.users
function users.handler_playerDropped()
    AddEventHandler(
        "playerDropped",
        function()
            local id = users.get_steam_id(source)
            local usr = state_get("users")
            for i, user in ipairs(usr) do
                if user.steamId == id then
                    table.remove(usr, i)
                    state_set("users", usr)
                    -- Send client the updated user list
                    client.pass_data(usr, "users")
                    break
                end
            end
        end
    )
end

return users
