----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:46:10 09/25/2017 
-- Design Name: 
-- Module Name:    multiplier - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           res : out  STD_LOGIC_VECTOR (7 downto 0));
end multiplier;

architecture Behavioral of multiplier is

signal eightBitValue: std_logic_vector(11 downto 0);

begin

	eightBitValue <= std_logic_vector(unsigned(a) * "1100");
	
	process(eightBitValue)
	begin
		if eightBitValue > "0000000011001000" then
			res <= "11001000";
		else
			res <= eightBitValue(7 downto 0);
		end if;
	end process;
	
	

end Behavioral;

