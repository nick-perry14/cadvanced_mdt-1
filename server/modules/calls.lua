local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")
local client = module("server/modules/comms/client")

local calls = {}

local current_calls = {}

-- Get the table of all calls
function calls.get_all_calls()
    local q_all_calls = queries.get_all_calls()
    api.request(
        q_all_calls,
        function(response)
            if response.error == nil then
                for _, call in ipairs(response.result.data.allCalls) do
                    table.insert(current_calls, call)
                end
                client.pass_data(current_calls, 'calls')
            else
                print(response.error)
            end
        end
    )
end

function calls.get_current_calls()
    return calls.current_calls
end

return calls
