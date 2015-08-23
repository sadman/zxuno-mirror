//============================================================================
// A-Z80 core, instantiates and connects all internal blocks.
//
// This file is included by the "z80_top_ifc_n" and "z80_top_direct" providing
// interface binding and direct (no interface) binding.
//============================================================================

// Include a list of top-level signal wires
`include "globals.vh"

// Specific to Modelsim, some modules in the schematics need to be pre-initialized
// to avoid starting simulations with unknown values in selected flip flops.
// When synthesized, the CPU RESET input signal will do the work.
//reg fpga_reset = 0;
wire fpga_reset = reset_in;
//initial begin
//    fpga_reset = 1;
//    #20;
//    fpga_reset = 0;
//end

// Define internal data bus partitions separated by data bus switches
wire [7:0] db0;         // Segment connecting data pins and IR
wire [7:0] db1;         // Segment with ALU
wire [7:0] db2;         // Segment with msb part of the register address-side interface

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Control block
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Collect the PLA instruction decode prefix bitfield
wire [6:0] prefix;
assign prefix = { ~use_ixiy, use_ixiy, ~in_halt, in_alu, table_xx, table_cb, table_ed };

ir          instruction_reg_( .ctl_ir_we(ctl_ir_we), .clk(clk), .db(db0[7:0]), .opcode(opcode) );

pla_decode  pla_decode_(.prefix(prefix), .opcode(opcode), .pla(pla) );

resets      reset_block_(.reset_in(reset_in), .clk(clk), .M1(M1), .T2(T2), .fpga_reset(fpga_reset),	.clrpc(clrpc), .nreset(nreset) );

sequencer   sequencer_(.clk(clk), .nextM(nextM), .setM1(setM1), .nreset(nreset), .hold_clk_iorq(hold_clk_iorq), .hold_clk_wait(hold_clk_wait), 
                       .hold_clk_busrq(hold_clk_busrq), .M1(M1), .M2(M2), .M3(M3), .M4(M4), .M5(M5), .M6(M6), 
                       .T1(T1), .T2(T2), .T3(T3), .T4(T4), .T5(T5), .T6(T6), .timings_en(timings_en) );	

execute     execute_(
                    .ctl_state_iy_set(ctl_state_iy_set),
                    .ctl_state_ixiy_clr(ctl_state_ixiy_clr),
                    .ctl_state_ixiy_we(ctl_state_ixiy_we),
                    .ctl_state_halt_set(ctl_state_halt_set),
                    .ctl_state_tbl_clr(ctl_state_tbl_clr),
                    .ctl_state_tbl_ed_set(ctl_state_tbl_ed_set),
                    .ctl_state_tbl_cb_set(ctl_state_tbl_cb_set),
                    .ctl_state_alu(ctl_state_alu),
                    .ctl_repeat_we(ctl_repeat_we),
                    .ctl_iff1_iff2(ctl_iff1_iff2),
                    .ctl_iffx_we(ctl_iffx_we),
                    .ctl_iffx_bit(ctl_iffx_bit),
                    .ctl_im_we(ctl_im_we),
                    .ctl_no_ints(ctl_no_ints),
                    .ctl_ir_we(ctl_ir_we),
                    .ctl_mRead(ctl_mRead),
                    .ctl_mWrite(ctl_mWrite),
                    .ctl_iorw(ctl_iorw),
                    .ctl_shift_en(ctl_shift_en),
                    .ctl_daa_oe(ctl_daa_oe),
                    .ctl_alu_op_low(ctl_alu_op_low),
                    .ctl_cond_short(ctl_cond_short),
                    .ctl_alu_core_hf(ctl_alu_core_hf),
                    .ctl_eval_cond(ctl_eval_cond),
                    .ctl_66_oe(ctl_66_oe),
                    .ctl_pf_sel(ctl_pf_sel),
                    .ctl_alu_oe(ctl_alu_oe),
                    .ctl_alu_shift_oe(ctl_alu_shift_oe),
                    .ctl_alu_op2_oe(ctl_alu_op2_oe),
                    .ctl_alu_res_oe(ctl_alu_res_oe),
                    .ctl_alu_op1_oe(ctl_alu_op1_oe),
                    .ctl_alu_bs_oe(ctl_alu_bs_oe),
                    .ctl_alu_op1_sel_bus(ctl_alu_op1_sel_bus),
                    .ctl_alu_op1_sel_low(ctl_alu_op1_sel_low),
                    .ctl_alu_op1_sel_zero(ctl_alu_op1_sel_zero),
                    .ctl_alu_op2_sel_zero(ctl_alu_op2_sel_zero),
                    .ctl_alu_op2_sel_bus(ctl_alu_op2_sel_bus),
                    .ctl_alu_op2_sel_lq(ctl_alu_op2_sel_lq),
                    .ctl_alu_sel_op2_neg(ctl_alu_sel_op2_neg),
                    .ctl_alu_sel_op2_high(ctl_alu_sel_op2_high),
                    .ctl_alu_core_R(ctl_alu_core_R),
                    .ctl_alu_core_V(ctl_alu_core_V),
                    .ctl_alu_core_S(ctl_alu_core_S),
                    .ctl_flags_oe(ctl_flags_oe),
                    .ctl_flags_bus(ctl_flags_bus),
                    .ctl_flags_alu(ctl_flags_alu),
                    .ctl_flags_nf_set(ctl_flags_nf_set),
                    .ctl_flags_cf_set(ctl_flags_cf_set),
                    .ctl_flags_cf_cpl(ctl_flags_cf_cpl),
                    .ctl_flags_cf_we(ctl_flags_cf_we),
                    .ctl_flags_sz_we(ctl_flags_sz_we),
                    .ctl_flags_xy_we(ctl_flags_xy_we),
                    .ctl_flags_hf_we(ctl_flags_hf_we),
                    .ctl_flags_pf_we(ctl_flags_pf_we),
                    .ctl_flags_nf_we(ctl_flags_nf_we),
                    .ctl_flags_cf2_we(ctl_flags_cf2_we),
                    .ctl_flags_hf_cpl(ctl_flags_hf_cpl),
                    .ctl_flags_use_cf2(ctl_flags_use_cf2),
                    .ctl_flags_hf2_we(ctl_flags_hf2_we),
                    .ctl_flags_nf_clr(ctl_flags_nf_clr),
                    .ctl_alu_zero_16bit(ctl_alu_zero_16bit),
                    .ctl_flags_cf2_sel(ctl_flags_cf2_sel),
                    .ctl_sw_4d(ctl_sw_4d),
                    .ctl_sw_4u(ctl_sw_4u),
                    .ctl_reg_in_hi(ctl_reg_in_hi),
                    .ctl_reg_in_lo(ctl_reg_in_lo),
                    .ctl_reg_out_lo(ctl_reg_out_lo),
                    .ctl_reg_out_hi(ctl_reg_out_hi),
                    .ctl_reg_exx(ctl_reg_exx),
                    .ctl_reg_ex_af(ctl_reg_ex_af),
                    .ctl_reg_ex_de_hl(ctl_reg_ex_de_hl),
                    .ctl_reg_use_sp(ctl_reg_use_sp),
                    .ctl_reg_sel_pc(ctl_reg_sel_pc),
                    .ctl_reg_sel_ir(ctl_reg_sel_ir),
                    .ctl_reg_sel_wz(ctl_reg_sel_wz),
                    .ctl_reg_gp_we(ctl_reg_gp_we),
                    .ctl_reg_not_pc(ctl_reg_not_pc),
                    .ctl_reg_sys_we_lo(ctl_reg_sys_we_lo),
                    .ctl_reg_sys_we_hi(ctl_reg_sys_we_hi),
                    .ctl_reg_sys_we(ctl_reg_sys_we),
                    .ctl_reg_gp_hilo(ctl_reg_gp_hilo),
                    .ctl_reg_gp_sel(ctl_reg_gp_sel),
                    .ctl_reg_sys_hilo(ctl_reg_sys_hilo),
                    .ctl_inc_cy(ctl_inc_cy),
                    .ctl_inc_dec(ctl_inc_dec),
                    .ctl_inc_zero(ctl_inc_zero),
                    .ctl_al_we(ctl_al_we),
                    .ctl_inc_limit6(ctl_inc_limit6),
                    .ctl_bus_inc_oe(ctl_bus_inc_oe),
                    .ctl_apin_mux(ctl_apin_mux),
                    .ctl_apin_mux2(ctl_apin_mux2),
                    .ctl_bus_ff_oe(ctl_bus_ff_oe),
                    .ctl_bus_zero_oe(ctl_bus_zero_oe),
                    .ctl_bus_db_oe(ctl_bus_db_oe),
                    .ctl_sw_1u(ctl_sw_1u),
                    .ctl_sw_1d(ctl_sw_1d),
                    .ctl_sw_2u(ctl_sw_2u),
                    .ctl_sw_2d(ctl_sw_2d),
                    .ctl_sw_mask543_en(ctl_sw_mask543_en),
                    .ctl_bus_db_we(ctl_bus_db_we),
                     .nextM(nextM),                 // Last M cycle of any instruction
                     .setM1(setM1),                 // Last T clock of any instruction
                     .fFetch(fFetch),               // Function: opcode fetch cycle ("M1")
                     .fMRead(fMRead),               // Function: memory read cycle
                     .fMWrite(fMWrite),             // Function: memory write cycle
                     .fIORead(fIORead),             // Function: IO Read cycle
                     .fIOWrite(fIOWrite),           // Function: IO Write cycle
                     .pla(pla),                     // Statically decoded instructions
                     .fpga_reset(fpga_reset),       // Internal fpga test mode
                     .nreset(nreset),               // Internal reset signal
                     .clk(clk),                     // Internal clock signal
                     .in_intr(in_intr),             // Servicing maskable interrupt
                     .in_nmi(in_nmi),               // Servicing non-maskable interrupt
                     .in_halt(in_halt),             // Currently in HALT mode
                     .im1(im1),                     // Interrupt Mode 1
                     .im2(im2),                     // Interrupt Mode 2
                     .use_ixiy(use_ixiy),           // Special decode signal
                     .flags_cond_true(flags_cond_true),         // Flags condition is true
                     .repeat_en(repeat_en),         // Enable repeat of a block instruction
                     .flags_zf(flags_zf),           // ZF to test a condition
                     .flags_nf(flags_nf),           // NF to test for subtraction
                     .flags_sf(flags_sf),           // SF to test for 8-bit sign of a value
                     .flags_cf(flags_cf),           // CF to set HF for CCF
                     .M1(M1),                       // Machine cycle #1
                     .M2(M2),                       // Machine cycle #2
                     .M3(M3),                       // Machine cycle #3
                     .M4(M4),                       // Machine cycle #4
                     .M5(M5),                       // Machine cycle #5
                     .M6(M6),                       // Machine cycle #6
                     .T1(T1),                       // T-cycle #1
                     .T2(T2),                       // T-cycle #2
                     .T3(T3),                       // T-cycle #3
                     .T4(T4),                       // T-cycle #4
                     .T5(T5),                       // T-cycle #5
                     .T6(T6)                        // T-cycle #6
 );

interrupts  interrupts_(
    .ctl_iff1_iff2(ctl_iff1_iff2),
	.nmi(nmi),
	.setM1(setM1),
	.intr(intr),
	.ctl_iffx_we(ctl_iffx_we),
	.ctl_iffx_bit(ctl_iffx_bit),
	.ctl_im_we(ctl_im_we),
	.clk(clk),
	.ctl_no_ints(ctl_no_ints),
	.nreset(nreset),	
	.iff1(iff1),
	.iff2(iff2),
	.im1(im1),
	.im2(im2),
	.in_nmi(in_nmi),
	.in_intr(in_intr), 
    .db(db0[4:3]) 
    );
    
decode_state decode_state_(
    .ctl_state_iy_set(ctl_state_iy_set),
	.ctl_state_ixiy_clr(ctl_state_ixiy_clr),
	.ctl_state_ixiy_we(ctl_state_ixiy_we),
	.ctl_state_halt_set(ctl_state_halt_set),
	.ctl_state_tbl_clr(ctl_state_tbl_clr),
	.ctl_state_tbl_ed_set(ctl_state_tbl_ed_set),
	.ctl_state_tbl_cb_set(ctl_state_tbl_cb_set),
	.ctl_state_alu(ctl_state_alu),
	.clk(clk),
	.address_is_1(address_is_1),
	.ctl_repeat_we(ctl_repeat_we),
	.in_intr(in_intr),
	.in_nmi(in_nmi),
	.nreset(nreset),
	.in_halt(in_halt),
	.table_cb(table_cb),
	.table_ed(table_ed),
	.table_xx(table_xx),
	.use_ix(use_ix),
	.use_ixiy(use_ixiy),
	.in_alu(in_alu),
	.repeat_en(repeat_en)
    );

clk_delay   clk_delay_(
	.clk(clk),
	.in_intr(in_intr),
	.nreset(nreset),
	.T1(T1),
	.latch_wait(latch_wait),
	.mwait(mwait),
	.M1(M1),
	.busrq(busrq),
	.setM1(setM1),
	.hold_clk_iorq(hold_clk_iorq),
	.hold_clk_wait(hold_clk_wait),
	.iorq_Tw(iorq_Tw),
	.busack(busack),
	.pin_control_oe(pin_control_oe),
	.hold_clk_busrq(hold_clk_busrq)
    );

pin_control pin_control_(
	.fFetch(fFetch),
	.fMRead(fMRead),
	.fMWrite(fMWrite),
	.fIORead(fIORead),
	.fIOWrite(fIOWrite),
	.T1(T1),
	.T2(T2),
	.T3(T3),
	.T4(T4),
	.bus_ab_pin_we(bus_ab_pin_we),
	.bus_db_pin_oe(bus_db_pin_oe),
	.bus_db_pin_re(bus_db_pin_re)
    );

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ALU and ALU control, including the flags
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alu_control alu_control_(
	.alu_shift_db0(alu_shift_db0),
	.alu_shift_db7(alu_shift_db7),
	.ctl_shift_en(ctl_shift_en),
	.alu_low_gt_9(alu_low_gt_9),
	.alu_high_gt_9(alu_high_gt_9),
	.alu_high_eq_9(alu_high_eq_9),
	.ctl_daa_oe(ctl_daa_oe),
	.ctl_alu_op_low(ctl_alu_op_low),
	.alu_parity_out(alu_parity_out),
	.flags_cf(flags_cf),
	.flags_zf(flags_zf),
	.flags_pf(flags_pf),
	.flags_sf(flags_sf),
	.ctl_cond_short(ctl_cond_short),
	.alu_vf_out(alu_vf_out),
	.iff2(iff2),
	.ctl_alu_core_hf(ctl_alu_core_hf),
	.ctl_eval_cond(ctl_eval_cond),
	.repeat_en(repeat_en),
	.flags_cf_latch(flags_cf_latch),
	.flags_hf2(flags_hf2),
	.flags_hf(flags_hf),
	.ctl_66_oe(ctl_66_oe),
	.clk(clk),
	.ctl_pf_sel(ctl_pf_sel),
	.alu_shift_in(alu_shift_in),
	.alu_shift_right(alu_shift_right),
	.alu_shift_left(alu_shift_left),
	.shift_cf_out(shift_cf_out),
	.alu_parity_in(alu_parity_in),
	.flags_cond_true(flags_cond_true),
	.daa_cf_out(daa_cf_out),
	.pf_sel(pf_sel),
	.alu_op_low(alu_op_low),
	.alu_core_cf_in(alu_core_cf_in),
    .db(db1[7:0]), 
    .op543({pla[104],pla[103],pla[102]}) 
    );
    
alu_select  alu_select_(
	.ctl_alu_oe(ctl_alu_oe),
	.ctl_alu_shift_oe(ctl_alu_shift_oe),
	.ctl_alu_op2_oe(ctl_alu_op2_oe),
	.ctl_alu_res_oe(ctl_alu_res_oe),
	.ctl_alu_op1_oe(ctl_alu_op1_oe),
	.ctl_alu_bs_oe(ctl_alu_bs_oe),
	.ctl_alu_op1_sel_bus(ctl_alu_op1_sel_bus),
	.ctl_alu_op1_sel_low(ctl_alu_op1_sel_low),
	.ctl_alu_op1_sel_zero(ctl_alu_op1_sel_zero),
	.ctl_alu_op2_sel_zero(ctl_alu_op2_sel_zero),
	.ctl_alu_op2_sel_bus(ctl_alu_op2_sel_bus),
	.ctl_alu_op2_sel_lq(ctl_alu_op2_sel_lq),
	.ctl_alu_sel_op2_neg(ctl_alu_sel_op2_neg),
	.ctl_alu_sel_op2_high(ctl_alu_sel_op2_high),
	.ctl_alu_core_R(ctl_alu_core_R),
	.ctl_alu_core_V(ctl_alu_core_V),
	.ctl_alu_core_S(ctl_alu_core_S),
	.alu_oe(alu_oe),
	.alu_shift_oe(alu_shift_oe),
	.alu_op2_oe(alu_op2_oe),
	.alu_res_oe(alu_res_oe),
	.alu_op1_oe(alu_op1_oe),
	.alu_bs_oe(alu_bs_oe),
	.alu_op1_sel_bus(alu_op1_sel_bus),
	.alu_op1_sel_low(alu_op1_sel_low),
	.alu_op1_sel_zero(alu_op1_sel_zero),
	.alu_op2_sel_zero(alu_op2_sel_zero),
	.alu_op2_sel_bus(alu_op2_sel_bus),
	.alu_op2_sel_lq(alu_op2_sel_lq),
	.alu_sel_op2_neg(alu_sel_op2_neg),
	.alu_sel_op2_high(alu_sel_op2_high),
	.alu_core_R(alu_core_R),
	.alu_core_V(alu_core_V),
	.alu_core_S(alu_core_S)
    );
    
alu_flags   alu_flags_(
	.ctl_flags_oe(ctl_flags_oe),
	.ctl_flags_bus(ctl_flags_bus),
	.ctl_flags_alu(ctl_flags_alu),
	.alu_sf_out(alu_sf_out),
	.alu_yf_out(alu_yf_out),
	.alu_xf_out(alu_xf_out),
	.ctl_flags_nf_set(ctl_flags_nf_set),
	.alu_zero(alu_zero),
	.shift_cf_out(shift_cf_out),
	.alu_core_cf_out(alu_core_cf_out),
	.daa_cf_out(daa_cf_out),
	.ctl_flags_cf_set(ctl_flags_cf_set),
	.ctl_flags_cf_cpl(ctl_flags_cf_cpl),
	.pf_sel(pf_sel),
	.ctl_flags_cf_we(ctl_flags_cf_we),
	.ctl_flags_sz_we(ctl_flags_sz_we),
	.ctl_flags_xy_we(ctl_flags_xy_we),
	.ctl_flags_hf_we(ctl_flags_hf_we),
	.ctl_flags_pf_we(ctl_flags_pf_we),
	.ctl_flags_nf_we(ctl_flags_nf_we),
	.ctl_flags_cf2_we(ctl_flags_cf2_we),
	.ctl_flags_hf_cpl(ctl_flags_hf_cpl),
	.ctl_flags_use_cf2(ctl_flags_use_cf2),
	.ctl_flags_hf2_we(ctl_flags_hf2_we),
	.ctl_flags_nf_clr(ctl_flags_nf_clr),
	.ctl_alu_zero_16bit(ctl_alu_zero_16bit),
	.clk(clk),
	.ctl_flags_cf2_sel(ctl_flags_cf2_sel),
	.flags_sf(flags_sf),
	.flags_zf(flags_zf),
	.flags_hf(flags_hf),
	.flags_pf(flags_pf),
	.flags_cf(flags_cf),
	.flags_nf(flags_nf),
	.flags_cf_latch(flags_cf_latch),
	.flags_hf2(flags_hf2),
    .db(db1[7:0])
    );
    
alu         alu_(
	.alu_core_R(alu_core_R),
	.alu_core_V(alu_core_V),
	.alu_core_S(alu_core_S),
	.alu_bs_oe(alu_bs_oe),
	.alu_parity_in(alu_parity_in),
	.alu_oe(alu_oe),
	.alu_shift_oe(alu_shift_oe),
	.alu_core_cf_in(alu_core_cf_in),
	.alu_op2_oe(alu_op2_oe),
	.alu_op1_oe(alu_op1_oe),
	.alu_res_oe(alu_res_oe),
	.alu_op1_sel_low(alu_op1_sel_low),
	.alu_op1_sel_zero(alu_op1_sel_zero),
	.alu_op1_sel_bus(alu_op1_sel_bus),
	.alu_op2_sel_zero(alu_op2_sel_zero),
	.alu_op2_sel_bus(alu_op2_sel_bus),
	.alu_op2_sel_lq(alu_op2_sel_lq),
	.alu_op_low(alu_op_low),
	.alu_shift_in(alu_shift_in),
	.alu_sel_op2_neg(alu_sel_op2_neg),
	.alu_sel_op2_high(alu_sel_op2_high),
	.alu_shift_left(alu_shift_left),
	.alu_shift_right(alu_shift_right),
	.clk(clk),
	.alu_zero(alu_zero),
	.alu_parity_out(alu_parity_out),
	.alu_high_eq_9(alu_high_eq_9),
	.alu_high_gt_9(alu_high_gt_9),
	.alu_low_gt_9(alu_low_gt_9),
	.alu_shift_db0(alu_shift_db0),
	.alu_shift_db7(alu_shift_db7),
	.alu_core_cf_out(alu_core_cf_out),
	.alu_sf_out(alu_sf_out),
	.alu_yf_out(alu_yf_out),
	.alu_xf_out(alu_xf_out),
	.alu_vf_out(alu_vf_out),
	.test_db_high(test_db_high),
	.test_db_low(test_db_low),
    .db(db2[7:0]),
    .bsel(db0[5:3]) 
    );

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Register file and register control
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire [7:0] db_hi_as;
wire [7:0] db_lo_as;

reg_file    reg_file_(
	.reg_sel_sys_lo(reg_sel_sys_lo),
	.reg_sel_gp_lo(reg_sel_gp_lo),
	.reg_sel_sys_hi(reg_sel_sys_hi),
	.reg_sel_gp_hi(reg_sel_gp_hi),
	.reg_sel_ir(reg_sel_ir),
	.reg_sel_pc(reg_sel_pc),
	.ctl_sw_4d(ctl_sw_4d),
	.ctl_sw_4u(ctl_sw_4u),
	.reg_sel_wz(reg_sel_wz),
	.reg_sel_sp(reg_sel_sp),
	.reg_sel_iy(reg_sel_iy),
	.reg_sel_ix(reg_sel_ix),
	.reg_sel_hl2(reg_sel_hl2),
	.reg_sel_hl(reg_sel_hl),
	.reg_sel_de2(reg_sel_de2),
	.reg_sel_de(reg_sel_de),
	.reg_sel_bc2(reg_sel_bc2),
	.reg_sel_bc(reg_sel_bc),
	.reg_sel_af2(reg_sel_af2),
	.reg_sel_af(reg_sel_af),
	.reg_gp_we(reg_gp_we),
	.reg_sys_we_lo(reg_sys_we_lo),
	.reg_sys_we_hi(reg_sys_we_hi),
	.ctl_reg_in_hi(ctl_reg_in_hi),
	.ctl_reg_in_lo(ctl_reg_in_lo),
	.ctl_reg_out_lo(ctl_reg_out_lo),
	.ctl_reg_out_hi(ctl_reg_out_hi),
	.clk(clk),
    .db_hi_ds(db2[7:0]),
    .db_lo_ds(db1[7:0]),
    .db_hi_as(db_hi_as[7:0]),
    .db_lo_as(db_lo_as[7:0])
    );
    
reg_control reg_control_(
	.ctl_reg_exx(ctl_reg_exx),
	.ctl_reg_ex_af(ctl_reg_ex_af),
	.ctl_reg_ex_de_hl(ctl_reg_ex_de_hl),
	.ctl_reg_use_sp(ctl_reg_use_sp),
	.nreset(nreset),
	.ctl_reg_sel_pc(ctl_reg_sel_pc),
	.ctl_reg_sel_ir(ctl_reg_sel_ir),
	.ctl_reg_sel_wz(ctl_reg_sel_wz),
	.ctl_reg_gp_we(ctl_reg_gp_we),
	.ctl_reg_not_pc(ctl_reg_not_pc),
	.use_ixiy(use_ixiy),
	.use_ix(use_ix),
	.ctl_reg_sys_we_lo(ctl_reg_sys_we_lo),
	.ctl_reg_sys_we_hi(ctl_reg_sys_we_hi),
	.ctl_reg_sys_we(ctl_reg_sys_we),
	.clk(clk),
	.ctl_reg_gp_hilo(ctl_reg_gp_hilo),
	.ctl_reg_gp_sel(ctl_reg_gp_sel),
	.ctl_reg_sys_hilo(ctl_reg_sys_hilo),
	.reg_sel_bc(reg_sel_bc),
	.reg_sel_bc2(reg_sel_bc2),
	.reg_sel_ix(reg_sel_ix),
	.reg_sel_iy(reg_sel_iy),
	.reg_sel_de(reg_sel_de),
	.reg_sel_hl(reg_sel_hl),
	.reg_sel_de2(reg_sel_de2),
	.reg_sel_hl2(reg_sel_hl2),
	.reg_sel_af(reg_sel_af),
	.reg_sel_af2(reg_sel_af2),
	.reg_sel_wz(reg_sel_wz),
	.reg_sel_pc(reg_sel_pc),
	.reg_sel_ir(reg_sel_ir),
	.reg_sel_sp(reg_sel_sp),
	.reg_sel_gp_hi(reg_sel_gp_hi),
	.reg_sel_gp_lo(reg_sel_gp_lo),
	.reg_sel_sys_lo(reg_sel_sys_lo),
	.reg_sel_sys_hi(reg_sel_sys_hi),
	.reg_gp_we(reg_gp_we),
	.reg_sys_we_lo(reg_sys_we_lo),
	.reg_sys_we_hi(reg_sys_we_hi)
    );

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Address latch (with the incrementer)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
address_latch address_latch_(
	.ctl_inc_cy(ctl_inc_cy),
	.ctl_inc_dec(ctl_inc_dec),
	.ctl_inc_zero(ctl_inc_zero),
	.ctl_al_we(ctl_al_we),
	.ctl_inc_limit6(ctl_inc_limit6),
	.ctl_bus_inc_oe(ctl_bus_inc_oe),
	.clk(clk),
	.ctl_apin_mux(ctl_apin_mux),
	.ctl_apin_mux2(ctl_apin_mux2),
	.address_is_1(address_is_1),
	.address(address),
    .abus({db_hi_as[7:0], db_lo_as[7:0]})
    );

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Timing control of the external pins
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wire nM1_int;
assign nM1_int = !((setM1 & nextM) | (fFetch & T1));

memory_ifc memory_ifc_(
	.clk(clk),
	.nM1_int(nM1_int),
	.ctl_mRead(ctl_mRead),
	.ctl_mWrite(ctl_mWrite),
	.in_intr(in_intr),
	.nreset(nreset),
	.fIORead(fIORead),
	.fIOWrite(fIOWrite),
	.setM1(setM1),
	.ctl_iorw(ctl_iorw),
	.timings_en(timings_en),
	.iorq_Tw(iorq_Tw),
	.hold_clk_wait(hold_clk_wait),
	.nM1_out(nM1_out),
	.nRFSH_out(nRFSH_out),
	.nMREQ_out(nMREQ_out),
	.nRD_out(nRD_out),
	.nWR_out(nWR_out),
	.nIORQ_out(nIORQ_out),
	.latch_wait(latch_wait)
    );

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Data path within the CPU in various forms, ending with data pins
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bus_switch bus_switch_(
    .ctl_sw_1u(ctl_sw_1u),               // Control input for the SW1 upstream
    .ctl_sw_1d(ctl_sw_1d),               // Control input for the SW1 downstream
    .ctl_sw_2u(ctl_sw_2u),               // Control input for the SW2 upstream
    .ctl_sw_2d(ctl_sw_2d),               // Control input for the SW2 downstream
    .ctl_sw_mask543_en(ctl_sw_mask543_en),       // Enables masking [5:3] on the data bus switch 1
    .bus_sw_1u(bus_sw_1u),              // SW1 upstream
    .bus_sw_1d(bus_sw_1d),              // SW1 downstream
    .bus_sw_2u(bus_sw_2u),              // SW2 upstream
    .bus_sw_2d(bus_sw_2d),              // SW2 downstream
    .bus_sw_mask543_en(bus_sw_mask543_en)       // Affects SW1 downstream
    );

data_switch sw2_( .sw_up_en(bus_sw_2u), .sw_down_en(bus_sw_2d), .db_up(db1[7:0]), .db_down(db2[7:0]) );

// Controls writers to the first section of the data bus
bus_control bus_control_(
	.ctl_bus_ff_oe(ctl_bus_ff_oe),
	.ctl_bus_zero_oe(ctl_bus_zero_oe),
	.ctl_bus_db_oe(ctl_bus_db_oe),
	.bus_db_oe(bus_db_oe),
    .db(db0[7:0])
    );

// Data switch SW1 with the data mask
data_switch_mask sw1_( .sw_mask543_en(bus_sw_mask543_en), .sw_up_en(bus_sw_1u), .sw_down_en(bus_sw_1d), .db_up(db0[7:0]), .db_down(db1[7:0]) );
