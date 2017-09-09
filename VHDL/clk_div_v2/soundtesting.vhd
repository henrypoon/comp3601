----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:46:00 09/07/2017 
-- Design Name: 
-- Module Name:    soundtesting - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity soundtesting is
	port (
		clk : in std_logic;
		reset : in std_logic;
		sw	:	in std_logic_vector(6 downto 0);
		led	:	out std_logic_vector(7 downto 0);
		sound: out std_logic
	);
	
end soundtesting;

architecture Behavioral of soundtesting is

-- components
	component clock_divider is
		port( 
			clk : in std_logic;
			reset: in std_logic;
			en	:	in std_logic;
			note_data: in std_logic_vector(5 downto 0);
	--		max_counter: in std_logic_vector(19 downto 0);
			square_wave: out std_logic
		);
	end component;

	component note_timer is
	port(
		clk: in std_logic;
		reset: in std_logic;
		en: in std_logic;
		note_dur: in std_logic_vector(3 downto 0);
		tempo: in std_logic_vector(7 downto 0);
		timeout: out std_logic
		);
	end component;

--	component frequency_sel is
--		port(
--			clk : in std_logic;
--			reset: in std_logic;
--			note_data: in std_logic_vector(5 downto 0);
--			note_counter: out std_logic_vector(19 downto 0)
--	);
--	end component;

--signals
	--signal sig_note_counter : std_logic_vector(19 downto 0);
	signal sig_note_dur : std_logic_vector (3 downto 0);
	signal sig_tempo	: std_logic_vector (7 downto 0);	
	signal sig_timer_out : std_logic;
	signal sig_clk_div_en : std_logic;
begin
	
--	f_sel: frequency_sel
--	port map (
--		clk => clk,
--		reset => reset,
--		note_data => sw(5 downto 0), 
--		note_counter => sig_note_counter
--	);

	--testing clock divider
	clk_div: clock_divider 
	port map (
		clk => clk,
		reset => reset,
		en => sig_clk_div_en,
		note_data => sw(5 downto 0),
		--max_counter => sig_note_counter,
		square_wave => sound
	);
	led(6 downto 0) <= sw(6 downto 0);
	
	--testing duration timer
	sig_note_dur <= "0100"; -- i.e. 1 beat duration
	--sig_tempo <= "01111000"; -- 120 bpm
	sig_tempo <= "01111001"; --triggers other condition
	note_dur: note_timer
	port map(
		clk => clk,
		reset => reset,
		en => sw(6),
		note_dur => sig_note_dur,
		tempo => sig_tempo,
		timeout => sig_timer_out
	);
	
	sig_clk_div_en <= not sig_timer_out;
	led(7) <= sig_timer_out;
	
end Behavioral;

