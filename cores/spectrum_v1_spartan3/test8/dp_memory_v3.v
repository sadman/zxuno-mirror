`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:08:40 02/15/2014 
// Design Name: 
// Module Name:    dp_memory_v3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module dp_memory_v3 (
    input wire clk,  // 20MHz
    input wire [18:0] a1,
    output wire [7:0] dout1,
    input wire rd1_n,
    input wire [18:0] a2,
    input wire [7:0] din2,
    output wire [7:0] dout2,
    input wire rd2_n,
    input wire wr2_n,
    
    output reg [18:0] a,
    inout wire [7:0] d,
    output reg we_n
    );

   parameter
		ACCESO_M1 = 1,
		READ_M1   = 2,
		WRITE_M1  = 3,
		ACCESO_M2 = 4,
		READ_M2   = 5,
		WRITE_M2  = 6;		

   reg [7:0] data_to_write;
	reg enable_input_to_sram;
	
	reg [7:0] doutput1;
	reg [7:0] doutput2;
	reg write_in_dout1;
	reg write_in_dout2;

	reg [2:0] state = ACCESO_M1;
	reg [2:0] next_state;
	
	always @(posedge clk) begin
		state <= next_state;
	end

	always @* begin
		a = 0;
		we_n = 1;
		enable_input_to_sram = 0;
		next_state = ACCESO_M1;
		data_to_write = 8'h00;
		write_in_dout1 = 0;
		write_in_dout2 = 0;
		
		case (state)
			ACCESO_M1: begin
					 		 a = a1;
 						    next_state = READ_M1;
						  end
			READ_M1:   begin
                      a = a1;
                      write_in_dout1 = 1;
							 next_state = ACCESO_M2;
						  end
			ACCESO_M2: begin
							 a = a2;
							 if (wr2_n == 1) begin
							    next_state = READ_M2;
							 end
							 else begin
								 next_state = WRITE_M2;
							 end
						  end
			READ_M2:   begin
                      if (wr2_n == 1) begin
                        a = a2;
                        write_in_dout2 = 1;
                      end
                      next_state = ACCESO_M1;
						  end
			WRITE_M2:  begin
                      if (wr2_n == 0) begin
                        a = a2;
                        enable_input_to_sram = 1;
                        data_to_write = din2;
                        we_n = 0;
                      end
							 next_state = ACCESO_M1;
						  end
       endcase
	 end

    assign d = (enable_input_to_sram)? data_to_write : 8'hZZ;
	 assign dout1 = doutput1;
	 assign dout2 = (rd2_n)? 8'hZZ : doutput2;
	 
	 always @(posedge clk) begin
      if (write_in_dout1)
         doutput1 <= d;
		if (write_in_dout2)
			doutput2 <= d;
	 end

endmodule
