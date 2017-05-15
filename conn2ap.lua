
-- conn2ap module
local M, module = {}, ...
_G[module] = M

function M:connect_wifi( ssid, passwd )
    -- body
    wifi.setmode(wifi.STATION)
    wifi.sta.config(ssid, passwd)
    wifi.sta.autoconnect(1)
    wifi.sta.sethostname("NodeMCU")
end

return M
