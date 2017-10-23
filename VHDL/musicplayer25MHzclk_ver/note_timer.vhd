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
		base_vector : out std_logic_vector(25 downto 0);
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
	
	base_vector <= sig_base; 
	
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
			timeout <= '1';
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
		--when "00111100" => sig_base <= "10111110101111000010000000"; --60 bpm, this case should be covered already using "others"
		when "00111101" => sig_base <= "00101110111001101110101001";
		when "00111110" => sig_base <= "00101110001001010100000110";
		when "00111111" => sig_base <= "00101101011010011011111001";
		when "01000000" => sig_base <= "00101100101101000001011110";
		when "01000001" => sig_base <= "00101100000001000000011101";
		when "01000010" => sig_base <= "00101011010110010100110100";
		when "01000011" => sig_base <= "00101010101100111010101101";
		when "01000100" => sig_base <= "00101010000100101110100011";
		when "01000101" => sig_base <= "00101001011101101100111101";
		when "01000110" => sig_base <= "00101000110111110010101101";
		when "01000111" => sig_base <= "00101000010010111100110100";
		when "01001000" => sig_base <= "00100111101111001000011010";
		when "01001001" => sig_base <= "00100111001100010010110100";
		when "01001010" => sig_base <= "00100110101010011001011111";
		when "01001011" => sig_base <= "00100110001001011010000000";
		when "01001100" => sig_base <= "00100101101001010010000101";
		when "01001101" => sig_base <= "00100101001001111111100011";
		when "01001110" => sig_base <= "00100100101011100000011000";
		when "01001111" => sig_base <= "00100100001101110010100110";
		when "01010000" => sig_base <= "00100011110000110100011000";
		when "01010001" => sig_base <= "00100011010100100011111011";
		when "01010010" => sig_base <= "00100010111000111111100101";
		when "01010011" => sig_base <= "00100010011110000101110000";
		when "01010100" => sig_base <= "00100010000011110100111011";
		when "01010101" => sig_base <= "00100001101010001011101001";
		when "01010110" => sig_base <= "00100001010001001000100010";
		when "01010111" => sig_base <= "00100000111000101010010001";
		when "01011000" => sig_base <= "00100000100000101111100111";
		when "01011001" => sig_base <= "00100000001001010111010110";
		when "01011010" => sig_base <= "00011111110010100000010101";
		when "01011011" => sig_base <= "00011111011100001001011110";
		when "01011100" => sig_base <= "00011111000110010001101101";
		when "01011101" => sig_base <= "00011110110000111000000100";
		when "01011110" => sig_base <= "00011110011011111011100011";
		when "01011111" => sig_base <= "00011110000111011011010000";
		when "01100000" => sig_base <= "00011101110011010110010100";
		when "01100001" => sig_base <= "00011101011111101011110110";
		when "01100010" => sig_base <= "00011101001100011011000101";
		when "01100011" => sig_base <= "00011100111001100011001101";
		when "01100100" => sig_base <= "00011100100111000011100000";
		when "01100101" => sig_base <= "00011100010100111011001110";
		when "01100110" => sig_base <= "00011100000011001001101101";
		when "01100111" => sig_base <= "00011011110001101110010001";
		when "01101000" => sig_base <= "00011011100000101000010010";
		when "01101001" => sig_base <= "00011011001111110111001001";
		when "01101010" => sig_base <= "00011010111111011010001111";
		when "01101011" => sig_base <= "00011010101111010001000001";
		when "01101100" => sig_base <= "00011010011111011010111100";
		when "01101101" => sig_base <= "00011010001111110111011101";
		when "01101110" => sig_base <= "00011010000000100110000101";
		when "01101111" => sig_base <= "00011001110001100110010100";
		when "01110000" => sig_base <= "00011001100010110111101100";
		when "01110001" => sig_base <= "00011001010100011001110000";
		when "01110010" => sig_base <= "00011001000110001100000011";
		when "01110011" => sig_base <= "00011000111000001110001011";
		when "01110100" => sig_base <= "00011000101010011111101101";
		when "01110101" => sig_base <= "00011000011101000000010000";
		when "01110110" => sig_base <= "00011000001111101111011100";
		when "01110111" => sig_base <= "00011000000010101100111001";
		when "01111000" => sig_base <= "00010111110101111000010000";
		when "01111001" => sig_base <= "00010111101001010001001011";
		when "01111010" => sig_base <= "00010111011100110111010100";
		when "01111011" => sig_base <= "00010111010000101010011000";
		when "01111100" => sig_base <= "00010111000100101010000011";
		when "01111101" => sig_base <= "00010110111000110110000000";
		when "01111110" => sig_base <= "00010110101101001101111100";
		when "01111111" => sig_base <= "00010110100001110001100111";
		when "10000000" => sig_base <= "00010110010110100000101111";
		when "10000001" => sig_base <= "00010110001011011011000001";
		when "10000010" => sig_base <= "00010110000000100000001110";
		when "10000011" => sig_base <= "00010101110101110000000110";
		when "10000100" => sig_base <= "00010101101011001010011010";
		when "10000101" => sig_base <= "00010101100000101110111001";
		when "10000110" => sig_base <= "00010101010110011101010110";
		when "10000111" => sig_base <= "00010101001100010101100011";
		when "10001000" => sig_base <= "00010101000010010111010001";
		when "10001001" => sig_base <= "00010100111000100010010100";
		when "10001010" => sig_base <= "00010100101110110110011110";
		when "10001011" => sig_base <= "00010100100101010011100011";
		when "10001100" => sig_base <= "00010100011011111001010110";
		when "10001101" => sig_base <= "00010100010010100111101100";
		when "10001110" => sig_base <= "00010100001001011110011010";
		when "10001111" => sig_base <= "00010100000000011101010011";
		when "10010000" => sig_base <= "00010011110111100100001101";
		when "10010001" => sig_base <= "00010011101110110010111101";
		when "10010010" => sig_base <= "00010011100110001001011010";
		when "10010011" => sig_base <= "00010011011101100111011000";
		when "10010100" => sig_base <= "00010011010101001100101111";
		when "10010101" => sig_base <= "00010011001100111001010101";
		when "10010110" => sig_base <= "00010011000100101101000000";
		when "10010111" => sig_base <= "00010010111100100111100111";
		when "10011000" => sig_base <= "00010010110100101001000010";
		when "10011001" => sig_base <= "00010010101100110001001000";
		when "10011010" => sig_base <= "00010010100100111111110001";
		when "10011011" => sig_base <= "00010010011101010100110101";
		when "10011100" => sig_base <= "00010010010101110000001100";
		when "10011101" => sig_base <= "00010010001110010001101110";
		when "10011110" => sig_base <= "00010010000110111001010011";
		when "10011111" => sig_base <= "00010001111111100110110101";
		when "10100000" => sig_base <= "00010001111000011010001100";
		when "10100001" => sig_base <= "00010001110001010011010001";
		when "10100010" => sig_base <= "00010001101010010001111101";
		when "10100011" => sig_base <= "00010001100011010110001010";
		when "10100100" => sig_base <= "00010001011100011111110010";
		when "10100101" => sig_base <= "00010001010101101110101110";
		when "10100110" => sig_base <= "00010001001111000010111000";
		when "10100111" => sig_base <= "00010001001000011100001001";
		when "10101000" => sig_base <= "00010001000001111010011101";
		when "10101001" => sig_base <= "00010000111011011101101101";
		when "10101010" => sig_base <= "00010000110101000101110100";
		when "10101011" => sig_base <= "00010000101110110010101100";
		when "10101100" => sig_base <= "00010000101000100100010001";
		when "10101101" => sig_base <= "00010000100010011010011100";
		when "10101110" => sig_base <= "00010000011100010101001000";
		when "10101111" => sig_base <= "00010000010110010100010010";
		when "10110000" => sig_base <= "00010000010000010111110011";
		when "10110001" => sig_base <= "00010000001010011111101000";
		when "10110010" => sig_base <= "00010000000100101011101011";
		when "10110011" => sig_base <= "00001111111110111011111000";
		when "10110100" => sig_base <= "00001111111001010000001010";
		when "10110101" => sig_base <= "00001111110011101000011110";
		when "10110110" => sig_base <= "00001111101110000100101111";
		when "10110111" => sig_base <= "00001111101000100100111000";
		when "10111000" => sig_base <= "00001111100011001000110110";
		when "10111001" => sig_base <= "00001111011101110000100110";
		when "10111010" => sig_base <= "00001111011000011100000010";
		when "10111011" => sig_base <= "00001111010011001011000111";
		when "10111100" => sig_base <= "00001111001101111101110001";
		when "10111101" => sig_base <= "00001111001000110011111101";
		when "10111110" => sig_base <= "00001111000011101101101000";
		when "10111111" => sig_base <= "00001110111110101010101101";
		when "11000000" => sig_base <= "00001110111001101011001010";
		when "11000001" => sig_base <= "00001110110100101110111010";
		when "11000010" => sig_base <= "00001110101111110101111011";
		when "11000011" => sig_base <= "00001110101011000000001001";
		when "11000100" => sig_base <= "00001110100110001101100010";
		when "11000101" => sig_base <= "00001110100001011110000010";
		when "11000110" => sig_base <= "00001110011100110001100110";
		when "11000111" => sig_base <= "00001110011000001000001100";
		when "11001000" => sig_base <= "00001110010011100001110000";
		when others => sig_base <= "00101111101011110000100000";
	end case;
	end process;
end Behavioral;

