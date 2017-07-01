
-- config module
local M, module = {}, ...
_G[module] = M


M.tcp_server_ip = "10.207.124.243"
M.tcp_server_port = 2003
M.company_wifi_name = "twguest"
M.company_wifi_passwd = "begin hark sauce editor sign"
M.home_wifi_name = "TPLINK-7d99re"
M.home_wifi_passwd = "vnmg-w43b-4b8n"

M.debug_mode = 0        -- 0:console 1:file 2:net
M.debug_on = true

M.log_sock_ip = "10.207.124.243"
M.log_sock_port = 3476

return M
