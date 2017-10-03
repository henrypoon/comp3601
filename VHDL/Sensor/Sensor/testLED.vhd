----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:03 09/10/2017 
-- Design Name: 
-- Module Name:    testLED - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testLED is
    Port ( clk : in std_logic;
			  pulse : in  STD_LOGIC;
			  trig  : out STD_LOGIC;
			  LED : out std_logic_vector(1 downto 0));
end testLED;

architecture Behavioral of testLED is

component distCalc is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           dist : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

component trigGen is
    Port ( clk : in  STD_LOGIC;
           trigOut : out  STD_LOGIC);
end component;

signal dOut: std_logic_vector(8 downto 0);
signal trigOut: std_logic;

begin
trigGenerator: trigGen port map(clk,trigOut);
pulseWidth: distCalc port map(clk,trigOut,pulse,dOut);

process(dOut)
begin

if dOut > "00110010" then
	LED(0) <= '0';
	LED(1) <= '0';
else
	LED(0) <= '0';
	LED(1) <= '1';
end if;

end process;

trig <= trigOut;

end Behavioral;

