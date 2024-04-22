-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 22.4.2024 17:57:30 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (BTND          : in std_logic;
              BTNC          : in std_logic;
              CLK100MHZ     : in std_logic;
              SW            : in std_logic_vector (8 downto 0);
              CA            : out std_logic;
              CB            : out std_logic;
              CC            : out std_logic;
              CD            : out std_logic;
              CE            : out std_logic;
              CF            : out std_logic;
              CG            : out std_logic;
              DP            : out std_logic;
              AN            : out std_logic_vector (7 downto 2);
              AN0           : out std_logic;
              AN1           : out std_logic;
              LED16_B       : out std_logic;
              LED           : out std_logic_vector (8 downto 0);
              output_drumA1 : out std_logic;
              output_drumB1 : out std_logic;
              output_drumC1 : out std_logic;
              output_drumD1 : out std_logic;
              output_drumE1 : out std_logic;
              output_drumF1 : out std_logic;
              output_drumG1 : out std_logic;
              output_song   : out std_logic);
    end component;

    signal BTND          : std_logic;
    signal BTNC          : std_logic;
    signal CLK100MHZ     : std_logic;
    signal SW            : std_logic_vector (8 downto 0);
    signal CA            : std_logic;
    signal CB            : std_logic;
    signal CC            : std_logic;
    signal CD            : std_logic;
    signal CE            : std_logic;
    signal CF            : std_logic;
    signal CG            : std_logic;
    signal DP            : std_logic;
    signal AN            : std_logic_vector (7 downto 2);
    signal AN0           : std_logic;
    signal AN1           : std_logic;
    signal LED16_B       : std_logic;
    signal LED           : std_logic_vector (8 downto 0);
    signal output_drumA1 : std_logic;
    signal output_drumB1 : std_logic;
    signal output_drumC1 : std_logic;
    signal output_drumD1 : std_logic;
    signal output_drumE1 : std_logic;
    signal output_drumF1 : std_logic;
    signal output_drumG1 : std_logic;
    signal output_song   : std_logic;

    constant TbPeriod : time := 10000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level
    port map (BTND          => BTND,
              BTNC          => BTNC,
              CLK100MHZ     => CLK100MHZ,
              SW            => SW,
              CA            => CA,
              CB            => CB,
              CC            => CC,
              CD            => CD,
              CE            => CE,
              CF            => CF,
              CG            => CG,
              DP            => DP,
              AN            => AN,
              AN0           => AN0,
              AN1           => AN1,
              LED16_B       => LED16_B,
              LED           => LED,
              output_drumA1 => output_drumA1,
              output_drumB1 => output_drumB1,
              output_drumC1 => output_drumC1,
              output_drumD1 => output_drumD1,
              output_drumE1 => output_drumE1,
              output_drumF1 => output_drumF1,
              output_drumG1 => output_drumG1,
              output_song   => output_song);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        BTND <= '0';
        BTNC <= '0';
        SW <= (others => '0');

        -- Reset generation
        --  EDIT: Replace BTND below by the name of your reset as I haven't guessed it
        BTND <= '1';
        wait for 100 ns;
        BTND <= '0';
        BTNC <= '1';
        wait for 10 * TbPeriod;
        
        BTNC <= '1';
        BTND <= '0';
        BTNC <= '1';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top_level of tb_top_level is
    for tb
    end for;
end cfg_tb_top_level;