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
-- modified to test changing tempos. 8 switches are used. s(0) = play, s(1) = is to enable the dynamic tmepo control
-- sw(7 downto 2) will enter the tempo value. In this case, "00" will need to be concatentated at the end of the tempo
-- because there are not enought switches on the board to control all this
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
entity musicplayer_top is
	port (clk 	  : in std_logic;
			reset	  : in std_logic;
			play		  : in std_logic; --sw0
			tempo_mode:	in std_logic; -- sw1, switches between tempo in file to dynaimic tempo
			--tempo_val	: in std_logic_vector (5 downto 0); --sw2 to 8 used for testing
			pulse : in  STD_LOGIC;
			trig : out  STD_LOGIC;
         --epp ports
			pdb		: inout std_logic_vector(7 downto 0);
         astb 	: in std_logic;
			dstb 	: in std_logic;
			pwr 	: in std_logic;
			pwait 	: out std_logic;
			loaddone: out std_logic;
			memoryWrite: out std_logic;
			--led: out std_logic_vector(7 downto 0);
			
			--7seg ports
			segments : out std_logic_vector(7 downto 0);
			displayOut : out std_logic_vector(3 downto 0);
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
               addr_in : in std_logic_vector(7 downto 0);
              data_out : out std_logic_vector(11 downto 0));
  end component;
  
	component register_8b is	
		port(
			clk :in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			data_in: in std_logic_vector(7 downto 0);
			data_out:	 out std_logic_vector(7 downto 0)
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
	
  component adder_8b is
    port ( src_a : in std_logic_vector(7 downto 0);
        src_b : in std_logic_vector(7 downto 0);
        sum : out std_logic_vector(7 downto 0);
        carry_out : out std_logic );
  end component;
  
  component mux2to1_8b is
		port (data_a : in std_logic_vector(7 downto 0);
			data_b : in std_logic_vector(7 downto 0);
			sel	 : in std_logic;
			data	 : out std_logic_vector(7 downto 0)
	);
	end component;

	component mux2to1_12b is
		port (data_a : in std_logic_vector(11 downto 0);
			data_b : in std_logic_vector(11 downto 0);
			sel	 : in std_logic;
			data	 : out std_logic_vector(11 downto 0)
	);
	end component;

	component sound_generator is 
	port (clk	: in std_logic;
			reset	: in std_logic;
			note_data: in std_logic_vector(11 downto 0);
			tempo_data: in std_logic_vector(11 downto 0);
			enable:	in std_logic;
			sound	: out std_logic;
			base_vector : out std_logic_vector(25 downto 0);
			done	: out std_logic
	);
	end component;

	component sevenSeg2 is
	port (
		CLKK : in std_logic;
		number : in std_logic_vector(7 downto 0);
		segments : out std_logic_vector(7 downto 0);
		displayOut : out std_logic_vector(3 downto 0)	
	);

  end component;
	
	component sensorComponent is
    Port ( clk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           timerSwitch : in  STD_LOGIC;
           trig : out  STD_LOGIC;
			  rst: in std_logic;
           swingValue : out  STD_LOGIC_VECTOR (7 downto 0));
  end component;


	component eppctrl is
    Port (
			mclk 	: in std_logic;
         pdb		: inout std_logic_vector(7 downto 0);
         astb 	: in std_logic;
         dstb 	: in std_logic;
         pwr 	: in std_logic;
         pwait 	: out std_logic;
		--rgLed	: out std_logic_vector(7 downto 0); 
		--rgSwt	: in std_logic_vector(7 downto 0);
		--rgBtn	: in std_logic_vector(4 downto 0);
			enable : out std_logic;
			done : out std_logic;
			dataToBram: out std_logic_vector(11 downto 0);
			addressToBram: out std_logic_vector(7 downto 0)
		);
	end component;	
--signals
	signal sig_music_counter_en: std_logic;
	signal sig_next_addr	: std_logic_vector(7 downto 0);
	signal sig_curr_addr	: std_logic_vector(7 downto 0);
	signal sig_one		: std_logic_vector(7 downto 0); --three?
	signal sig_zero	: std_logic_vector(7 downto 0);
	signal sig_add_en	: std_logic; -- control signal, enables music counter incrementer when = '1'
	signal sig_add_in	: std_logic_vector(7 downto 0);
	signal sig_add_carry: std_logic;
	
	signal tempo_val : std_logic_vector(7 downto 0);
	--memory signals
	signal sig_write_en	: std_logic; --need filereader
	signal sig_write_data : std_logic_vector(11 downto 0); -- need filereader
	signal sig_mem_out: std_logic_vector(11 downto 0);
	signal sig_mem_addr : std_logic_vector(7 downto 0);

	signal sig_epp_done: std_logic;
	signal sig_epp_addr: std_logic_vector(7 downto 0);
	signal sig_epp_data: std_logic_vector(12 downto 0);
	signal sig_epp_write_en : std_logic;
	
	signal sig_buffer_reg_in : std_logic_vector(11 downto 0);
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
	signal rest_max: integer range 0 to 100000000;
	signal sig_sound_gen_out: std_logic; 
	signal sig_base : std_logic_vector(25 downto 0);
	signal sig_play : std_logic;
	signal sig_tempo_mux_out : std_logic_vector (11 downto 0);
	signal sig_tempo_mux_b : std_logic_vector (11 downto 0);
	--fsm
	TYPE State_Type IS (load, idle, read_note, play_note); ---added handshake state
	SIGNAL y : State_Type;
	signal sig_load_done: std_logic;
	
begin
	music_counter: register_8b 
	port map(
		clk => clk,
		reset => reset, --will need to alter later for restarts
		--enable => sig_music_counter_en,
		enable => sig_add_en,
		data_in => sig_next_addr,
		data_out => sig_curr_addr
	); 
	
	sig_one <= "00000001"; --? might need to change this value to make mem work properly
	sig_zero <= "00000000";
	
	add_en: mux2to1_8b
	port map(
		data_a => sig_zero,
		data_b => sig_one,
		sel => sig_add_en,
		data => sig_add_in
	);
	
	increment_music_counter: adder_8b
	port map(
		src_a => sig_curr_addr,
		src_b => sig_add_in,
		sum => sig_next_addr,
		carry_out => sig_add_carry
	);
	
	epp: eppctrl 
   port map(
		mclk 	=> clk,
      pdb	=> pdb,
      astb =>astb,
      dstb => dstb,
      pwr =>	pwr,
      pwait => pwait,
		enable => sig_epp_write_en,
		done => sig_epp_done,
		dataToBram => sig_write_data,
		addressToBram => sig_epp_addr
	);
	
	memoryWrite <= sig_epp_write_en;
	loaddone <= sig_epp_done;
	
	--sig_epp_done <= '1'; --testing signal
	--led <= sig_mem_out(9 downto 2);
	
	load_or_play_addr: mux2to1_8b
	port map (
		data_a => sig_epp_addr,
		data_b => sig_curr_addr, 
		sel => sig_epp_done,
		data => sig_mem_addr
	);
	
	mem: memory
	port map (
		reset => reset,
		clk => clk,
		write_enable => sig_write_en,
		write_data => sig_write_data,
		addr_in => sig_mem_addr,
		data_out => sig_mem_out
	);
	
	
	process(sig_mem_addr, sig_mem_out)
	begin
		if sig_mem_addr = X"00" then
			sig_buffer_reg_in <= X"000";
		else 
			sig_buffer_reg_in <= sig_mem_out;
		end if;
	end process;
	
	buffer_reg: register_12b
	port map (
		clk => clk,
		reset => reset,
		enable => sig_buffer_reg_en,
		done => sig_buffer_reg_done,
		data_in => sig_buffer_reg_in, --sig_mem_out,
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
	
	--added in sensor
	sense: sensorComponent
   port map ( 
		clk => clk,
      pulse => pulse,
      timerSwitch => tempo_mode,
      trig => trig,
		rst => reset,
      swingValue => tempo_val  
	);
	
	
	--sig_tempo_mux_b <= "00" & tempo_val & "00";
	tempo_mux :	mux2to1_8b 
	port map (
		data_a => sig_tempo_data(9 downto 2),
		data_b => tempo_val, --sig_tempo_mux_b,
		sel => tempo_mode,
		data => sig_tempo_mux_out(9 downto 2)
	);
	
	
	---added in display
	
	dsplay: sevenSeg2 
	port map (
		CLKK => clk,
		--number => sig_write_data(9 downto 2), --this here for testing, use line below for actual
		--number => sig_tempo_data(9 downto 2), --this here for testing, use line below for actual
		number => sig_tempo_mux_out(9 downto 2),
		segments => segments,
		displayOut => displayOut	
	);
	
	
	sound_gen: sound_generator
	port map (
		clk => clk,
		reset => reset,
		note_data => sig_note_data,
		tempo_data => sig_tempo_mux_out,--sig_tempo_data,--
		enable => sig_sound_en,
		sound	=> sig_sound_gen_out,--speaker,
		base_vector => sig_base,
		done => sig_sound_done
	);
	
	sig_play <= play;
	sig_add_en <= sig_sound_done;
	
	--control
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
	
	rest_time: process(clk, sig_play, sig_load_timer)
	--signal rest_counter: integer
	begin
		if sig_play = '0' then
			rest_counter <= 0;
			sig_sound_en <= '0';
			--speaker <= '0';
			sig_load_done <= '0';
		elsif rising_edge(clk) and sig_load_timer = '1' then
			--if rest_counter < 1000000 then --slurred?
			--if rest_counter < 500000 then
			--if rest_counter < 30000000 then --normal?
			--if sig_tempo_data(11 downto 10) = "00" then

			
			if rest_counter < rest_max then 
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
	
	rest_max_counter: process (sig_tempo_data(11 downto 10), sig_base)
	begin
		case sig_tempo_data(11 downto 10) is
			when "01" => rest_max <= 700000; --slurred
			when "10" => rest_max <= to_integer(unsigned(sig_base)); --staccato
			when others => rest_max <= to_integer(unsigned('0' & sig_base(25 downto 1))); --normal
		end case;
	end process;
	
	
	fsm_transitions: process (clk, sig_play, sig_load_done, sig_sound_done, reset, sig_epp_done)
	begin
		if reset = '1' then
			y <= load;
		elsif rising_edge(clk) then
			case y is
				when load =>
					if sig_epp_done = '1' then 
						y <= idle;
					else 
						y <= load;
					end if;
				when idle =>
					if sig_play = '1' then 
						--if sig_epp_done = '1' then
							y <= read_note;
						--end if;
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
	
	fsm_outputs: process(y, sig_curr_addr)
	begin
	--initalise the control signals 
	sig_write_en <= '0'; sig_buffer_reg_en <= '0'; sig_tempo_reg_en <= '0';-- sig_sound_en <= '0';
		case y is
			when load => 
				sig_write_en <= sig_epp_write_en; 
				sig_buffer_reg_en <= '0'; 
				sig_tempo_reg_en <= '0';
--				if sig_curr_addr = sig_zero then 
--					sig_buffer_reg_en <= '0';
--					sig_tempo_reg_en <= '0';
--				else
--					sig_buffer_reg_en <= '0';
--					sig_tempo_reg_en <= '0';
--				end if;
				speaker <= '0';
			when idle =>
				--	
				sig_buffer_reg_en <= '0'; 
				sig_tempo_reg_en <= '0'; 
				--sig_sound_en <= '0';
				
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

