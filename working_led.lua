
-- ws2812 module
local M, module = {}, ...
_G[module] = M

function M:startup_working_led (  )
    -- body
    local pin_board, pin_esp8268 = 0, 4

    -- set mode
    gpio.mode(pin_board, gpio.OUTPUT)
    gpio.mode(pin_esp8268, gpio.OUTPUT)

    local led_timer = tmr.create()
    local lighton = false

    tmr.register(led_timer, 2000, tmr.ALARM_AUTO, function ()
        -- body
        if false == lighton then
            lighton = true
            gpio.write(pin_board, gpio.LOW)
            gpio.write(pin_esp8268, gpio.LOW)
        else
            lighton = false
            gpio.write(pin_board, gpio.HIGH)
            gpio.write(pin_esp8268, gpio.HIGH)
        end
    end)

    -- start timer  
    if false == tmr.start(led_timer) then
        tmr.unregister(led_timer)
        led_timer = nil
        log2file:print("start working_led timer fail")
    end
end

return M
