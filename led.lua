
-- ws2812 module
local M, module = {}, ...
_G[module] = M

local working_timer, debug_timer = nil, nil
local pin_esp8268, pin_board = 4, 0

function M:start_working_led()
    -- body
    M:stop_working_led()

    working_timer = tmr.create()
    local lighton = false

    tmr.register(working_timer, 2000, tmr.ALARM_AUTO, function ()
        -- body
        if false == lighton then
            lighton = true
            gpio.write(pin_esp8268, gpio.LOW)
        else
            lighton = false
            gpio.write(pin_esp8268, gpio.HIGH)
        end
    end)

    -- start timer  
    if false == tmr.start(working_timer) then
        tmr.unregister(working_timer)
        working_timer = nil
        log2file:print("start working_led timer fail")
    end
end

function M:stop_working_led()
    -- body
    gpio.mode(pin_esp8268, gpio.OUTPUT)

    if working_timer and tmr.state(working_timer) then
        tmr.unregister(working_timer)
            working_timer = nil
    end

    gpio.write(pin_esp8268, gpio.HIGH)
end

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
        log2file:print("start debug_led timer fail")
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
