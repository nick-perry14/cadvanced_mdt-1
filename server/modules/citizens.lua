local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")

local citizens = {}

function citizens.search_citizens(search, callback)
    local q_search_citizens = queries.search_citizens(search)
    api.request(
        q_search_citizens,
        function(response)
            if response.error == nil then
                local received = response.result.data.searchCitizens
                -- Send client the search results
                print("SERVER: SENDING ALL CLIENTS UPDATED UNITS")
                callback(received, "search_results")
            else
                print(response.error)
            end
        end
    )
end

function citizens.get_citizen_offences(data, callback)
    local q_get_citizen_offences = queries.get_citizen_offences(data)
    api.request(
        q_get_citizen_offences,
        function(response)
            if response.error == nil then
                local received = response.result.data.getCitizen
                -- Send client the offences
                print("SERVER: SENDING ALL CLIENTS CITIZEN OFFENCES")
                callback(received, "citizen_offences")
            else
                print(response.error)
            end
        end
    )
end

return citizens