-- load modules
config = require("config")
led_mod = require("led_mod")
wifi_mod = require("wifi_mod")
log_mod = require("log_mod")
gates_mod = require("gates_mod")
tcp_mod = require("tcp_mod")
qrcode_mod = require("qrcode_mod")

-- wifi
wifi_mod:start()

-- log
log_mod:init_mod()
log_mod:print("init log mod")

-- gates
gates_mod:init_mod()
log_mod:print("start gates")

-- tcp server
tcp_mod:start()
log_mod:print("start tcp")

-- qr scanner
qrcode_mod:start()
log_mod:print("start qrcode")

function test()
    -- body
    if true ~= check_wifi() then
        log_mod:print("check wifi fail .. .")
    end

    if true ~= check_log() then
        log_mod:print("check log fail .. .")
    end

    if true ~= check_tcp() then
        log_mod:print("check tcp fail .. .")
    end

    if true ~= check_qrcode() then
        log_mod:print("check qrcode fail .. .")
    end

    if true ~= check_gates() then
        log_mod:print("check gates fail .. .")
    end
end