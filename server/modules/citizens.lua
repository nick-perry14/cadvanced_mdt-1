local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")

local citizens = {}

function citizens.search_citizens(search, callback, src)
    local q_search_citizens = queries.search_citizens(search)
    api.request(
        q_search_citizens,
        function(response)
            if response.error == nil then
                local received = response.result.data.searchCitizens
                -- Send client the search results
                print("SERVER: SENDING ALL CLIENTS UPDATED UNITS")
                callback(received, "search_results", src)
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

-- Get the table of citizen markers
function citizens.get_all_markers()
    local q_get_all_citizen_markers = queries.get_all_citizen_markers()
    api.request(
        q_get_all_citizen_markers,
        function(response)
            if response.error == nil then
                local citizen_markers = {}
                for _, marker in ipairs(response.result.data.allCitizenMarkers) do
                    table.insert(citizen_markers, marker)
                end
                state_set("citizen_markers", citizen_markers)
            else
                print(response.error)
            end
        end
    )
end

-- Add a marker to a citizen
function citizens.add_marker(data)
    local q_attach_marker_to_citizen = queries.attach_marker_to_citizen(data)
    api.request(
        q_attach_marker_to_citizen,
        function(response)
            if response.error ~= nil then
                print(response.error)
            end
        end
    )
end

-- Remove a marker from a citizen
function citizens.remove_marker(data)
    local q_detach_marker_from_citizen = queries.detach_marker_from_citizen(data)
    api.request(
        q_detach_marker_from_citizen,
        function(response)
            if response.error ~= nil then
                print(response.error)
            end
        end
    )
end

return citizens