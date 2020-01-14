local conf = module("server/modules/config")
local users = module("server/modules/users")

-- Check we have a valid config
local sane = conf.sanity_check()
if not sane then
    return
end

-- Get the whitelisted players, if appropriate
users.get_whitelisted(whitelisted)

-- Add the playerConnecting handler
users.handler_playerConnecting()
