`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:56:25 01/02/2015 
// Design Name: 
// Module Name:    bus_expansion 
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
module bus_expansion (
    // Señales desde el core a la CPLD
    input wire clkmux,
    input wire selectmux,
    input wire [7:0] zxuno_a,
    input wire zxuno_clkcpu,
    inout wire [7:0] zxuno_d,
    input wire zxuno_mreq_n,
    input wire zxuno_iorq_n,
    input wire zxuno_rd_n,
    input wire zxuno_wr_n,
    input wire zxuno_m1_n,
    input wire zxuno_rfsh_n,
    input wire zxuno_y_n,
    inout wire zxuno_int_n,
    inout wire zxuno_iorqge,
    output wire zxuno_romcs,
    inout wire zxuno_reset_n,
    output wire zxuno_nmi_n,
    output wire zxuno_wait_n,
    
    // Señales desde la CPLD al bus de expansión
    output wire bus_clkcpu,
    output wire [15:0] bus_a,
    inout wire [7:0] bus_d,
    output wire bus_mreq_n,
    output wire bus_iorq_n,
    output wire bus_rd_n,
    output wire bus_wr_n,
    output wire bus_m1_n,
    output wire bus_rfsh_n,
    output wire bus_y_n,
    inout wire bus_int_n,
    inout wire bus_iorqge,
    input wire bus_romcs,
    inout wire bus_reset_n,
    input wire bus_nmi_n,
    input wire bus_wait_n
    );

    assign bus_clkcpu = zxuno_clkcpu;
    assign bus_mreq_n = zxuno_mreq_n;
    assign bus_iorq_n = zxuno_iorq_n;
    assign bus_rd_n = zxuno_rd_n;
    assign bus_wr_n = zxuno_wr_n;
    assign bus_m1_n = zxuno_m1_n;
    assign bus_rfsh_n = zxuno_rfsh_n;
    assign bus_y_n = zxuno_y_n;
    assign zxuno_nmi_n = bus_nmi_n;
    assign zxuno_wait_n = bus_wait_n;
    assign zxuno_romcs = bus_romcs;
    
    assign bus_d = (zxuno_wr_n == 1'b0)? zxuno_d : 8'hZZ;
    assign zxuno_d = (zxuno_wr_n == 1'b1)? bus_d : 8'hZZ;
    
    reg [7:0] abus_high_l1, abus_high_l2, abus_low_l2;
    assign bus_a = {abus_high_l2, abus_low_l2};
    always @(posedge clkmux) begin
        if (selectmux == 1'b1)
            abus_high_l1 <= zxuno_a;
        else begin
            abus_high_l2 <= abus_high_l1;
            abus_low_l2 <= zxuno_a;
        end
    end

    assign bus_int_n = zxuno_int_n;
    assign bus_iorqge = zxuno_iorqge;
    assign bus_reset_n = zxuno_reset_n;

endmodule
