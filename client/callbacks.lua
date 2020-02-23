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