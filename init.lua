-- connect to wifi ap
local wifi_mod = require("conn2ap")
wifi_mod:connect_wifi("TPLINK-7d99re", "vnmg-w43b-4b8n")
--wifi_mod:connect_wifi("twguest", "begin hark sauce editor sign")

-- open log (global variable )
log2file = require("log2file")
log2file:open_log()

-- test log2file
-- local test_log2file = require("test_log2file")
-- test_log2file:test()

-- start up led
led = require("led")
led:start_working_led()
led:start_debug_led()

-- init mqtt client
mqtt_client = require("mqtt_client")
mqtt_client:connect("192.168.1.105", 1883)

-- start up gates
gates = require("gates")

-- start up qr scanner
local qr_scanner = require("qr_scanner")
qr_scanner:register_qrcode_hdl("192.168.1.105", 1234)

