library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity rozdvoj is
    Port ( inp : in STD_LOGIC;
           outp : out STD_LOGIC);
           --n_outp : out STD_LOGIC);
end rozdvoj;

architecture Behavioral of rozdvoj is

begin
    outp <= inp;
    --n_outp <= not(inp);

end Behavioral;
