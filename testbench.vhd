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
  FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
  COMPONENT multiprocessor
    PORT (
          reset : In std_logic;
          clk : In std_logic;
          ascii1 : in std_logic_vector(6 downto 0);
          ascii2 : in std_logic_vector(6 downto 0);
          ready1 : out std_logic;
          ready2 : out std_logic;
          stall_p1 : out std_logic;
          stall_p2 : out std_logic
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
  file stimuli_file2 : text open read_mode is "stimuli2.txt";
  file stimuli_file3 : text open read_mode is "stimuli3.txt";
  file results_file : text open write_mode is "stimresults.txt";
  --signal x : std_logic_vector(7 downto 0);
  signal char : character;
  signal char2: character;
  signal char_vector : std_logic_vector(6 downto 0);
  signal char_vector2 : std_logic_vector(6 downto 0);
  signal ready_next_char : std_logic;
  signal ready_next_char2 : std_logic;
  signal sig_stall_p1 : std_logic;
  signal sig_stall_p2 : std_logic;
  
  BEGIN
    UUT : multiprocessor
        PORT MAP (
                  reset => reset,
                  clk => clk,
                  ascii1 => char_vector,
                  ascii2 => char_vector2,
                  ready1 => ready_next_char,
                  ready2 => ready_next_char2,
                  stall_p1 => sig_stall_p1,
                  stall_p2 => sig_stall_p2
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
  WAIT FOR 280000 ns;
  IF (TX_ERROR = 0) THEN
  STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
  STD.TEXTIO.writeline(RESULTS, TX_OUT);
  ASSERT (FALSE) REPORT
  "Simulation successful (not a failure). No problems detected."
  SEVERITY FAILURE;
  ELSE
  STD.TEXTIO.write(TX_OUT, TX_ERROR);
  STD.TEXTIO.write(TX_OUT,
  string'(" errors found in simulation"));
  STD.TEXTIO.writeline(RESULTS, TX_OUT);
  ASSERT (FALSE) REPORT "Errors found during simulation"
  SEVERITY FAILURE;
  END IF;
  END PROCESS;
  -- Handle reading data from the pattern file and the input "stream" file
  stimuli_gen_fileio: process (clk, reset, ready_next_char)
  variable data_buf : character;--std_logic_vector(7 downto 0);
  variable line_buf : line;
  variable num_cycles : integer := 3;
  variable pattern_length : integer := 64;
  variable buffer_length : integer := 64;
  begin
  -- wait for reset and clock signals
  if reset = '1' then
  char_vector <= (others => '0');
  elsif rising_edge(clk) then
  if (num_cycles = 3) then
  -- read pattern (aka stimuli.txt)
  if ((not endfile(stimuli_file)) and pattern_length > 0) then
  -- read from file
  readline(stimuli_file, line_buf);
  --writeline(results_file, line_buf);
  read(line_buf, data_buf);
  --x <= data_buf;
  char <= data_buf;
  char_vector <= CONV_STD_LOGIC_VECTOR(character'pos(data_buf), 7);
  --wait for 1 ns; -- wait awhile for signals of the DUT to update
  --hwrite(line_buf, x);
  --writeline(results_file, line_buf);
  pattern_length := pattern_length - 1;
  elsif (pattern_length >= 0) then
  char_vector <= (others => '0');
  pattern_length := pattern_length - 1;
  -- read stream aka stimuli2.txt
  elsif ((not endfile(stimuli_file2)) and (buffer_length > 0)) then
  -- read from file
  readline(stimuli_file2, line_buf);
  read(line_buf, data_buf);
  --x <= data_buf;
  char_vector <= CONV_STD_LOGIC_VECTOR(character'pos(data_buf), 7);
  --wait for 1 ns; -- wait awhile for signals of the DUT to update
  --hwrite(line_buf, x);
  --writeline(results_file, line_buf);
  buffer_length := buffer_length - 1;
  elsif (buffer_length > 0) then
  char_vector <= (others => '0');
  buffer_length := buffer_length - 1;
  end if;
  num_cycles := 0;
  elsif (sig_stall_p1 = '0') then
  num_cycles := num_cycles + 1;
  if (num_cycles > 3) then
  num_cycles := 3;
  end if;
  end if;
  if (ready_next_char = '1') then
  --std.textio.write(TX_OUT, string'("Push new char here?"));
  --STD.TEXTIO.writeline(RESULTS, TX_OUT);
  if (not endfile(stimuli_file2)) then
  readline(stimuli_file2, line_buf);
  read(line_buf, data_buf);
  char_vector <= CONV_STD_LOGIC_VECTOR(character'pos(data_buf), 7);
  else
  char_vector <= (others => '0');
  end if;
  end if;
  end if;
  end process;
  -- Handle reading data from the pattern file and the input "stream" file
END testbench_arch;
