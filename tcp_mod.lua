
-- MQTT module
local M, module = {}, ...
_G[module] = M


local tcp_cli = nil
local b_connected = false
local snd_flag = true

local function r_data_cb(data)
    log_mod:print("r data" .. data)
    gates_mod:cmd_proc(data)
end

function M:start()
    -- body
    -- register reconnect timer
    reconnect_timer = tmr.create()
    tmr.register(reconnect_timer, 3000, tmr.ALARM_SEMI, function()
        log_mod:print("timer out. reconect to server".. config.tcp_server_ip)
        tcp_cli:connect(config.tcp_server_port, config.tcp_server_ip)
    end)

    tcp_cli = net.createConnection(net.TCP, 0)

    tcp_cli:on("receive", function( sck, c )
        -- body
        log_mod:print("tcp r data: " .. c)
        -- tmr.stop(reconnect_timer)
        b_connected = true
        r_data_cb(c)
    end)
    tcp_cli:on("connection", function( sck, c )
        -- body
        log_mod:print("connect to tcp server succ")
        -- tmr.stop(reconnect_timer)
        b_connected = true
    end)
    tcp_cli:on("reconnection", function( sck, c )
        -- body
        log_mod:print("reconnect to server")
        -- tmr.stop(reconnect_timer)
        tmr.start(reconnect_timer)
        b_connected = false
    end)
    tcp_cli:on("disconnection", function( sck, c )
        -- body
        log_mod:print("disconnect to server:" .. c)
        -- tmr.stop(reconnect_timer)
        tmr.start(reconnect_timer)
        b_connected = false
    end)
    tcp_cli:on("sent", function( sck, c )
        -- body
        snd_flag = true
    end)

    -- tmr.start(reconnect_timer)
    tcp_cli:connect(config.tcp_server_port, config.tcp_server_ip)
end

function M:send(buf)
    -- body
    if b_connected then
        --tcp_cli:send(buf)
        if true == snd_flag then
            tcp_cli:send(buf)
            snd_flag = false
        end
    end
end

function check_tcp()
    -- body
    return true == b_connected
end

return M