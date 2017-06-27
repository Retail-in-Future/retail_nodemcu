
-- log module
local M, module = {}, ...
_G[module] = M

local config = require("config")

local file_name = "log.txt"
local file_hdl = nil

-- must invoke log2file before print
function M:init_mod()
    -- body
    self:close_log()
    file_hdl = file.open(file_name, "a+")
end

-- write msg. must invoke log2file first
function M:print( msg )
    -- body
    if config.debug_on then
        if file.exists(file_name) and file_hdl then
            file_hdl:writeline(msg)
            file_hdl:flush()
        end
    end
end

-- close the file
function M:close_log()
    -- body
    if file_hdl then
        file_hdl:flush()
        file_hdl:close()
        file_hdl = nil
    end
end

function check_log()
    -- body
    return true
end

return M
