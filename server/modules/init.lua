local conf = module("server/modules/config")
local users = module("server/modules/users")
local calls = module("server/modules/calls")
local units = module("server/modules/units")
local citizens = module("server/modules/citizens")
local vehicles = module("server/modules/vehicles")
local client_receiver = module("server/modules/comms/client_receiver")

local init = {}

-- Bootstrap our local data model
function init.bootstrapData()
    -- Check we have a valid config
    local sane = conf.sanity_check()
    if not sane then
        return
    end

    -- Get the whitelisted players, if appropriate
    users.get_whitelisted()

    -- Get all calls
    calls.get_all_calls()

    -- Get all units
    units.get_all_units()

    -- Get all unit states
    units.get_all_unit_states()

    -- Get all user / unit assignments
    units.get_all_user_units()

    -- Get all user ranks
    users.get_all_user_ranks()

    -- Get all citizen markers
    citizens.get_all_markers()

    -- Get all vehicle markers
    vehicles.get_all_markers()
end

function init.createEventHandlers()
    -- Add the playerConnecting handler
    users.handler_playerConnecting()

    -- Add the playerDropped handler
    users.handler_playerDropped()

    -- Add handling for client initiated events
    client_receiver.client_event_handlers()
end

return init
