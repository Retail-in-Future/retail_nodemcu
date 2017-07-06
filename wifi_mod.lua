
-- wifi_mod module
local M, module = {}, ...
_G[module] = M


function M:start()
    -- body
    wifi.setmode(wifi.STATION)
    wifi.sta.config(config.company_wifi_name, config.company_wifi_passwd)
    wifi.sta.autoconnect(1)
    wifi.sta.sethostname("NodeMCU")
end

function check_wifi()
    -- body
    return wifi.STA_GOTIP == wifi.sta.status()
end

return M
