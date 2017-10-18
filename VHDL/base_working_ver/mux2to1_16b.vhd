----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:32:43 09/01/2017 
-- Design Name: 
-- Module Name:    mux2to1_16b - Behavioral 
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

entity mux2to1_16b is
	port (data_a : in std_logic_vector(15 downto 0);
			data_b : in std_logic_vector(15 downto 0);
			sel	 : in std_logic;
			data	 : out std_logic_vector(15 downto 0)
	);
end mux2to1_16b;

architecture Behavioral of mux2to1_16b is

begin
	data <= data_a when (sel = '0') else data_b;

end Behavioral;

