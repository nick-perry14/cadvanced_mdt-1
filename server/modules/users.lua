local user_helpers = module("server/modules/helpers/users")
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

-- Check if a user has a SteamID
function users.validate(source, setKickReason)
    if not source then
        setKickReason(
            "Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open"
        )
        CancelEvent()
        print("SERVER: PLAYER JOIN DENIED - NO SOURCE")
        return false
    end
    local id = user_helpers.get_steam_id(source)
    if not id then
        setKickReason(
            "Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open"
        )
        CancelEvent()
        print("SERVER: PLAYER JOIN DENIED - NO STEAM ID")
        return false
    end
    if conf.val("enable_whitelist") and not hasValue(state_get("whitelisted"), id) then
        setKickReason("You are not whitelisted for this server")
        CancelEvent()
        print("SERVER: PLAYER JOIN DENIED - NOT WHITELISTED")
        return false
    end
    print("SERVER: PLAYER JOIN ACCEPTED")
    return true
end

-- Get a newly connected players details and update state
function users.populate_player()
    print("SERVER: GETTING NEWLY CONNECTED PLAYER DETAILS FOR " .. source)
    local my_source = source
    local id = user_helpers.get_steam_id(source)
    local q_user = queries.get_user(id)
    api.request(
        q_user,
        function(response)
            if response.error == nil then
                local usr = state_get("users")
                local new_user = response.result.data.getUser
                new_user.source = my_source
                table.insert(usr, new_user)
                state_set("users", usr)
                -- Send client the updated user list
                print("SERVER: SENDING ALL CLIENTS UPDATED USERS")
                client.pass_data(usr, "users")
            else
                print(response.error)
            end
        end
    )
end

-- Player connect handler
function users.handler_playerConnecting()
    -- Validate a user when they connect
    AddEventHandler(
        "playerConnecting",
        function(name, setKickReason)
            print("SERVER: PLAYER CONNECTED " .. source)
            print("SERVER: VALIDATING PLAYER")
            local valid = users.validate(source, setKickReason)
            if valid then
                users.populate_player()
            end
        end
    )
end

-- Player dropped handler
---- Remove the user table from state.users
function users.handler_playerDropped()
    AddEventHandler(
        "playerDropped",
        function()
            print("SERVER: PLAYER DROPPED")
            local id = user_helpers.get_steam_id(source)
            local usr = state_get("users")
            for i, user in ipairs(usr) do
                print("SERVER: USER'S STEAM ID " .. user.steamId .. " - ITERATED ID " .. id)
                if user.steamId == id then
                    table.remove(usr, i)
                    state_set("users", usr)
                    -- Send client the updated user list
                    print("SERVER: SENDING ALL CLIENTS UPDATED USERS")
                    client.pass_data(usr, "users")
                    break
                end
            end
        end
    )
end

return users
