----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:04:13 09/18/2017 
-- Design Name: 
-- Module Name:    distCalc - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity distCalc is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           dist : out  STD_LOGIC_VECTOR (8 downto 0));
end distCalc;

architecture Behavioral of distCalc is

component countr is
	generic(n: positive :=10);
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           outCount : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal pWidth: std_logic_vector(21 downto 0);

begin
pulseCounter: countr generic map(22) port map(clk,pulse,not(rst),pWidth);

dCalc: process(pulse)
				variable res:integer;
				variable mult: std_logic_vector(23 downto 0);
				
				begin
					if(pulse = '0') then
						mult := pWidth*"11";
						res:= to_integer(unsigned(mult(23 downto 13)));
							if(res > 458) then
								dist <= "111111111";
							else
								dist <= std_logic_vector(to_unsigned(res,9));
							end if;
					end if;
				end process;
end Behavioral;

