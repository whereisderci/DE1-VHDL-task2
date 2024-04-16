----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2024 16:10:41
-- Design Name: 
-- Module Name: signal_G1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity signal_G1 is
    Port (
        clk : in STD_LOGIC;
        output_G1 : out STD_LOGIC
    );
end signal_G1;

architecture Behavioral of signal_G1 is

    -- Signal declarations
    signal signal_G1 : STD_LOGIC := '0';
    signal r_counter : unsigned(20 downto 0) := (others => '0'); -- 16 bits wide
    
    constant OUT_FREQ  :    natural := 98;
    
    constant TOGGLE_COUNT : natural := 100_000_000 / (2 * OUT_FREQ);
begin

    -- Process to generate 40 Hz output from 100 MHz input clock
    --100MHz / 12_50_000/ 2 = 40Hz
    process(clk)
    begin
        if rising_edge(clk) then
            if r_counter >= TOGGLE_COUNT then
                r_counter <= (others => '0');
                signal_G1 <= not signal_G1;
            else
                r_counter <= r_counter + 1;
            end if;
        end if;
    end process;

    -- Output assignment
    output_G1 <= signal_G1;

end Behavioral;
