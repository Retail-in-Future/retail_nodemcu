
-- ws2812 module
local M, module = {}, ...
_G[module] = M

local green_timer, red_timer = nil, nil

local function clean_timer(  )
    -- body
    if green_timer and tmr.state(green_timer) then
        tmr.unregister(green_timer)
            green_timer = nil
    end

    if red_timer and tmr.state(red_timer) then
        tmr.unregister(red_timer)
            red_timer = nil
    end
end

function M:turn_on_green(time_in_s)
    -- body
    -- turn on the green led
    ws2812.init(ws2812.MODE_SINGLE)
    ws2812.write(string.char(255,0,0, 255,0,0, 255,0,0, 255,0,0))

    clean_timer()
    green_timer = tmr.create()
    tmr.register(green_timer, time_in_s * 1000, tmr.ALARM_SINGLE, function ()
        -- body
        ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
    end)

    -- start timer
    if false == tmr.start(green_timer) then
        tmr.unregister(green_timer)
        green_timer = nil
        log2file:print("start green_timer timer fail")
    end
end

function M:turn_on_red(time_in_s)
    -- body
    -- turn on the green led
    ws2812.init(ws2812.MODE_SINGLE)
    ws2812.write(string.char(0,255,0, 0,255,0, 0,255,0, 0,255,0))

    clean_timer()
    red_timer = tmr.create()
    tmr.register(red_timer, time_in_s * 1000, tmr.ALARM_SINGLE, function ()
        -- body
        ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
    end)

    -- start timer
    if false == tmr.start(red_timer) then
        tmr.unregister(red_timer)
        red_timer = nil
        log2file:print("start red_timer timer fail")
    end
end

return M
