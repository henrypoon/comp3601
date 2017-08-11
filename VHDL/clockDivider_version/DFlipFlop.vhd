library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- 3 bit version of D filp flop
entity DFlipFlop is
   port (
     clk : in std_logic;
	  reset : in std_logic;
     enable  : in std_logic;
     d : in std_logic_vector(2 downto 0);
     q : out std_logic_vector(2 downto 0)
   );
end entity DFlipFlop;

architecture Behavioral of DFlipFlop is
begin
   process (clk, reset, enable) is
   begin
	 if (reset = '1') then
		 q <= "000"; --  initial
    elsif (rising_edge(clk)) then
		if (enable = '1') then
        q <= d; -- update output when enable is true
		end if;
    end if;
   end process;
end architecture Behavioral;
