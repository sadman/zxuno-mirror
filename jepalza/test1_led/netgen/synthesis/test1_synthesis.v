////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.40xd
//  \   \         Application: netgen
//  /   /         Filename: test1_synthesis.v
// /___/   /\     Timestamp: Fri Nov 28 08:42:12 2014
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim test1.ngc test1_synthesis.v 
// Device	: xc6slx9-2-tqg144
// Input file	: test1.ngc
// Output file	: C:\a\ZX_ONE\test_led_zxuno_v2\netgen\synthesis\test1_synthesis.v
// # of Modules	: 1
// Design Name	: test1
// Xilinx        : C:\Xilinx\14.3\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module test1 (
  clk50mhz, testled
);
  input clk50mhz;
  output testled;
  wire clk50mhz_BUFGP_0;
  wire N0;
  wire N1;
  wire \Mcount_divisor_cy<1>_rt_80 ;
  wire \Mcount_divisor_cy<2>_rt_81 ;
  wire \Mcount_divisor_cy<3>_rt_82 ;
  wire \Mcount_divisor_cy<4>_rt_83 ;
  wire \Mcount_divisor_cy<5>_rt_84 ;
  wire \Mcount_divisor_cy<6>_rt_85 ;
  wire \Mcount_divisor_cy<7>_rt_86 ;
  wire \Mcount_divisor_cy<8>_rt_87 ;
  wire \Mcount_divisor_cy<9>_rt_88 ;
  wire \Mcount_divisor_cy<10>_rt_89 ;
  wire \Mcount_divisor_cy<11>_rt_90 ;
  wire \Mcount_divisor_cy<12>_rt_91 ;
  wire \Mcount_divisor_cy<13>_rt_92 ;
  wire \Mcount_divisor_cy<14>_rt_93 ;
  wire \Mcount_divisor_cy<15>_rt_94 ;
  wire \Mcount_divisor_cy<16>_rt_95 ;
  wire \Mcount_divisor_cy<17>_rt_96 ;
  wire \Mcount_divisor_cy<18>_rt_97 ;
  wire \Mcount_divisor_cy<19>_rt_98 ;
  wire \Mcount_divisor_cy<20>_rt_99 ;
  wire \Mcount_divisor_cy<21>_rt_100 ;
  wire \Mcount_divisor_cy<22>_rt_101 ;
  wire \Mcount_divisor_cy<23>_rt_102 ;
  wire \Mcount_divisor_xor<24>_rt_103 ;
  wire [24 : 0] divisor;
  wire [24 : 0] Result;
  wire [0 : 0] Mcount_divisor_lut;
  wire [23 : 0] Mcount_divisor_cy;
  VCC   XST_VCC (
    .P(N0)
  );
  GND   XST_GND (
    .G(N1)
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_0 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[0]),
    .Q(divisor[0])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_1 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[1]),
    .Q(divisor[1])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_2 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[2]),
    .Q(divisor[2])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_3 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[3]),
    .Q(divisor[3])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_4 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[4]),
    .Q(divisor[4])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_5 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[5]),
    .Q(divisor[5])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_6 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[6]),
    .Q(divisor[6])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_7 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[7]),
    .Q(divisor[7])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_8 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[8]),
    .Q(divisor[8])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_9 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[9]),
    .Q(divisor[9])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_10 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[10]),
    .Q(divisor[10])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_11 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[11]),
    .Q(divisor[11])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_12 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[12]),
    .Q(divisor[12])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_13 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[13]),
    .Q(divisor[13])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_14 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[14]),
    .Q(divisor[14])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_15 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[15]),
    .Q(divisor[15])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_16 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[16]),
    .Q(divisor[16])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_17 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[17]),
    .Q(divisor[17])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_18 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[18]),
    .Q(divisor[18])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_19 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[19]),
    .Q(divisor[19])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_20 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[20]),
    .Q(divisor[20])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_21 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[21]),
    .Q(divisor[21])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_22 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[22]),
    .Q(divisor[22])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_23 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[23]),
    .Q(divisor[23])
  );
  FD #(
    .INIT ( 1'b0 ))
  divisor_24 (
    .C(clk50mhz_BUFGP_0),
    .D(Result[24]),
    .Q(divisor[24])
  );
  MUXCY   \Mcount_divisor_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(Mcount_divisor_lut[0]),
    .O(Mcount_divisor_cy[0])
  );
  XORCY   \Mcount_divisor_xor<0>  (
    .CI(N1),
    .LI(Mcount_divisor_lut[0]),
    .O(Result[0])
  );
  MUXCY   \Mcount_divisor_cy<1>  (
    .CI(Mcount_divisor_cy[0]),
    .DI(N1),
    .S(\Mcount_divisor_cy<1>_rt_80 ),
    .O(Mcount_divisor_cy[1])
  );
  XORCY   \Mcount_divisor_xor<1>  (
    .CI(Mcount_divisor_cy[0]),
    .LI(\Mcount_divisor_cy<1>_rt_80 ),
    .O(Result[1])
  );
  MUXCY   \Mcount_divisor_cy<2>  (
    .CI(Mcount_divisor_cy[1]),
    .DI(N1),
    .S(\Mcount_divisor_cy<2>_rt_81 ),
    .O(Mcount_divisor_cy[2])
  );
  XORCY   \Mcount_divisor_xor<2>  (
    .CI(Mcount_divisor_cy[1]),
    .LI(\Mcount_divisor_cy<2>_rt_81 ),
    .O(Result[2])
  );
  MUXCY   \Mcount_divisor_cy<3>  (
    .CI(Mcount_divisor_cy[2]),
    .DI(N1),
    .S(\Mcount_divisor_cy<3>_rt_82 ),
    .O(Mcount_divisor_cy[3])
  );
  XORCY   \Mcount_divisor_xor<3>  (
    .CI(Mcount_divisor_cy[2]),
    .LI(\Mcount_divisor_cy<3>_rt_82 ),
    .O(Result[3])
  );
  MUXCY   \Mcount_divisor_cy<4>  (
    .CI(Mcount_divisor_cy[3]),
    .DI(N1),
    .S(\Mcount_divisor_cy<4>_rt_83 ),
    .O(Mcount_divisor_cy[4])
  );
  XORCY   \Mcount_divisor_xor<4>  (
    .CI(Mcount_divisor_cy[3]),
    .LI(\Mcount_divisor_cy<4>_rt_83 ),
    .O(Result[4])
  );
  MUXCY   \Mcount_divisor_cy<5>  (
    .CI(Mcount_divisor_cy[4]),
    .DI(N1),
    .S(\Mcount_divisor_cy<5>_rt_84 ),
    .O(Mcount_divisor_cy[5])
  );
  XORCY   \Mcount_divisor_xor<5>  (
    .CI(Mcount_divisor_cy[4]),
    .LI(\Mcount_divisor_cy<5>_rt_84 ),
    .O(Result[5])
  );
  MUXCY   \Mcount_divisor_cy<6>  (
    .CI(Mcount_divisor_cy[5]),
    .DI(N1),
    .S(\Mcount_divisor_cy<6>_rt_85 ),
    .O(Mcount_divisor_cy[6])
  );
  XORCY   \Mcount_divisor_xor<6>  (
    .CI(Mcount_divisor_cy[5]),
    .LI(\Mcount_divisor_cy<6>_rt_85 ),
    .O(Result[6])
  );
  MUXCY   \Mcount_divisor_cy<7>  (
    .CI(Mcount_divisor_cy[6]),
    .DI(N1),
    .S(\Mcount_divisor_cy<7>_rt_86 ),
    .O(Mcount_divisor_cy[7])
  );
  XORCY   \Mcount_divisor_xor<7>  (
    .CI(Mcount_divisor_cy[6]),
    .LI(\Mcount_divisor_cy<7>_rt_86 ),
    .O(Result[7])
  );
  MUXCY   \Mcount_divisor_cy<8>  (
    .CI(Mcount_divisor_cy[7]),
    .DI(N1),
    .S(\Mcount_divisor_cy<8>_rt_87 ),
    .O(Mcount_divisor_cy[8])
  );
  XORCY   \Mcount_divisor_xor<8>  (
    .CI(Mcount_divisor_cy[7]),
    .LI(\Mcount_divisor_cy<8>_rt_87 ),
    .O(Result[8])
  );
  MUXCY   \Mcount_divisor_cy<9>  (
    .CI(Mcount_divisor_cy[8]),
    .DI(N1),
    .S(\Mcount_divisor_cy<9>_rt_88 ),
    .O(Mcount_divisor_cy[9])
  );
  XORCY   \Mcount_divisor_xor<9>  (
    .CI(Mcount_divisor_cy[8]),
    .LI(\Mcount_divisor_cy<9>_rt_88 ),
    .O(Result[9])
  );
  MUXCY   \Mcount_divisor_cy<10>  (
    .CI(Mcount_divisor_cy[9]),
    .DI(N1),
    .S(\Mcount_divisor_cy<10>_rt_89 ),
    .O(Mcount_divisor_cy[10])
  );
  XORCY   \Mcount_divisor_xor<10>  (
    .CI(Mcount_divisor_cy[9]),
    .LI(\Mcount_divisor_cy<10>_rt_89 ),
    .O(Result[10])
  );
  MUXCY   \Mcount_divisor_cy<11>  (
    .CI(Mcount_divisor_cy[10]),
    .DI(N1),
    .S(\Mcount_divisor_cy<11>_rt_90 ),
    .O(Mcount_divisor_cy[11])
  );
  XORCY   \Mcount_divisor_xor<11>  (
    .CI(Mcount_divisor_cy[10]),
    .LI(\Mcount_divisor_cy<11>_rt_90 ),
    .O(Result[11])
  );
  MUXCY   \Mcount_divisor_cy<12>  (
    .CI(Mcount_divisor_cy[11]),
    .DI(N1),
    .S(\Mcount_divisor_cy<12>_rt_91 ),
    .O(Mcount_divisor_cy[12])
  );
  XORCY   \Mcount_divisor_xor<12>  (
    .CI(Mcount_divisor_cy[11]),
    .LI(\Mcount_divisor_cy<12>_rt_91 ),
    .O(Result[12])
  );
  MUXCY   \Mcount_divisor_cy<13>  (
    .CI(Mcount_divisor_cy[12]),
    .DI(N1),
    .S(\Mcount_divisor_cy<13>_rt_92 ),
    .O(Mcount_divisor_cy[13])
  );
  XORCY   \Mcount_divisor_xor<13>  (
    .CI(Mcount_divisor_cy[12]),
    .LI(\Mcount_divisor_cy<13>_rt_92 ),
    .O(Result[13])
  );
  MUXCY   \Mcount_divisor_cy<14>  (
    .CI(Mcount_divisor_cy[13]),
    .DI(N1),
    .S(\Mcount_divisor_cy<14>_rt_93 ),
    .O(Mcount_divisor_cy[14])
  );
  XORCY   \Mcount_divisor_xor<14>  (
    .CI(Mcount_divisor_cy[13]),
    .LI(\Mcount_divisor_cy<14>_rt_93 ),
    .O(Result[14])
  );
  MUXCY   \Mcount_divisor_cy<15>  (
    .CI(Mcount_divisor_cy[14]),
    .DI(N1),
    .S(\Mcount_divisor_cy<15>_rt_94 ),
    .O(Mcount_divisor_cy[15])
  );
  XORCY   \Mcount_divisor_xor<15>  (
    .CI(Mcount_divisor_cy[14]),
    .LI(\Mcount_divisor_cy<15>_rt_94 ),
    .O(Result[15])
  );
  MUXCY   \Mcount_divisor_cy<16>  (
    .CI(Mcount_divisor_cy[15]),
    .DI(N1),
    .S(\Mcount_divisor_cy<16>_rt_95 ),
    .O(Mcount_divisor_cy[16])
  );
  XORCY   \Mcount_divisor_xor<16>  (
    .CI(Mcount_divisor_cy[15]),
    .LI(\Mcount_divisor_cy<16>_rt_95 ),
    .O(Result[16])
  );
  MUXCY   \Mcount_divisor_cy<17>  (
    .CI(Mcount_divisor_cy[16]),
    .DI(N1),
    .S(\Mcount_divisor_cy<17>_rt_96 ),
    .O(Mcount_divisor_cy[17])
  );
  XORCY   \Mcount_divisor_xor<17>  (
    .CI(Mcount_divisor_cy[16]),
    .LI(\Mcount_divisor_cy<17>_rt_96 ),
    .O(Result[17])
  );
  MUXCY   \Mcount_divisor_cy<18>  (
    .CI(Mcount_divisor_cy[17]),
    .DI(N1),
    .S(\Mcount_divisor_cy<18>_rt_97 ),
    .O(Mcount_divisor_cy[18])
  );
  XORCY   \Mcount_divisor_xor<18>  (
    .CI(Mcount_divisor_cy[17]),
    .LI(\Mcount_divisor_cy<18>_rt_97 ),
    .O(Result[18])
  );
  MUXCY   \Mcount_divisor_cy<19>  (
    .CI(Mcount_divisor_cy[18]),
    .DI(N1),
    .S(\Mcount_divisor_cy<19>_rt_98 ),
    .O(Mcount_divisor_cy[19])
  );
  XORCY   \Mcount_divisor_xor<19>  (
    .CI(Mcount_divisor_cy[18]),
    .LI(\Mcount_divisor_cy<19>_rt_98 ),
    .O(Result[19])
  );
  MUXCY   \Mcount_divisor_cy<20>  (
    .CI(Mcount_divisor_cy[19]),
    .DI(N1),
    .S(\Mcount_divisor_cy<20>_rt_99 ),
    .O(Mcount_divisor_cy[20])
  );
  XORCY   \Mcount_divisor_xor<20>  (
    .CI(Mcount_divisor_cy[19]),
    .LI(\Mcount_divisor_cy<20>_rt_99 ),
    .O(Result[20])
  );
  MUXCY   \Mcount_divisor_cy<21>  (
    .CI(Mcount_divisor_cy[20]),
    .DI(N1),
    .S(\Mcount_divisor_cy<21>_rt_100 ),
    .O(Mcount_divisor_cy[21])
  );
  XORCY   \Mcount_divisor_xor<21>  (
    .CI(Mcount_divisor_cy[20]),
    .LI(\Mcount_divisor_cy<21>_rt_100 ),
    .O(Result[21])
  );
  MUXCY   \Mcount_divisor_cy<22>  (
    .CI(Mcount_divisor_cy[21]),
    .DI(N1),
    .S(\Mcount_divisor_cy<22>_rt_101 ),
    .O(Mcount_divisor_cy[22])
  );
  XORCY   \Mcount_divisor_xor<22>  (
    .CI(Mcount_divisor_cy[21]),
    .LI(\Mcount_divisor_cy<22>_rt_101 ),
    .O(Result[22])
  );
  MUXCY   \Mcount_divisor_cy<23>  (
    .CI(Mcount_divisor_cy[22]),
    .DI(N1),
    .S(\Mcount_divisor_cy<23>_rt_102 ),
    .O(Mcount_divisor_cy[23])
  );
  XORCY   \Mcount_divisor_xor<23>  (
    .CI(Mcount_divisor_cy[22]),
    .LI(\Mcount_divisor_cy<23>_rt_102 ),
    .O(Result[23])
  );
  XORCY   \Mcount_divisor_xor<24>  (
    .CI(Mcount_divisor_cy[23]),
    .LI(\Mcount_divisor_xor<24>_rt_103 ),
    .O(Result[24])
  );
  OBUF   testled_OBUF (
    .I(divisor[24]),
    .O(testled)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<1>_rt  (
    .I0(divisor[1]),
    .O(\Mcount_divisor_cy<1>_rt_80 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<2>_rt  (
    .I0(divisor[2]),
    .O(\Mcount_divisor_cy<2>_rt_81 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<3>_rt  (
    .I0(divisor[3]),
    .O(\Mcount_divisor_cy<3>_rt_82 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<4>_rt  (
    .I0(divisor[4]),
    .O(\Mcount_divisor_cy<4>_rt_83 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<5>_rt  (
    .I0(divisor[5]),
    .O(\Mcount_divisor_cy<5>_rt_84 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<6>_rt  (
    .I0(divisor[6]),
    .O(\Mcount_divisor_cy<6>_rt_85 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<7>_rt  (
    .I0(divisor[7]),
    .O(\Mcount_divisor_cy<7>_rt_86 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<8>_rt  (
    .I0(divisor[8]),
    .O(\Mcount_divisor_cy<8>_rt_87 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<9>_rt  (
    .I0(divisor[9]),
    .O(\Mcount_divisor_cy<9>_rt_88 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<10>_rt  (
    .I0(divisor[10]),
    .O(\Mcount_divisor_cy<10>_rt_89 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<11>_rt  (
    .I0(divisor[11]),
    .O(\Mcount_divisor_cy<11>_rt_90 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<12>_rt  (
    .I0(divisor[12]),
    .O(\Mcount_divisor_cy<12>_rt_91 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<13>_rt  (
    .I0(divisor[13]),
    .O(\Mcount_divisor_cy<13>_rt_92 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<14>_rt  (
    .I0(divisor[14]),
    .O(\Mcount_divisor_cy<14>_rt_93 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<15>_rt  (
    .I0(divisor[15]),
    .O(\Mcount_divisor_cy<15>_rt_94 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<16>_rt  (
    .I0(divisor[16]),
    .O(\Mcount_divisor_cy<16>_rt_95 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<17>_rt  (
    .I0(divisor[17]),
    .O(\Mcount_divisor_cy<17>_rt_96 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<18>_rt  (
    .I0(divisor[18]),
    .O(\Mcount_divisor_cy<18>_rt_97 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<19>_rt  (
    .I0(divisor[19]),
    .O(\Mcount_divisor_cy<19>_rt_98 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<20>_rt  (
    .I0(divisor[20]),
    .O(\Mcount_divisor_cy<20>_rt_99 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<21>_rt  (
    .I0(divisor[21]),
    .O(\Mcount_divisor_cy<21>_rt_100 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<22>_rt  (
    .I0(divisor[22]),
    .O(\Mcount_divisor_cy<22>_rt_101 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_cy<23>_rt  (
    .I0(divisor[23]),
    .O(\Mcount_divisor_cy<23>_rt_102 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_divisor_xor<24>_rt  (
    .I0(divisor[24]),
    .O(\Mcount_divisor_xor<24>_rt_103 )
  );
  BUFGP   clk50mhz_BUFGP (
    .I(clk50mhz),
    .O(clk50mhz_BUFGP_0)
  );
  INV   \Mcount_divisor_lut<0>_INV_0  (
    .I(divisor[0]),
    .O(Mcount_divisor_lut[0])
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

