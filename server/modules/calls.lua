local queries = module("server/modules/queries")
local client_sender = module("server/modules/comms/client_sender")
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

-- Update a call
function calls.update_call(id)
    local q_get_call = queries.get_call(id)
    print("SERVER: UPDATING CALL " .. id)
    api.request(
        q_get_call,
        function(response)
            if response.error == nil then
                print("SERVER: PARSING UPDATED CALL")
                local received = response.result.data.getCall
                local ex_calls = state_get("calls")
                local found = false
                for i, iter in ipairs(ex_calls) do
                    if (iter.id == received.id) then
                        ex_calls[i] = received
                        found = true
                    end
                end
                if not found then
                    table.insert(ex_calls, received)
                end
                state_set("calls", ex_calls)
                -- Send client the updated calls list
                print("SERVER: SENDING ALL CLIENTS UPDATED CALLS")
                client_sender.pass_data(ex_calls, "calls")
            else
                print(response.error)
            end
        end
    )
end


return calls
