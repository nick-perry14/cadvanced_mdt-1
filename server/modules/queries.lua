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
            '{ getUser(steamId: "$x") { id userName steamId avatarUrl roles { id name code } character { ... on Citizen { id firstName lastName active __typename } ... on Officer { id firstName lastName active __typename } } } }',
            {x = steam_id}
        )
    }
    return json.encode(query)
end

function queries.get_all_calls()
    local query = {
        operationName = null,
        query = "{ allCalls { id callerInfo markerX markerY callGrade { id name } callType { id name } callLocations { id name } callIncidents { id name } callDescriptions { id text } assignedUnits { id } } }"
    }
    return json.encode(query)
end

function queries.get_all_units()
    local query = {
        operationName = null,
        query = "{ allUnits { id callSign unitType { id name } unitState { id name colour } } }"
    }
    return json.encode(query)
end

function queries.get_unit(unit_id)
    local query = {
        operationName = null,
        query = _doSub(
            "{ getUnit(id: $x) { id callSign unitType { id name } unitState { id name colour } } }",
            {x = unit_id}
        )
    }
    return json.encode(query)
end

return queries
