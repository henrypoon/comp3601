----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:53 10/12/2017 
-- Design Name: 
-- Module Name:    sevenSeg2 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseghex is
	port (
	CLKK : in std_logic;
	number : in std_logic_vector(11 downto 0);
	segments : out std_logic_vector(7 downto 0);
	displayOut : out std_logic_vector(3 downto 0)
	
	);
end sevenseghex;

architecture Behavioral of sevenseghex is
	--component slowClock is
	--	port (
	--		clkin :std_logic;
	--		clkout: std_logic
	--	);
	--end component;
	
	component SevenSegment is
		port (
			binary : in std_logic_vector(3 downto 0);
			SEGMENTS : out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal counter : integer range 0 to 4 :=0;
	signal BCD : std_logic_vector(3 downto 0);
	signal display: std_logic_vector(3 downto 0);
	signal digits : std_logic_vector(11 downto 0);
	signal SLWCLK : std_logic :='0';
	signal slwclkcounter : integer range 0 to 500001;
	signal segmentin : std_logic_Vector(3 downto 0);
	
	
	
begin
	displayOut <= display;
	
--	slclk: slowClock 
--	port map (
--		clkin => CLKK,
--		clkout => SLWCLK
--	);
	
	sevensegm: SevenSegment
	port map (
		binary => BCD, --segmentin, --
		SEGMENTS => segments
	);
--	
--	conv: bin2bcd 
--	port map (
--		binIN => number,
--      ones => digits(3 downto 0),
--      tens => digits(7 downto 4),
--      hundreds => digits(11 downto 8)
--	);
	
	digits <= number; 
--	process (display, SLWCLK, digits)
--	begin
--		if rising_edge(slwclk) then
--			if display = "1110" then
--				segmentin <= digits(3 downto 0);
--			elsif display = "1101" then
--				segmentin <= digits(7 downto 4);
--			elsif display = "1011" then
--				segmentin <= digits(11 downto 8);
--			else
--				segmentin <= "0000";
--			end if;
--		end if;
--	end process;
	
	process(clkk)
	begin
		if rising_edge(clkk) then
			if slwclkcounter = 100 then
				SLWCLK <= '1';
				slwclkcounter <= 0;
			else 
				slwclkcounter <= slwclkcounter + 1;
				SLWCLK <= '0';
			end if;
		end if;
	end process;
	
	process (clkk, SLWCLK)
	begin
		if rising_edge(clkk) then
		if slwclk = '1' then
			if counter = 0 then
				BCD <= digits(3 downto 0);
				display <= "1110";
				counter <= counter +1;
			elsif counter = 1 then
				BCD <= digits(7 downto 4);
				display <= "1101";
				counter <= counter +1;
			elsif counter = 2 then
				BCD <= digits(11 downto 8);
				display <= "1011";
				counter <= counter +1;
			elsif counter = 3 then	
			--	BCD <= digits(3 downto 0);
				display <= "1111";
				counter <= 0;
			else
				display <= "1111";
				counter <= 0;
			end if; 
		end if;
	end if;
	end process;
end Behavioral;

