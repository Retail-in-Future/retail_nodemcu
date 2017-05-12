
working_led = require("working_led")
gate_simulation = require("gate_simulation")

function startup()
    -- body
    if nil == file.open("init.lua")
    then
        print("init.lua deleted or renamed")
    else
        print("Running")
        file.close("init.lua")
    end
end

-- turn on the working led
working_led.turn_on()



-- working_led.turn_off()
