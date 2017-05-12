
working_led = {}

    local mytimer = nil

    -- Turn on the working light
    function working_led.turn_on()
        
        local lighton = false
        local pin_board = 0
        local pin_esp8268 = 4

        gpio.mode(pin_board, gpio.OUTPUT)
        gpio.mode(pin_esp8268, gpio.OUTPUT)

        mytimer = tmr.create()
        
        if nil == mytimer then
            print("create working_led timer fail")
        else
            tmr.register(mytimer, 2000, tmr.ALARM_AUTO, function ()
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
            if true == tmr.start(mytimer) then
                print("start up working led")
            else
                tmr.unregister(mytimer)
                mytimer = nil
                print("register working_led timer fail")
            end
        end
    end

    -- Turn off the working light
    function working_led.turn_off()
        if nil ~= mytimer then
            tmr.unregister(mytimer)
            mytimer = nil
        end

        print("stop working led")
    end

return working_led
