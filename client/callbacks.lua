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
        print("CLIENT: RECEIVED REQUEST FROM NUI TO SET ROUTE FOR CALL " .. data.call.id)
        set_call_route(data.call)
        cb()
    end
)

-- Callback to handle removal of call marker
RegisterNUICallback(
    "clearCallMarker",
    function(data, cb)
        -- Remove the marker
        print("CLIENT: RECEIVED REQUEST FROM NUI TO REMOVE MARKER FOR CALL " .. data.call.id)
        clear_call_marker(data.call)
        cb()
    end
)

-- Callback to handle removal of call route
RegisterNUICallback(
    "clearCallRoute",
    function(data, cb)
        -- Remove the marker
        print("CLIENT: RECEIVED REQUEST FROM NUI TO REMOVE ROUTE FOR CALL " .. data.call.id)
        clear_call_route(data.call)
        cb()
    end
)

local blips = {}

function set_call_marker(call)
    local blip = AddBlipForCoord(call.markerX, call.markerY)
    SetBlipSprite(blip, 398)
    SetBlipColour(blip, 0)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("String")
    AddTextComponentString(call.callType.name .. ' - ' .. call.callGrade.name)
    EndTextCommandSetBlipName(blip)
    blips[call.id] = blip
end

function clear_call_marker(call)
    local blip = blips[call.id]
    SetBlipRoute(blip, false)
    RemoveBlip(blip)
end

function set_call_route(call)
    local blip = blips[call.id]
    SetBlipRoute(blip, true)
end

function clear_call_route(call)
    local blip = blips[call.id]
    SetBlipRoute(blip, false)
end