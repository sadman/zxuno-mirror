`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:57:57 12/30/2014 
// Design Name: 
// Module Name:    sistema 
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
module sistema(
    input wire clk,
    input wire clkforz80,
    input wire clkps2,
    input wire dataps2,
    output wire led,
	 
    output wire z80_reset_n,
    output wire z80_clk,
    output wire z80_int_n,
    output wire z80_nmi_n,
    input wire z80_m1_n,
    input wire z80_mreq_n,
    input wire z80_iorq_n,
    input wire z80_rd_n,
    input wire z80_wr_n,
    input wire [15:0] z80_a,
    inout wire [7:0] z80_d
    );

    wire mreq_n, iorq_n, rd_n, wr_n;
    wire [15:0] cpuaddr;
    wire [7:0] cpudin;
    wire [7:0] cpudout;

    reg [4:0] cntreset = 5'b00000;
    always @(posedge clk) begin
        if (cntreset[4] == 1'b0)
            cntreset <= cntreset + 1;
    end
    wire reset_n = cntreset[4];

    wire [7:0] tecla;
    wire soltada,extendida;

    wire [7:0] memdout;
    
    reg [7:0] busdatosin;
    assign cpudin = busdatosin;
    always @* begin
        if (!mreq_n && !rd_n)
            busdatosin = memdout;
        else if (!iorq_n && !rd_n && cpuaddr[7:0]==8'h00)
            busdatosin = tecla;
        else if (!iorq_n && !rd_n && cpuaddr[7:0]==8'h01)
            busdatosin = { 6'b000000, extendida, soltada };
        else
            busdatosin = 8'hZZ;
    end

    reg rled = 1'b1;
    assign led = rled;
    always @(posedge clk) begin
        if (!iorq_n && !wr_n && cpuaddr[7:0]==8'h02)
            rled <= cpudout[0];
    end

    memoria rom_y_ram (
        .clk(clk),
        .a(cpuaddr[7:0]),
        .we(!mreq_n && !wr_n),
        .din(cpudout),
        .dout(memdout)
        );

	ps2_port el_teclado (
		.clk(clk),
		.enable_rcv(1'b1),
		.ps2clk_ext(clkps2),
		.ps2data_ext(dataps2),
		.kb_interrupt(),
		.scancode(tecla),
		.released(soltada),
		.extended(extendida)
    );
	 
	tv80n_wrapper la_cpu (
        .reset_n(reset_n),
        .clk(clkforz80),
        .wait_n(1'b1),
        .int_n(1'b1),
        .nmi_n(1'b1),
        .busrq_n(1'b1),
        .m1_n(),
        .mreq_n(mreq_n),
        .iorq_n(iorq_n),
        .rd_n(rd_n),
        .wr_n(wr_n),
        .rfsh_n(),
        .halt_n(),
        .busak_n(),
        .A(cpuaddr),
        .di(cpudin),
        .dout(cpudout),
  
        .z80_reset_n(z80_reset_n),
        .z80_clk(z80_clk),
        .z80_int_n(z80_int_n),
        .z80_nmi_n(z80_nmi_n),
        .z80_m1_n(z80_m1_n),
        .z80_mreq_n(z80_mreq_n),
        .z80_iorq_n(z80_iorq_n),
        .z80_rd_n(z80_rd_n),
        .z80_wr_n(z80_wr_n),
        .z80_a(z80_a),
        .z80_d(z80_d)
  );

//  tv80n_wrapper_interno la_cpu (
//        .reset_n(reset_n),
//        .clk(clk),
//        .wait_n(1'b1),
//        .int_n(1'b1),
//        .nmi_n(1'b1),
//        .busrq_n(1'b1),
//        .m1_n(),
//        .mreq_n(mreq_n),
//        .iorq_n(iorq_n),
//        .rd_n(rd_n),
//        .wr_n(wr_n),
//        .rfsh_n(),
//        .halt_n(),
//        .busak_n(),
//        .A(cpuaddr),
//        .di(cpudin),
//        .dout(cpudout)
//  );

endmodule

module memoria (
    input wire clk,
    input wire [7:0] a,
    input wire we,
    input wire [7:0] din,
    output reg [7:0] dout
    );
    
    reg [7:0] mem[0:255];  // la memoria

    integer i;
    initial begin
        for (i=0; i<256; i=i+1) begin
            mem[i] = 8'h00;
        end
        $readmemh ("pruebaz80.hex", mem);
    end
    
    always @(posedge clk) begin
        if (we)
            mem[a] <= din;
        else
            dout <= mem[a];
    end
endmodule
