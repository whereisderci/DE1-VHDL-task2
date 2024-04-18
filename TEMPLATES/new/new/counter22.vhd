library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity clk_enable2 is
    generic (
        N_PERIODS : integer := 3 
    );
    port (
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic  
    );
end entity clk_enable2;

-------------------------------------------------

architecture behavioral of clk_enable2 is

    signal sig_count : integer range 0 to N_PERIODS - 1;
begin


    p_clk_enable : process (clk) is
    begin

        if clk = '1' then                   
            if (rst = '1') then                     
                sig_count <= 0;

           
            elsif (sig_count < (N_PERIODS - 1)) then
                sig_count <= sig_count + 1;          

  
            else
                sig_count <= 0;
            end if;                                 
        end if;

    end process p_clk_enable;

 
    pulse <= '1' when (sig_count = N_PERIODS - 1) else
             '0';

end architecture behavioral;