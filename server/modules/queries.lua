local queries = {}

function queries.get_whitelisted()
    local query = {
        operationName = null,
        query = "{allWhitelisted{steamId}}"
    }
    return json.encode(query)
end

return queries
