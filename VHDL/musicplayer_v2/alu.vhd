
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity alu is
	port (
		clk : in std_logic;
		--add_en : in std_logic;
		--sub_en : in std_logic;
		alu_en: in std_logic;
		alu_op : in std_logic;
		data_a: in std_logic_vector(7 downto 0);
		data_b: in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0)
	);
end alu;

architecture Behavioral of alu is

signal data_out_int:  integer;
signal data_a_int:  integer;
signal data_b_int:  integer;

begin

	data_a_int <=to_integer(unsigned(data_a));
	data_b_int  <= to_integer(unsigned(data_b));

	process(clk, alu_op, data_a_int, data_b_int)
	begin
	if rising_edge(clk) then
	if alu_en = '1' then
		--if add_en = '1' then
		if alu_op = '1' then	
			data_out_int <= data_a_int + data_b_int;
		elsif alu_op <= '0' then
		--elsif sub_en = '1' then
			data_out_int <= data_a_int - data_b_int;
		end if;
	end if;
	end if;
	end process;
	data_out <= std_logic_vector(to_unsigned(data_out_int, 8));
end Behavioral;

