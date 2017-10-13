library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memory is
  port (       reset : in std_logic;
                 clk : in std_logic;
        write_enable : in std_logic;
          write_data : in std_logic_vector(11 downto 0);
             addr_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(11 downto 0) );
end memory;
architecture behavioral of memory is
--type mem_array is array(0 to 50) of std_logic_vector(11 downto 0); --give memory 50 slots for testing
type mem_array is array(0 to 256)  of std_logic_vector(11 downto 0); --change to this for the final product
signal sig_data_mem : mem_array;
begin
  mem_process: process ( clk, write_enable, write_data, addr_in ) is
  variable var_data_mem : mem_array;
  variable var_addr : integer;
  begin
    var_addr := conv_integer(addr_in);
    if (reset = '1') then
      -- instantiate all other values to zero
      var_data_mem := ((others=> (others=>'0')));
		-------------------------------------------	
		--FORMAT
		--first line(timing and bpm) = TTBBBBBBBB00
		--other LINES(note and dura) = NNNNNNDDDD00
		--------------------------------------------
	
		--var_data_mem(0)  := X"00000008";
		--might need to change this to have the first line be timing-tempo
		--var_data_mem(0)  := "010111100000";--timing = slurred, bpm = 120
		var_data_mem(0)  := "000011110000"; -- timing: normal, bpm = 60		
		--var_data_mem(0)  := "001011101100"; -- timing: normal, bpm = 187
		--var_data_mem(0)  := "001001001100"; -- timing: normal, bpm = 147	
	
	
	--tests to play every possible note
		var_data_mem(1)  := "000000010000";
		var_data_mem(2)  := "000001010000";
		var_data_mem(3)  := "000010010000";
		var_data_mem(4)  := "000011010000";
		var_data_mem(5)  := "000100010000";
		var_data_mem(6)  := "000101010000";
		var_data_mem(7)  := "000110010000";
		var_data_mem(8)  := "000111010000";
		var_data_mem(9)  := "001000010000";
		var_data_mem(10) := "001001010000";
		var_data_mem(11) := "001010010000";
		var_data_mem(12) := "001011010000";
		var_data_mem(13) := "001100010000";
		var_data_mem(14) := "001101010000";
		var_data_mem(15) := "001110010000";
		var_data_mem(16) := "001111010000";
		var_data_mem(17) := "010000010000";
		var_data_mem(18) := "010001010000";
		var_data_mem(19) := "010010010000";
		var_data_mem(20) := "010011010000";
		var_data_mem(21) := "010100010000";
		var_data_mem(22) := "010101010000";
		var_data_mem(23) := "010110010000";
		var_data_mem(24) := "010111010000";
		var_data_mem(25) := "011000010000";
		var_data_mem(26) := "011001010000";
		var_data_mem(27) := "011010010000";
		var_data_mem(28) := "011011010000";
		var_data_mem(29) := "011100010000";
		var_data_mem(30) := "011101010000";
		var_data_mem(31) := "011110010000";
		var_data_mem(32) := "011111010000";
		var_data_mem(33) := "100000010000";
		var_data_mem(34) := "100001010000";
		var_data_mem(35) := "100010010000";
		var_data_mem(36) := "100011010000";
		var_data_mem(37) := "100100010000";
		var_data_mem(38) := "100101010000";
		var_data_mem(39) := "100110010000";
		var_data_mem(40) := "100111010000";
		var_data_mem(41) := "101000010000";
		var_data_mem(42) := "101001010000";
		var_data_mem(43) := "101010010000";
		var_data_mem(44) := "101011010000";
		var_data_mem(45) := "101100010000";
		var_data_mem(46) := "101101010000";
		var_data_mem(47) := "101110010000";
		var_data_mem(48) := "101111010000";
		var_data_mem(49) := "110000010000";
		var_data_mem(50) := "110001010000";




	
	--notes for mary had a little lamb		
--		var_data_mem(1)  := "000111010000";
--		var_data_mem(2)  := "000100010000";
--		var_data_mem(3)  := "000010010000";
--		var_data_mem(4)  := "000100010000";
--		var_data_mem(5)  := "000111010000";
--		var_data_mem(6)  := "000111010000";
--		var_data_mem(7)  := "000111010000";
--		var_data_mem(8)  := "000100010000";
--		var_data_mem(9)  := "000100010000";
--		var_data_mem(10) := "000100010000";
--		var_data_mem(11) := "000111010000";
--		var_data_mem(12) := "001001010000";
--		var_data_mem(13) := "001001010000";
--		var_data_mem(14) := "000111010000";
--		var_data_mem(15) := "000100010000";
--		var_data_mem(16) := "000010010000";
--		var_data_mem(17) := "000100010000";
--		var_data_mem(18) := "000111010000";
--		var_data_mem(19) := "000111010000";
--		var_data_mem(20) := "000111010000";
--		var_data_mem(21) := "000111010000";
--		var_data_mem(22) := "000100010000";
--		var_data_mem(23) := "000100010000";
--		var_data_mem(24) := "000111010000";
--		var_data_mem(25) := "000100010000";
--		var_data_mem(26) := "000010010000";
		
    elsif (falling_edge(clk) and write_enable = '1') then
      -- memory writes on the falling clock edge
      var_data_mem(var_addr) := write_data;
    end if;
    
    -- continuous read of the memory location given by var_addr
    data_out <= var_data_mem(var_addr);
    
    -- the following are probe signals (for simulation purpose)
    sig_data_mem <= var_data_mem;
  end process;
end behavioral;