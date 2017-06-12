
-- gates module
local M, module = {}, ...
_G[module] = M

local simulate = require("ws2812")

function M:allow_enter()
    -- body
    simulate:turn_on_green(5)
end

function M:prohibit_enter()
    -- body
    simulate:turn_on_red(5)
end

return M
