----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2024 21:03:49
-- Design Name: 
-- Module Name: signals - Behavioral
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
use IEEE.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signals is
generic(
    target_frequency    :   integer := 440; -- Default to A (440 Hz)
    clock_frequency :   integer := 100_000_000
        );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           tone_out : out STD_LOGIC);
end signals;

architecture Behavioral of signals is

-- Calculate toggle rate to achieve the target frequency from the input clock frequency
constant toggle_count   :   integer := clock_frequency/(2*target_frequency)-1;
signal counter          :   integer range 0 to toggle_count := 0;
signal tone_signal      :   STD_LOGIC := '0';

begin

    process(clk, reset)
        begin
            if reset = '1' then
                counter <= 0;
                tone_signal <= '0';
             elsif rising_edge(clk) then
                if counter >= toggle_count then
                    counter <= 0;
                    tone_signal <= NOT tone_signal;
                 else
                    counter <= counter + 1;
                 end if;
               end if;
            end process;
            
            tone_out <= tone_signal;
            

end Behavioral;
