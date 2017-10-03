----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:50 09/19/2017 
-- Design Name: 
-- Module Name:    swingCounter - Behavioral 
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

entity swingCounter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  done: in std_logic;
           swingNum : out  STD_LOGIC_VECTOR (7 downto 0));
end swingCounter;

architecture Behavioral of swingCounter is

component countr is
	generic(n: positive :=10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           outCount : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal swing: std_logic_vector(7 downto 0);

begin

swingCounter: countr generic map(8) port map(clk,'1',rst,swing);

process(clk,done)
begin
	if done = '1' then
		swingNum <= swing;
	end if;
end process;


end Behavioral;

