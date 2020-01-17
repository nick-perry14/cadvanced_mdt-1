local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")
local client = module("server/modules/comms/client")

local units = {}

local current_units = {}

-- Get the table of all units
function units.get_all_units()
    local q_all_units = queries.get_all_units()
    api.request(
        q_all_units,
        function(response)
            if response.error == nil then
                for _, unit in ipairs(response.result.data.allUnits) do
                    table.insert(current_units, unit)
                end
                -- Pass the data to NUI (via the client)
                client.pass_data(current_units, "units")
            else
                print(response.error)
            end
        end
    )
end

return units
