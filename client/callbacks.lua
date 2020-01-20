-- Callback for hiding the MDT
RegisterNUICallback(
    "hideMdt",
    function(_, cb)
        SetNuiFocus(false, false)
        cb()
    end
)

-- Callback for sending initialisation data
RegisterNUICallback(
    "init",
    function(_, cb)
        print('REQUESTED TO SEND INIT DATA')
        cb()
    end
)