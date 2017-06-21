module boot_rom (
    input wire clk,
	 input wire RD_n,
    input wire [13:0] A,
    output reg [7:0] D_out
    );

//(* ROM_STYLE="BLOCK" *)
   reg [7:0] mem[0:16383];
   integer i;
   initial begin 
//      for (i=0;i<16383;i=i+1) begin
//        mem[i] = 8'h00;
//      end
      $readmemh ("/boot.hex", mem);
   end

   always @(posedge clk) begin
		if (RD_n == 1'b0) begin
			D_out <= mem[A];
		end
   end
endmodule