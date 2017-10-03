----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:20 09/19/2017 
-- Design Name: 
-- Module Name:    timer - Behavioral 
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

entity timer is
    Port ( clk: in std_logic;
			  en: in std_logic;
			  rst: in std_logic;
           done : out  STD_LOGIC);
end timer;

architecture Behavioral of timer is

component countr is
	generic(n: positive :=10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           outCount : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal timeValue: std_logic_vector(28 downto 0);

begin

timrCounter: countr generic map(29) port map(clk,en,rst,timeValue);

process(timeValue)

constant fiveSeconds: std_logic_vector(28 downto 0):= "11101110011010110010100000000";

begin

if timeValue = fiveSeconds then
	done <= '1';
else
	done <= '0';
end if;
end process;

end Behavioral;

