local conf = module("server/modules/config")

-- Check we have a valid config
local sane = conf.sanity_check()
if not sane then
    return
end
