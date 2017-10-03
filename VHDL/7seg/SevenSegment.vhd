library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevenSegment is
    Port (      binary : in std_logic_vector(7 downto 0);
                    CLK : in std_logic;
               SEGMENTS : out std_logic_vector(7 downto 0));
end SevenSegment;

architecture my_sseg of sseg_dec is

begin

stateSignal: process(binary) ---
begin
	case binary is
		when "00000000" => SEGMENTS <= x"C0";
		when "00000001" => SEGMENTS <= x"f9";
		when "00000010" => SEGMENTS <= X"a4";
		when "00000011" => SEGMENTS <= X"b0";
		when "00000100" => SEGMENTS <= X"99";
		when "00000101" => SEGMENTS <= X"92";
		when "00000110" => SEGMENTS <= X"82";
		when "00000111" => SEGMENTS <= X"f8";
		when "00001000" => SEGMENTS <= X"f8";
		when "00001001" => SEGMENTS <= X"f8";
		when others =>
		end case;
end process;

end my_sseg;
