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
        wave   : out std_logic
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
signal sig_freq_max:	integer;---?? 

begin
	sig_note <= data(11 downto 6);
	sig_duration <= data(5 downto 2);
	sig_extra <= data(1 downto 0);
	
    process(clk, enable, reset) --this process just sets each counter value needed to be reached for each frequency
	 begin
		if reset = '1' then
			wave <= '0';
		elsif (rising_edge(clk)) then --using 50Mhz clock
		  if (enable = '1') then
				case sig_note is
					when "000000" => --rest 
						sig_freq_max <= others => '0'; --might need to change this line
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
						sig_freq_max <= others => '0'; --might need to change this line
				end case;
			end if;
		end if;
	end process;
	 
	square_wave: clock_divider 
	port map (clk => clk,
				reset => reset,
				max_counter => sif_freq_max,
				square_wave => wave
	);
	
end behavioural;

