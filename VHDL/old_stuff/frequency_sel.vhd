----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:16 09/02/2017 
-- Design Name: 
-- Module Name:    frequency_sel - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- sets each counter value needed to be reached for each frequency
entity frequency_sel is
	port(
		clk : in std_logic;
		reset: in std_logic;
		note_data: in std_logic_vector(5 downto 0);
		note_counter: out std_logic_vector(19 downto 0)
	);
end frequency_sel;

architecture Behavioral of frequency_sel is
	signal sig_note: std_logic_vector(5 downto 0);
	signal sig_freq_max: std_logic_vector(19 downto 0);

begin
	sig_note <= note_data;
	note_counter <= sig_freq_max;
	
	sel_music_note: process(clk, reset) 
	begin
		if reset = '1' then
			sig_freq_max <= "00000000000000000000";
		elsif (rising_edge(clk)) then --using 50Mhz clock
		 -- if (enable = '1') then
				case sig_note is
					when "000000" => --rest 
						sig_freq_max <= "00000000000000000000";
					when "000010" => --c3
						sig_freq_max <= conv_std_logic_vector(384615, 20);
					when "000011" => --c3# d3b
						sig_freq_max <= conv_std_logic_vector(360776, 20);
					when "000100" => --d3
						sig_freq_max <= conv_std_logic_vector(340529, 20);
					when "000101" => --d3# e3b
						sig_freq_max <= conv_std_logic_vector(321419, 20);
					when "000110" => --e3 f3b
						sig_freq_max <= conv_std_logic_vector(303379, 20);
					when "000111" => --e3# f3
						sig_freq_max <= conv_std_logic_vector(286352, 20);
					when "001000" => --f3# g3b
						sig_freq_max <= conv_std_logic_vector(270270, 20);
					when "001001" => --g3
						sig_freq_max <= conv_std_logic_vector(255102, 20);
					when "001010" => --g3# a4b
						sig_freq_max <= conv_std_logic_vector(240789, 20);
					when others => 
						sig_freq_max <= "00000000000000000000"; --will need to expand on this to include the 2 other octaves
				end case;
			--end if;
		end if;
	end process;

end Behavioral;

