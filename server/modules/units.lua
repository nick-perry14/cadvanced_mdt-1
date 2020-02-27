local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
local api = module("server/modules/comms/api")

local units = {}

-- Get the table of all units
function units.get_all_units(pass_to_client)
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
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.units, "units")
                end
            else
                print(response.error)
            end
        end
    )
end

-- Get the table of all user / unit assignments
function units.get_all_user_units(pass_to_client)
    local q_all_user_units = queries.get_all_user_units()
    api.request(
        q_all_user_units,
        function(response)
            if response.error == nil then
                local user_units = {}
                for _, assignment in ipairs(response.result.data.allUserUnits) do
                    table.insert(user_units, assignment)
                end
                state_set("user_units", user_units)
                if (pass_to_client ~= nil and pass_to_client) then
                    client_sender.pass_data(state.user_units, "user_units")
                end
            else
                print(response.error)
            end
        end
    )
end

-- Repopulate all user_units
function units.repopulate_user_units()
    units.get_all_user_units(true)
end

-- Repopulate all units
function units.repopulate_units()
    units.get_all_units(true)
end

-- Update a unit
function units.update_unit(id)
    local q_get_unit = queries.get_unit(id)
    print("SERVER: UPDATING UNIT " .. id)
    api.request(
        q_get_unit,
        function(response)
            if response.error == nil then
                print("SERVER: PARSING UPDATED UNIT")
                local received = response.result.data.getUnit
                local ex_units = state_get("units")
                local found = false
                for i, iter in ipairs(ex_units) do
                    if (iter.id == received.id) then
                        ex_units[i] = received
                        found = true
                    end
                end
                if not found then
                    table.insert(ex_units, received)
                end
                state_set("units", ex_units)
                -- Send client the updated units list
                print("SERVER: SENDING ALL CLIENTS UPDATED UNITS")
                client_sender.pass_data(ex_units, "units")
            else
                print(response.error)
            end
        end
    )
end

return units
