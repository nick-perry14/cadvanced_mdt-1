local queries = module("server/modules/queries")
local api = module("server/modules/comms/api")

local calls = {}

-- Get the table of all calls
function calls.get_all_calls()
    local q_all_calls = queries.get_all_calls()
    api.request(
        q_all_calls,
        function(response)
            if response.error == nil then
                local cll = {}
                for _, call in ipairs(response.result.data.allCalls) do
                    table.insert(cll, call)
                end
                state_set("calls", cll)
            else
                print(response.error)
            end
        end
    )
end

return calls
