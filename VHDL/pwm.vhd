library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity pwm is
  port (enable : in std_logic;
			clk	: in std_logic;
			reset	: in std_logic;
        data   : in std_logic_vector(11 downto 0); --0 and 1 are extra, 2 to 5 are duration, 6 to 11 are note
		  tempo	: in std_logic_vector (11 downto 0);
        done	: out std_logic;
		  output   : out std_logic
        );
end pwm;
architecture behavioural of pwm is

component clock_divider is
	port( clk : in std_logic;
			reset: in std_logic;
			max_counter: in std_logic_vector(19 downto 0);
			square_wave: out std_logic
	);
end component;


signal sig_note : std_logic_vector(5 downto 0);
signal sig_duration: std_logic_vector(3 downto 0);

signal sig_extra: std_logic_vector(1 downto 0);
signal sig_wave: std_logic;
signal sig_play_sound: std_logic;
signal sig_freq_max: std_logic_vector(19 downto 0); 
signal sig_dur_int: integer ;
signal global_counter: integer:=0;
--signal x: integer :=0;
--signal sine_counter: integer :=0;
--signal amp :std_logic_vector(3 downto 0); -- not sure how big this will be


begin
	sig_note <= data(11 downto 6);
	sig_duration <= data(5 downto 2);
	sig_extra <= data(1 downto 0);
	
	
	
	main: process(clk, reset)
	begin
		if reset = '1' then
			done <='0';
			--x <="0000";
			output<= '0';
			
		elsif rising_edge(clk) then
			if global_counter < sig_duration then
				--play sound
				output <= sig_wave;
				
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
			elsif global_counter < tempo then
				output <= '0';
				done <= '0';
				--x <="0000";
			else 
				output <= '0';
				done <='0';
			end if;
		end if;
	end process;
	
	sig_dur_int <= sig_dur_int(to_unsigned(sig_duration));
	g_counter: process(clk, reset)
	begin
		if reset = '1' then
			global_counter <= 0;
		elsif rising_edge(clk) then
			global_counter <= global_counter +1;
		end if;
	end process;
		
	
	
	process(clk, enable, reset) --this process just sets each counter value needed to be reached for each frequency
	begin
		if reset = '1' then
			sig_freq_max <= "00000000000000000000";
		elsif (rising_edge(clk)) then --using 50Mhz clock
		  if (enable = '1') then
				case sig_note is
					when "000000" => --rest 
						sig_freq_max <= "00000000000000000000"; --might need to change this line
					when "000010" => --c3
						sig_freq_max <= conv_std_logic_vector(384615, 20);
					when "000011" => --c3# d3b
						sig_freq_max <= conv_std_logic_vector(360776, 20);
					when "000100" => --d3
						sig_freq_max <= conv_std_logic_vector(340529, 20);
					when "000101" => --d3# e3b
						sig_freq_max <= conv_std_logic_vector(321419, 20);
					when "000110" => --e3 f3b
						sig_freq_max <= conv_std_logic_vector(303379, 20);
					when "000111" => --e3# f3
						sig_freq_max <= conv_std_logic_vector(286352, 20);
					when "001000" => --f3# g3b
						sig_freq_max <= conv_std_logic_vector(270270, 20);
					when "001001" => --g3
						sig_freq_max <= conv_std_logic_vector(255102, 20);
					when "001010" => --g3# a4b
						sig_freq_max <= conv_std_logic_vector(240789, 20);
					when others => 
						sig_freq_max <= "00000000000000000000"; --might need to change this line
				end case;
			end if;
		end if;
	end process;
	 
	square_wave: clock_divider 
	port map (clk => clk,
				reset => reset,
			--	en		=> sig_play_sound,
				max_counter => sig_freq_max,
				square_wave => sig_wave
	);
	
	
	--crotchet = tempo/60  --number of beats per second
	--quaver = crotechet/2
	--semiquaver = quaver/2
	--tupet = crotchet/3
	--dotted quaver = quaver + semi quaver
	--dotted crotchet = crotchet + quaver
	--minim = crotech *2
	--dotted minim = crotechet + minim
	--semibreve = minim *2
	--breve = semibreve*2
	

end behavioural;

