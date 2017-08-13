library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity musicplayer is
  port (reset     : in std_logic;
        clk       : in std_logic;
      music_data : in std_logic_vector(11 downto 0); --??? Depends on the format of the text file input
        sensor    : in std_logic;
        ready     :out std_logic; --??? might not need
        sound     :out std_logic --pwm output 
        );
end musicplayer;

architecture structural of musicplayer is
  --components
  component memory is 
    port (       reset : in std_logic;
                   clk : in std_logic;
          write_enable : in std_logic;
            write_data : in std_logic_vector(11 downto 0);
               addr_in : in std_logic_vector(15 downto 0);
              data_out : out std_logic_vector(11 downto 0));
  end component;
  
  component music_counter is
    port ( reset : in std_logic;
           clk : in std_logic;
          addr_in : in std_logic_vector(15 downto 0);
          addr_out : out std_logic_vector(15 downto 0));
  end component;
  
  component pwm is --contents will change depending on when the pwm is completed
    port (enable : in std_logic;
          data   : in std_logic_vector(11 downto 0);
          wave   : out std_logic);
  end component;
  
  component adder_16b is
    port ( src_a : in std_logic_vector(15 downto 0);
        src_b : in std_logic_vector(15 downto 0);
        sum : out std_logic_vector(15 downto 0);
        carry_out : out std_logic );
  end component;
  
--control sigals
  signal sig_mem_wr_en  : std_logic;
  signal sig_pwm_en :std_logic;
  
  --signal sig_mem_wr_data: std_logic_vector(11 downto 0);
  signal sig_mem_addr_in: std_logic_vector(15 downto 0);
  signal sig_mem_data_out: std_logic_vector(11 downto 0);
  signal sig_cur_addr : std_logic_vector(15 downto 0);
  signal sig_one_16b : std_logic_vector(15 downto 0);
  signal sig_addr_sum :std_logic_vector(15 downto 0);
  signal sig_carry: std_logic;
  begin
    ---control process
    --to do
    
          
    -----
    mem: memory 
    port map (reset => reset,
              clk => clk,
              write_enable => sig_mem_wr_en,
              write_data => music_data,
              addr_in => sig_mem_addr_in,
              data_out => sig_mem_data_out
              );
    
    soundplayer: pwm 
    port map ( enable => sig_pwm_en,
              data  => sig_mem_data_out,
              wave  =>  sound
             );
    
    counter:  music_counter 
    port map ( reset => reset,
              clk => clk,
              addr_in => sig_cur_addr,
              addr_out => sig_mem_addr_in
              );

    sig_one_16b <= "0000000000000001"; --??? or x"001"    
    adder: adder_16b
    port map (src_a => sig_mem_addr_in,
              src_b => sig_one_16b,
              sum => sig_addr_sum,
              carry_out => sig_carry
              );
end structural; 