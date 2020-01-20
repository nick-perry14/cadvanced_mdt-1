local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")

local units = {}

-- Get the table of all units
function units.get_all_units()
    local q_all_units = queries.get_all_units()
    api.request(
        q_all_units,
        function(response)
            if response.error == nil then
                local unt = {}
                for _, unit in ipairs(response.result.data.allUnits) do
                    table.insert(unt, unit)
                end
                state_set("units", unt)
            else
                print(response.error)
            end
        end
    )
end

return units
