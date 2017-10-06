----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:00:46 08/24/2017 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity clock_divider is
	port( clk : in std_logic;
			reset: in std_logic;
			en	:	in std_logic;
			--changed it to directly take in the note data
			note_data: in std_logic_vector(5 downto 0);
--			max_counter: in std_logic_vector(19 downto 0);
			square_wave: out std_logic
	);
end clock_divider;

architecture Behavioral of clock_divider is
	signal count:  integer range 0 to 400000 := 0;
	signal temp: std_logic;
	signal sig_max: integer range 0 to 500000;	
begin

	--sig_max <= to_integer(unsigned(max_counter));
	
	--select frequency counter value
	--LUT
	process(note_data)
	begin
		case note_data is
			when "000000" => sig_max <= 0; -- rest
			when "000010" => sig_max <= 384615; --c3
			when "000011" => sig_max <= 360776; --c3# d3b
			when "000100" => sig_max <= 340529; --d3
			when "000101" => sig_max <= 321419; --d3# e3b
			when "000110" => sig_max <= 303379; --e3 f3b
			when "000111" => sig_max <= 286352; --e3# f3
			when "001000" => sig_max <= 270270; --f3# g3b
			when "001001" => sig_max <= 255102; --g3
			when "001010" => sig_max <= 240789 ; --g3# a4b
			when "001011" => sig_max <= 113636 ; --a3
			when "001100" => sig_max <= 107259 ; --a3# b3b
			when "001101" => sig_max <= 101239 ; --b3 c3b
			when "001110" => sig_max <= 191109 ; --b3# c4
			when "001111" => sig_max <= 180388 ; --c4# d4b
			when "010000" => sig_max <= 170264 ; --d4
			when "010001" => sig_max <= 160704 ; --d4# e4b
			when "010010" => sig_max <= 151685 ; --e4 f4b
			when "010011" => sig_max <= 143172 ; --e4# f4
			when "010100" => sig_max <= 135138 ; --f4# g4b
			when "010101" => sig_max <= 127551 ; --g4
			when "010110" => sig_max <= 120394 ; --g4# a4b
			when "010111" => sig_max <= 56818 ; --a4
			when "011000" => sig_max <= 53629 ; --a4# b4b
			when "011001" => sig_max <= 50619 ; --b4 c5b
			when "011010" => sig_max <= 95556 ; --b5# c5
			when "011011" => sig_max <= 90192 ; --c5# d5b
			when "011100" => sig_max <= 85131 ; --d5
			when "011101" => sig_max <= 80353 ; --d5# e5b
			when "011110" => sig_max <= 75843 ; --e5 f5b
			when "011111" => sig_max <= 71586 ; --e5# f5
			when "100000" => sig_max <= 67568 ; --f5# g5b
			when "100001" => sig_max <= 63776 ; --g5
			when "100010" => sig_max <= 60196 ; --g5# a5b
			when "100011" => sig_max <= 56818 ; --a5
			when "100100" => sig_max <= 53648 ; --a5# b5b
			when "100101" => sig_max <= 50658 ; --b5 c6b
			when "100110" => sig_max <= 47778 ; --b6# c6
			when "100111" => sig_max <= 45126 ; --c6# d6b
			when "101000" => sig_max <= 42589 ; --d6
			when "101001" => sig_max <= 40192 ; --d6# e6b
			when "101010" => sig_max <= 37936 ; --e6 f6b
			when "101011" => sig_max <= 35816 ; --e6# f6
			when "101100" => sig_max <= 33806 ; --f6# g6b
			when "101101" => sig_max <= 31908 ; --g6
			when "101110" => sig_max <= 30102 ; --g6# a6b
			when "101111" => sig_max <= 28409 ; --a6
			when "110000" => sig_max <= 26824 ; --a6# b6b
			when "110001" => sig_max <= 25316 ; --b6 c7b
			when others => sig_max <= 0;
		end case;
	end process;



	--mux version
--	with note_data select sig_max <= 
--		0 when "000000", -- rest
--		384615 when "000010", --c3
--		360776 when "000011", --c3# d3b
--		340529 when "000100", --d3
--		321419 when "000101", --d3# e3b
--		303379 when "000110", --e3 f3b
		--works up to here
		--286352 when "000111", --e3# f3
		--270270 when "001000", --f3# g3b
		--255102 when "001001", --g3
		--240789 when "001010", --g3# a4b
--		0 when others;	-- will fill this in later

		
		
	counter: process(clk, reset)
	begin
		if (reset = '1') then
			temp <= '0';
			count <= 0;
		elsif (rising_edge(clk)) then
			if en ='1' then
				if sig_max = 0 then
					temp <= '0';
					count <= 0;
				elsif count > sig_max then 
					temp <= NOT(temp);
					count <= 0;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
		end process;
		
	square_wave <= temp;

end Behavioral;
