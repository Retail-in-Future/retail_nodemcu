
-- ws2812 module
local M, module = {}, ...
_G[module] = M


local debug_timer = nil
local pin_esp8268, pin_board = 4, 0

function M:start_debug_led()
    -- body
    M:stop_debug_led()

    debug_timer = tmr.create()
    local lighton = false

    tmr.register(debug_timer, 2000, tmr.ALARM_AUTO, function ()
        -- body
        if false == lighton then
            lighton = true
            gpio.write(pin_board, gpio.LOW)
        else
            lighton = false
            gpio.write(pin_board, gpio.HIGH)
        end
    end)

    -- start timer  
    if false == tmr.start(debug_timer) then
        tmr.unregister(debug_timer)
        debug_timer = nil
        log_mod:print("start debug_led timer fail")
    end
end

function M:stop_debug_led()
    -- body
    gpio.mode(pin_board, gpio.OUTPUT)

    if debug_timer and tmr.state(debug_timer) then
        tmr.unregister(debug_timer)
            debug_timer = nil
    end

    gpio.write(pin_board, gpio.HIGH)
end

return M
