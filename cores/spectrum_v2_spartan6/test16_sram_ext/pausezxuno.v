`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:32 06/16/2015 
// Design Name: 
// Module Name:    pausezxuno 
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
module pausezxuno (
    input wire clk,
    input wire rst_n,
    input wire pulsador,
    output wire wait_n,
    output wire enable_clkay
    );
    
    reg en_pausa = 1'b0;
    reg [1:0] edgedetect = 2'b00;
    assign wait_n = ~en_pausa;
    assign enable_clkay = ~en_pausa;
    
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            en_pausa <= 1'b0;
            edgedetect <= 2'b00;
        end
        else begin
            edgedetect <= {edgedetect[0], pulsador};
            if (edgedetect == 2'b01)
                en_pausa <= ~en_pausa;
        end
    end
endmodule
