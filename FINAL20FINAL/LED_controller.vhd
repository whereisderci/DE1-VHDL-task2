----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2024 09:14:44
-- Design Name: 
-- Module Name: LED_controller - Behavioral
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

entity LED_controller is
   Port (  
           clk : in STD_LOGIC;               -- Hodinový signál
           rst : in STD_LOGIC;             -- Signál pro resetování ?íta??
           LED_out : out STD_LOGIC
         );       
end LED_controller;

architecture Behavioral of LED_controller is
    constant CLK_FREQ : natural := 100_000_000;  -- Frekvence hodinového signálu (nap?. 100 MHz)
    constant BLINK_FREQ : natural := 2;           -- Frekvence blikání LED diody (nap?. 2 Hz)
    constant TOGGLE_COUNT : natural := CLK_FREQ / (2 * BLINK_FREQ);  -- Po?et tik? ?íta?e pro jedno bliknutí LED diody
    signal signal_LED_out : STD_LOGIC := '0';
    signal counter : integer range 0 to TOGGLE_COUNT;  

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
               counter <= 0;  -- Resetovat ?íta?      
               signal_LED_out <= '0';
            end if;
            if counter >= TOGGLE_COUNT then   -- Pokud ?íta? dosáhne požadovaného po?tu tik?
               counter <= 0;
               signal_LED_out <= not signal_LED_out;
            else
                counter <= counter + 1;
                signal_LED_out <= '1';
            end if;
        end if;
     end process;
     LED_out <= signal_LED_out;
end Behavioral;