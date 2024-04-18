library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity STOP is
    Port ( x1 : in STD_LOGIC;
           x2 : in STD_LOGIC;
           x3 : in STD_LOGIC;
           x0 : in STD_LOGIC;
           y1 : out STD_LOGIC;
           y2 : out STD_LOGIC;
           y3 : out STD_LOGIC;
           y0 : out std_logic
           );
end STOP;

architecture Behavioral of STOP is

begin
    process(x0)
        begin
            if x0 = '1' then
                y0 <= '1';
                y1 <= '0';
                y2 <= '0';
                y3 <= '0';
            else
                y1 <= x1;
                y2 <= x2;
                y3 <= x3;
                y0 <= '0';
            end if;
    end process;
                
      


end Behavioral;
