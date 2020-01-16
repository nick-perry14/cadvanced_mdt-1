local queries = {}

function _doSub(str, sub)
    return string.gsub(str, "%$(%w+)", sub)
end

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
        query = _doSub(
            '{ getUser(steamId: "$x") { id userName steamId avatarUrl roles { id name code } citizens { id firstName lastName } officers { id firstName lastName } } }',
            {x = steam_id}
        )
    }
    return json.encode(query)
end

return queries
