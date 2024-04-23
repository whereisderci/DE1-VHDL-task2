library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity cleaner2 is
    generic(N_PERIOD : integer);
    Port ( clk : in STD_LOGIC;
           rst : in std_logic;
           outp : out STD_LOGIC);
end cleaner2;

architecture Behavioral of cleaner2 is
signal count : integer range 0 to (N_PERIOD - 1);
begin
    process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then         
                    outp <= '0';
                    count <= 0;
                else
                    if count < (N_PERIOD - 1) then 
                        count <= count + 1;
                        outp <= '0';
                    else
                        count <= 0;
                        outp <= '1';
                    end if;
                end if;
                        
                          
--            else    
--                    outp <= '0';
            end if;
    end process;       

end Behavioral;
