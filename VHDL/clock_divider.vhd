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
			max_counter: in std_logic_vector(19 downto 0);
			square_wave: out std_logic
	);
end clock_divider;

architecture Behavioral of clock_divider is
	signal count:  integer range 0 to 400000 := 0;
	signal temp: std_logic;
	signal sig_max: integer;	
begin

	sig_max <= to_integer(unsigned(max_counter));
	
	counter: process(clk, reset)
			begin
			if (reset = '1') then
				temp <= '0';
				count <= 0;
			elsif (risingedge(clk)) then
				if counter = sig_max then 
					temp <= NOT(temp);
               counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
		end process;
		
	sqaure_wave <= temp;

end Behavioral;

