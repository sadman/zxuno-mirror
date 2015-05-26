`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:17 11/13/2013 
// Design Name: 
// Module Name:    bcd7seg 
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
module bcd7seg (
    input wire [3:0] d,
    output wire [6:0] seg
    );

    reg [6:0] tabla[0:15];
    initial begin
        tabla[0]  = 7'b0111111;
        tabla[1]  = 7'b0000110;
        tabla[2]  = 7'b1011011;
        tabla[3]  = 7'b1001111;
        tabla[4]  = 7'b1100110;
        tabla[5]  = 7'b1101101;
        tabla[6]  = 7'b1111101;
        tabla[7]  = 7'b0000111;
        tabla[8]  = 7'b1111111;
        tabla[9]  = 7'b1101111;
        tabla[10] = 7'b1110111;
        tabla[11] = 7'b1111100;
        tabla[12] = 7'b0111001;
        tabla[13] = 7'b1011110;
        tabla[14] = 7'b1111001;
        tabla[15] = 7'b1110001;
    end

    assign seg = ~tabla[d];
endmodule

module display (
    input wire clk,
    input wire [15:0] d,
    output wire [3:0] an,
    output wire [6:0] seg
    );
    
    reg [3:0] anodo = 4'b0111;
    always @(posedge clk)
        anodo <= {anodo[0],anodo[3:1]};
    assign an = anodo;    
    bcd7seg conversor ( !anodo[3]? d[15:12] :
                        !anodo[2]? d[11:8] :
                        !anodo[1]? d[7:4] :
                        !anodo[0]? d[3:0] :
                                   4'b0000 , seg);
endmodule

            