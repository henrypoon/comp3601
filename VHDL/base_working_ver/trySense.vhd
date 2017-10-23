----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:36 10/07/2017 
-- Design Name: 
-- Module Name:    trySense - Behavioral 
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

entity trySense is
    Port ( clk : in  STD_LOGIC;
           trig : out  STD_LOGIC;
           echo : in  STD_LOGIC;
           myOut : out  STD_LOGIC);
end trySense;

architecture Behavioral of trySense is

signal echo_time: integer:= 10;

begin

process(clk)
    variable c1,c2: integer:=0;
    variable y :std_logic:='1';
begin
    if rising_edge(clk) then

        if(c1=0) then
            trig<='1';
        elsif(c1=500) then--100us
            trig<='0';
            y:='1';
        elsif(c1=5000000) then-- 100 ms
            c1:=0;
            trig<='1';
        end if;
        c1:=c1+1;

        if(echo = '1') then
            c2:=c2+1;
        elsif(echo = '0' and y='1' ) then
            echo_time<= c2;
            c2:=0;
            y:='0';
        end if;

        if(echo_time < 100000) then
            myOut<='1';
        else
            myOut<='0';
        end if;
    end if; 
end process ;

end Behavioral;

