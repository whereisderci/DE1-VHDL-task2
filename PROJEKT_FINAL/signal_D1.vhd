----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2024 16:03:40
-- Design Name: 
-- Module Name: signal_D1 - Behavioral
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

entity signal_D1 is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        output_D1 : out STD_LOGIC
    );
end signal_D1;

architecture Behavioral of signal_D1 is

    -- Signal declarations
   
    
    constant OUT_FREQ  :    natural := 73;
    constant TOGGLE_COUNT : natural := 100_000_000 / (2 * OUT_FREQ);
    
    signal signal_D1 : STD_LOGIC := '0';
    signal r_counter : integer range 0 to TOGGLE_COUNT - 1;
begin

    -- Process to generate 40 Hz output from 100 MHz input clock
    --100MHz / 12_50_000/ 2 = 40Hz
    process(clk)
    begin
        if rising_edge(clk) then
                if (rst = '1') then
                    r_counter <= 0;
                
                elsif r_counter <= TOGGLE_COUNT then
                    r_counter <= r_counter + 1;
                else
                    r_counter <= 0;
                    signal_D1 <= not signal_D1;
                end if;
             
        end if;
    end process;

    -- Output assignment
    output_D1 <= signal_D1;

end Behavioral;
