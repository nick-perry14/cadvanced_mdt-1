local user_helpers = module("server/modules/helpers/users")
local citizens = module("server/modules/citizens")
local users = module("server/modules/users")
local client_sender = module("server/modules/comms/client_sender")

local client_receiver = {}

function client_receiver.client_event_handlers()
    -- Incoming events from client

    -- Send initialisation data
    RegisterNetEvent("send_init")
    AddEventHandler(
        "send_init",
        function()
            print("SERVER: RECEIVED REQUEST FROM CLIENT FOR INIT DATA")
            -- We call populate_player here rather than just passing the current
            -- state of all users because we probably don't know anything about
            -- this player, so we want to get their data first, which will have
            -- the side effect of distributing it to all clients, including us
            users.populate_player()
            client_sender.pass_data(state_get("calls"), "calls")
            client_sender.pass_data(state_get("units"), "units")
            client_sender.pass_data(state_get("user_units"), "user_units")
            client_sender.pass_data(state_get("user_ranks"), "user_ranks")
            client_sender.pass_data(user_helpers.get_steam_id(source), "steam_id")
        end
    )

    -- Perform citizen search
    RegisterNetEvent("search_citizens")
    AddEventHandler(
        "search_citizens",
        function(data)
            print("SERVER: RECEIVED REQUEST FROM CLIENT TO SEND CITIZEN SEARCH")
            citizens.search_citizens(data, client_sender.pass_data)
        end
    )

    -- Get citizen offences
    RegisterNetEvent("get_citizen_offences")
    AddEventHandler(
        "get_citizen_offences",
        function(data)
            print("SERVER: RECEIVED REQUEST FROM CLIENT TO GET CITIZEN OFFENCES")
            citizens.get_citizen_offences(data, client_sender.pass_data)
        end
    )

    -- Remove user from unit
    RegisterNetEvent("remove_user_from_unit")
    AddEventHandler(
        "remove_user_from_unit",
        function(data)
            print("SERVER: RECEIVED REQUEST FROM CLIENT TO REMOVE USER FROM UNIT")
            users.remove_from_unit(data)
        end
    )
end

return client_receiver