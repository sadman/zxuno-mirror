`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:53 06/03/2015 
// Design Name: 
// Module Name:    ps2_keyb 
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
module ps2_keyb(
    input wire clk,
    input wire clkps2,
    input wire dataps2,
    output wire [7:0] scancode,
    input wire [7:0] kbcommand,
    input wire kbcommand_load,
    output wire kbnewkey,
    output wire kbextended,
    output wire kbreleased,
    output wire kberror,
    output wire kbbusy,
    //---------------------------------
    input wire [7:0] rows,
    output wire [4:0] cols,
    output wire [4:0] joy,
    output wire rst_out_n,
    output wire nmi_out_n,
    output wire mrst_out_n,
    output wire [4:0] user_toggles
    );

    wire master_reset, user_reset, user_nmi;
    assign mrst_out_n = ~master_reset;
    assign rst_out_n = ~user_reset;
    assign nmi_out_n = ~user_nmi;

    wire [7:0] kbcode;
    wire ps2busy = 1'b0;
    wire nueva_tecla;
    wire extended;
    wire released;
    assign scancode = kbcode;
    assign kbnewkey = nueva_tecla;    
    assign kbbusy = ps2busy;
    assign kbextended = extended;
    assign kbreleased = released;

    ps2_port lectura_de_teclado (
        .clk(clk),
        .enable_rcv(~ps2busy),
        .ps2clk_ext(clkps2),
        .ps2data_ext(dataps2),
        .kb_interrupt(nueva_tecla),
        .scancode(kbcode),
        .released(released),
        .extended(extended)
    );

    scancode_to_speccy traductor (
        .clk(clk),
        .rst(1'b0),
        .scan_received(nueva_tecla),
        .scan(kbcode),
        .extended(extended),
        .released(released),
        .sp_row(rows),
        .sp_col(cols),
        .joyup(joy[3]),
        .joydown(joy[2]),
        .joyleft(joy[1]),
        .joyright(joy[0]),
        .joyfire(joy[4]),
        .master_reset(master_reset),
        .user_reset(user_reset),
        .user_nmi(user_nmi),
        .user_toggles(user_toggles)
        );

//    ps2_host_to_kb escritura_a_teclado (
//        .clk(clk),
//        .ps2clk_ext(clkps2),
//        .ps2data_ext(dataps2),
//        .data(kbcommand),
//        .dataload(kbcommand_load),
//        .ps2busy(ps2busy),
//        .ps2error(kberror)
//    );
endmodule
