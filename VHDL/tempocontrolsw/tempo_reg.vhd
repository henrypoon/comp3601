----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:15:54 10/17/2017 
-- Design Name: 
-- Module Name:    tempo_reg - Behavioral 
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

entity tempo_reg is
	port(
		clk : in std_logic;
		reset : in std_logic;
		en : in std_logic;
		tempo_val: in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0)
		);
end tempo_reg;

architecture Behavioral of tempo_reg is

begin
	process (clk, reset, en)
	begin
		if reset ='1' then 
			data_out <= tempo_val;
		elsif rising_edge(clk) then
			if en = '1' then 
				data_out <= data_in;
			end if;
		end if;
	end process;

end Behavioral;
