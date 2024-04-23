library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity demux is
    Port ( d : in STD_LOGIC;
           y0 : out STD_LOGIC;
           y1 : out STD_LOGIC;
           y2 : out STD_LOGIC;
           y3 : out STD_LOGIC;
           s : in std_logic_vector (1 downto 0)
           );
end demux;

architecture Behavioral of demux is

begin
    process(s,d)
        begin
            if s = "00" then 
                y0 <= d; 
                y1 <= '0';
                y2 <= '0';
                y3 <= '0';
            elsif s = "01" then 
                y0 <= '0'; 
                y1 <= d;
                y2 <= '0';
                y3 <= '0';
            elsif s = "10" then 
                y0 <= '0'; 
                y1 <= '0';
                y2 <= d;
                y3 <= '0';  
            else
                y0 <= '0'; 
                y1 <= '0';
                y2 <= '0';
                y3 <= d;
            end if;
        end process; 
                
end Behavioral;
