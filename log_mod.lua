
-- log module
local M, module = {}, ...
_G[module] = M


local file_name = "log.txt"
local file_hdl = nil

local udp_sock = nil

-- close the file
function close_log()
    -- body
    if nil ~= file_hdl then
        file_hdl:flush()
        file_hdl:close()
        file_hdl = nil
    end
end

function close_sock()
    if nil ~= udp_sock then
        udp_sock = nil
    end
end

-- must invoke log2file before print
function M:init_mod()
    -- body
    close_log()
    close_sock()

    file_hdl = file.open(file_name, "a+")
    udp_sock = net.createUDPSocket()
end

-- write msg. must invoke log2file first
function M:print( msg )
    -- body
    
    if config.debug_on then

        if 0 == config.debug_mode then
            print(msg)
        elseif  1 == config.debug_mode then
            if file.exists(file_name) and file_hdl then
                file_hdl:writeline(msg)
                file_hdl:flush()
            end
        else
            udp_sock:send(config.log_sock_port, config.log_sock_ip, msg)
        end
        
    end
end

function check_log()
    -- body
    return true
end

return M
