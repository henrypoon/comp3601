----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:33:51 09/25/2017 
-- Design Name: 
-- Module Name:    sensorComponent - Behavioral 
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

entity sensorComponent is
    Port ( clk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           timerSwitch : in  STD_LOGIC;
           trig : out  STD_LOGIC;
           swingValue : out  STD_LOGIC_VECTOR (7 downto 0));
end sensorComponent;

architecture Behavioral of sensorComponent is

component timer is
    Port ( clk: in std_logic;
			  en: in std_logic;
			  rst: in std_logic;
           done : out  STD_LOGIC);
end component;

component sensoModule is
    Port ( clk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
			  trig: out std_logic;
           senseOut: out std_logic);
end component;

component multiplier is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           res : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component swingCounter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  done: in std_logic;
           swingNum : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal timerDone: std_logic;
signal sensorOutput: std_logic;
signal swings: std_logic_vector(7 downto 0);
signal totalSwings: std_logic_vector(7 downto 0);
signal toOut: std_logic_vector(7 downto 0);

begin

timr: timer port map(clk, timerSwitch, timerSwitch, timerDone);
sensModule: sensoModule port map(clk, pulse, trig, sensorOutput);
swingCtr: swingCounter port map(sensorOutput, timerSwitch, timerDone, swings);
mult: multiplier port map(swings, totalSwings); 

process(timerSwitch, toOut, timerDone)
begin
	if timerSwitch = '0' then
		toOut <= (others=>'0');
	elsif timerDone = '1' and toOut = "00000000" then
		toOut <= totalSwings;
	end if;
end process;

swingValue <= toOut;

end Behavioral;

