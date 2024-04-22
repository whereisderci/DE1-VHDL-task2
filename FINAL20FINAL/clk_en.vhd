library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity clk_enable is
    generic (
        N_PERIODS : integer := 2 --100000
    );
    port (
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        --en    : in    std_logic;
        pulse : out   std_logic := '0'  
    );
end entity clk_enable;

-------------------------------------------------

architecture behavioral of clk_enable is

    signal sig_count : integer range 0 to N_PERIODS - 1;
begin


    p_clk_enable : process (clk) is
    begin

        if (rising_edge(clk)) then                   
            if (rst = '1') then                     
                sig_count <= 0;
                pulse <= '0';
           
            --elsif (en = '1') then
            else
                if (sig_count < (N_PERIODS - 1)) then
                    sig_count <= sig_count + 1; 
                    pulse <= '0';
                else 
                    pulse <= '1';
                    sig_count <= 0;
                end if;        
            --else
                --sig_count <= sig_count;
            end if;                                 
        end if;

    end process p_clk_enable;

 
--    pulse <= '1' when (sig_count = N_PERIODS - 1) else
--             '0';

end architecture behavioral;