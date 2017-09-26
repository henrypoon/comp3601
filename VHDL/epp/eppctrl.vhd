----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:14 09/22/2017 
-- Design Name: 
-- Module Name:    eppctrl - Behavioral 
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

entity eppctrl is
    Port ( 
			  --clk	: in std_logic;
			  sw	: in std_logic;
			  ctlEppWr  : in  STD_LOGIC; --if wr = 1, then pc reads, if wr = 0, then pc writes
           ctlEppAstb : in  STD_LOGIC; -- if add
           ctlEppDwr : in  STD_LOGIC;
			  data		: inout std_logic_vector(7 downto 0); --data bus
			  led	: out std_logic_vector(3 downto 0);
			  pwait : buffer  STD_LOGIC -- wait signal, if = 1, the pc reads, if = 0, the fpga reads
			  
			 );
end eppctrl;

architecture Behavioral of eppctrl is
	signal reg_data_top4 : std_logic_vector(7 downto 0); --data "0000" & (11 downto 8)
	signal reg_data_bottom8 : std_logic_vector(7 downto 0); --data bits (7 downto 0)
	signal reg_bram_addr : std_logic_vector(7 downto 0); --bram address data
	signal busEppData : std_logic_vector(7 downto 0);
	signal busEppOut : std_logic_vector(7 downto 0);
	signal busEppIn : std_logic_vector(7 downto 0);
	signal address_strobe :std_logic;
	signal data_strobe :std_logic;
	signal regEppAdr: std_logic_Vector(1 downto 0);
--	signal pwait : std_logic;
	signal nothing :std_logic;
	--fsm
	TYPE State_Type IS (initial, read_addr, wait_r_addr, read_data, wait_r_data, write_addr, wait_w_addr, write_data, wait_w_data); 
	SIGNAL y : State_Type;
 

begin
--
	led(0) <=  ctlEppWr;
	led(1) <= pwait;
	led(2) <= address_strobe;
	led(3) <= data_strobe;
	 
	fsm_transitions: process(sw) --clk)
	begin
		if rising_edge(sw) then --clk) then
			case y is 
				when initial =>
					if address_strobe = '0' then
						if ctlEppWr = '1' then
							y <= read_addr;
						elsif ctlEppWr = '0' then
							y <= write_addr;
						else 
							y <= initial;
						end if;
					elsif data_strobe = '0' then
						if ctlEppWr = '1' then
							y <= read_data;
						elsif ctlEppWr = '0' then
							y <= write_data;
						else 
							y <= initial;
						end if;
					else
						y <= initial;
					end if;
				when read_addr =>
					if (ctlEppWr and address_strobe) = '1' then  
						y <= wait_r_addr;
					else 
						y <= read_addr;
					end if;
				when wait_r_addr => 
					y <= initial; 
				when read_data =>
					if (ctlEppWr and data_strobe) ='1' then  
						y <= wait_r_data;
					else 
						y <= read_data;
					end if;
				when wait_r_data => 
					y <= initial;
				when write_addr =>
					if (ctlEppWr and address_strobe) = '1' then 
						y <= wait_w_addr;
					else 
						y <= write_addr;
					end if;
				when wait_w_addr =>	
					y <= initial;
				when write_data =>
					if (ctlEppWr and data_strobe) = '1' then  
						y <= wait_w_data;
					else 
						y <= write_data;
					end if;
				when wait_w_data =>
					y <= initial;
			end case;
		end if;
	end process;

	fsm_outputs: process (y)
	begin
		case y is 
			when initial =>
				pwait <= '0';
			when read_addr =>		
				pwait <= '1';
			when wait_r_addr =>  
				pwait <= '0';
			when read_data => 
				pwait <= '1';
			when wait_r_data =>
				pwait <= '0';
			when write_addr => 
				pwait <= '1';
			when wait_w_addr=>
				pwait <= '0';
			when write_data=> 
				pwait <= '1';
			when wait_w_data =>
				pwait <= '0';
			when others =>
				pwait <='0';
		end case;
	end process;


	address_strobe <= ctlEppAstb;
	data_strobe <= ctlEppDwr;
	
	busEppData <= reg_data_top4 when regEppAdr = "00" else -- address 0 =>data
						reg_data_bottom8 when regEppAdr = "01" else -- address 1 => data
						reg_bram_addr when regEppAdr = "10" else -- address 2 => bram address
						"00000000";

	-- handle address and data reads	
	busEppOut <= "000000" & regEppAdr when ctlEppAstb = '0' else busEppData;

	-- data bus gets read data during read, tri-state otherwise
	data <= busEppOut when ctlEppWr = '1' and pwait = '1' else "ZZZZZZZZ";
	
	busEppIn <= data when ctlEppWr = '0' and pwait = '0' else "ZZZZZZZZ";
	
	
	--pwait = '1' when 
	
	--done timer
	-- not sure if we're going to be using this in the final product ???
	--process (clk, pwait, ctlEppWr, address_strobe, data_strobe)
	--begin
	--	if rising_edge(clk) then 
	--		if (data_strobe and ctlEppWr) = '1' then
	--			pwait <='1'; 
	--		elsif  (address_strobe and ctlEppWr) = '1' then
	--			pwait <='1';
	--		else
	--			pwait <='0';
	--		end if;
	--	end if;
	--end process;
	
	-- address register
	process (address_strobe, sw) --clk) -- ctlEppAwr)
	begin
		if rising_Edge(sw) then --clk) then
			if address_strobe = '1' then
				regEppAdr <= busEppIn(1 downto 0);
			end if;
		end if;
	end process;
	-- data register
	process (regEppAdr, data_strobe, busEppIn, sw)--clk)
	begin
		if rising_edge(sw) then --clk) then
			--if ctlEppDwr 
			if data_strobe = '1' then
				case regEppAdr is
					when "00" => reg_data_top4 <= busEppIn;
					when "01" => reg_data_bottom8 <= busEppIn;
					when "10" => reg_bram_addr <= busEppIn;
					when others => nothing <= '0' ; 
				end case;
			end if;
		end if;
	end process;
	
end Behavioral;

