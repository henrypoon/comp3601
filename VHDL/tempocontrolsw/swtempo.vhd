----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:05 10/17/2017 
-- Design Name: 
-- Module Name:    swtempo - Behavioral 
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
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity swtempo is
    Port ( clk : in std_logic;
			  reset: in std_logic;
			  tempo_val : in  STD_LOGIC_VECTOR (7 downto 0);
           tempo_mode : in  STD_LOGIC;
			  tempo_up :in  STD_LOGIC;
			  tempo_down :in  STD_LOGIC;
           tempo_out : out  STD_LOGIC_vector(7 downto 0));
end swtempo;

architecture Behavioral of swtempo is
	component tempo_reg is
	port(
		clk : in std_logic;
		reset : in std_logic;
		en : in std_logic;
		tempo_val: in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		data_out :out std_logic_vector(7 downto 0)
		);
	end component;
	
	component alu is
	port (
		clk : in std_logic;
		alu_en: in std_logic;
		alu_op : in std_logic;
	--	add_en : in std_logic;
	--	sub_en : in std_logic;
		data_a: in std_logic_vector(7 downto 0);
		data_b: in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0)
	);
	end component;
	
	signal counter : integer range 0 to 60000000;
	signal tempo_val_int : integer range 0 to 200;
	signal slowclk : std_logic := '0';
	--signal tempo_reg_int : integer range 0 to 200;
--	--signal tempo_reg	:std_logic_Vector(7 downto 0);
--	
--	signal lower_limit : integer range 0 to 200;
--	signal upper_limit : integer range 0 to 200;
--	signal counter_en : std_logic;
--	signal tempo_counter : integer range 0 to 200;
--	signal tempo_counter_vector : std_logic_vector(7 downto 0); 
	signal tempo_out_int: integer range 0 to 200;
--	signal lessthan200: std_logic;
--	signal morethan60: std_logic;
	
	TYPE State_Type IS (first, idle, decrement, increment);
	SIGNAL y : State_Type;
	--signal tempo_out_int : integer range 0 to 200;
	signal tempo_reg_in : std_logic_vector(7 downto 0);
	signal tempo_reg_out : std_logic_vector(7 downto 0);
	signal sig_one : std_logic_vector(7 downto 0);
	signal reg_write_en : std_logic;
	signal alu_op : std_logic;
	--signal add_en : std_logic;
	--signal sub_en : std_logic;
	signal reg_init: std_logic;
	signal alu_en: std_logic;	
	signal tempo_reset: std_logic;
begin

	fsm_transistions: process(tempo_val, tempo_mode, tempo_up, tempo_down, reset, tempo_out_int)
	begin
		if reset = '1' then
			y <= first;
		elsif rising_edge(clk) then
			if tempo_mode = '1' then  
			case y is
				when first =>
					y<= idle;
				
				when idle =>
				if tempo_up = '1' then 
					if tempo_down = '0' then
						if tempo_out_int < 200 then
							y <= increment;
						end if;
					end if;
				elsif tempo_down = '1' then 
					if tempo_up = '0' then
						if tempo_out_int >60 then 
							y <= decrement;
						end if;
					else 
						y <= idle;
					end if;
				end if;
				when increment =>
					if tempo_up = '1' then 
						if tempo_down = '0' then
							if tempo_out_int <200 then 
								y <= increment;
							else 
								y<= idle;
							end if;
						end if;
					elsif tempo_down = '1' then 
						if tempo_up = '0' then
							if tempo_out_int >60 then 
								y <= decrement;
							end if;
						end if;
					elsif tempo_out_int > 199 then 
								y <= idle;
					else 
						y <= idle;
					end if;
				when decrement =>
					if tempo_up = '1' then 
						if tempo_down = '0' then
							if tempo_out_int <200 then 
								y <= increment;
							end if;
						end if;
					elsif tempo_down = '1' then 
						if tempo_up = '0' then
							if tempo_out_int >60 then 
								y <= decrement;
							else
								y<= idle;
							end if;
						end if;
					elsif tempo_out_int < 61 then 
								y <= idle;
					else 
						y <= idle;
					end if;
				when others =>
					y<= idle;
			end case;
			end if;
		end if;
	end process;
	
	fsm_outputs: process(y)
	begin
		alu_en <= '0'; reg_init <= '1'; reg_write_en <= '0'; alu_op <= '0'; --add_en <= '0'; sub_en <= '0'; --intialise
		case y is
			when first =>
				reg_init <= '1';
				reg_write_en <= '0';
				alu_op <= '0';
				alu_en <= '0';
			--	sub_en <= '0';
			--	add_en <= '0';
			when idle => 
				reg_init <='0';
				reg_write_en <= '0';
				alu_op <= '0';
				alu_en <= '0';
			--	sub_en <= '0';
			--	add_en <= '0';
			when increment =>
				reg_init <='0';
				alu_op <= '1';
			--	add_en <= '1';
				reg_write_en <= '1';
			--	sub_en <= '0';
			alu_en <= '1';
			when decrement =>
			reg_init <='0';
			alu_op <= '0';
			alu_en <= '1';
			--	sub_en <='1';
			--	add_en <= '0';
				reg_write_en <='1';
		end case;
	end process;
	
	tempo_reset <= reset OR NOT tempo_mode;
	reg: tempo_reg 
	port map(
		clk => slowclk,
		reset => tempo_reset,
		en =>reg_write_en,
		tempo_val => tempo_val,
		data_in => tempo_reg_in,
		data_out => tempo_reg_out
	);

	sig_one <= X"01";
	addsum: alu
	port map (
		clk =>clk,
		alu_en => alu_en,
		alu_op => alu_op,
		--add_en => add_en, 
		--sub_en => sub_en,
		data_a=> tempo_reg_out,
		data_b => sig_one,
		data_out => tempo_reg_in
	);
	
	tempo_out <= tempo_reg_out;

	tempo_out_int <= to_integer(unsigned(tempo_reg_out));
--	tempo_val_int <= to_integer(unsigned(tempo_val));
--	lower_limit <= tempo_val_int - 60;
--	upper_limit <= 200 - tempo_val_int;
	
	--updates once per second
	slwclk: process(clk, counter, reset)
	begin
	if reset = '1' then 
		counter <=0;
	elsif rising_edge(clk) then 
		if counter > 50000000 then 
			slowclk <= not slowclk;
			counter <= 0;
		else
			counter <= counter +1;
		end if;
	end if;
	end process;

--	increment_counter: process(slowclk, increment_reset)
--	begin
--	if increment_reset <= '1' then
--		addcounter <= 0;
--		
--	end process;
--	
--	process(slowclk, tempo_mode, tempo_counter, upper_limit, lower_limit, clk)
--	begin
--	if rising_edge(slowclk) then
--		if tempo_mode = '1' then	
--			if tempo_counter < upper_limit then
--				lessthan200 <= '1';
--			else
--				lessthan200 <= '0';
--			end if;
--			
--			if tempo_counter < lower_limit then
--					--counter_en <= '1';
--					morethan60 <= '1';
--			else
--					morethan60 <= '0';
--					--counter_en <= '0';
--			end if;
--			
--		else
--		--	counter_en <= '0';
--			morethan60 <= '0';
--			lessthan200 <= '0';
--		end if;	
--	end if;
--	--end if;
--	end process;
--	
--	
--	counter_en <= morethan60 AND lessthan200;
--	--counter_en <= slowclk;
--	process(counter_en, slowclk)
--	begin
----	if counter_reset = '1' then 
--	if rising_edge(slowclk) then
--		if counter_en = '1' then  
--			tempo_counter <= tempo_counter + 1;
--		--end if;
----		elsif falling_edge(tempo_mode) then
----			tempo_counter <= 0;
----		elsif falling_edge(tempo_up) then
----			tempo_counter <= 0;
----		elsif falling_edge(tempo_down) then
----			tempo_counter <= 0;
--		end if;
--	end if;
--	end process;
--	
--	 
--	tempo_counter_vector <= std_logic_vector(to_unsigned(tempo_counter, 8));
--	output: process(tempo_mode, clk, tempo_counter, tempo_up, tempo_down)
--	begin
--	if rising_edge(slowclk) then
--		if tempo_mode = '1' then
--			if tempo_up = '1' then
--				if tempo_down = '0' then
--					tempo_out_int <= tempo_val_int + tempo_counter; --std_logic_vector(unsigned(tempo_val) + unsigned(tempo_counter_vector));
--				--else 
--				--	tempo_out <= tempo_reg;
--				end if;
--			elsif tempo_down = '1' then
--				if tempo_up = '0' then 
--					tempo_out_int <= tempo_val_int - tempo_counter; --";--std_logic_vector(unsigned(tempo_val) - unsigned(tempo_counter_vector));
--				end if;
--			end if;
--		else
--			tempo_out_int <= tempo_val_int;
--		end if;
--	end if;
--	end process;
--	
--	
--	tempo_out <= std_logic_vector(to_unsigned(tempo_out_int, 8));
end Behavioral;

