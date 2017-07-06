
-- config module
local M, module = {}, ...
_G[module] = M


M.tcp_server_ip = "192.168.0.165"
M.tcp_server_port = 2003
M.company_wifi_name = "andy"
M.company_wifi_passwd = "IoT-ztgd_@2017"
M.home_wifi_name = "TPLINK-7d99re"
M.home_wifi_passwd = "vnmg-w43b-4b8n"

M.debug_mode = 0        -- 0:console 1:file 2:net
M.debug_on = true

M.log_sock_ip = "192.168.0.165"
M.log_sock_port = 3476

return M
