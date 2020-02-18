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

function queries.get_all_user_units()
    local query = {
        operationName = null,
        query = "{ allUserUnits { UserId UnitId UserRankId } }"
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

function queries.search_citizens(props)
    -- Ensure all properties are populated, as we need to substitute
    -- all placeholders in the query
    local to_send = {}
    local allProps = {'firstName', 'lastName', 'dateOfBirth', 'id'};
    for _, key in ipairs(allProps) do
        if props[key] ~= nil and string.len(props[key]) > 0 then
            to_send[key] = props[key]
        else
            to_send[key] = ""
        end
    end
    local query = {
        operationname = null,
        query = _doSub(
            '{ searchCitizens(firstName: "$firstName", lastName: "$lastName", dateOfBirth: "$dateOfBirth", id: "$id" ) { id firstName lastName address postalCode GenderId gender { id name } EthnicityId ethnicity { id name } vehicles { id colour licencePlate vehicleModel { id name } insuranceStatus { id name } } weapons { id weaponType { id name } weaponStatus { id name } } licences { id licenceType { id name } licenceStatus { id name } } warrants { id validFrom validTo details } dateOfBirth weight height hair eyes active createdAt } }',
            to_send
        )
    }
    return json.encode(query)
end

function queries.get_citizen_offences(data)
    local query = {
        operationname = null,
        query = _doSub(
            '{ getCitizen(id: "$id") { id offences { id date time location ArrestId arrest { id date time OfficerId officer { id firstName lastName } charges { id name } } charges { id name } TicketId ticket { id date time location points fine notes OfficerId officer { id firstName lastName } } } } }',
            data
        )
    }
    return json.encode(query)
end

return queries
