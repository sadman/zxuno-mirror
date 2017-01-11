-------------------------------------------------------------------------------
--
-- Delta-Sigma DAC
--
-- $Id: dac.vhd,v 1.1 2006/05/10 20:57:06 arnim Exp $
--
-- Refer to Xilinx Application Note XAPP154.
--
-- This DAC requires an external RC low-pass filter:
--
--   o 0---XXXXX---+---0 analog audio
--          3k3    |
--                === 4n7
--                 |
--                GND
--
-------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity dac is

	generic
	(
		msbi : integer := 7
	);
	port
	(
		clock : in  std_logic;
		reset : in  std_logic;
		i     : in  std_logic_vector(msbi downto 0);
		o     : out std_logic
	);

end;

architecture rtl of dac is

	signal s : unsigned(msbi+2 downto 0) := (others => '0');

begin
	process(clock, reset)
	begin
	--	if reset = '0' then
	--		s <= to_unsigned(2**(msbi+1), s'length);
	--		o <= '0';
	--	elsif rising_edge(clock) then
	--		s <= s+unsigned(s(msbi+2)&s(msbi+2)&i);
	--		o <= s(msbi+2);
	--	end if;

		if rising_edge(clock)
		then
			if reset = '0'
			then
				s <= to_unsigned(2**(msbi+1), s'length);
				o <= '0';
			else
				s <= s+unsigned(s(msbi+2)&s(msbi+2)&i);
				o <= s(msbi+2);
			end if;
		end if;

	end process seq;
end;

----
-- 
-- ‘define MSBI 7                // Most significant Bit of DAC input
-- 
-- module dac
-- (
-- 	DACout,
-- 	DACin,
-- 	Clk,
-- 	Reset
-- );
-- 
-- output DACout;                // This is the average output that feeds low pass filter
-- reg DACout;                   // for optimum performance, ensure that this ff is in IOB
-- input [‘MSBI:0] DACin;        // DAC input (excess 2**MSBI)
-- input Clk;
-- input Reset;
-- reg [‘MSBI+2:0] DeltaAdder;   // Output of Delta adder
-- reg [‘MSBI+2:0] SigmaAdder;   // Output of Sigma adder
-- reg [‘MSBI+2:0] SigmaLatch;   // Latches output of Sigma adder
-- reg [‘MSBI+2:0] DeltaB;       // B input of Delta adder
-- 
-- always @(SigmaLatch) DeltaB = {SigmaLatch[‘MSBI+2], SigmaLatch[‘MSBI+2]} << (‘MSBI+1);
-- always @(DACin or DeltaB) DeltaAdder = DACin + DeltaB;
-- always @(DeltaAdder or SigmaLatch) SigmaAdder = DeltaAdder + SigmaLatch;
-- always @(posedge Clk or posedge Reset)
-- begin
-- 	if(Reset)
-- 	begin
-- 		SigmaLatch <= #1 1’bl << (‘MSBI+1);
-- 		DACout <= #1 1‘b0;
-- 	end
-- 	else
-- 	begin
-- 		SigmaLatch <== #1 SigmaAdder;
-- 		DACout <= #1 SigmaLatch[‘MSBI+2];
-- 	end
-- end
-- 
-- endmodule
-- 
----