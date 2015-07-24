`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:33 07/23/2015 
// Design Name: 
// Module Name:    asic 
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
module asic (
    input wire clk,
    input wire rst_n,
    // CPU interface
    input wire mreq_n,
    input wire iorq_n,
    input wire rd_n,
    input wire wr_n,
    input wire [15:0] cpuaddr,
    input wire [7:0] data_from_cpu,
    output reg [7:0] data_to_cpu,
    output reg wait_n,
    // RAM/ROM interface
    output reg [18:0] ramaddr,
    input wire [7:0] data_from_ram,
    output reg [7:0] data_to_ram,
    output reg ramwr_n,
    output reg romcs_n,
    // audio I/O
    output wire mic,
    output wire beep,
    // video output
    output wire [1:0] r,
    output wire [1:0] g,
    output wire [1:0] b,
    output wire bright,
    output reg csync,
    output wire int_n
    );

    parameter HACTIVEREGION = 512,
              RBORDER       = 64,
              HFPORCH       = 16,
              HSYNC         = 64,
              HBPORCH       = 64,
              LBORDER       = 48;
              
    parameter HTOTAL = HACTIVEREGION + 
                       RBORDER + 
                       HFPORCH + 
                       HSYNC + 
                       HBPORCH + 
                       LBORDER;
    
    parameter VACTIVEREGION = 192,
              BBORDER       = 48,
              VFPORCH       = 4,
              VSYNC         = 4,
              VBPORCH       = 16,
              TBORDER       = 48;
              
    parameter VTOTAL = VACTIVEREGION + 
                       BBORDER + 
                       VFPORCH + 
                       VSYNC + 
                       VBPORCH + 
                       TBORDER;
    
    parameter BEGINVSYNCH = HACTIVEREGION + RBORDER + HFPORCH + HSYNC + HBPORCH;
    parameter BEGINVINTH  = HACTIVEREGION + RBORDER + HFPORCH;
    parameter BEGINVINTV  = VACTIVEREGION + BBORDER + VFPORCH - 1;
    parameter ENDVINTV    = VACTIVEREGION + BBORDER + VFPORCH;
    parameter ENDVINTH    = (BEGINVINTH + 256)%HTOTAL;
    parameter BEGINHINTH  = BEGINVSYNCH;
    parameter ENDHINTH    = (BEGINHINTH + 256)%HTOTAL;

    parameter IOADDR_VMPR     = 8'd252,
              IOADDR_HMPR     = 8'd251,
              IOADDR_LMPR     = 8'd250,
              IOADDR_BORDER   = 8'd254,
              IOADDR_LINEINT  = 8'd249,
              IOADDR_BASECLUT = 8'd248,
              IOADDR_ATTRIB   = 8'd255;
    
    //////////////////////////////////////////////////////////////////////////
    // IO regs
    reg [7:0] vmpr = 8'b00000000;  // port 252. bit 7 is not used. R/W
    wire [1:0] screen_mode = vmpr[6:5];
    wire [4:0] screen_page = vmpr[4:0];
    
    reg [7:0] hmpr = 8'h00;  // port 251. Bit 7 is not used for now. R/W
    wire [4:0] high_page = hmpr[4:0];
    wire [1:0] clut_mode_3_hi = hmpr[6:5];
    
    reg [7:0] lmpr = 8'b00000000;  // port 250. R/W
    wire [4:0] low_page = lmpr[4:0];
    wire rom_in_section_a = ~lmpr[5];
    wire rom_in_section_d = lmpr[6];
    wire write_protect_section_a = lmpr[7];
    
    reg [7:0] border = 8'h00;  // port 254. Bit 6 not implemented. Write only
    wire [3:0] clut_border = {border[5],border[2:0]};
    assign mic = border[3];
    assign beep = border[4];
    wire screen_off = border[7];
    
    reg [7:0] lineint = 8'hFF;   // port 249 write only
    
    reg [6:0] clut[0:15];  // Port xF8h where x=0..F 
    integer i;
    initial begin
        for (i=0;i<16;i=i+1)
            clut[i] = 7'h00;
    end
        
    //////////////////////////////////////////////////////////////////////////
    // Pixel counter and scan counter
    reg [9:0] hc = 10'h000;
    reg [8:0] vc = 9'h000;
    
    always @(posedge clk) begin
        if (hc != (HTOTAL-1))
            hc <= hc + 1;
        else begin
            hc <= 10'h000;
            if (vc != (VTOTAL-1))
                vc <= vc + 1;
            else
                vc <= 9'h000;
        end
    end
    
    //////////////////////////////////////////////////////////////////////////
    // Syncs and vertical retrace/raster line int generation
    reg vint_n;
    reg rint_n;
    
    always @* begin
        csync = 1'b1;
        vint_n = 1'b1;
        rint_n = 1'b1;
        if (hc >= (HACTIVEREGION + RBORDER + HFPORCH) && 
            hc < (HACTIVEREGION + RBORDER + HFPORCH + HSYNC))
                csync = 1'b0;
        if ( (vc > BEGINVINTV && vc < (BEGINVINTV+4)) ||
             (vc == BEGINVINTV && hc >= BEGINVSYNCH) ||
             (vc == (BEGINVINTV+4) && hc < BEGINVSYNCH) )
                csync = ~csync;
        if ( (vc == BEGINVINTV && hc >= BEGINVINTH) ||
             (vc == ENDVINTV && hc < ENDVINTH) )
                vint_n = 1'b0;
        if (lineint >= 8'd0 && lineint <= 8'd191)
            if ( ( ((lineint == 8'd0 && vc == VTOTAL-1) || (lineint == vc-1)) && hc >= BEGINHINTH ) ||
                 ( lineint == vc && hc < ENDHINTH ) )
                 rint_n = 1'b0;
    end
    assign int_n = vint_n | rint_n;
    
    //////////////////////////////////////////////////////////////////////////
    // fetching_pixels = 1 when pixels should be fetched from memory
    reg fetching_pixels;
    
    always @* begin
        if (vc>=0 && vc<VACTIVEREGION && hc>=0 && hc<HACTIVEREGION)
            fetching_pixels = ~screen_off;
        else
            fetching_pixels = 1'b0;
    end
    
    //////////////////////////////////////////////////////////////////////////
    // Contention signal (risk of)
    reg contention;
    
    always @* begin
        contention = 1'b0;
        if (fetching_pixels == 1'b1 && hc[3:0]<4'd10)
            contention = 1'b1;
        else if (fetching_pixels == 1'b0 && (hc[3:0]==4'd0 ||
                                            hc[3:0]==4'd1 ||
                                            hc[3:0]==4'd8 ||
                                            hc[3:0]==4'd9) )
            contention = 1'b1;
        if (screen_mode == 2'b00 && hc[3:0]<4'd10 && hc[9:4]<6'd40)
            contention = 1'b1;
    end
    
    //////////////////////////////////////////////////////////////////////////
    // WAIT signal with contention applied
    always @* begin
        wait_n = 1'b1;
        if (cpuaddr<16'h4000 && rom_in_section_a==1'b1)
            wait_n = 1'b1;
        else if (cpuaddr>=16'hC000 && rom_in_section_d==1'b1)
            wait_n = 1'b1;
        else if (contention == 1'b1) begin
            if (mreq_n == 1'b0)
                wait_n = 1'b0;
            else if (iorq_n == 1'b0)
                if (rd_n == 1'b0 || wr_n == 1'b0)
                    wait_n = 1'b0;
        end
    end
    
    //////////////////////////////////////////////////////////////////////////
    // FSM for fetching pixels from RAM and shift registers
    reg [14:0] screen_offs = 15'h0000;
    reg [4:0] screen_column = 5'h00;
    reg [7:0] vram_byte1, vram_byte2, vram_byte3, vram_byte4;
    reg [18:0] vramaddr = 19'h00000;
    reg [7:0] sregm12 = 8'h00;
    reg [7:0] attrreg = 8'h00;
    reg [31:0] sregm3 = 32'h00000000, sregm4 = 32'h00000000;
    reg [4:0] flash_counter = 5'h00;
    reg [1:0] hibits_clut_m3 = 2'b00;
    
    always @(posedge clk) begin
        // a good time to reset pixel address counters and advance flash counter for modes 1 and 2
        if (vc==(VTOTAL-1) && hc==(HTOTAL-1)) begin
            screen_offs <= 15'h0000;
            screen_column <= 5'h00;
            flash_counter <= flash_counter + 1;
        end
        case (hc[3:0])
            4'd0,
            4'd2,
            4'd4,
            4'd6: 
                if (fetching_pixels==1'b1) begin
                    if (screen_mode == 2'd0) begin
                        if (hc[3:0] == 4'd0)
                            vramaddr <= {screen_page, 2'b00, vc[7:6], vc[2:0], vc[5:3], screen_column};
                        else if (hc[3:0] == 4'd4)
                            vramaddr <= {screen_page, 5'b00110, vc[7:3], screen_column};
                    end
                    else if (screen_mode == 2'd1) begin
                        if (hc[3:0] == 4'd0)
                            vramaddr <= {screen_page, 2'b00, screen_offs[12:0]};
                        else if (hc[3:0] == 4'd4)
                            vramaddr <= {screen_page, 2'b01, screen_offs[12:0]};
                    end
                    else
                        vramaddr <= {screen_page[4:1], 1'b0, screen_offs};
                end
            4'd1: 
                if (fetching_pixels==1'b1) begin
                    vram_byte1 <= data_from_ram;
                    if (screen_mode > 2'd1)
                        screen_offs <= screen_offs + 1;
                end
            4'd3: 
                if (fetching_pixels==1'b1) begin
                    vram_byte2 <= data_from_ram;
                    if (screen_mode > 2'd1)
                        screen_offs <= screen_offs + 1;
                end
            4'd5: 
                if (fetching_pixels==1'b1) begin
                    vram_byte3 <= data_from_ram;
                    if (screen_mode > 2'd1)
                        screen_offs <= screen_offs + 1;
                end
            4'd7: 
                if (fetching_pixels==1'b1) begin
                    vram_byte4 <= data_from_ram;
                    screen_offs <= screen_offs + 1;
                    screen_column <= screen_column + 1;
                end
            4'd9:
                begin
                    vramaddr <= 29'hZZZZZ;
                end
        endcase
        case (hc[3:0])
            4'd9:
                begin
                    // Transferir buffers al registro de desplazamiento
                    if (fetching_pixels == 1'b1) begin
                        sregm12 <= vram_byte1;
                        attrreg <= vram_byte3;  // cambiar para el borde!!
                        sregm3 <= {vram_byte1, vram_byte2, vram_byte3, vram_byte4};
                        sregm4 <= {vram_byte1, vram_byte2, vram_byte3, vram_byte4};
                        hibits_clut_m3 <= clut_mode_3_hi;
                    end
                    else begin
                        sregm12 <= 8'h00;
                        attrreg <= {1'b0, clut_border, 3'b000};
                        sregm3 <= { {16{clut_border[1:0]}} };
                        hibits_clut_m3 <= clut_border[3:2];
                        sregm4 <= { {8{clut_border}} };
                    end
                end
            default:
                begin
                    if (hc[0]==1'b1) begin
                        sregm12 <= {sregm12[6:0],1'b0};
                        sregm4 <= {sregm4[27:0],4'h0};
                    end
                    sregm3 <= {sregm3[29:0],2'b00};
                end
        endcase
    end

    //////////////////////////////////////////////////////////////////////////
    // MUX to select current pixel colour depending upon the current mode
    reg [6:0] pixel;
    reg [3:0] index;
    reg pixel_with_flash;
    
    always @* begin
        case (screen_mode)
            2'd0,2'd1:
                begin
                    pixel_with_flash = sregm12[7] ^ (attrreg[7] & flash_counter[4]);
                    if (pixel_with_flash == 1'b0)
                        index = {attrreg[6],attrreg[2:0]};
                    else
                        index = {attrreg[6],attrreg[5:3]};
                    pixel = clut[index];
                end
            2'd2: 
                begin
                    pixel = clut[{hibits_clut_m3, sregm3[31:30]}];
                end
            default:
                begin
                    pixel = clut[sregm3[31:28]];
                end
        endcase
    end
    assign r = {pixel[5], pixel[1]};
    assign g = {pixel[6], pixel[2]};
    assign b = {pixel[4], pixel[0]};
    assign bright = pixel[3];
    
    //////////////////////////////////////////////////////////////////////////
    // Memory handling
    always @* begin
        romcs_n = 1'b1;
        ramwr_n = 1'b1;
        data_to_cpu = 8'hZZ;
        data_to_ram = 8'hZZ;
        if (cpuaddr<16'h4000 && rom_in_section_a==1'b1) begin
            romcs_n = 1'b0;
            ramaddr = vramaddr;
        end
        else if (cpuaddr>=16'hC000 && rom_in_section_d==1'b1) begin
            romcs_n = 1'b0;
            ramaddr = vramaddr;
        end
        else begin
            if (fetching_pixels == 1'b1 && contention == 1'b1) begin
                ramaddr = vramaddr;
            end
            else begin
                if (mreq_n == 1'b0 && iorq_n == 1'b1)
                    data_to_cpu = data_from_ram;
                if (cpuaddr < 16'h8000) begin
                    ramaddr = {low_page, cpuaddr[13:0]};
                    if (write_protect_section_a == 1'b0 || cpuaddr >= 16'h4000)
                        ramwr_n = mreq_n | wr_n;
                end
                else begin
                    ramaddr = {high_page, cpuaddr[13:0]};
                    ramwr_n = mreq_n | wr_n;
                end
            end
        end
        if (ramwr_n == 1'b0)
            data_to_ram = data_from_cpu;
    end

    //////////////////////////////////////////////////////////////////////////
    // IO ports
    
    // Write to IO ports
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            vmpr <= 8'h00;
            hmpr <= 8'h00;
            lmpr <= 8'h00;
            border <= 8'h00;
            lineint <= 8'hFF;
            
    
endmodule
