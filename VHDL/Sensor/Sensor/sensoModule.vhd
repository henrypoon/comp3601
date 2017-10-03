----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:23:45 09/25/2017 
-- Design Name: 
-- Module Name:    sensoModule - Behavioral 
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

entity sensoModule is
    Port ( clk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
			  trig: out std_logic;
           senseOut: out std_logic);
end sensoModule;

architecture Behavioral of sensoModule is

component trigGen is
    Port ( clk : in  STD_LOGIC;
           trigOut : out  STD_LOGIC);
end component;

component distCalc is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           dist : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

signal dOut: std_logic_vector(8 downto 0);
signal trigOut: std_logic;
signal senseVal: std_logic;

begin

trigr: trigGen port map(clk, trigOut);
pWidth: distCalc port map(clk, trigOut, pulse, dOut);

process(dOut)
begin
	if dOut > "000000001" then
		senseVal <= '0';
	else
		senseVal <= '1';
	end if;
end process;

trig <= trigOut;
senseOut <= senseVal;

end Behavioral;

