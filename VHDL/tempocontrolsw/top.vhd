----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:37:52 10/17/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
	port(
	clk : in std_logic;
	reset: in std_logic;
	number : in std_logic_vector(7 downto 0);
	tempo_mode2 : in  STD_LOGIC;
  tempo_up :in  STD_LOGIC;
  tempo_down :in  STD_LOGIC;
	led	: out std_logic_vector(7 downto 0);
	segments : out std_logic_vector(7 downto 0);
	displayOut : out std_logic_vector(3 downto 0));
end top;

architecture Behavioral of top is
	component sevenSeg2 is
	port (
		CLKK : in std_logic;
		number : in std_logic_vector(7 downto 0);
		segments : out std_logic_vector(7 downto 0);
		displayOut : out std_logic_vector(3 downto 0)
	);
	end component;

	component swtempo is
    Port ( clk : in std_logic;
			  reset: in std_logic;
			  tempo_val : in  STD_LOGIC_VECTOR (7 downto 0);
           tempo_mode : in  STD_LOGIC;
			  tempo_up :in  STD_LOGIC;
			  tempo_down :in  STD_LOGIC;
           tempo_out : out  STD_LOGIC_vector(7 downto 0));
	end component;
	
	signal sig_tempo_val: std_logic_vector(7 downto 0);
	signal sig_tempo_out: std_logic_vector(7 downto 0);
begin
	--sig_tempo_val <= "01111000"; --120
	--sig_tempo_val <= "10111110"; --190
	sig_tempo_val <="01000001"; --165
	
	switches: swtempo 
	port map (
		clk => clk,
		reset => reset,
		tempo_val => sig_tempo_val,
		tempo_mode => tempo_mode2,
		tempo_up => tempo_up,
		tempo_down => tempo_down,
		tempo_out => sig_tempo_out
	);
	led <= sig_tempo_out;
	seg: sevenSeg2 
	port map (
		clkk => clk,
		number => sig_tempo_out, 
		segments => segments,
		displayOut => displayOut
	);
end Behavioral;

