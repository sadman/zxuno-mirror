module joypad
(
  input  wire        clk_in,         // 100MHz system clock
  input  wire        rst_in,         // reset signal
  input  wire        joypad_clk,     // joypad clk signal
  input  wire        joypad_latch,   // joypad latch signal
  input  wire        up,
  input  wire        down,
  input  wire        left,
  input  wire        right,
  input  wire        A,
  input  wire        B,
  input  wire        select,
  input  wire        start,
  output wire        joypad_data     // joypad data signal
);

reg shift;
reg joypad_clk_delayed;
reg [7:0] sr;

always @ (posedge clk_in) begin
  if (rst_in) begin
    joypad_clk_delayed <= 1'b0;
    shift <= 1'b0;
  end else begin
    joypad_clk_delayed <= joypad_clk;
    shift <= joypad_clk & ~joypad_clk_delayed;
  end
end
       
  
always @ (posedge clk_in) begin
  if (rst_in)
    sr <= 8'd0;
  else if (joypad_latch)
    sr <= {~A, ~B, select, start, up, down, left, right};
  else if (shift)
    sr <= {sr[6:0], 1'b0};
end

assign joypad_data = sr[7];

endmodule

    