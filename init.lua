-- connect to wifi ap
local wifi_mod = require("conn2ap")
-- wifi_mod:connect_wifi("TPLINK-7d99re", "vnmg-w43b-4b8n")
wifi_mod:connect_wifi("twguest", "begin hark sauce editor sign")

-- open log (global variable )
log2file = require("log2file")
log2file:open_log()

-- test log2file
local test_log2file = require("test_log2file")
test_log2file:test()

-- start up working led
local working_led = require("working_led")
working_led:startup_working_led()

-- start up gates
local gates = require("gates")

-- start up qr scanner
local qr_scanner = require("qr_scanner")
qr_scanner:register_qrcode_hdl("10.207.125.109", 1234)



-- test send udp message to local host
function test_s_udp( msg )
    -- body
    udpSocket = net.createUDPSocket()
    udpSocket:send(12344, "10.207.125.109", msg)
end
