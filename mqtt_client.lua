
-- MQTT module
local M, module = {}, ...
_G[module] = M

M.mqtt_client_hdl = nil
M.b_connected = false

function M:connect(ip, port)
    -- body
    self.mqtt_client_hdl = mqtt.Client("clientid", 120)

    self.mqtt_client_hdl:connect(ip, port, 0, function (client)
        -- body
        self.b_connected = true
    end)

end

function M:publish(topic, payload, qos, retain)
    -- body
    if self.b_connected then
        self.mqtt_client_hdl:publish(topic, payload, qos, retain)
    end
end

return M