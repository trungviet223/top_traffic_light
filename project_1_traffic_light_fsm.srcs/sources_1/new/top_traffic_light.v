module top_traffic_light(

    input wire clk,
    input wire btnC,

    output wire led_red,
    output wire led_yellow,
    output wire led_green
);

    wire tick_1hz;
    wire rst_clean;

    //------------------------------------------------
    // CLOCK DIVIDER
    //------------------------------------------------

    clock_1hz_generator u_clk_div (
        .clk(clk),
        .tick_1hz(tick_1hz)
    );

    //------------------------------------------------
    // DEBOUNCE RESET BUTTON
    //------------------------------------------------

    debounce u_debounce (
        .clk(clk),
        .btn(btnC),
        .btn_clean(rst_clean)
    );

    //------------------------------------------------
    // FSM
    //------------------------------------------------

    traffic_light_fsm u_fsm (
        .clk(clk),
        .rst(rst_clean),
        .tick(tick_1hz),

        .red(led_red),
        .yellow(led_yellow),
        .green(led_green)
    );

endmodule