-- load modules
config = require("config")
led_mod = require("led_mod")
log_mod = require("log_mod")
gates_mod = require("gates_mod")
tcp_mod = require("tcp_mod")
qrcode_mod = require("qrcode_mod")

log_mod:init_mod()
log_mod:print("init log mod")

function wifi_connected_cb(T)
    log_mod:print("connect to ap succ")

    -- gates
    gates_mod:init_mod()
    log_mod:print("start gates")

    -- tcp server
    tcp_mod:start()
    log_mod:print("start tcp")

    -- qr scanner
    qrcode_mod:start()
    log_mod:print("start qrcode")
end

function wifi_disconnected_cb(T)
    log_mod:print("disconnect to ap")
end

-- set wifi evt mon cb
-- wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, wifi_connected_cb)
wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, wifi_disconnected_cb)
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, wifi_connected_cb)

-- connect to wifi
wifi.setmode(wifi.STATION)
wifi.sta.config(config.company_wifi_name, config.company_wifi_passwd)
wifi.sta.autoconnect(1)
wifi.sta.sethostname("nodemcu")
wifi.sta.connect()

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