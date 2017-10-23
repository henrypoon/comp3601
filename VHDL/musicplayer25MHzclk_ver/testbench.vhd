--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:37:47 09/22/2017
-- Design Name:   
-- Module Name:   C:/Users/luong/Documents/4thyr/SEM2/COMP3601/musicplayer_v1/musicplayer_v1.1/testbench.vhd
-- Project Name:  musicplayer_v1.1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: musicplayer_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT musicplayer_top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         play : IN  std_logic;
         tempo_mode : IN  std_logic;
         tempo_val : IN  std_logic_vector(5 downto 0);
         speaker : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal play : std_logic := '0';
   signal tempo_mode : std_logic := '0';
   signal tempo_val : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal speaker : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: musicplayer_top PORT MAP (
          clk => clk,
          reset => reset,
          play => play,
          tempo_mode => tempo_mode,
          tempo_val => tempo_val,
          speaker => speaker
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;
		play <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
