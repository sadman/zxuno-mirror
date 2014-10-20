//-------------------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : April 30, 2001
// Update: 4/30/01 copied this file from lcd_2.v (pared down).
// Update: 5/24/01 changed the first module from "ps2_keyboard_receiver"
//                 to "ps2_keyboard_interface"
// Update: 5/29/01 Added input synchronizing flip-flops.  Changed state
//                 encoding (m1) for good operation after part config.
// Update: 5/31/01 Added low drive strength and slow transitions to ps2_clk
//                 and ps2_data in the constraints file.  Added the signal
//                 "tx_shifting_done" as distinguished from "rx_shifting_done."
//                 Debugged the transmitter portion in the lab.
// Update: 6/01/01 Added horizontal tab to the ascii output.
// Update: 6/01/01 Added parameter TRAP_SHIFT_KEYS.
// Update: 6/05/01 Debugged the "debounce" timer functionality.
//                 Used 60usec timer as a "watchdog" timeout during
//                 receive from the keyboard.  This means that a keyboard
//                 can now be "hot plugged" into the interface, without
//                 messing up the bit_count, since the bit_count is reset
//                 to zero during periods of inactivity anyway.  This was
//                 difficult to debug.  I ended up using the logic analyzer,
//                 and had to scratch my head quite a bit.
// Update: 6/06/01 Removed extra comments before the input synchronizing
//                 flip-flops.  Used the correct parameter to size the
//                 5usec_timer_count.  Changed the name of this file from
//                 ps2.v to ps2_keyboard.v
// Update: 6/06/01 Removed "&& q[7:0]" in output_strobe logic.  Removed extra
//                 commented out "else" condition in the shift register and
//                 bit counter.
// Update: 6/07/01 Changed default values for 60usec timer parameters so that
//                 they correspond to 60usec for a 49.152MHz clock.
//
//
//
//
//
// Description
//-------------------------------------------------------------------------------------
// This is a state-machine driven serial-to-parallel and parallel-to-serial
// interface to the ps2 style keyboard interface.  The details of the operation
// of the keyboard interface were obtained from the following website:
//
//   http://www.beyondlogic.org/keyboard/keybrd.htm
//
// Some aspects of the keyboard interface are not implemented (e.g, parity
// checking for the receive side, and recognition of the various commands
// which the keyboard sends out, such as "power on selt test passed," "Error"
// and "Resend.")  However, if the user wishes to recognize these reply
// messages, the scan code output can always be used to extend functionality
// as desired.
//
// Note that the "Extended" (0xE0) and "Released" (0xF0) codes are recognized.
// The rx interface provides separate indicator flags for these two conditions
// with every valid character scan code which it provides.  The shift keys are
// also trapped by the interface, in order to provide correct uppercase ASCII
// characters at the ascii output, although the scan codes for the shift keys
// are still provided at the scan code output.  So, the left/right ALT keys
// can be differentiated by the presence of the rx_entended signal, while the
// left/right shift keys are differentiable by the different scan codes
// received.
//
// The interface to the ps2 keyboard uses ps2_clk clock rates of
// 30-40 kHz, dependent upon the keyboard itself.  The rate at which the state
// machine runs should be at least twice the rate of the ps2_clk, so that the
// states can accurately follow the clock signal itself.  Four times 
// oversampling is better.  Say 200kHz at least.  The upper limit for clocking
// the state machine will undoubtedly be determined by delays in the logic 
// which decodes the scan codes into ASCII equivalents.  The maximum speed
// will be most likely many megahertz, depending upon target technology.
// In order to run the state machine extremely fast, synchronizing flip-flops
// have been added to the ps2_clk and ps2_data inputs of the state machine.
// This avoids poor performance related to slow transitions of the inputs.
// 
// Because this is a bi-directional interface, while reading from the keyboard
// the ps2_clk and ps2_data lines are used as inputs.  While writing to the
// keyboard, however (which may be done at any time.  If writing interrupts a
// read from the keyboard, the keyboard will buffer up its data, and send
// it later) both the ps2_clk and ps2_data lines are occasionally pulled low,
// and pullup resistors are used to bring the lines high again, by setting
// the drivers to high impedance state.
//
// The tx interface, for writing to the keyboard, does not provide any special
// pre-processing.  It simply transmits the 8-bit command value to the
// keyboard.
//
// Pullups MUST BE USED on the ps2_clk and ps2_data lines for this design,
// whether they be internal to an FPGA I/O pad, or externally placed.
// If internal pullups are used, they may be fairly weak, causing bounces
// due to crosstalk, etc.  There is a "debounce timer" implemented in order
// to eliminate erroneous state transitions which would occur based on bounce.
// 
// Parameters are provided in order to configure and appropriately size the
// counter of a 60 microsecond timer used in the transmitter, depending on
// the clock frequency used.  The 60 microsecond period is guaranteed to be
// more than one period of the ps2_clk_s signal.
//
// Also, a smaller 5 microsecond timer has been included for "debounce".
// This is used because, with internal pullups on the ps2_clk and ps2_data
// lines, there is some bouncing around which occurs
//
// A parameter TRAP_SHIFT_KEYS allows the user to eliminate shift keypresses
// from producing scan codes (along with their "undefined" ASCII equivalents)
// at the output of the interface.  If TRAP_SHIFT_KEYS is non-zero, the shift
// key status will only be reported by rx_shift_key_on.  No ascii or scan
// codes will be reported for the shift keys.  This is useful for those who
// wish to use the ASCII data stream, and who don't want to have to "filter
// out" the shift key codes.
//
//-------------------------------------------------------------------------------------
`resetall
`timescale 1ns/100ps

`define TOTAL_BITS   11          //total data bits of the data package
`define EXTEND_CODE  8'hE0      //extend code
`define RELEASE_CODE 8'hF0      //release code

module ps2_keyboard(
  clk,
  reset,
  ps2_clk,
  ps2_data,
  interrupt,
  rx_scan_code
  );

// Parameters

// The timer value can be up to (2^bits) inclusive.
parameter TIMER_60USEC_VALUE_PP = 28*60; // Number of sys_clks for 60usec. (for a 28Mhz clock)
parameter TIMER_60USEC_BITS_PP  = 11;   // Number of bits needed for timer. Cambiar para que pueda almacenar el valor anterior

// State encodings, provided as parameters
// for flexibility to the one instantiating the module.
// In general, the default values need not be changed.

// State "m1_rx_clk_l" has been chosen on purpose.  Since the input
// synchronizing flip-flops initially contain zero, it takes one clk
// for them to update to reflect the actual (idle = high) status of
// the I/O lines from the keyboard.  Therefore, choosing 0 for m1_rx_clk_l
// allows the state machine to transition to m1_rx_clk_h when the true
// values of the input signals become present at the outputs of the
// synchronizing flip-flops.  This initial transition is harmless, and it
// eliminates the need for a "reset" pulse before the interface can operate.

parameter m1_rx_clk_h = 1;
parameter m1_rx_clk_l = 0;
parameter m1_rx_falling_edge_marker = 3;
parameter m1_rx_rising_edge_marker = 4;

  
// I/O declarations
input clk;
input reset;
input ps2_clk;
input ps2_data;
output interrupt;
output [7:0] rx_scan_code;
//output [7:0] rx_ascii;

reg rx_extended;
reg rx_released;
reg [7:0] rx_scan_code;
reg interrupt;



// Internal signal declarations
wire timer_60usec_done;
wire extended;
wire released;
                         // NOTE: These two signals used to be one.  They
                         //       were split into two signals because of
                         //       shift key trapping.  With shift key
                         //       trapping, no event is generated externally,
                         //       but the "hold" data must still be cleared
                         //       anyway regardless, in preparation for the
                         //       next scan codes.
wire rx_output_strobe;   // Used to produce the actual output.
wire rx_shifting_done;
        

reg [`TOTAL_BITS-1:0] q;      
reg [3:0] m1_state;
reg [3:0] m1_next_state;
reg [3:0] bit_count;

reg enable_timer_60usec;
reg [TIMER_60USEC_BITS_PP-1:0] timer_60usec_count;


reg ps2_clk_s;        // Synchronous version of this input
reg ps2_data_s;       // Synchronous version of this input


//--------------------------------------------------------------------------
// Module code

// Input "synchronizing" logic -- synchronizes the inputs to the state
// machine clock, thus avoiding errors related to
// spurious state machine transitions.
always @(posedge clk)
begin
  ps2_clk_s <= ps2_clk;
  ps2_data_s <= ps2_data;
end

// State register
always @(posedge clk)
begin : m1_state_register
  if (reset) m1_state <= m1_rx_clk_h;
  else m1_state <= m1_next_state;
end

// State transition logic
always @(m1_state
         or q
         or ps2_clk_s
         or ps2_data_s
         or timer_60usec_done
         )
begin : m1_state_logic

  // Output signals default to this value, unless changed in a state condition.

  enable_timer_60usec <= 0;

  case (m1_state)

    m1_rx_clk_h :
      begin
        enable_timer_60usec <= 1;
		  if (~ps2_clk_s) m1_next_state <= m1_rx_falling_edge_marker;
        else m1_next_state <= m1_rx_clk_h;
      end
      
    m1_rx_falling_edge_marker :
      begin
        enable_timer_60usec <= 0;
        m1_next_state <= m1_rx_clk_l;
      end

    m1_rx_rising_edge_marker :
      begin
        enable_timer_60usec <= 0;
        m1_next_state <= m1_rx_clk_h;
      end

    m1_rx_clk_l :
      begin
        enable_timer_60usec <= 1;
		  if (ps2_clk_s) m1_next_state <= m1_rx_rising_edge_marker;
        else m1_next_state <= m1_rx_clk_l;
      end
    default : m1_next_state <= m1_rx_clk_h;
  endcase
end


// This is the bit counter

always @(posedge clk)
begin
  if ( reset
        || rx_shifting_done
      ) 
		bit_count <= 0;  // normal reset
  else if (timer_60usec_done
           && (m1_state == m1_rx_clk_h)
           && (ps2_clk_s)
      ) 
		bit_count <= 0;  // rx watchdog timer reset
  else if ( (m1_state == m1_rx_falling_edge_marker)   // increment for rx
           )
    bit_count <= bit_count + 1;
end
// This signal is high for one clock at the end of the timer count.

assign rx_shifting_done = (bit_count == `TOTAL_BITS);



// This is the signal which enables loading of the shift register.
// It also indicates "ack" to the device writing to the transmitter.


// This is the ODD parity bit for the transmitted word.


// This is the shift register
always @(posedge clk)
begin
  if (reset) q <= 0;
  else if ( (m1_state == m1_rx_falling_edge_marker) )
    q <= {ps2_data_s,q[`TOTAL_BITS-1:1]};
end

// This is the 60usec timer counter

always @(posedge clk)
begin
  if (~enable_timer_60usec) timer_60usec_count <= 0;
  else if (~timer_60usec_done) timer_60usec_count <= timer_60usec_count + 1;
end

assign timer_60usec_done = (timer_60usec_count == (TIMER_60USEC_VALUE_PP - 1));



// Create the signals which indicate special scan codes received.
// These are the "unlatched versions."

assign extended = (q[8:1] == `EXTEND_CODE) && rx_shifting_done;
assign released = (q[8:1] == `RELEASE_CODE) && rx_shifting_done;


// Store the special scan code status bits
// Not the final output, but an intermediate storage place,
// until the entire set of output data can be assembled.

// Output the special scan code flags, the scan code and the ascii
always @(posedge clk)
begin
  if (reset)
  begin
    rx_scan_code <= 0;
    interrupt<=0;
  end
  else if (rx_output_strobe)      //if not extended, not relaeased,get the scan_code 
  begin
    rx_scan_code <= q[8:1];
    interrupt<=1;
  end
  else
  begin
  //rx_scan_code<=rx_scan_code;
  interrupt<=0;
  end
end

// Store the final rx output data only when all extend and release codes
// are received and the next (actual key) scan code is also ready.
// (the presence of rx_extended or rx_released refers to the
// the current latest scan code received, not the previously latched flags.)


assign rx_output_strobe = rx_shifting_done;
//                          && ~extended 
//                          && ~released
//                          );

// This part translates the scan code into an ASCII value...
// Only the ASCII codes which I considered important have been included.
// if you want more, just add the appropriate case statement lines...
// (You will need to know the keyboard scan codes you wish to assign.)
// The entries are listed in ascending order of ASCII value.

endmodule

//`undefine TOTAL_BITS
//`undefine EXTEND_CODE
//`undefine RELEASE_CODE
//`undefine LEFT_SHIFT
//`undefine RIGHT_SHIFT

