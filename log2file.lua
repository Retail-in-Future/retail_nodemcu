
-- log module
local M, module = {}, ...
_G[module] = M

M.debug_on = false
local file_name = "log.lua"
local file_hdl = nil

-- must invoke log2file before print
function M:open_log()
    -- body
    if self.debug_on then
        self:close_log()
        file_hdl = file.open(file_name, "a+")
    end
end

-- write msg. must invoke log2file first
function M:print( msg )
    -- body
    if self.debug_on then
        if file.exists(file_name) and file_hdl then
            file_hdl:writeline("--" .. msg)
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

return M
