----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:18:05 09/01/2017 
-- Design Name: 
-- Module Name:    sound_generator - Behavioral 
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

entity sound_generator is
	port (
		clk	: in std_logic;
		reset	: in std_logic;
		note_data: in std_logic_vector(11 downto 0);
		tempo_data: in std_logic_vector(11 downto 0);
		enable:	in std_logic;
		sound	: out std_logic;
		done	: out std_logic
			);
end sound_generator;

architecture Behavioral of sound_generator is
	--components
	component clock_divider is
		port( 
			clk : in std_logic;
			reset: in std_logic;
			en:	in std_logic;
			max_counter: in std_logic_vector(19 downto 0);
			square_wave: out std_logic
		);
	end component;

	component counter is
		port (
			clk : in std_logic;
			reset : in std_logic;
			max	: in std_logic_Vector(28 downto 0);
			output: out std_logic
		);
	end component;
	
	component frequency_sel is
		port(
			clk : in std_logic;
			reset: in std_logic;
			note_data: in std_logic_vector(5 downto 0);
			note_counter: out std_logic_vector(19 downto 0)
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
	
	--signals
	--note data
	signal sig_note : std_logic_vector(5 downto 0);
	signal sig_duration: std_logic_vector(3 downto 0);
	signal sig_note_extra: std_logic_vector(1 downto 0);
	--tempo data
	signal sig_timing: std_logic_vector(1 downto 0);
	signal sig_tempo: std_logic_vector(7 downto 0);
	signal sig_temp_extra: std_logic_vector(1 downto 0);
	
	signal sig_wave: std_logic;
	signal sig_sound_en: std_logic;
	signal sig_freq_max: std_logic_vector(19 downto 0); --frequency sel
	signal sig_note_timeout: std_logic;

	
begin
 	--note data
	sig_note <= note_data(11 downto 6);
	sig_duration <= note_data(5 downto 2);
	sig_note_extra <= note_data(1 downto 0);
	--tempo data
	sig_timing <= tempo_data(11 downto 10);
	sig_tempo <= tempo_data(9 downto 2);
	sig_temp_extra <= tempo_data(1 downto 0);

	--sets each counter value needed to be reached for each frequency
	sel_music_note: frequency_sel
	port map (
		clk => clk,
		reset => reset,
		note_data => sig_note,
		note_counter => sig_freq_max
	);
   --generate sound for frequency	
	sq_wave: clock_divider 
	port map (
				clk => clk,
				reset => reset,
				en => sig_sound_en,
				max_counter => sig_freq_max,
				square_wave => sig_wave
	);
	
	n_timer: note_timer 
	port map (
		clk => clk,
		reset => reset,
		en => enable,
		note_dur => sig_duration,
		tempo => sig_tempo,
		timeout => sig_note_timeout
	);
	
	sig_sound_en <= not sig_note_timeout;
	sound <= sig_wave;
	done <= sig_note_timeout; -- will need to modify to account for timing
	
	
	---still need to implement timing stuff
	
	--sel_duration: process(clk, reset)
	--	if reset = '1' then
			--sig_dur_max <= "00000000000000000000000000000";
		---elsif (rising_edge(clk)) then 
			--case sig_duration is 
				--when "0100" =>
				--	sig_dur_max <= conv_std_logic_vector(25000000, 29);
		--		when others =>
			--		sig_dur_max <= conv_std_logic_vector(25000000, 29);
	--end process;


	--main: process(clk, reset)
	--begin
		--if reset = '1' then
			--done <='0';
			--sound<= '0';
			
	--	elsif rising_edge(clk) then
		--	if global_counter < 25000000 then
				--play sound
			--	output <= sig_wave;
				
			--	amp <= sineLUT(x); --assuming x initalised at 0
			--	if sine_counter < amp then
			--		sine_counter <= sine_counter +1;
			--		output <= '1';
			--		elsif rising_edge(sig_wave) then
			--		sine_counter <= 0;
			--		x <= x +1;
			--	else
			--		output <= '0';
			--	end if;
			--elsif global_counter < 35000000 then
				--output <= '0';
				--done <= '0';
				--x <="0000";
			--else 
				--output <= '0';
				--done <='0';
			--end if;
		--end if;
	--end process;
	--g_counter: process(clk, reset)
--	begin
		--if reset = '1' then
		--	global_counter <= 0;
	--	elsif rising_edge(clk) then
			--global_counter <= global_counter +1;
		--end if;
	--end process;
end Behavioral;

