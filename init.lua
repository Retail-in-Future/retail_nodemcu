
local config = require("config")

-- log
local log_mod = require("log_mod")
log_mod:init_mod()

-- wifi
local wifi_mod = require("wifi_mod")
wifi_mod:start()

-- tcp server
local tcp_mod = require("tcp_mod")
tcp_mod:start()

-- gates
local gates_mod = require("gates_mod")
gates_mod:init_mod()

-- qr scanner
local qrcode_mod = require("qrcode_mod")
qrcode_mod:start()

function test()
    -- body
    if true ~= check_wifi() then
        print("check wifi fail .. .")
    end

    if true ~= check_log() then
        print("check log fail .. .")
    end

    if true ~= check_tcp() then
        print("check tcp fail .. .")
    end

    if true ~= check_qrcode() then
        print("check qrcode fail .. .")
    end

    if true ~= check_gates() then
        print("check gates fail .. .")
    end
end