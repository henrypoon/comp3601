--Note: old code. needs to be adapted to the music player project
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;
ARCHITECTURE testbench_arch OF testbench IS
 -- FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
  COMPONENT musicplayer
    PORT (
        reset     : in std_logic;
        clk       : in std_logic;
       music_data : in std_logic_vector(11 downto 0); --??? Depends on the format of the text file input
        sensor    : in std_logic;
        ready     :out std_logic; --??? might not need
        sound     :out std_logic --pwm output 
          );
    END COMPONENT;
    
    

  SIGNAL reset : std_logic := '1';
  SIGNAL clk : std_logic := '0';
  SHARED VARIABLE TX_ERROR : INTEGER := 0;
  SHARED VARIABLE TX_OUT : LINE;
  constant PERIOD : time := 100 ns;
  constant DUTY_CYCLE : real := 0.5;
  constant OFFSET : time := 0 ns;
  --------------------------------------------
  -- file IO relevant declarations
  --------------------------------------------
  file stimuli_file : text open read_mode is "stimuli.txt";
  --signal char : character;
  signal char : std_logic_vector(11 downto 0);
  --signal char_vector : std_logic_vector(6 downto 0);
  signal char_vector : std_logic_vector(11 downto 0);
  signal ready_next_char : std_logic;
  signal sig_sound :std_logic;
  signal sig_sensor:std_logic;
  BEGIN
    UUT : musicplayer
        PORT MAP (
                  reset => reset,
                  clk => clk,
                  music_data => char_vector,
                  sensor => sig_sensor,
                  ready => ready_next_char,
                  sound => sig_sound
                  );
                  
  PROCESS -- clock process for clk
  BEGIN
    WAIT for OFFSET;
      CLOCK_LOOP : LOOP
      clk <= '0';
        WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
          clk <= '1';
        WAIT FOR (PERIOD * DUTY_CYCLE);
      END LOOP CLOCK_LOOP;
  END PROCESS;

  PROCESS
  BEGIN
  -- ------------- Current Time: 285ns
    WAIT FOR 285 ns;
    reset <= '0';
  -- -------------------------------------
  END PROCESS;
  
  -- Handle reading data from the pattern file and the input "stream" file
  stimuli_gen_fileio: process (clk, reset, ready_next_char)
  --variable data_buf : character;--std_logic_vector(7 downto 0); --old code
  variable data_buf : std_logic_vector(11 downto 0); --new code
  variable line_buf : line;
  
  variable num_cycles : integer := 3;
  --variable pattern_length : integer := 64;
  variable buffer_length : integer := 64;
  
  begin
    -- wait for reset and clock signals
    if reset = '1' then
      char_vector <= (others => '0');
    elsif rising_edge(clk) then
      if (num_cycles = 3) then
        -- read pattern (aka stimuli.txt)
          --if ((not endfile(stimuli_file)) and pattern_length > 0) then
          if (not endfile(stimuli_file)) then
            -- read from file
            readline(stimuli_file, line_buf);
            --writeline(results_file, line_buf);
            read(line_buf, data_buf);
            char <= data_buf;
            --char_vector <= CONV_STD_LOGIC_VECTOR(character'pos(data_buf), 7);
            char_vector <= data_buf;
            
            --wait for 1 ns; -- wait awhile for signals of the DUT to update
            --hwrite(line_buf, x);
            --writeline(results_file, line_buf);
          else
            char_vector <= (others => '0');                
         end if; 
      end if;
    end if;
  end process;

END testbench_arch;
