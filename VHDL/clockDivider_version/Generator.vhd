library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Generator is
    Port ( clk : in  STD_LOGIC;
			  note : in STD_LOGIC_VECTOR(2 downto 0);
			  enable : in STD_LOGIC;
           speaker : out  STD_LOGIC);
end Generator;

architecture Behavioral of Generator is
   signal temp : std_logic := '0';
begin

   gen: process (clk,temp,note,enable)
      variable curr : integer := 0;
		variable max : integer := 0;
   begin
		--select correct frequency based on input note
		case note is
			when "000" => max := 0; --when input is 000, no square wave should be outputted
			when "001" => max := 114036;
			when "010" => max := 95507;
			when "011" => max := 82931;
			when "100" => max_Count := 73546;
			when "101" => max := 63876;
			when "110" => max := 59918;
			when "111" => max := 47799;
			when others =>
		end case;
      if (rising_edge(clk)) then
         if (curr >= max) then
            temp <= not temp;
            curr := 0;
         else
            curr := curr + 1;
         end if;
      end if;
      if (enable = '1') then
			speaker <= temp;
		else
			speaker <= '0';
		end if;
  end process gen;

end Behavioral;
