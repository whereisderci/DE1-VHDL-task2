library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity signals is
generic(
       toggle_count : integer -- target_frequency    :   integer := 440 -- Default to A (440 Hz)
        );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en : in std_logic;
           r_rst : in std_logic;
           tone_out : out STD_LOGIC);
end signals;

architecture Behavioral of signals is

-- Calculate toggle rate to achieve the target frequency from the input clock frequency
--constant clock_frequency :   integer := 50000000;
--constant toggle_count   :   integer := (2*clock_frequency/target_frequency)-1;--clock_frequency/(2*target_frequency)-1;
signal counter          :   integer range 0 to (toggle_count - 1) := 0;
signal tone_signal      :   STD_LOGIC := '0';

begin

    process(clk)--, reset, r_rst)
        begin
            --if rising_edge(clk) then
            if rising_edge(clk) then
                if (reset = '1') or (r_rst = '1') then
                    counter <= 0;
                    tone_signal <= '0';
                               
                elsif en = '1' then
                    if counter = toggle_count-1 then
                        counter <= 0;
                        tone_signal <= '1';
                    else
                        tone_signal <= '0';
                        counter <= counter + 1;
                    end if;
                else 
                    counter <= counter;
                    tone_signal <= '0';
                 end if;
               end if;
            end process;
            
            tone_out <= tone_signal;
            

end Behavioral;