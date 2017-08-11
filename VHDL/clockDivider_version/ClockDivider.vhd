library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- slower the clock to match the frequency
entity ClockDivider is
    Port (  clk : in std_logic;
           sclk : out std_logic);
end ClockDivider;

architecture cd of ClockDivider is
   constant max : integer := (3000000);
   signal tmp : std_logic := '0';
begin
   my_div: process (clk,tmp)
      variable curr : integer := 0;
   begin
      if (rising_edge(clk)) then
         if (curr = MAX_COUNT) then
            tmp <= not tmp;
            curr := 0;
         else
            curr := curr + 1;
         end if;
      end if;
      sclk <= tmp;
   end process my_div;
end cd;
