
ws2812_led = {}

    local green_timer = nil
    local red_timer = nil

    -- Turn on the green led
    function ws2812_led.turn_on_green()

        -- turn off the red led first if it is open
        if nil ~= red_timer then
            tmr.unregister(red_timer)
            red_timer = nil
        end

        -- turn on the green led
        ws2812.init(ws2812.MODE_SINGLE)
        ws2812.write(string.char(255,0,0, 255,0,0, 255,0,0, 255,0,0))
        
        green_timer = tmr.create()
        
        if nil == green_timer then
            print("create ws2812 timer fail")
        else
            tmr.register(green_timer, 5000, tmr.ALARM_SINGLE, function ()
                -- body
                ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
            end)

            -- start timer 
            if true == tmr.start(green_timer) then
                print("start green_timer succ")
            else
                tmr.unregister(green_timer)
                green_timer = nil
                print("start green_timer fail")
            end
        end
    end

    function ws2812_led.turn_on_red()
        -- body
        -- turn off the green led first if it is open
        if nil ~= green_timer then
            tmr.unregister(green_timer)
            green_timer = nil
        end

        -- turn on the red led
        ws2812.init(ws2812.MODE_SINGLE)
        ws2812.write(string.char(0,255,0, 0,255,0, 0,255,0, 0,255,0))
        
        red_timer = tmr.create()
        
        if nil == red_timer then
            print("create ws2812 timer fail")
        else
            tmr.register(red_timer, 5000, tmr.ALARM_SINGLE, function ()
                -- body
                ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
            end)

            -- start timer 
            if true == tmr.start(red_timer) then
                print("start red_timer succ")
            else
                tmr.unregister(red_timer)
                red_timer = nil
                print("start red_timer fail")
            end
        end
    end

return ws2812_led
