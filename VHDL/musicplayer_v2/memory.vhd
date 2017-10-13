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
            data_out : out std_logic_vector(11 downto 0) );
end memory;

architecture behavioral of memory is
	type mem_array is array(0 to 255)  of std_logic_vector(11 downto 0); --change to this for the final product
	signal sig_data_mem : mem_array;
	signal sig_addr : std_logic_vector(7 downto 0); 
	
begin

	-- sig_1_16<= to_integer(unsigned(sig_max_vector(19 downto 4)));
	--sig_addr <= to_integer(unsigned(addr_in(7 downto 0)));
  mem_process: process ( clk, reset ) is
  begin
    if (reset = '1') then
      -- instantiate all other values to zero
      sig_data_mem <= ((others=> (others=>'0')));
		-------------------------------------------	
		--FORMAT
		--first line(timing and bpm) = TTBBBBBBBB00
		--other LINES(note and dura) = NNNNNNDDDD00
		--------------------------------------------
    elsif rising_edge(clk) then
		
      if write_enable = '1' then
			-- memory writes on the falling clock edge
			sig_data_mem(to_integer(unsigned(addr_in))) <= write_data;
		end if;
		data_out <= sig_data_mem(to_integer(unsigned(addr_in)));
    end if;
    
  end process;
end behavioral;
