`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:17 06/21/2015 
// Design Name: 
// Module Name:    alltogether 
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

module alltogether (
    // clock and control
    input wire clk,
    input wire rst_n,
    // CPU interface
    input wire [15:0] a,
    output wire [7:0] din,  // from device to CPU
    input wire [7:0] dout,  // from CPU to device
    output wire oe_n,
    input wire iorq_n,
    input wire rd_n,
    input wire wr_n,
    // PZX file player interface
    input wire play,
    input wire stop,
    output wire ear,
    output wire oe_ear_n,
    // SRAM interface
    output wire [20:0] sramaddr,
    inout wire [7:0] sramdata,
    output wire sramwe_n
    );
    
    wire [7:0] regs_dout;
    wire oe_n_regs;
    
    wire [7:0] zxuno_regaddr;
    wire zxuno_regrd;
    wire zxuno_regwr;
    wire regaddr_changed;
    
    wire [7:0] coreid_dout;
    wire oe_n_coreid;
    
    wire [7:0] pzx_dout;
    wire oe_n_pzx;
    wire tape_in_use;
    
    assign oe_ear_n = (tape_in_use && iorq_n == 1'b0 && rd_n == 1'b0 && a[0] == 1'b0)? 1'b0 : 1'b1;
    assign din = (oe_n_regs == 1'b0)?   regs_dout :
                 (oe_n_coreid == 1'b0)? coreid_dout :
                 (oe_n_pzx == 1'b0)?    pzx_dout :
                                        8'hZZ;
    assign oe_n = oe_n_regs & oe_n_coreid & oe_n_pzx;
                        
    zxunoregs register_bank (
     .clk(clk),
     .rst_n(rst_n),
     .a(a),
     .iorq_n(iorq_n),
     .rd_n(rd_n),
     .wr_n(wr_n),
     .din(dout),
     .dout(regs_dout),
     .oe_n(oe_n_regs),
     .addr(zxuno_regaddr),
     .read_from_reg(zxuno_regrd),
     .write_to_reg(zxuno_regwr),
     .regaddr_changed(regaddr_changed)
    );
    
    coreid identification (
     .clk(clk),
     .rst_n(rst_n),
     .zxuno_addr(zxuno_regaddr),
     .zxuno_regrd(zxuno_regrd),
     .regaddr_changed(regaddr_changed),
     .dout(coreid_dout),
     .oe_n(oe_n_coreid)
    );
    
    pzx_player the_player (
     .clk(clk),
     .rst_n(rst_n),
    //--------------------
     .zxuno_addr(zxuno_regaddr),
     .zxuno_regrd(zxuno_regrd),
     .zxuno_regwr(zxuno_regwr),
     .din(dout),
     .dout(pzx_dout),
     .oe_n(oe_n_pzx),
    //--------------------
     .play_in(play),
     .stop_in(stop),
     .pulse_out(ear),
     .playing(tape_in_use),
    //--------------------
     .addr(sramaddr),
     .we_n(sramwe_n),
     .data(sramdata)
    );
endmodule
