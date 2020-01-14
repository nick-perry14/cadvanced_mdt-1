local conf = module("server/modules/config")
local queries = module("server/modules/queries")
local api = module("server/modules/api")

local whitelisted = {}

-- Check we have a valid config
local sane = conf.sanity_check()
if not sane then
    return
end

-- Get the whitelisted players, if appropriate
if conf.val("enable_whitelist") then
    local q_whitelisted = queries.get_whitelisted()
    api.request(
        q_whitelisted,
        function(response)
            if response.error == nil then
                whitelisted = response.result
            else
                print(response.error)
                return
            end
        end
    )
end
