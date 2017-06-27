
-- MQTT module
local M, module = {}, ...
_G[module] = M

local config = require("config")
local log_mod = require("log_mod")
local gates_mod = require("gates_mod")

local tcp_cli = nil
local b_connected = false

local function r_data_cb(data)
    gates_mod:cmd_proc(data)
end

function M:start()
    -- body
    tcp_cli = net.createConnection(net.TCP, 0)

    tcp_cli:on("receive", function( sck, c )
        -- body
        log_mod:print("tcp r data: " .. c)

        -- send to gate
        r_data_cb(c)
    end)
    tcp_cli:on("connection", function( sck, c )
        -- body
        log_mod:print("connect to tcp server succ")
        b_connected = true
    end)
    tcp_cli:on("reconnection", function( sck, c )
        -- body
        log_mod:print("reconnect to tcp server succ")
        b_connected = true
    end)
    tcp_cli:on("disconnection", function( sck, c )
        -- body
        log_mod:print("disconnect to tcp server")
        b_connected = false

        -- reconnect to tcp server
        tcp_cli:connect(server_port, server_ip)
    end)

    tcp_cli:connect(server_port, server_ip)

    -- register reconnect timer
    reconnect_timer = tmr.create()
    tmr.register(reconnect_timer, 5000, tmr.ALARM_AUTO, function()
        -- body
        if false == b_connected then
            log_mod:connect(server_port, server_ip)
        end
    end)

    -- start timer  
    if false == tmr.start(reconnect_timer) then
        tmr.unregister(reconnect_timer)
        reconnect_timer = nil
        log2file:print("start reconnect timer fail")
    end
end

function M:send(buf)
    -- body
    if b_connected then
        tcp_cli:send(buf)
    end
end

function check_tcp()
    -- body
    return b_connected
end

return M