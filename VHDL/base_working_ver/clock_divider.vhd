----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:00:46 08/24/2017 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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

entity clock_divider is
	port( clk : in std_logic;
			reset: in std_logic;
			en	:	in std_logic;
			note_data: in std_logic_vector(5 downto 0);
			square_wave: out std_logic
	);
end clock_divider;

architecture Behavioral of clock_divider is
	signal count:  integer range 0 to 400000 := 0;
	signal segment_counter : integer range 0 to 500000;
	signal segment_counter_reset : std_logic := '0'; --initlise to zero?
	signal temp: std_logic;
	
	--
	--signal sig_1_32 : integer range 0 to 500000; --i.e. 1/32 of sig_max = 3.125% of period & 25% of a segment
	--signal sig_3_32 : integer range 0 to 500000; --i.e. 3/32 of sig_max = 9.375% of period & 75% of a segment
	signal sig_1_16 : integer range 0 to 500000; --i.e. 1/16 of sig_max = 6.25% of period & 50% of a segment
	signal sig_1_8 : integer range 0 to 500000; --i.e. 1/8 of sig_max = 12.5%
	signal sig_3_16 : integer range 0 to 500000;
	signal sig_1_4 : integer range 0 to 500000; --i.e. 1/4 of sig_max  = 25%
	signal sig_5_16 : integer range 0 to 500000;
	signal sig_3_8 : integer range 0 to 500000; 
	signal sig_7_16 : integer range 0 to 500000;
	signal sig_1_2 : integer range 0 to 500000; --i.e. 1/2 of sig_max =50% etc etc
	signal sig_9_16 : integer range 0 to 500000;
	signal sig_5_8 : integer range 0 to 500000;
	signal sig_11_16 : integer range 0 to 500000;
	signal sig_3_4 : integer range 0 to 500000;
	signal sig_13_16 : integer range 0 to 500000;
	signal sig_7_8 : integer range 0 to 500000;
	signal sig_15_16 : integer range 0 to 500000;
	signal sig_max: integer range 0 to 500000;
	signal sig_max_vector : std_logic_vector (19 downto 0);
	
	--segment signals
	signal sig_segment_vector : std_logic_vector(19 downto 0);
	signal sig_100segment : integer range 0 to 500000;
	signal sig_50segment : integer range 0 to 500000;
	signal sig_25segment : integer range 0 to 500000;
	signal sig_12_5segment : integer range 0 to 500000;
	signal sig_6_25segment : integer range 0 to 500000;
	signal sig_3_125segment : integer range 0 to 500000;
	signal sig_1_5625segment : integer range 0 to 500000;
	
	signal sig_87_5segment  : integer range 0 to 500000;
	signal sig_75segment : integer range 0 to 500000;
	signal sig_62_5segment  : integer range 0 to 500000;
	signal sig_37_5segment  : integer range 0 to 500000;
	
	signal sig_68_75segment : integer range 0 to 500000;
	signal sig_96_875segment : integer range 0 to 500000;
	signal sig_29_6875segment : integer range 0 to 500000;
	signal sig_85_9375segment : integer range 0 to 500000;
	signal sig_14_0625segment : integer range 0 to 500000;
begin
--note to self = when adding in the pwm need to add sig_max to the output of this module
	--sig_max <= to_integer(unsigned(max_counter));
		
	--sig_1_32<= to_integer(unsigned(sig_max(19 downto 5)));				
	sig_max_vector <= std_logic_vector(to_unsigned(sig_max, 20)); 
	
	--dividing the period of one sine wave into 16 segments 
	sig_1_16<= to_integer(unsigned(sig_max_vector(19 downto 4)));
	--sig_3_32<= sig_1_32 + sig_1_16;
	sig_1_8 <= to_integer(unsigned(sig_max_vector(19 downto 3)));
	sig_3_16<= sig_1_8 + sig_1_16; 
	sig_1_4 <= to_integer(unsigned(sig_max_vector(19 downto 2)));
	sig_5_16<= sig_1_4 + sig_1_8;
	sig_3_8 <= sig_1_8 + sig_1_4;
	sig_7_16<= sig_3_8 + sig_1_16;
	sig_1_2 <= to_integer(unsigned(sig_max_vector(19 downto 1)));
	sig_9_16<= sig_1_2 + sig_1_16;
	sig_5_8 <= sig_1_8 + sig_1_2;
	sig_11_16<= sig_5_8 + sig_1_16;
	sig_3_4 <= sig_1_4 + sig_1_2;
	sig_13_16 <= sig_3_4 + sig_1_16;
	sig_7_8 <= sig_1_8 + sig_3_4;
	sig_15_16 <= sig_7_8 + sig_1_16;

	--dividing the period of one sine wave into 16 segments
	sig_segment_vector <= std_logic_vector(to_unsigned(sig_1_16, 20)); 
	sig_100segment <= sig_1_16;
	sig_50segment <= to_integer(unsigned(sig_segment_vector(19 downto 2)));
	sig_25segment <= to_integer(unsigned(sig_segment_vector(19 downto 3)));
	sig_12_5segment <= to_integer(unsigned(sig_segment_vector(19 downto 4)));
	sig_6_25segment <= to_integer(unsigned(sig_segment_vector(19 downto 5)));
	sig_3_125segment <= to_integer(unsigned(sig_segment_vector(19 downto 6)));
	sig_1_5625segment <= to_integer(unsigned(sig_segment_vector(19 downto 6)));
	
	--sawtooth signals
	sig_62_5segment <= sig_50segment + sig_12_5segment;
	sig_75segment <= sig_50segment + sig_25segment;
	sig_87_5segment <= sig_75segment + sig_12_5segment;
	sig_37_5segment <= sig_25segment + sig_12_5segment;
	
	--sine signals
	sig_68_75segment <= sig_62_5segment + sig_12_5segment;
	sig_96_875segment <= sig_87_5segment + sig_6_25segment + sig_3_125segment;
	sig_29_6875segment <= sig_25segment + sig_3_125segment + sig_1_5625segment;
	sig_85_9375segment <= sig_75segment + sig_6_25segment +sig_3_125segment + sig_1_5625segment;
	sig_14_0625segment <= sig_12_5segment + sig_1_5625segment;
	
	---global counter
	process(clk, reset, sig_max)
	begin
		if reset = '1' then
			count <= 0;
		elsif rising_edge(clk) then
			if count > sig_max then
				count <= 0;
			else 
				count <= count +1;
			end if;
		end if;
	end process;
	
	--segment counter
	process(segment_counter_reset, reset, clk)
	begin
	if reset = '1' then
		segment_counter <= 0;
	elsif rising_edge(clk) then
		if segment_counter_reset = '1' then
			segment_counter <= 0;
		else 
			segment_counter <= segment_counter +1;
		end if;
	end if;
	end process;
	

----------------------------------------------		
	--------------sinewave--------------------
	process (clk, reset, sig_max, count, segment_counter)
	begin
		if (reset = '1') then 
			temp <= '0';
		elsif (rising_edge(clk)) then
			if en ='1' then
				if sig_max = 0 then
					temp <= '0';
				elsif count <sig_1_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_68_75segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_1_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_1_8 then
					segment_counter_reset <= '0';
					if segment_counter < sig_85_9375segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_1_8 then
					segment_counter_reset <= '1';
			
				elsif count <sig_3_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_96_875segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_3_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_1_4 then
						temp <= '1';
				elsif count = sig_1_4 then
					segment_counter_reset <= '1';
				
				elsif count <sig_5_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_96_875segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_5_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_3_8 then
					segment_counter_reset <= '0';
					if segment_counter < sig_85_9375segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_3_8 then
					segment_counter_reset <= '1';
					
				elsif count <sig_7_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_68_75segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_7_16 then
					segment_counter_reset <= '1';
					
				elsif count <sig_1_2 then
					segment_counter_reset <= '0';
					if segment_counter < sig_50segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_1_2 then
					segment_counter_reset <= '1';
					
				
				elsif count <sig_9_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_29_6875segment  then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_9_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_5_8 then
					segment_counter_reset <= '0';
					if segment_counter < sig_14_0625segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_5_8 then
					segment_counter_reset <= '1';
			
				elsif count <sig_11_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_3_125segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_11_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_3_4 then
						temp <= '0';
				elsif count = sig_3_4 then
					segment_counter_reset <= '1';
				
				elsif count <sig_13_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_3_125segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_13_16 then
					segment_counter_reset <= '1';
				
				elsif count <sig_7_8 then
					segment_counter_reset <= '0';
					if segment_counter < sig_14_0625segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_7_8 then
					segment_counter_reset <= '1';
					
				elsif count <sig_15_16 then
					segment_counter_reset <= '0';
					if segment_counter < sig_29_6875segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_15_16 then
					segment_counter_reset <= '1';
					
				elsif count <sig_max then
					segment_counter_reset <= '0';
					if segment_counter < sig_50segment then
						temp <= '1';
					else 
						temp <= '0';
					end if;
				elsif count = sig_max then
					segment_counter_reset <= '1';
					--count_reset <= '1';
				end if;
			end if;
		end if;
		end process;



	
--	----------------------------------------------		
--	--------------sawtoothwave--------------------
--	process (clk, reset, sig_max, count, segment_counter)
--	begin
--		if (reset = '1') then 
--			temp <= '0';
--		elsif (rising_edge(clk)) then
--			if en ='1' then
--				if sig_max = 0 then
--					temp <= '0';
--				elsif count <sig_1_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_62_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_1_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_1_8 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_75segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_1_8 then
--					segment_counter_reset <= '1';
--			
--				elsif count <sig_3_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_87_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_3_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_1_4 then
--						temp <= '1';
--				elsif count = sig_1_4 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_5_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_87_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_5_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_3_8 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_75segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_3_8 then
--					segment_counter_reset <= '1';
--					
--				elsif count <sig_7_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_62_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_7_16 then
--					segment_counter_reset <= '1';
--					
--				elsif count <sig_1_2 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_50segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_1_2 then
--					segment_counter_reset <= '1';
--					
--				
--				elsif count <sig_9_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_37_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_9_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_5_8 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_25segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_5_8 then
--					segment_counter_reset <= '1';
--			
--				elsif count <sig_11_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_12_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_11_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_3_4 then
--						temp <= '0';
--				elsif count = sig_3_4 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_13_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_12_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_13_16 then
--					segment_counter_reset <= '1';
--				
--				elsif count <sig_7_8 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_25segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_7_8 then
--					segment_counter_reset <= '1';
--					
--				elsif count <sig_15_16 then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_37_5segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_15_16 then
--					segment_counter_reset <= '1';
--					
--				elsif count <sig_max then
--					segment_counter_reset <= '0';
--					if segment_counter < sig_50segment then
--						temp <= '1';
--					else 
--						temp <= '0';
--					end if;
--				elsif count = sig_max then
--					segment_counter_reset <= '1';
--					--count_reset <= '1';
--				end if;
--			end if;
--		end if;
--		end process;

-----------------------------		
---------square wave	generator
--------- note: square wave output is actually double that of the target frequency i.e period = 2*sig_max 	
--	counter: process(clk, reset)
--	begin
--		if (reset = '1') then
--			temp <= '0';
--			count <= 0;
--		elsif (rising_edge(clk)) then
--			if en ='1' then
--				if sig_max = 0 then
--					temp <= '0';
--					count <= 0;
--				elsif count > sig_max then 
--					temp <= NOT(temp);
--					count <= 0;
--				else
--					count <= count + 1;
--				end if;
--			end if;
--		end if;
--		end process;
		
	square_wave <= temp;

		--mux version
--	with note_data select sig_max <= 
--		0 when "000000", -- rest
--		384615 when "000010", --c3
--		360776 when "000011", --c3# d3b
--		340529 when "000100", --d3
--		321419 when "000101", --d3# e3b
--		303379 when "000110", --e3 f3b
		--works up to here
		--286352 when "000111", --e3# f3
		--270270 when "001000", --f3# g3b
		--255102 when "001001", --g3
		--240789 when "001010", --g3# a4b
--		0 when others;	-- will fill this in later

			
	--select frequency counter value
	--LUT
	process(note_data)
	begin
		case note_data is
			when "000000" => sig_max <= 0; -- rest
			when "000010" => sig_max <= 384615; --c3
			when "000011" => sig_max <= 360776; --c3# d3b
			when "000100" => sig_max <= 340529; --d3
			when "000101" => sig_max <= 321419; --d3# e3b
			when "000110" => sig_max <= 303379; --e3 f3b
			when "000111" => sig_max <= 286352; --e3# f3
			when "001000" => sig_max <= 270270; --f3# g3b
			when "001001" => sig_max <= 255102; --g3
			when "001010" => sig_max <= 240789 ; --g3# a4b
			when "001011" => sig_max <= 113636 ; --a3
			when "001100" => sig_max <= 107259 ; --a3# b3b
			when "001101" => sig_max <= 101239 ; --b3 c4b
			when "001110" => sig_max <= 191109 ; --b3# c4
			when "001111" => sig_max <= 180388 ; --c4# d4b
			when "010000" => sig_max <= 170264 ; --d4
			when "010001" => sig_max <= 160704 ; --d4# e4b
			when "010010" => sig_max <= 151685 ; --e4 f4b
			when "010011" => sig_max <= 143172 ; --e4# f4
			when "010100" => sig_max <= 135138 ; --f4# g4b
			when "010101" => sig_max <= 127551 ; --g4
			when "010110" => sig_max <= 120394 ; --g4# a4b
			when "010111" => sig_max <= 56818 ; --a4
			when "011000" => sig_max <= 53629 ; --a4# b4b
			when "011001" => sig_max <= 50619 ; --b4 c5b
			when "011010" => sig_max <= 95556 ; --b5# c5
			when "011011" => sig_max <= 90192 ; --c5# d5b
			when "011100" => sig_max <= 85131 ; --d5
			when "011101" => sig_max <= 80353 ; --d5# e5b
			when "011110" => sig_max <= 75843 ; --e5 f5b
			when "011111" => sig_max <= 71586 ; --e5# f5
			when "100000" => sig_max <= 67568 ; --f5# g5b
			when "100001" => sig_max <= 63776 ; --g5
			when "100010" => sig_max <= 60196 ; --g5# a5b
			when "100011" => sig_max <= 56818 ; --a5
			when "100100" => sig_max <= 53648 ; --a5# b5b
			when "100101" => sig_max <= 50658 ; --b5 c6b
			when "100110" => sig_max <= 47778 ; --b6# c6
			when "100111" => sig_max <= 45126 ; --c6# d6b
			when "101000" => sig_max <= 42589 ; --d6
			when "101001" => sig_max <= 40192 ; --d6# e6b
			when "101010" => sig_max <= 37936 ; --e6 f6b
			when "101011" => sig_max <= 35816 ; --e6# f6
			when "101100" => sig_max <= 33806 ; --f6# g6b
			when "101101" => sig_max <= 31908 ; --g6
			when "101110" => sig_max <= 30102 ; --g6# a6b
			when "101111" => sig_max <= 28409 ; --a6
			when "110000" => sig_max <= 26824 ; --a6# b6b
			when "110001" => sig_max <= 25316 ; --b6 c7b
			when others => sig_max <= 0;
		end case;
	end process;
	


end Behavioral;
