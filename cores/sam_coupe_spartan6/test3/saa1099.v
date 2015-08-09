`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Miguel Angel Rodriguez Jodar
// 
// Create Date:    17:20:11 08/09/2015 
// Design Name:    SAM Coupé clone
// Module Name:    saa1099
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
module saa1099 (
    input wire clk,  // 8 MHz
    input wire rst_n,
    input wire cs_n,
    input wire a0,  // 0=data, 1=address
    input wire wr_n,
    input wire [7:0] din,
    output wire [7:0] out_l,
    output wire [7:0] out_r
    );
    // DTACK is not implemented. Sorry about that
        
    reg [7:0] amplit0, amplit1, amplit2, amplit3, amplit4, amplit5;
    reg [8:0] freq0, freq1, freq2, freq3, freq4, freq5;
    reg [7:0] oct10, oct32, oct54;
    reg [7:0] freqenable;
    reg [7:0] noiseenable;
    reg [7:0] noisegen;
    reg [7:0] envelope0, envelope1;
    reg [7:0] ctrl;  // frequency reset and sound enable for all channels
    
    reg [4:0] addr;  // holds the address of the register to write to
    
    // Write values into internal registers
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            ctrl <= 8'h00;
        end
        else begin
            if (cs_n == 1'b0 && wr_n == 1'b0) begin
                if (a0 == 1'b1)
                    addr <= din[4:0];
                else begin
                    case (addr)
                        5'h00: amplit0 <= din;
                        5'h01: amplit1 <= din;
                        5'h02: amplit2 <= din;
                        5'h03: amplit3 <= din;
                        5'h04: amplit4 <= din;
                        5'h05: amplit5 <= din;
                        
                        5'h08: freq0   <= 510 - {1'b0, din};
                        5'h09: freq1   <= 510 - {1'b0, din};
                        5'h0A: freq2   <= 510 - {1'b0, din};
                        5'h0B: freq3   <= 510 - {1'b0, din};
                        5'h0C: freq4   <= 510 - {1'b0, din};
                        5'h0D: freq5   <= 510 - {1'b0, din};
                        
                        5'h10: oct10   <= din;
                        5'h11: oct32   <= din;
                        5'h12: oct54   <= din;
                        
                        5'h14: freqenable <= din;
                        5'h15: noiseenable <= din;
                        5'h16: noisegen <= din;
                        
                        5'h18: envelope0 <= din;
                        5'h19: envelope1 <= din;
                        
                        5'h1C: ctrl <= din;
                    endcase
                end
            end
        end
    end
                     
    wire gen0_tone;
    wire gen1_tone;
    wire gen2_tone;
    wire gen3_tone;
    wire gen4_tone;
    wire gen5_tone;
    
    wire pulse_to_noise0, pulse_to_envelope0;
    wire pulse_to_noise1, pulse_to_envelope1;
    
    wire noise0, noise1;
    
    wire [4:0] mixout1_0, mixout0_r;
    wire [4:0] mixout1_l, mixout1_r;
    wire [4:0] mixout1_2, mixout2_r;
    wire [4:0] mixout1_3, mixout3_r;
    wire [4:0] mixout1_4, mixout4_r;
    wire [4:0] mixout1_5, mixout5_r;
    
    
    // Frequency and noise generators, top half

    saa1099_tone_gen freq_gen0 (
        .clk(clk),
        .octave(oct10[2:0]),
        .freq(freq0),
        .out(gen0_tone),
        .pulseout(pulse_to_noise0)
    );

    saa1099_tone_gen freq_gen1 (
        .clk(clk),
        .octave(oct10[6:4]),
        .freq(freq1),
        .out(gen1_tone),
        .pulseout(pulse_to_envelope0)
    );

    saa1099_tone_gen freq_gen2 (
        .clk(clk),
        .octave(oct32[2:0]),
        .freq(freq2),
        .out(gen2_tone),
        .pulseout()
    );

    saa1099_noise_gen noise0 (
        .clk(clk),
        .rst_n(rst_n),
        .pulse_from_gen(pulse_to_noise0),
        .noise_freq(noisegen[1:0]),
        .out(noise0)
    );


    // Frequency and noise generators, bottom half

    saa1099_tone_gen freq_gen3 (
        .clk(clk),
        .octave(oct32[6:4]),
        .freq(freq3),
        .out(gen3_tone),
        .pulseout(pulse_to_noise1)
    );

    saa1099_tone_gen freq_gen4 (
        .clk(clk),
        .octave(oct54[2:0]),
        .freq(freq4),
        .out(gen4_tone),
        .pulseout(pulse_to_envelope1)
    );

    saa1099_tone_gen freq_gen5 (
        .clk(clk),
        .octave(oct54[6:4]),
        .freq(freq5),
        .out(gen5_tone),
        .pulseout()
    );

    saa1099_noise_gen noise1 (
        .clk(clk),
        .rst_n(rst_n),
        .pulse_from_gen(pulse_to_noise1),
        .noise_freq(noisegen[5:4]),
        .out(noise1)
    );


    // Mixers

    sa1099_mixer_and_amplitude mixer0 (
        .clk(clk),
        .en_tone(freqenable[0] == 1'b1 && (noisegen[1:0] != 2'd3)),  // if gen0 is being used to generate noise, don't use this channel for tone output
        .en_noise(noiseenable[0]),
        .tone(gen0_tone),
        .noise(noise0),
        .amplitude_l(amplit0[3:0]),
        .amplitude_r(amplit0[4:7]),
        .out_l(mixout0_l),
        .out_r(mixout0_r)
    );

    sa1099_mixer_and_amplitude mixer1 (
        .clk(clk),
        .en_tone(freqenable[1] == 1'b1 && (envelope0[7] == 1'b0)),
        .en_noise(noiseenable[0]),
        .tone(gen1_tone),
        .noise(noise0),
        .amplitude_l(amplit1[3:0]),
        .amplitude_r(amplit1[4:7]),
        .out_l(mixout1_l),
        .out_r(mixout1_r)
    );

    sa1099_mixer_and_amplitude mixer2 (
        .clk(clk),
        .en_tone(freqenable[2]),
        .en_noise(noiseenable[0]),
        .tone(gen2_tone),
        .noise(noise0),
        .amplitude_l(amplit2[3:0]),
        .amplitude_r(amplit2[4:7]),
        .out_l(mixout2_l),
        .out_r(mixout2_r)
    );

    sa1099_mixer_and_amplitude mixer3 (
        .clk(clk),
        .en_tone(freqenable[3] == 1'b1 && (noisegen[5:4] != 2'd3)),  // if gen0 is being used to generate noise, don't use this channel for tone output
        .en_noise(noiseenable[1]),
        .tone(gen3_tone),
        .noise(noise1),
        .amplitude_l(amplit3[3:0]),
        .amplitude_r(amplit3[4:7]),
        .out_l(mixout3_l),
        .out_r(mixout3_r)
    );

    sa1099_mixer_and_amplitude mixer4 (
        .clk(clk),
        .en_tone(freqenable[4] == 1'b1 && (envelope1[7] == 1'b0)),
        .en_noise(noiseenable[1]),
        .tone(gen4_tone),
        .noise(noise1),
        .amplitude_l(amplit4[3:0]),
        .amplitude_r(amplit4[4:7]),
        .out_l(mixout4_l),
        .out_r(mixout4_r)
    );

    sa1099_mixer_and_amplitude mixer5 (
        .clk(clk),
        .en_tone(freqenable[5]),
        .en_noise(noiseenable[1]),
        .tone(gen5_tone),
        .noise(noise1),
        .amplitude_l(amplit5[3:0]),
        .amplitude_r(amplit5[4:7]),
        .out_l(mixout5_l),
        .out_r(mixout5_r)
    );


endmodule

module saa1099_tone_gen (
    input wire clk,
    input wire [2:0] octave,
    input wire [8:0] freq,
    output reg out,
    output wire pulseout
);
  
    reg [7:0] fcounter;
    always @* begin
        case (octave)
            3'd0: fcounter = 8'd255;
            3'd1: fcounter = 8'd127;
            3'd2: fcounter = 8'd63;
            3'd3: fcounter = 8'd31;
            3'd4: fcounter = 8'd15;
            3'd5: fcounter = 8'd7;
            3'd6: fcounter = 8'd3;
            3'd7: fcounter = 8'd1;
        endcase
    end
  
    reg [7:0] count = 8'd0;
    always @(posedge clk) begin
        if (count == fcounter)
            count <= 8'd0;
        else
        count <= count + 1;
    end
  
    reg pulse;
    always @* begin
        if (count == fcounter)
            pulse = 1'b1;
        else
            pulse = 1'b0;
    end
  
    initial out = 1'b0;    
    reg [8:0] cfinal = 9'd0;
    always @(posedge clk) begin
        if (pulse == 1'b1) begin
            if (cfinal == freq) begin
                cfinal <= 9'd0;
                out <= ~out;
            end
            else
                cfinal <= cfinal + 1;
        end
    end
    
    always @* begin
        if (pulse == 1'b1 && cfinal == freq)
            pulseout = 1'b1;
        else
            pulseout = 1'b0;
    end
endmodule

module saa1099_noise_gen (
    input wire clk,
    input wire rst_n,
    input wire pulse_from_gen,
    input wire [1:0] noise_freq,
    output wire out
    );
    
    reg [10:0] fcounter;
    always @* begin
        case (noise_freq)
            2'd0: fcounter = 11'd255;
            2'd1: fcounter = 11'd511;
            2'd2: fcounter = 11'd1023;
            default: fcounter = 11'd2047;  // actually not used
        endcase
    end
  
    reg [10:0] count = 11'd0;
    always @(posedge clk) begin
        if (count == fcounter)
            count <= 11'd0;
        else
        count <= count + 1;
    end
    
    reg [30:0] lfsr = 31'h11111111;
    always @(posedge clk) begin
        if (rst_n == 1'b0)
            lfsr <= 31'h11111111;  // just a seed
        if ((noise_freq == 2'd3 && pulse_from_gen == 1'b1) ||
            (noise_freq != 2'd3 && count == fcounter)) begin
                if ((lfsr[2] ^ lfsr[30]) == 1'b1)
                    lfsr <= {lfsr[29:0], 1'b1};
                else
                    lfsr <= {lfsr[29:0], 1'b0};
        end
    end
    
    assign out = lfsr[0];

endmodule

module sa1099_mixer_and_amplitude (
    input wire clk,
    input wire en_tone,
    input wire en_noise,
    input wire tone,
    input wire noise,
    input wire [3:0] amplitude_l,
    input wire [3:0] amplitude_r,
    output reg [4:0] out_l,
    output reg [4:0] out_r
    );

    reg [4:0] next_out_l, next_out_r;
    always @* begin
        next_out_l = 5'b00000;
        next_out_r = 5'b00000;
        if (en_tone == 1'b1)
            if (tone == 1'b1) begin
                next_out_l = next_out_l + amplitude_l;
                next_out_r = next_out_r + amplitude_r;
            end
        if (en_noise == 1'b1)
            if (noise == 1'b1) begin
                next_out_l = next_out_l + amplitude_l;
                next_out_r = next_out_r + amplitude_r;
            end
    end
    
    always @(posedge clk) begin
        out_l <= next_out_l;
        out_r <= next_out_r;
    end
endmodule

module saa1099_output_mixer (
    input wire [4:0] i1,
    input wire [4:0] i2,
    input wire [4:0] i3,
    input wire [4:0] i4,
    input wire [4:0] i5,
    input wire [4:0] i6,
    output reg [9:0] o
    );
    
    always @* begin
        o = i1 + i2 + i3 + i4 + i5;
    end
endmodule
    
    