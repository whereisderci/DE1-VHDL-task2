library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity clk_enable2 is
    generic (
        N_PERIODS : integer := 1--33 
    );
    port (
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic := '0' 
    );
end entity clk_enable2;

-------------------------------------------------

architecture behavioral of clk_enable2 is

    signal sig_count : integer range 0 to N_PERIODS - 1;
begin


    p_clk_enable : process (clk) is
    begin

--            if rst = '0' then 
--                pulse <= '0';
--                sig_count <= 0;
--            elsif clk = '1' and clk'event then
--                if (sig_count < (N_PERIODS - 1)) then
--                    sig_count <= sig_count + 1; 
--                    pulse <= '0';
--                else
--                    sig_count <= 0;
--                    pulse <= '1';
--                end if;                                 
--            end if;
                
        if rising_edge(clk) then                   
            if (rst = '1') then                     
                sig_count <= 0;
                pulse <= '1';
           
            elsif (sig_count < (N_PERIODS - 1)) then
                sig_count <= sig_count + 1;  
                pulse <= '0';        
            else
                sig_count <= 0;
                pulse <= '1';
            end if;                                 
        end if;

    end process p_clk_enable;

 
--    pulse <= '1' when (sig_count = N_PERIODS - 1) else
--             '0';

end architecture behavioral;