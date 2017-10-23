----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:09:39 09/01/2017 
-- Design Name: 
-- Module Name:    register_16b - Behavioral 
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

entity register_16b is
	port(clk :in std_logic;
		reset: in std_logic;
		enable: in std_logic;
		data_in: in std_logic_vector(15 downto 0);
		data_out:	 out std_logic_vector(15 downto 0)
			);
end register_16b;

architecture Behavioral of register_16b is

begin
	process (clk, reset)
	begin
		if reset ='1' then 
			data_out <= "0000000000000000";
		elsif rising_edge(clk) AND enable = '1' then
			data_out <= data_in;
		end if;
	end process;

end Behavioral;

