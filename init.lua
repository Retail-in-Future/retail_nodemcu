-- wifi
local wifi_mod = require("wifi_mod")
wifi_mod:start()

-- log
local log_mod = require("log_mod")
log_mod:init_mod()

log_mod:print("init log mod")

-- tcp server
local tcp_mod = require("tcp_mod")
tcp_mod:start()

log_mod:print("start tcp")

-- gates
local gates_mod = require("gates_mod")
gates_mod:init_mod()

log_mod:print("start gates")

-- qr scanner
local qrcode_mod = require("qrcode_mod")
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