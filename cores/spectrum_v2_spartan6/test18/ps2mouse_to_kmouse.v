`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:22 06/30/2015 
// Design Name: 
// Module Name:    ps2mouse_to_kmouse 
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
module ps2mouse_to_kmouse (
    input wire clk,
    input wire rst_n,
    input wire [7:0] data,
    input wire data_valid,
    output reg [7:0] kmouse_x,
    output reg [7:0] kmouse_y,
    output reg [7:0] kmouse_buttons    
    );
    
    parameter FIRST_FRAME     = 2'd0,
              SECOND_FRAME    = 2'd1,
              THIRD_FRAME     = 2'd2,
              CALCULATE_NEWXY = 2'd3;
    
    initial begin
        kmouse_x = 8'h00;
        kmouse_y = 8'h00;
        kmouse_buttons = 8'hFF;
    end    
    
    reg [7:0] deltax, deltay;
    reg signdx, signdy;
    reg [22:0] toutcnt = 23'h0;
    reg [1:0] state = FIRST_FRAME;
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            kmouse_x <= 8'h00;
            kmouse_y <= 8'h00;
            kmouse_buttons <= 8'hFF;
            toutcnt <= 23'h0;
            state <= FIRST_FRAME;
        end
        else begin
            if (toutcnt == 23'hFFFFFF)
                state <= FIRST_FRAME;
            else begin
                case (state)
                    FIRST_FRAME: 
                        if (data_valid == 1'b1) begin
                            kmouse_buttons <= {5'b11111,~data[2],~data[0],~data[1]};
                            signdx <= data[4];
                            signdy <= data[5];
                            state <= SECOND_FRAME;                            
                        end
                        else
                            toutcnt <= toutcnt + 1;
                    SECOND_FRAME:
                        if (data_valid == 1'b1) begin
                            deltax <= data;
                            state <= THIRD_FRAME;
                        end
                        else
                            toutcnt <= toutcnt + 1;
                    THIRD_FRAME:
                        if (data_valid == 1'b1) begin
                            deltay <= data;
                            state <= CALCULATE_NEWXY;
                        end
                        else
                            toutcnt <= toutcnt + 1;
                    CALCULATE_NEWXY:
                        begin
                            if (signdx == 1'b0)
                                kmouse_x <= kmouse_x + deltax;
                            else
                                kmouse_x <= kmouse_x - deltax;
                            if (signdy == 1'b0)
                                kmouse_y <= kmouse_y + deltay;
                            else
                                kmouse_y <= kmouse_y - deltay;
                            state <= FIRST_FRAME;
                            toutcnt <= 23'h0;
                        end
                endcase
            end
        end
    end
endmodule
