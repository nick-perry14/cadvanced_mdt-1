local queries = module("server/modules/queries")
local client = module("server/modules/comms/client")
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

-- Update a unit
function units.update_unit(id)
    local q_get_unit = queries.get_unit(id)
    api.request(
        q_get_unit,
        function(response)
            if response.error == nil then
                local received = response.result.data.getUnit
                local ex_units = state_get("units")
                for i, iter in ipairs(ex_units) do
                    if (iter.id == received.id) then
                        ex_units[i] = received
                    end
                end
                state_set("units", ex_units)
                -- Send client the updated units list
                print("SERVER: SENDING ALL CLIENTS UPDATED UNITS")
                client.pass_data(ex_units, "units")
            else
                print(response.error)
            end
        end
    )
end

return units
