-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 4.4.2024 14:06:17 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (clear : in std_logic;
              bin   : in std_logic_vector (3 downto 0);
              seg1  : out std_logic_vector (6 downto 0);
              seg2  : out std_logic_vector (6 downto 0);
              dec   : in std_logic_vector (3 downto 0));
    end component;

    signal clear : std_logic;
    signal bin   : std_logic_vector (3 downto 0);
    signal seg1  : std_logic_vector (6 downto 0);
    signal seg2  : std_logic_vector (6 downto 0);
    signal dec   : std_logic_vector (3 downto 0);

begin

    dut : bin2seg
    port map (clear => clear,
              bin   => bin,
              seg1  => seg1,
              seg2  => seg2,
              dec   => dec);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        clear <= '1';
        bin <= (others => '0');
        dec <= (others => '0');
        wait for 100 ns;
        clear <= '0';
        wait for 10 ns;
        bin <= x"0";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"0";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"1";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"2";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"3";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"4";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"1";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"2";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"3";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"4";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"5";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"6";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"7";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"8";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"9";
        dec <= x"5";
        wait for 10 ns;
        bin <= x"0";
        dec <= x"6";

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2seg of tb_bin2seg is
    for tb
    end for;
end cfg_tb_bin2seg;