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
	signal sig_note_data: std_logic_vector(11 downto 0);
	signal sig_tempo_reg_en : std_logic; -- control signal
	signal sig_tempo_data: std_logic_vector(11 downto 0);
	signal sig_sound_done: std_logic;
	signal sig_sound_en: std_logic;
	
begin
	music_counter: register_16b 
	port map(
		clk => clk,
		reset => reset, --will need to alter later for restarts
		enable => sig_music_counter_en,
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
		data_in => sig_mem_out,
		data_out => sig_note_data
	);
	
	tempo_reg : register_12b
	port map (
		clk => clk,
		reset => reset,
		enable => sig_tempo_reg_en,
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
		sound	=> speaker,
		done => sig_sound_done
	);
	
	--control
	process(clk, reset)
	begin
		if reset = '1' then
			sig_buffer_reg_en <= '0';
			sig_tempo_reg_en <= '0';
			sig_add_en <= '0';
			sig_sound_en <= '0';
		elsif rising_edge(clk) then -- might be able to convert this to not need clock signals
			--handling the first mem address being tempo. Will need to change this logic when the tempo control unit is added
			if sig_curr_addr = sig_zero then 
				sig_buffer_reg_en <= '0';
				sig_tempo_reg_en <= '1';
			else
				sig_buffer_reg_en <= '1';
				sig_tempo_reg_en <= '0';
			end if;
		end if;
		
		sig_add_en <= sig_sound_done;
		sig_sound_en <= '1';
	end process;
	
	
	
end Behavioral;

