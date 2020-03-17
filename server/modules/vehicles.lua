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

-- Add a marker to a vehicle
function vehicles.add_marker(data)
    local q_attach_marker_to_vehicle = queries.attach_marker_to_vehicle(data)
    api.request(
        q_attach_marker_to_vehicle,
        function(response)
            if response.error ~= nil then
                print(response.error)
            end
        end
    )
end

-- Remove a marker from a vehicle
function vehicles.remove_marker(data)
    local q_detach_marker_from_vehicle = queries.detach_marker_from_vehicle(data)
    api.request(
        q_detach_marker_from_vehicle,
        function(response)
            if response.error ~= nil then
                print(response.error)
            end
        end
    )
end

return vehicles