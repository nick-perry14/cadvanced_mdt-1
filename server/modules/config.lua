local config = {}

function config.sanity_check()
    local conf = module("config")
    if conf then
        if conf.cad_url == nil or conf.cad_url == "https://yourcad.cadvanced.app" then
            print("** Invalid or missing cad_url value in config")
            return false
        end
        if conf.api_token == nil or conf.api_token == "" then
            print("** Invalid or missing api_token value in config")
            return false
        end
        if conf.enable_whitelist == nil then
            print("** Missing enable_whitelist value in config")
            return false
        end
        if conf.sound_volume == nil then
            print("** Missing sound_volume value in config")
            return false
        end
        return true
    else
        print(
            "** UNABLE TO LOAD CONFIG. File config.lua was not found. Please create a config file (using config.lua.sample as an example). Then try again"
        )
        return false
    end
end

return config
