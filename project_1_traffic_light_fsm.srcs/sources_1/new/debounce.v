module debounce (
    input  wire clk,
    input  wire btn,
    output reg  btn_pulse
);

  reg [15:0] shift = 0;
  reg btn_stable = 0;
  reg last = 0;

  always @(posedge clk) begin
    shift <= {shift[14:0], btn};

    if (shift == 16'hFFFF) btn_stable <= 1'b1;
    else if (shift == 16'h0000) btn_stable <= 1'b0;

    btn_pulse <= btn_stable & ~last;
    last <= btn_stable;
  end

endmodule
