----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:48:39 10/10/2017 
-- Design Name: 
-- Module Name:    swingmodule - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity swingmodule is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  release: in std_logic;
           swingout : out  STD_LOGIC_VECTOR (7 downto 0));
end swingmodule;

architecture Behavioral of swingmodule is

signal swingCount: std_logic_vector(7 downto 0);
signal tomult: std_logic_vector(7 downto 0);
signal totalSwing: std_logic_vector(7 downto 0);

begin

process(clk, en, rst, swingCount, release)
begin

if rst = '1' then
	swingCount <= (others=>'0');
elsif en = '1' then
	if rising_edge(clk) then
		swingCount<= swingCount+1;
	end if;
	
   if release = '1' then
		tomult<= swingCount * "1100";
		
		if(tomult < conv_std_logic_vector(60, 8)) then
			totalSwing <= conv_std_logic_vector(60, 8);
		elsif (tomult > conv_std_logic_vector(200, 8)) then
			totalSwing <= conv_std_logic_vector(200, 8);
		else
			totalSwing<= tomult;
		end if;
		
		swingout<=totalSwing;
	end if;
end if;

--tomult<= swingCount * "1100";
--swingout<=tomult;

end process;

end Behavioral;

