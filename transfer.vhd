library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity transfer is
    Port ( inp : in STD_LOGIC;
           outp : out STD_LOGIC;
           n_outp : out std_logic
           );
end transfer;

architecture Behavioral of transfer is

begin
    process
        begin
            outp <= inp;
            n_outp <= not inp;
    end process;

end Behavioral;