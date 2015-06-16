`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:22 06/16/2015 
// Design Name: 
// Module Name:    pzx_player 
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
module pzx_player(
    input wire clk,
    input wire rst_n,
    //--------------------
    input wire [7:0] zxuno_addr,
    input wire regaddr_changed,
    input wire zxuno_regrd,
    input wire zxuno_regwr,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire oe_n,
    //--------------------
    output wire [20:0] addr,
    output wire we_n,
    inout wire [7:0] data
    );
    
    parameter SRAMRDWRINC = 8'hFD,
              SRAMWRINC = 8'hFC;
              
    parameter IDLE              = 4'b1000,
              READ_IN_PROGRESS  = 4'b0100,
              WRITE_IN_PROGRESS = 4'b0010,
              INCADD            = 4'b0001;
    
    reg [20:0] a = 21'h000000;
    assign addr = a;
    
    assign oe_n = ~((zxuno_addr == SRAMRDWRINC || zxuno_addr == SRAMWRINC) && zxuno_regrd == 1'b1);
    assign we_n = ~((zxuno_addr == SRAMRDWRINC || zxuno_addr == SRAMWRINC) && zxuno_regwr == 1'b1);
    assign data = (we_n == 1'b0)? din : 8'hZZ;
    assign dout = data;
    
    reg [3:0] state = IDLE;
    always @(posedge clk) begin
        if (rst_n == 1'b0 || (regaddr_changed == 1 && (zxuno_addr == SRAMRDWRINC || zxuno_addr == SRAMWRINC))) begin
            state <= IDLE;
            a <= 21'h000000;
        end
        else if (state == IDLE) begin
            if ((zxuno_addr == SRAMRDWRINC || zxuno_addr == SRAMWRINC) && zxuno_regrd == 1'b1)
                state <= READ_IN_PROGRESS;
            else if ((zxuno_addr == SRAMRDWRINC || zxuno_addr == SRAMWRINC) && zxuno_regwr == 1'b1)
                state <= WRITE_IN_PROGRESS;
        end
        else if (state == READ_IN_PROGRESS) begin
            if (zxuno_regrd == 1'b0 && zxuno_regwr == 1'b0) begin
                if (zxuno_addr == SRAMRDWRINC)
                    state <= INCADD;
                else
                    state <= IDLE;
            end
        end
        else if (state == WRITE_IN_PROGRESS) begin
            if (zxuno_regrd == 1'b0 && zxuno_regwr == 1'b0)
                state <= INCADD;
        end
        else if (state == INCADD) begin
            a <= a + 1;
            state <= IDLE;
        end
    end
endmodule
