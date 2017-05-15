
-- test_log2file module
local M, module = {}, ...
_G[module] = M

function M.test()
    -- body
    local debug_flag = false
    if false == log2file.debug_on then
        log2file.debug_on = true
        debug_flag = true
    end

    -- test 1
    log2file:close_log()

    -- test 2
    log2file:print("fuck 1")

    -- test 3
    log2file:open_log()
    log2file:open_log()
    log2file:close_log()
    log2file:open_log()
    log2file:print("fuck 2")
    log2file:open_log()
    log2file:close_log()

    -- test 4
    log2file:open_log()
    log2file:print("fuck 3")
    log2file:print("fuck 4")
    log2file:close_log()

    file.remove("log.lua")

    if true == debug_flag then
        log2file.debug_on = false
    end

end

return M
