`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Miguel Angel Rodriguez Jodar
// 
// Create Date:    03:34:47 07/25/2015 
// Design Name:    SAM Coupé clone
// Module Name:    ram 
// Project Name:   SAM Coupé clone
// Target Devices: Spartan 6
// Tool versions:  ISE 12.4
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ram_dual_port (
    input wire clk12,
    input wire [18:0] vramaddr,
    input wire [18:0] cpuramaddr,
    input wire cpu_we_n,
    input wire [7:0] data_from_cpu,
    output wire [7:0] data_to_asic,
    output wire [7:0] data_to_cpu,
    // Actual interface with SRAM
    output reg [18:0] sram_a,
    output reg sram_we_n,
    inout wire [7:0] sram_d
    );
    
    reg turno = 1'b0;
    initial sram_we_n = 1'b1;
    assign sram_d = (sram_we_n == 1'b0)? data_from_cpu : 8'hZZ;

    always @(posedge clk12) begin
        turno <= ~turno;
        if (turno == 1'b0) begin
            sram_a <= vramaddr;
            data_to_cpu <= sram_d;
            sram_we_n <= 1'b1;
        end
        else begin
            sram_a <= cpuramaddr;
            if (cpu_we_n == 1'b0)
                sram_we_n <= 1'b0;
            data_to_asic <= sram_d;
        end
    end
endmodule
