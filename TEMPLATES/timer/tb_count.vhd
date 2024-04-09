-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 4.4.2024 14:24:51 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_simple_counter is
end tb_simple_counter;

architecture tb of tb_simple_counter is

    component simple_counter
        port (clk   : in std_logic;
              rst   : in std_logic;
              en    : in std_logic;
              count : out std_logic_vector (3 downto 0);
              dec   : out std_logic_vector (3 downto 0));
    end component;

    signal sig_clk   : std_logic;
    signal sig_rst   : std_logic;
    signal sig_en    : std_logic;
    signal sig_count : std_logic_vector (3 downto 0);
    signal sig_dec   : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : simple_counter
    port map (clk   => sig_clk,
              rst   => sig_rst,
              en    => sig_en,
              count => sig_count,
              dec   => sig_dec);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    sig_clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        sig_rst <= '1';
        sig_en <= '0';
        wait for 100 ns;
        sig_en <= '1';

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_simple_counter of tb_simple_counter is
    for tb
    end for;
end cfg_tb_simple_counter;