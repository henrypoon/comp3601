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
			  rst: in std_logic;
           swingValue : out  STD_LOGIC_VECTOR (7 downto 0));
end sensorComponent;

architecture Behavioral of sensorComponent is 

component trySense is
    Port ( clk : in  STD_LOGIC;
           trig : out  STD_LOGIC;
           echo : in  STD_LOGIC;
           myOut : out  STD_LOGIC);
end component;

component timerMod is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           done : out  STD_LOGIC);
end component;

component swingmodule is
    Port ( clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  release: in std_logic;
           swingout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clkSensor: std_logic;
signal swingSwitch: std_logic;
signal outSwing: std_logic_vector(7 downto 0);

begin

sensor: trySense port map(clk, trig, pulse, clkSensor);
swingTimer: timerMod port map(clk, timerSwitch, rst, swingSwitch);
swingComp: swingmodule port map(clkSensor, timerSwitch, rst, swingSwitch, outSwing);

swingValue <= outSwing;

end Behavioral;

