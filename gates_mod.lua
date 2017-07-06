
-- gates module
local M, module = {}, ...
_G[module] = M


local gate_timer = nil


local function update_dev_state(gates, light)
    -- body
    tbl_state = {}
    tbl_state["gates"] = gates
    tbl_state["light"] = light

    tbl_dev_state = {}
    tbl_dev_state["state"] = tbl_state

    tbl_dev = {}
    tbl_dev["dev_state"] = tbl_state

    ok, json = pcall(sjson.encode, tbl_dev)
    if ok then tcp_mod:send(json)
    end

    log_mod:print("update dev state" .. json)
end

local function reset_gate()
    -- body
    if gate_timer ~= nil and tmr.state(gate_timer) then
        tmr.unregister(gate_timer)
        gate_timer = nil
    end

    ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
end

local function start_timer(time_in_s)
    -- body
    gate_timer = tmr.create()
    tmr.register(gate_timer, time_in_s * 1000, tmr.ALARM_SINGLE, function ()
        -- body
        reset_gate()
        update_dev_state("close", "close")
    end)

    -- start timer
    if false == tmr.start(gate_timer) then
        tmr.unregister(gate_timer)
        gate_timer = nil
        log_mod:print("start gate_timer timer fail")
    end
end

local function allow_enter( time_in_s )
    -- body
    reset_gate()

    log_mod:print("allowd enter")

    -- trun on green light
    ws2812.write(string.char(255,0,0, 255,0,0, 255,0,0, 255,0,0))
    -- start timer
    start_timer(time_in_s)

    update_dev_state("open", "green")
end

local function prohibit_enter( time_in_s )
    -- body
    reset_gate()

    log_mod:print("prohibit enter")

    -- turn on red light
    ws2812.write(string.char(0,255,0, 0,255,0, 0,255,0, 0,255,0))
    -- start timer
    start_timer(time_in_s)

    update_dev_state("close", "red")
end

function M:cmd_proc(data)
    -- body
    gates, light = nil, nil
    ok, json = pcall(sjson.decode, data)
    if ok then
        log_mod:print("light: " .. json["light"])
    
        if "green" == json["light"] then
            allow_enter(5)
        elseif "red" == json["light"] then
            prohibit_enter(5)
        else
            log_mod:print("wrong json")
        end  
    end

    
end

function M:init_mod()
    -- body
    ws2812.init(ws2812.MODE_SINGLE)
end

function check_gates()
    -- body
    allow_enter(3)
    return true
end

return M