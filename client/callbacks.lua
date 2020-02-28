-- Callback for hiding the MDT
RegisterNUICallback(
    "hideMdt",
    function(_, cb)
        print("CLIENT: RECEIVED hideMdt FROM NUI")
        SetNuiFocus(false, false)
        cb()
    end
)

-- Callback for sending initialisation data
RegisterNUICallback(
    "init",
    function(_, cb)
        -- Tell the server to send the init data
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SEND INIT DATA")
        print("CLIENT: REQUESTING INIT DATA FROM SERVER")
        TriggerServerEvent("send_init")
        cb()
    end
)

-- Callback to handle citizen searches
RegisterNUICallback(
    "searchCitizen",
    function(data, cb)
        -- Tell the server to send the init data
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SEND CITIZEN SEARCH PARAMETERS")
        print("CLIENT: SENDING CITIZEN SEARCH OBJECT TO SERVER")
        TriggerServerEvent("search_citizens", data)
        cb()
    end
)

-- Callback to handle citizen offences retrieval
RegisterNUICallback(
    "getCitizenOffences",
    function(data, cb)
        -- Tell the server to send the init data
        print("CLIENT: RECEIVED REQUEST FROM NUI TO GET CITIZEN OFFENCES")
        print("CLIENT: SENDING GET CITIZEN OFFENCES REQUEST TO SERVER")
        TriggerServerEvent("get_citizen_offences", data)
        cb()
    end
)

-- Callback to handle removal of user from unit
RegisterNUICallback(
    "removeUserFromUnit",
    function(data, cb)
        -- Tell the server to remove the user from the unit
        print("CLIENT: RECEIVED REQUEST FROM NUI TO REMOVE USER " .. data.userId .. " FROM UNIT " .. data.unitId)
        print("CLIENT: SENDING REMOVE USER FROM UNIT REQUEST TO SERVER")
        TriggerServerEvent("remove_user_from_unit", data)
        cb()
    end
)

-- Callback to handle addition of user to unit
RegisterNUICallback(
    "addUserToUnit",
    function(data, cb)
        -- Tell the server to add the user to the unit
        print("CLIENT: RECEIVED REQUEST FROM NUI TO ADD USER " .. data.userId .. " TO UNIT " .. data.unitId)
        print("CLIENT: SENDING ADD USER TO UNIT REQUEST TO SERVER")
        TriggerServerEvent("add_user_to_unit", data)
        cb()
    end
)

-- Callback to handle addition of user to unit
RegisterNUICallback(
    "setUnitState",
    function(data, cb)
        -- Tell the server to set the state of the unit
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SET STATE OF UNIT " .. data.unitId .. " TO STATE " .. data.stateId)
        print("CLIENT: SENDING SET UNIT STATE REQUEST TO SERVER")
        TriggerServerEvent("set_unit_state", data)
        cb()
    end
)

-- Callback to handle setting of call marker
RegisterNUICallback(
    "setCallMarker",
    function(data, cb)
        -- Add the marker
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SET MARKER FOR CALL " .. data.call.id)
        set_call_marker(data.call)
        cb()
    end
)

-- Callback to handle setting of call route
RegisterNUICallback(
    "setCallRoute",
    function(data, cb)
        -- Add the route
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SET ROUTE")
        set_call_route()
        cb()
    end
)

-- Callback to handle removal of call marker
RegisterNUICallback(
    "clearCallMarker",
    function(data, cb)
        -- Remove the marker
        print("CLIENT: RECEIVED REQUEST FROM NUI TO REMOVE MARKER")
        clear_call_marker()
        cb()
    end
)

-- Callback to handle removal of all call routes
RegisterNUICallback(
    "clearCallRoute",
    function(cb)
        -- Remove the routes
        print("CLIENT: RECEIVED REQUEST FROM NUI TO REMOVE ROUTE")
        clear_call_route()
        cb()
    end
)

local active_blip

function set_call_marker(call)
    -- For now, we're only allowing a single call marker
    -- Clear any prexisting markers or routes
    clear_call_marker()
    clear_call_route()
    local blip = AddBlipForCoord(call.markerX, call.markerY)
    SetBlipSprite(blip, 398)
    SetBlipColour(blip, 0)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("String")
    AddTextComponentString(call.callType.name .. ' - ' .. call.callGrade.name)
    EndTextCommandSetBlipName(blip)
    active_blip = blip
end

function clear_call_marker()
    if (active_blip ~= nil) then
        RemoveBlip(active_blip)
    end
end

function set_call_route()
    if (active_blip ~= nil) then
        clear_call_route()
        SetBlipRoute(active_blip, true)
    end
end

function clear_call_route()
    if (active_blip ~= nil) then
        SetBlipRoute(active_blip, false)
    end
end