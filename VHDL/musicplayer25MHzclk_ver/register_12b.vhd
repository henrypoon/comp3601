----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:42 09/01/2017 
-- Design Name: 
-- Module Name:    register_12b - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_12b is
	port(
		clk :in std_logic;
		reset: in std_logic;
		enable: in std_logic;
		data_in: in std_logic_vector(11 downto 0);
		done	: out std_logic;
		data_out:	 out std_logic_vector(11 downto 0)
	);
end register_12b;

architecture Behavioral of register_12b is

begin
	process (clk, reset)
	begin
		if reset ='1' then 
			data_out <= "000000000000";
			done <= '0';
		elsif rising_edge(clk) then
			if enable = '1' then 
				data_out <= data_in;
				done <= '1';
			else
				done <= '0';
			end if;
		end if;
	end process;

end Behavioral;


