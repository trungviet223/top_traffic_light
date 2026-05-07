module tick_1hz_gen (
    input  wire clk,
    output reg  tick_1hz
);

  reg [26:0] counter = 0;

  always @(posedge clk) begin
    if (counter == 100_000_000 - 1) begin
      counter  <= 0;
      tick_1hz <= 1'b1;  // xung 1 chu kỳ
    end else begin
      counter  <= counter + 1;
      tick_1hz <= 1'b0;
    end
  end

endmodule
