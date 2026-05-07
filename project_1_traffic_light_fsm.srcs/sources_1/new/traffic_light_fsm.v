module traffic_light_fsm(
    input wire clk,
    input wire rst,
    input wire tick,

    output reg red,
    output reg yellow,
    output reg green
);

    //================================================
    // STATE DECLARATION
    //================================================

    localparam RED_STATE    = 2'b00;
    localparam GREEN_STATE  = 2'b01;
    localparam YELLOW_STATE = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    reg [3:0] timer;

    //================================================
    // STATE REGISTER
    //================================================

    always @(posedge clk) begin
        if (rst)
            state <= RED_STATE;
        else
            state <= next_state;
    end

    //================================================
    // TIMER LOGIC
    //================================================

    always @(posedge clk) begin

        if (rst)
            timer <= 0;

        else if (tick) begin

            case (state)

                RED_STATE: begin
                    if (timer == 4)
                        timer <= 0;
                    else
                        timer <= timer + 1;
                end

                GREEN_STATE: begin
                    if (timer == 4)
                        timer <= 0;
                    else
                        timer <= timer + 1;
                end

                YELLOW_STATE: begin
                    if (timer == 1)
                        timer <= 0;
                    else
                        timer <= timer + 1;
                end

                default:
                    timer <= 0;

            endcase
        end
    end

    //================================================
    // NEXT STATE LOGIC
    //================================================

    always @(*) begin

        next_state = state;

        case (state)

            RED_STATE: begin
                if (tick && timer == 4)
                    next_state = GREEN_STATE;
            end

            GREEN_STATE: begin
                if (tick && timer == 4)
                    next_state = YELLOW_STATE;
            end

            YELLOW_STATE: begin
                if (tick && timer == 1)
                    next_state = RED_STATE;
            end

            default:
                next_state = RED_STATE;

        endcase
    end

    //================================================
    // OUTPUT LOGIC
    //================================================

    always @(*) begin

        red    = 0;
        yellow = 0;
        green  = 0;

        case (state)

            RED_STATE:
                red = 1;

            GREEN_STATE:
                green = 1;

            YELLOW_STATE:
                yellow = 1;

        endcase
    end

endmodule