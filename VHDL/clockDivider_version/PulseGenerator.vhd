library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PulseGenerator is
    Port ( clk : in  STD_LOGIC;
           inc : in  STD_LOGIC;
           q : out  STD_LOGIC);
end PulseGenerator;

architecture Behavioral of PulseGenerator is

begin
Incrementer : process (clk)
	variable prev : std_logic := '0'; --previous state of input
begin
	if rising_edge(clk) then
		q <= '0'; --default output is low
		if prev ='0' and inc = '1' then --if input goes from low to high
			q <= '1'; --output as high
		end if;
		prev := inc;
	end if;
end process;


end Behavioral;
