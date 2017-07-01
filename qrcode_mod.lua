
-- qrcode_hdl module
local M, module = {}, ...
_G[module] = M

local led_mod = require("led_mod")
local tcp_mod = require("tcp_mod")
local log_mod = require("log_mod")

local pin_interrupt = 3
local uart_mod_flag = 0

local function on_flash_button_click_cb()
    gpio.trig(pin_interrupt)

    -- register reset timer
    reset_timer = tmr.create()
    tmr.register(reset_timer, 1000, tmr.ALARM_SINGLE, function ()
        gpio.trig(pin_interrupt, "up", on_flash_button_click_cb)
    end)

    -- start reset timer  
    if false == tmr.start(reset_timer) then
        tmr.unregister(reset_timer)
        reset_timer = nil
        log_mod:print("start reconnect timer fail")
    end

    log_mod:print("r button click evt")

    -- add a timer for get a complete qrcode
    buf = ""
    buffer_timer = tmr.create()
    tmr.register(buffer_timer, 2000, tmr.ALARM_SEMI, function ()
        if "" ~= buf then
            tmp_tbl = {}
            tmp_tbl["entry_token"] = buf
            
            ok, json = pcall(sjson.encode, tmp_tbl)
            if ok then tcp_mod:send(json)
            end

            buf = ""

            log_mod:print("send data :" .. json)
        end
    end)

    if 0 == uart_mod_flag then
        uart_mod_flag = 1
        led_mod:stop_debug_led()

        log_mod:print("turn to run_mod")
        
        uart.setup(0, 9600, 0, uart.PARITY_NONE, uart.STOPBITS_1, 0)
        uart.on("data", 0, function (data)
            running, mode = buffer_timer:state()
            
            if running then
                tmr.stop(buffer_timer)
            end
            
            tmr.start(buffer_timer)
            buf = buf .. data
        end, 0)
    else
        uart_mod_flag = 0
        led_mod:start_debug_led()

        log_mod:print("turn to debug_mod")

        uart.setup(0, 9600, 0, uart.PARITY_NONE, uart.STOPBITS_1, 1)
        uart.on("data")
    end
end

function M:start()
    -- set mode 2 debug
    uart_mod_flag = 0
    led_mod:start_debug_led()

    -- add a interrupt to change uart mode
    gpio.mode(pin_interrupt, gpio.INT)
    gpio.trig(pin_interrupt, "up", on_flash_button_click_cb)
end

function check_qrcode(  )
    -- body
    return true
end

return M

