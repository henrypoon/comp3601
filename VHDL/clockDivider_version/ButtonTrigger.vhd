library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- debouce for press button to trigger the adder

entity ButtonTrigger is
    Port ( clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  btn : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end ButtonTrigger;

architecture Behavioral of ButtonTrigger is

type state is (hold0, ready0, hold1, ready1);
signal curr_state, next_state : state;
signal t : STD_LOGIC_VECTOR(1 downto 0);

begin

seq : process(clk, rst, ns)
begin
	if (rising_edge(clk)) then
		if (rst= '1') then
			curr_state <= hold0;
		else
			curr_state <=  next_state;
		end if;
	end if;
end process seq;

comb : process(clk, rst, btn, curr_state)
begin
	case curr_state is
		when hold0 => t <= "00";
			if (btn = '0') then
				 next_state <= ready0;
			else
				 next_state <= curr_state;
			end if;
		when ready0 => t <= "01";
  		if (btn = '1') then
  			 next_state <= hold1;
  		else
  			 next_state <= curr_state;
  		end if;
		when hold1 => t <= "10";
			if (btn = '0') then
				 next_state <= ready1;
			else
				 next_state <= curr_state;
			end if;
		when ready1 => t <= "11";
			if (btn = '1') then
				 next_state <= hold0;
			else
				 next_state <= curr_state;
			end if;
	end case;
end process comb;

Q <= t(1);

end Behavioral;
