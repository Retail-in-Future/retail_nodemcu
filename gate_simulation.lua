
gate_simulation = {}

    ws2812_led = require("ws2812_led")

    function gate_simulation.open_gate()
        -- body
        ws2812_led.turn_on_green()
    end

    function gate_simulation.alarm()
        -- body
        ws2812_led.turn_on_red()
    end

return gate_simulation
