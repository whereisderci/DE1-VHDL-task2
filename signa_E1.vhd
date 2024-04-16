----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2024 16:05:04
-- Design Name: 
-- Module Name: signa_E1 - Behavioral
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

entity signal_E1 is
    Port (
        clk : in STD_LOGIC;
        output_E1 : out STD_LOGIC
    );
end signal_E1;

architecture Behavioral of signal_E1 is

    -- Signal declarations
    signal signal_E1 : STD_LOGIC := '0';
    signal r_counter : unsigned(20 downto 0) := (others => '0'); -- 16 bits wide
    
    constant OUT_FREQ  :    natural := 82;
    
    constant TOGGLE_COUNT : natural := 100_000_000 / (2 * OUT_FREQ);
begin

    -- Process to generate 40 Hz output from 100 MHz input clock
    --100MHz / 12_50_000/ 2 = 40Hz
    process(clk)
    begin
        if rising_edge(clk) then
            if r_counter >= TOGGLE_COUNT then
                r_counter <= (others => '0');
                signal_E1 <= not signal_E1;
            else
                r_counter <= r_counter + 1;
            end if;
        end if;
    end process;

    -- Output assignment
    output_E1 <= signal_E1;

end Behavioral;
