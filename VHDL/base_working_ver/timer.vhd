----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:45:00 10/10/2017 
-- Design Name: 
-- Module Name:    timerMod - Behavioral 
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timerMod is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           done : out  STD_LOGIC);
end timerMod;


architecture Behavioral of timerMod is

signal timerCounter: integer;

begin

process(clk, en, rst, timerCounter)
begin
	if rst = '1' then
		timerCounter<= 0;
	elsif en = '1' then
		if rising_edge(clk) then
		    if timerCounter < 700000000 then
    			timerCounter <= timerCounter+1;
			end if;
		end if;
		
	end if;
end process;

done <= '1' when (timerCounter > 500000000 and timerCounter < 600000000) else '0';

end Behavioral;

