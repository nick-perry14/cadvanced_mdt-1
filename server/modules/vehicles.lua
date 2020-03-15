local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")

local vehicles = {}

-- Get the table of vehicle markers
function vehicles.get_all_markers()
    local q_get_all_vehicle_markers = queries.get_all_vehicle_markers()
    api.request(
        q_get_all_vehicle_markers,
        function(response)
            if response.error == nil then
                local vehicle_markers = {}
                for _, marker in ipairs(response.result.data.allVehicleMarkers) do
                    table.insert(vehicle_markers, marker)
                end
                state_set("vehicle_markers", vehicle_markers)
            else
                print(response.error)
            end
        end
    )
end

return vehicles