----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:03:10 09/01/2017 
-- Design Name: 
-- Module Name:    musicplayer_top - Behavioral 
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

entity musicplayer_top is
	port (clk 	  : in std_logic;
			reset	  : in std_logic;
			sw		  : in std_logic;
			speaker : out std_logic
			);

end musicplayer_top;

architecture Behavioral of musicplayer_top is
--components
  component memory is 
    port (       reset : in std_logic;
                   clk : in std_logic;
          write_enable : in std_logic;
            write_data : in std_logic_vector(11 downto 0);
               addr_in : in std_logic_vector(15 downto 0);
              data_out : out std_logic_vector(11 downto 0));
  end component;
  
	component register_16b is	
		port(clk :in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			data_in: in std_logic_vector(15 downto 0);
			data_out:	 out std_logic_vector(15 downto 0)
			);
	end component;
	
	component register_12b is	
		port(clk :in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			data_in: in std_logic_vector(11 downto 0);
			done	: out std_logic;
			data_out:	 out std_logic_vector(11 downto 0)
		);
	end component;
	
  component adder_16b is
    port ( src_a : in std_logic_vector(15 downto 0);
        src_b : in std_logic_vector(15 downto 0);
        sum : out std_logic_vector(15 downto 0);
        carry_out : out std_logic );
  end component;
  
  component mux2to1_16b is
  	port (data_a : in std_logic_vector(15 downto 0);
			data_b : in std_logic_vector(15 downto 0);
			sel	 : in std_logic;
			data	 : out std_logic_vector(15 downto 0)
	);
	end component;
	
	component sound_generator is 
	port (clk	: in std_logic;
			reset	: in std_logic;
			note_data: in std_logic_vector(11 downto 0);
			tempo_data: in std_logic_vector(11 downto 0);
			enable:	in std_logic;
			sound	: out std_logic;
			done	: out std_logic
	);
	end component;

--signals
	signal sig_music_counter_en: std_logic;
	signal sig_next_addr	: std_logic_vector(15 downto 0);
	signal sig_curr_addr	: std_logic_vector(15 downto 0);
	signal sig_one		: std_logic_vector(15 downto 0); --three?
	signal sig_zero	: std_logic_vector(15 downto 0);
	signal sig_add_en	: std_logic; -- control signal, enables music counter incrementer when = '1'
	signal sig_add_in	: std_logic_vector(15 downto 0);
	signal sig_add_carry: std_logic;
	--memory signals
	signal sig_write_en	: std_logic; --need filereader
	signal sig_write_data : std_logic_vector(11 downto 0); -- need filereader
	signal sig_mem_out: std_logic_vector(11 downto 0);

	signal sig_buffer_reg_en: std_logic; -- control signal
	signal sig_buffer_reg_done: std_logic;
	signal sig_note_data: std_logic_vector(11 downto 0);
	signal sig_tempo_reg_en : std_logic; -- control signal
	signal sig_tempo_reg_done: std_logic;
	signal sig_tempo_data: std_logic_vector(11 downto 0);
	signal sig_sound_done: std_logic;
	signal sig_sound_en: std_logic;
	
	signal sig_load_timer : std_logic;
	signal rest_counter: integer range 0 to 100000000;
	signal sig_sound_gen_out: std_logic; 
	--fsm
	TYPE State_Type IS (idle, read_note, play_note); ---added handshake state
	SIGNAL y : State_Type;
	signal sig_load_done: std_logic;
	
begin
	music_counter: register_16b 
	port map(
		clk => clk,
		reset => reset, --will need to alter later for restarts
		--enable => sig_music_counter_en,
		enable => sig_add_en,
		data_in => sig_next_addr,
		data_out => sig_curr_addr
	); 
	
	sig_one <= "0000000000000001"; --? might need to change this value to make mem work properly
	sig_zero <= "0000000000000000";
	
	add_en: mux2to1_16b
	port map(
		data_a => sig_zero,
		data_b => sig_one,
		sel => sig_add_en,
		data => sig_add_in
	);
	
	increment_music_counter: adder_16b
	port map(
		src_a => sig_curr_addr,
		src_b => sig_add_in,
		sum => sig_next_addr,
		carry_out => sig_add_carry
	);
	
	mem: memory
	port map (
		reset => reset,
		clk => clk,
		write_enable => sig_write_en,
		write_data => sig_write_data,
		addr_in => sig_curr_addr,
		data_out => sig_mem_out
	);
	
	buffer_reg: register_12b
	port map (
		clk => clk,
		reset => reset,
		enable => sig_buffer_reg_en,
		done => sig_buffer_reg_done,
		data_in => sig_mem_out,
		data_out => sig_note_data
	);
	
	tempo_reg : register_12b
	port map (
		clk => clk,
		reset => reset,
		enable => sig_tempo_reg_en,
		done => sig_tempo_reg_done,
		data_in => sig_mem_out,
		data_out => sig_tempo_data
	);
	
	sound_gen: sound_generator
	port map (
		clk => clk,
		reset => reset,
		note_data => sig_note_data,
		tempo_data => sig_tempo_data,
		enable => sig_sound_en,
		sound	=> sig_sound_gen_out,--speaker,
		done => sig_sound_done
	);
	
	
	
	--sig_sound_en <= sw;
	sig_add_en <= sig_sound_done;
	
	--control
	--sig_load_done <= sig_buffer_reg_en; 
	
	--takes in the done signal from the sound generator and counts to 2500000(? aka 1/20 of a second) 
	--before outputing the sig_load_done output as high
	save_done_sig:process(sig_sound_done, sig_sound_en)
	--signal sig_load_timer : std_logic;
	begin
		if sig_sound_done = '1' then
			sig_load_timer <= '1';
		elsif sig_sound_en = '1' then
			sig_load_timer <= '0';
		end if;
	end process;
	
	rest_time: process(clk, sw, sig_load_timer)
	--signal rest_counter: integer
	begin
		if sw = '0' then
			rest_counter <= 0;
			sig_sound_en <= '0';
			--speaker <= '0';
			sig_load_done <= '0';
		elsif rising_edge(clk) and sig_load_timer = '1' then
			--if rest_counter < 1000000 then --slurred?
			--if rest_counter < 500000 then
			if rest_counter < 30000000 then --normal?
				rest_counter <= rest_counter +1;
				sig_sound_en <= '0';
				sig_load_done <= '0';
				--speaker <= '0';
			else
				sig_sound_en <= '1';
				rest_counter <= 0;
				sig_load_done <= '1';
				--speaker <= sig_sound_gen_out;
			end if;
		end if;
	end process;
	
	
	
	fsm_transitions: process (clk, sw, sig_load_done, sig_sound_done)
	begin
		if sw = '0' then
			y <= idle;
		elsif rising_edge(clk) then
			case y is 
				when idle =>
					if sw = '1' then 
						y <= read_note;
					else 
						y <= idle;
					end if;
				when read_note =>
					if sig_load_done = '1' then
						y <= play_note;
					else
						y <= read_note;
					end if;
				when play_note => 
					if sig_sound_done = '1' then
						y <= read_note;
					else
						y <= play_note;
					end if;
			end case;
		end if;
	end process;
	
	fsm_outputs: process(y)
	begin
	--initalise the control signals 
	sig_write_en <= '0'; sig_buffer_reg_en <= '0'; sig_tempo_reg_en <= '0';-- sig_sound_en <= '0';
		case y is
			when idle =>
				sig_write_en <= '0'; 	
				sig_buffer_reg_en <= '0'; 
				sig_tempo_reg_en <= '0'; 
				--sig_sound_en <= '0';
				speaker <= '0';
			when read_note =>
				speaker <= '0';
				
				if sig_curr_addr = sig_zero then 
					sig_buffer_reg_en <= '0';
					sig_tempo_reg_en <= '1';
				else
					sig_buffer_reg_en <= '1';
					sig_tempo_reg_en <= '0';
				end if;
			when play_note =>
			--	sig_sound_en <= '1';
				sig_buffer_reg_en <= '0';
				sig_tempo_reg_en <= '0';
				speaker <= sig_sound_gen_out; 
		end case;
	end process;
		
	--process(clk, reset)
	--begin
	--	if reset = '1' then
		--	sig_buffer_reg_en <= '0';
		--	sig_tempo_reg_en <= '0';
		--	sig_add_en <= '0';
		--	sig_sound_en <= '0';
	--	elsif rising_edge(clk) then -- might be able to convert this to not need clock signals
			--handling the first mem address being tempo. Will need to change this logic when the tempo control unit is added
	--		
	--	end if;
		
		
		--sig_sound_en <= '1';
	--end process;
	
	
	
end Behavioral;

