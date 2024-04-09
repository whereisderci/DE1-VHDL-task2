library IEEE;
use IEEE.std_logic_1164.all;

--je tøeba ještì upravit finální hodnoty

entity tb_signals is
end tb_signals;


architecture tb of tb_signals is

    component signals
        port (clk      : in std_logic;
              reset    : in std_logic;
              tone_out : out std_logic);
    end component;

   signal clk      : std_logic;
    signal reset    : std_logic;
    signal tone_out : std_logic;

    constant TbPeriod : time := 10 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    constant clock_frequency : integer := 100000000;
    constant target_frequency : integer := 10000000;
    constant tg_count : integer := (clock_frequency/(2*target_frequency)-1);-- = 4

begin

   dut : signals
    port map (clk      => clk,
              reset    => reset,
              tone_out => tone_out);


    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';


    clk <= TbClock;

    stimuli : process
    begin
        report "Stimulus process started";
            --for c in 1 to 4 loop
            reset <= '1';
            
            
            wait for 10 * TbPeriod;
            reset <= '0';
            wait for 100*TbPeriod;
 
            
            
--            TbSimEnded <= '1';
--            sig_counter <= 0;
--            sig_tone_out <= '0';
--            TbClock <= '0';
--            sig_clk <='0';
--            wait;
            
            
            
            
--            for i in 1 to 10 loop

--                if sig_counter < tg_count then 
--                    sig_counter <= sig_counter +1;
--                    sig_tone_out <= '0';
--                    wait for TbPeriod;
--                else
--                    sig_tone_out <= '1';
--                    sig_counter <= 0;
--                    wait for TbPeriod;                
--                end if;
--                wait for 80 *TbPeriod;
--                TbSimEnded <= '1';  
--                wait; 
--            end loop;             


        
        report "Stimulus process ended";
    end process;

end tb;



configuration cfg_tb_signals of tb_signals is
    for tb
    end for;
end cfg_tb_signals;