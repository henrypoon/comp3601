library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity music_counter is
  port ( reset : in std_logic;
         clk : in std_logic;
         addr_in : in std_logic_vector(15 downto 0);
        addr_out : out std_logic_vector(15 downto 0) );
end music_counter;
architecture behavioral of music_counter is
begin
  update_process: process ( reset, clk ) is
  begin
    if (reset = '1') then
      addr_out <= (others => '0');
    elsif (rising_edge(clk)) then
      addr_out <= addr_in;
    end if;
  end process;
end behavioral;
