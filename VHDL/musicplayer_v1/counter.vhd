----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:07 09/01/2017 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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
entity counter is -- counter for duration
	port (clk : in std_logic;
			reset: in std_logic;
			max	: in std_logic_Vector(28 downto 0);
			output: out std_logic
	);
end counter;

architecture Behavioral of counter is
	signal sig_count : integer := 0;
	signal sig_max	 : integer;
begin
	sig_max <= to_integer(unsigned(max));
	process (clk, reset)
	begin
		if reset = '1' then
			output <= '0'; 
		elsif rising_edge(clk) then
			if sig_count = sig_max then
				output <= '1';
			else 
				output <= '0';
			end if;
			sig_count <= sig_count +1;
		end if;
	end process;

end Behavioral;

