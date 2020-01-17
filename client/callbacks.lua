-- Callback for hiding the MDT
RegisterNUICallback(
    "hideMdt",
    function(_, cb)
        SetNuiFocus(false, false)
        cb()
    end
)
