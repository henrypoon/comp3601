----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:24 09/17/2017 
-- Design Name: 
-- Module Name:    countr - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countr is
	generic(n: positive :=10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           outCount : out  STD_LOGIC_VECTOR (n-1 downto 0));
end countr;

architecture Behavioral of countr is

signal count: std_logic_vector(n-1 downto 0);

begin

process(clk,rst)
begin
	if(rst = '0') then
		count <= (others => '0');
	elsif rising_edge(clk) then
		if en = '1' then
			count <= count+1;
		end if;
	end if;
end process;

outCount <= count;

end Behavioral;

