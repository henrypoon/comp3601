library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity pwm is
  port (enable : in std_logic;
        data   : in std_logic_vector(11 downto 0);
        wave   : out std_logic
        );
end pwm;
architecture behavioural of pwm is
begin
  --basically does nothing right now
    wave <= data(0);
end behavioural;

