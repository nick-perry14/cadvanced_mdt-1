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
