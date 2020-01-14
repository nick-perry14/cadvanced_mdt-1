local queries = {}

function queries.get_whitelisted()
    local query = {
        operationName = null,
        query = "{ allWhitelisted{ steamId } }"
    }
    return json.encode(query)
end

function queries.get_user(steam_id)
    local query = {
        operationName = null,
        query = string.format("{ getUser(steamId: %s) { id steamId userName avatarUrl } }", steam_id)
    }
end

return queries
