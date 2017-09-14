----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:16 09/02/2017 
-- Design Name: 
-- Module Name:    note_timer - Behavioral 
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
USE ieee.numeric_std.ALL;
--handles how long each note plays for
entity note_timer is
	port(
		clk: in std_logic;
		reset: in std_logic;
		en: in std_logic;
		note_dur: in std_logic_vector(3 downto 0);
		tempo: in std_logic_vector(7 downto 0);
		timeout: out std_logic
	);
end note_timer;

architecture Behavioral of note_timer is
	signal sig_1_8 : integer range 0 to 200000000;
	signal sig_1_4 : integer range 0 to 200000000;
	signal sig_1_3 : integer range 0 to 200000000;
	signal sig_1_2 : integer range 0 to 200000000;
	signal sig_3_4 : integer range 0 to 200000000;
	signal sig_1 : integer range 0 to 200000000;
	signal sig_1_1_2 : integer range 0 to 200000000;
	signal sig_2 : integer range 0 to 200000000;
	signal sig_3 : integer range 0 to 200000000;
	signal sig_4 : integer range 0 to 200000000;
	signal sig_8 : integer range 0 to 200000000;
	signal sig_base: std_logic_vector(25 downto 0);
	signal sig_duration: integer range 0 to 200000000;
	signal counter : integer range 0 to 250000000:=0; -- bigger than note duration just in case it overflows
begin
	
	--handle different note durations
	sig_1_8 <= to_integer(unsigned(sig_base(25 downto 3)));
	sig_1_4 <= to_integer(unsigned(sig_base(25 downto 2)));
	sig_1_3 <= sig_1_8 + sig_1_4; 
	sig_1_2 <= to_integer(unsigned(sig_base(25 downto 1)));
	sig_3_4 <= sig_1_2 + sig_1_4;
	sig_1 <= to_integer(unsigned(sig_base));
	sig_1_1_2 <= sig_1 + sig_1_2;
	sig_2 <= to_integer(unsigned(sig_base(24 downto 0) & '0'));
	sig_3 <= sig_1 + sig_2;
	sig_4 <= to_integer(unsigned(sig_base(23 downto 0) & "00"));
	sig_8 <= to_integer(unsigned(sig_base(22 downto 0) & "000"));

	with note_dur select sig_duration <= 
		sig_1_4 when "0000",
		sig_1_3 when "0001",
		sig_1_2 when "0010",
		sig_3_4 when "0011",
		--sig_1 <= moved to others
		sig_1_1_2 when "0101",
		sig_2 when "0110",
		sig_3 when "0111",
		sig_4 when "1000",
		sig_8 when "1001",
		sig_1 when others;

	note_timer:process (reset, clk)
	begin
		if reset = '1' then 
			timeout <= '0';
			counter <= 0;
		elsif falling_edge(clk) then -- falling edge since input signals sent on rising edge
			if en = '1' then
				if counter < sig_duration then
					timeout <= '0';
					counter <= counter +1;
				else 
					timeout <= '1'; 
				end if;
			else
				timeout <= '0';
				counter <= 0;
			end if;
		end if;
			
	end process;
	
	--hard coded for tempo = 120 i.e. 25000000 cc for a beat
	--with tempo select sig_base <=
	--	"01011111010111100001000000" when "01111000", -- 2500000 for 120 bpm
	--	"10111110101111000010000000" when others; -- 50000000 for 60 bpm
	
--	when tempo <= "" selec sig_base <= ""

--tempo = 8 bits, sig_base = 26 bits
	process (tempo)
	begin 
	case tempo is 
		when "00111100" => sig_base <= "10111110101111000010000000";
		when "00111101" => sig_base <= "10111011100110111010100111";
		when "00111110" => sig_base <= "10111000100101010000011000";
		when "00111111" => sig_base <= "10110101101001101111100111";
		when "01000000" => sig_base <= "10110010110100000101111000";
		when "01000001" => sig_base <= "10110000000100000001110110";
		when "01000010" => sig_base <= "10101101011001010011010001";
		when "01000011" => sig_base <= "10101010110011101010110111";
		when "01000100" => sig_base <= "10101000010010111010001111";
		when "01000101" => sig_base <= "10100101110110110011110100";
		when "01000110" => sig_base <= "10100011011111001010110110";
		when "01000111" => sig_base <= "10100001001011110011010001";
		when "01001000" => sig_base <= "10011110111100100001101010";
		when "01001001" => sig_base <= "10011100110001001011010010";
		when "01001010" => sig_base <= "10011010101001100101111100";
		when "01001011" => sig_base <= "10011000100101101000000000";
		when "01001100" => sig_base <= "10010110100101001000010100";
		when "01001101" => sig_base <= "10010100100111111110001110";
		when "01001110" => sig_base <= "10010010101110000001100010";
		when "01001111" => sig_base <= "10010000110111001010011011";
		when "01010000" => sig_base <= "10001111000011010001100000";
		when "01010001" => sig_base <= "10001101010010001111101101";
		when "01010010" => sig_base <= "10001011100011111110010101";
		when "01010011" => sig_base <= "10001001111000010111000010";
		when "01010100" => sig_base <= "10001000001111010011101101";
		when "01010101" => sig_base <= "10000110101000101110100101";
		when "01010110" => sig_base <= "10000101000100100010001000";
		when "01010111" => sig_base <= "10000011100010101001000110";
		when "01011000" => sig_base <= "10000010000010111110011101";
		when "01011001" => sig_base <= "10000000100101011101011001";
		when "01011010" => sig_base <= "01111111001010000001010101";
		when "01011011" => sig_base <= "01111101110000100101111000";
		when "01011100" => sig_base <= "01111100011001000110110111";
		when "01011101" => sig_base <= "01111011000011100000010000";
		when "01011110" => sig_base <= "01111001101111101110001101";
		when "01011111" => sig_base <= "01111000011101101101000011";
		when "01100000" => sig_base <= "01110111001101011001010000";
		when "01100001" => sig_base <= "01110101111110101111011011";
		when "01100010" => sig_base <= "01110100110001101100010100";
		when "01100011" => sig_base <= "01110011100110001100110110";
		when "01100100" => sig_base <= "01110010011100001110000000";
		when "01100101" => sig_base <= "01110001010011101100111010";
		when "01100110" => sig_base <= "01110000001100100110110100";
		when "01100111" => sig_base <= "01101111000110111001000101";
		when "01101000" => sig_base <= "01101110000010100001001001";
		when "01101001" => sig_base <= "01101100111111011100100100";
		when "01101010" => sig_base <= "01101011111101101000111110";
		when "01101011" => sig_base <= "01101010111101000100000111";
		when "01101100" => sig_base <= "01101001111101101011110001";
		when "01101101" => sig_base <= "01101000111111011101110111";
		when "01101110" => sig_base <= "01101000000010011000010111";
		when "01101111" => sig_base <= "01100111000110011001010011";
		when "01110000" => sig_base <= "01100110001011011110110010";
		when "01110001" => sig_base <= "01100101010001100111000000";
		when "01110010" => sig_base <= "01100100011000110000001101";
		when "01110011" => sig_base <= "01100011100000111000101100";
		when "01110100" => sig_base <= "01100010101001111110110100";
		when "01110101" => sig_base <= "01100001110100000001000001";
		when "01110110" => sig_base <= "01100000111110111101110000";
		when "01110111" => sig_base <= "01100000001010110011100100";
		when "01111000" => sig_base <= "01011111010111100001000000";
		when "01111001" => sig_base <= "01011110100101000100101100";
		when "01111010" => sig_base <= "01011101110011011101010011";
		when "01111011" => sig_base <= "01011101000010101001100011";
		when "01111100" => sig_base <= "01011100010010101000001100";
		when "01111101" => sig_base <= "01011011100011011000000000";
		when "01111110" => sig_base <= "01011010110100110111110011";
		when "01111111" => sig_base <= "01011010000111000110011111";
		when "10000000" => sig_base <= "01011001011010000010111100";
		when "10000001" => sig_base <= "01011000101101101100000101";
		when "10000010" => sig_base <= "01011000000010000000111011";
		when "10000011" => sig_base <= "01010111010111000000011011";
		when "10000100" => sig_base <= "01010110101100101001101000";
		when "10000101" => sig_base <= "01010110000010111011100110";
		when "10000110" => sig_base <= "01010101011001110101011011";
		when "10000111" => sig_base <= "01010100110001010110001110";
		when "10001000" => sig_base <= "01010100001001011101000111";
		when "10001001" => sig_base <= "01010011100010001001010010";
		when "10001010" => sig_base <= "01010010111011011001111010";
		when "10001011" => sig_base <= "01010010010101001110001101";
		when "10001100" => sig_base <= "01010001101111100101011011";
		when "10001101" => sig_base <= "01010001001010011110110011";
		when "10001110" => sig_base <= "01010000100101111001101000";
		when "10001111" => sig_base <= "01010000000001110101001100";
		when "10010000" => sig_base <= "01001111011110010000110101";
		when "10010001" => sig_base <= "01001110111011001011110111";
		when "10010010" => sig_base <= "01001110011000100101101001";
		when "10010011" => sig_base <= "01001101110110011101100011";
		when "10010100" => sig_base <= "01001101010100110010111110";
		when "10010101" => sig_base <= "01001100110011100101010100";
		when "10010110" => sig_base <= "01001100010010110100000000";
		when "10010111" => sig_base <= "01001011110010011110011101";
		when "10011000" => sig_base <= "01001011010010100100001010";
		when "10011001" => sig_base <= "01001010110011000100100011";
		when "10011010" => sig_base <= "01001010010011111111000111";
		when "10011011" => sig_base <= "01001001110101010011010110";
		when "10011100" => sig_base <= "01001001010111000000110001";
		when "10011101" => sig_base <= "01001000111001000110111000";
		when "10011110" => sig_base <= "01001000011011100101001101";
		when "10011111" => sig_base <= "01000111111110011011010100";
		when "10100000" => sig_base <= "01000111100001101000110000";
		when "10100001" => sig_base <= "01000111000101001101000100";
		when "10100010" => sig_base <= "01000110101001000111110110";
		when "10100011" => sig_base <= "01000110001101011000101011";
		when "10100100" => sig_base <= "01000101110001111111001010";
		when "10100101" => sig_base <= "01000101010110111010111010";
		when "10100110" => sig_base <= "01000100111100001011100001";
		when "10100111" => sig_base <= "01000100100001110000100111";
		when "10101000" => sig_base <= "01000100000111101001110110";
		when "10101001" => sig_base <= "01000011101101110110110111";
		when "10101010" => sig_base <= "01000011010100010111010010";
		when "10101011" => sig_base <= "01000010111011001010110011";
		when "10101100" => sig_base <= "01000010100010010001000100";
		when "10101101" => sig_base <= "01000010001001101001110000";
		when "10101110" => sig_base <= "01000001110001010100100011";
		when "10101111" => sig_base <= "01000001011001010001001001";
		when "10110000" => sig_base <= "01000001000001011111001110";
		when "10110001" => sig_base <= "01000000101001111110100000";
		when "10110010" => sig_base <= "01000000010010101110101100";
		when "10110011" => sig_base <= "00111111111011101111100000";
		when "10110100" => sig_base <= "00111111100101000000101010";
		when "10110101" => sig_base <= "00111111001110100001111001";
		when "10110110" => sig_base <= "00111110111000010010111100";
		when "10110111" => sig_base <= "00111110100010010011100010";
		when "10111000" => sig_base <= "00111110001100100011011011";
		when "10111001" => sig_base <= "00111101110111000010011000";
		when "10111010" => sig_base <= "00111101100001110000001000";
		when "10111011" => sig_base <= "00111101001100101100011100";
		when "10111100" => sig_base <= "00111100110111110111000110";
		when "10111101" => sig_base <= "00111100100011001111110111";
		when "10111110" => sig_base <= "00111100001110110110100001";
		when "10111111" => sig_base <= "00111011111010101010110110";
		when "11000000" => sig_base <= "00111011100110101100101000";
		when "11000001" => sig_base <= "00111011010010111011101001";
		when "11000010" => sig_base <= "00111010111111010111101101";
		when "11000011" => sig_base <= "00111010101100000000100111";
		when "11000100" => sig_base <= "00111010011000110110001010";
		when "11000101" => sig_base <= "00111010000101111000001010";
		when "11000110" => sig_base <= "00111001110011000110011011";
		when "11000111" => sig_base <= "00111001100000100000110000";
		when "11001000" => sig_base <= "00111001001110000111000000";
		when others => sig_base <= "10111110101111000010000000";
	end case;
	end process;
end Behavioral;

