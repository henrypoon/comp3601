library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memory is
  port (       reset : in std_logic;
                 clk : in std_logic;
        write_enable : in std_logic;
          write_data : in std_logic_vector(11 downto 0);
             addr_in : in std_logic_vector(15 downto 0);
            data_out : out std_logic_vector(11 downto 0) );
end memory;
architecture behavioral of memory is
type mem_array is array(0 to 31) of std_logic_vector(11 downto 0); 
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
		--var_data_mem(0)  := X"00000008";
		var_data_mem(0)  := "000111010000";
		var_data_mem(1)  := "000100010000";
		var_data_mem(2)  := "000010010000";
		var_data_mem(3)  := "000100010000";
		var_data_mem(4)  := "000111010000";
		var_data_mem(5)  := "000111010000";
		var_data_mem(6)  := "000111010000";
		var_data_mem(7)  := "000100010000";
		var_data_mem(8)  := "000100010000";
		var_data_mem(9)  := "000100010000";
		var_data_mem(10) := "000111010000";
		var_data_mem(11) := "001001010000";
		var_data_mem(12) := "001001010000";
		var_data_mem(13) := "000111010000";
		var_data_mem(14) := "000100010000";
		var_data_mem(15) := "000010010000";
		var_data_mem(16) := "000100010000";
		var_data_mem(17) := "000111010000";
		var_data_mem(18) := "000111010000";
		var_data_mem(19) := "000111010000";
		var_data_mem(20) := "000111010000";
		var_data_mem(21) := "000100010000";
		var_data_mem(22) := "000100010000";
		var_data_mem(23) := "000111010000";
		var_data_mem(24) := "000100010000";
		var_data_mem(25) := "000010010000";
		
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
