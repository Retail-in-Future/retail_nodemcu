
-- gates module
local M, module = {}, ...
_G[module] = M

local gate_timer = nil

local function reset_gate()
    -- body
    if gate_timer and tmr.state(gate_timer) then
        tmr.unregister(gate_timer)
            gate_timer = nil
    end

    ws2812.write(string.char(0,0,0, 0,0,0, 0,0,0, 0,0,0))
end

local function start_timer()
    -- body
    tmr.register(gate_timer, time_in_s * 1000, tmr.ALARM_SINGLE, function ()
        -- body
        reset_gate()
    end)

    -- start timer
    if false == tmr.start(gate_timer) then
        tmr.unregister(gate_timer)
        gate_timer = nil
        log2file:print("start gate_timer timer fail")
    end
end

local function allow_enter( time_in_s )
    -- body
    reset_gate()
    -- trun on green light
    ws2812.write(string.char(255,0,0, 255,0,0, 255,0,0, 255,0,0))
    -- start timer
    start_timer(time_in_s)
end

local function prohibit_enter( time_in_s )
    -- body
    reset_gate()
    -- turn on red light
    ws2812.write(string.char(0,255,0, 0,255,0, 0,255,0, 0,255,0))
    -- start timer
    start_timer(time_in_s)
end

function M:cmd_proc(data)
    -- body
    if "allow" == data then
        allow_enter(5)
    else
        prohibit_enter(5)
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