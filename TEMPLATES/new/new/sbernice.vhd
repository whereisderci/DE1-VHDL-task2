library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity sbernice is
    Port ( sng_loop : in STD_LOGIC;
           in_0 : in STD_LOGIC;
           in_1 : in STD_LOGIC;
           in_2 : in STD_LOGIC;
           in_3 : in STD_LOGIC;
           to_counter : out STD_LOGIC;
           out_1 : out STD_LOGIC;
           out_2 : out STD_LOGIC;
           out_3 : out STD_LOGIC);
end sbernice;

architecture Behavioral of sbernice is
signal to_and : std_logic;


begin
    process(in_0,in_1,in_2,in_3)
        begin 
            if (in_0 = '1') or (in_1 = '1') or (in_2 = '1') or (in_3 = '1') then
                to_and <= '1';
            else
                to_and <= '0';
            end if;
            
            to_counter <= sng_loop and to_and;
            out_1 <= in_1;
            out_2 <= in_2;
            out_3 <= in_3;
    end process;
            
                            
end Behavioral;
