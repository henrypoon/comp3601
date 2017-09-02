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
	--hard coded for tempo = 120 i.e. 25000000 cc for a beat
	with tempo select sig_base <=
		"01011111010111100001000000" when "01111000", -- 2500000 for 120 bpm
		"10111110101111000010000000" when others; -- 50000000 for 60 bpm
	
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
		elsif falling_edge(clk) and en ='1' then -- falling edge since input signals sent on rising edge
			if counter < sig_duration then
				timeout <= '0';
				counter <= counter +1;
			else 
				timeout <= '1'; 
			end if;
		end if;
	end process;
end Behavioral;

