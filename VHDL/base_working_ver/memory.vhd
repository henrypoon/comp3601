library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.numeric_std.ALL;
entity memory is
  port (       reset : in std_logic;
                 clk : in std_logic;
        write_enable : in std_logic;
          write_data : in std_logic_vector(11 downto 0);
             addr_in : in std_logic_vector(7 downto 0);
				 mem_zero : out std_logic_vector(11 downto 0);
            data_out : out std_logic_vector(11 downto 0)
				);
end memory;

architecture behavioral of memory is
	type mem_array is array(0 to 255)  of std_logic_vector(15 downto 0); --change to this for the final product
	signal sig_data_mem : mem_array;
	signal sig_addr : std_logic_vector(7 downto 0); 
	
begin
  mem_process: process ( clk, reset, write_enable ) is
  begin
   -- if (reset = '1') then
      -- instantiate all other values to zero
   --   sig_data_mem <= ((others=> (others=>'0')));
		-------------------------------------------	
		--FORMAT
		--first line(timing and bpm) = TTBBBBBBBB00
		--other LINES(note and dura) = NNNNNNDDDD00
		--------------------------------------------
--		sig_data_mem(0)  <= "010111100000";--timing = slurred, bpm = 120		
----		--mary had a little lamb
--		sig_data_mem(1)  <= "000111010000";
--		sig_data_mem(2)  <= "000100010000";
--		sig_data_mem(3)  <= "000010010000";
--		sig_data_mem(4)  <= "000100010000";
--		sig_data_mem(5)  <= "000111010000";
--		sig_data_mem(6)  <= "000111010000";
--		sig_data_mem(7)  <= "000111010000";
--		sig_data_mem(8)  <= "000100010000";
--		sig_data_mem(9)  <= "000100010000";
--		sig_data_mem(10) <= "000100010000";
--		sig_data_mem(11) <= "000111010000";
--		sig_data_mem(12) <= "001001010000";
--		sig_data_mem(13) <= "001001010000";
--		sig_data_mem(14) <= "000111010000";
--		sig_data_mem(15) <= "000100010000";
--		sig_data_mem(16) <= "000010010000";
--		sig_data_mem(17) <= "000100010000";
--		sig_data_mem(18) <= "000111010000";
--		sig_data_mem(19) <= "000111010000";
--		sig_data_mem(20) <= "000111010000";
--		sig_data_mem(21) <= "000111010000";
--		sig_data_mem(22) <= "000100010000";
--		sig_data_mem(23) <= "000100010000";
--		sig_data_mem(24) <= "000111010000";
--		sig_data_mem(25) <= "000100010000";
--		sig_data_mem(26) <= "000010010000";
    if falling_edge(clk) then
		
      if write_enable = '1' then
			-- memory writes on the falling clock edge
			sig_data_mem(to_integer(unsigned(addr_in))) <= X"0" & write_data;
		end if;
		data_out <= sig_data_mem(to_integer(unsigned(addr_in)))(11 downto 0);
		mem_zero <= sig_data_mem(0)(11 downto 0);
    end if;
    
  end process;
end behavioral;
