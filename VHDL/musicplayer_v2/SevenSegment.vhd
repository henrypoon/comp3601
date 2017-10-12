library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (      binary : in std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
end SevenSegment;

architecture my_sseg of SevenSegment is

begin

stateSignal: process(binary) ---
begin
	case binary is
		when "0000" => SEGMENTS <= x"C0";
		when "0001" => SEGMENTS <= x"f9";
		when "0010" => SEGMENTS <= X"a4";
		when "0011" => SEGMENTS <= X"b0";
		when "0100" => SEGMENTS <= X"99";
		when "0101" => SEGMENTS <= X"92";
		when "0110" => SEGMENTS <= X"82";
		when "0111" => SEGMENTS <= X"f8";
		when "1000" => SEGMENTS <= X"80";
		when "1001" => SEGMENTS <= X"98";
		when others => SEGMENTS <= X"00";
		end case;
end process;

end my_sseg;