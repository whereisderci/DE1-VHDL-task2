library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tempo is
    Port ( sw_1 : in STD_LOGIC;
           sw_2 : in STD_LOGIC;
           out_1 : out STD_LOGIC;
           out_2 : out STD_LOGIC;
           out_0 : out STD_LOGIC);
end tempo;

architecture Behavioral of tempo is

begin
    process
        begin
            if (sw_1 = '0' and sw_2 = '0') or (sw_1 = '1' and sw_2 = '1') then
                out_0 <= '1';
                out_1 <= '0';
                out_2 <= '0';
            elsif (sw_1 = '0' and sw_2 = '1') then
                out_0 <= '0';
                out_1 <= '1';
                out_2 <= '0';
            else
                out_0 <= '0';
                out_1 <= '0';
                out_2 <= '1';
            end if;
     end process;
           


end Behavioral;
