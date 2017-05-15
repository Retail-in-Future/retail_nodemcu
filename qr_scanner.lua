
-- qr_scanner module 0--0
local M, module = {}, ...
_G[module] = M

function M:register_qrcode_hdl(server_ip, port)

    -- add a timer for get a complete qrcode
    local buf = ""
    local buffer_timer = tmr.create()
    local udpSocket = net.createUDPSocket()
    tmr.register(buffer_timer, 2000, tmr.ALARM_SEMI, function ()
        if "" ~= buf then
            udpSocket:send(port, server_ip, buf)
            buf = ""
        end
    end)

    -- add a interrupt to change uart mode
    local pin_interrupt = 3
    gpio.mode(pin_interrupt, gpio.INT)
    
    local uart_mod_flag = 0
    local function on_low_level_cb()

        -- eliminate jitter
        gpio.trig(pin_interrupt)
        tmr.alarm(0, 500, tmr.ALARM_SINGLE, function ()
            gpio.trig(pin_interrupt, "low", on_low_level_cb)
        end)

        if 0 == uart_mod_flag then
            uart_mod_flag = 1
            
            uart.setup(0, 9600, 0, uart.PARITY_NONE, uart.STOPBITS_1, 0)
            uart.on("data", 0, function (data)
                local running, mode = buffer_timer:state()
                if nil ~= running then 
                    if running then
                        tmr.stop(buffer_timer)
                    end
                    tmr.start(buffer_timer)
                    buf = buf .. data
                end
            end, 0)
        else
            uart_mod_flag = 0

            uart.setup(0, 9600, 0, uart.PARITY_NONE, uart.STOPBITS_1, 1)
            uart.on("data")
        end
    end

    gpio.trig(pin_interrupt, "low", on_low_level_cb)

end

return M

