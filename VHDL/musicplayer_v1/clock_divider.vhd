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
