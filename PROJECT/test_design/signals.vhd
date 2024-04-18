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
    target_frequencyA    :   integer := 440; -- Default to A (440 Hz)
    target_frequencyG    :   integer := 392; -- Default to A (440 Hz)
    target_frequencyC    :   integer := 261; -- Default to A (440 Hz)
    target_frequencyE    :   integer := 659; -- Default to A (440 Hz)
    clock_frequency :   integer := 100_000_000
        );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           tone_outA : out STD_LOGIC;
           tone_outG : out STD_LOGIC;
           tone_outC : out STD_LOGIC;
           tone_outE : out STD_LOGIC);
end signals;

architecture Behavioral of signals is

-- Calculate toggle rate to achieve the target frequency from the input clock frequency
constant toggle_countA   :   integer := clock_frequency/(2*target_frequencyA)-1;
constant toggle_countG   :   integer := clock_frequency/(2*target_frequencyG)-1;
constant toggle_countC   :   integer := clock_frequency/(2*target_frequencyC)-1;
constant toggle_countE   :   integer := clock_frequency/(2*target_frequencyE)-1;

signal counterA           :   integer range 0 to toggle_countA := 0;
signal counterG           :   integer range 0 to toggle_countG := 0;
signal counterC           :   integer range 0 to toggle_countC := 0;
signal counterE           :   integer range 0 to toggle_countE := 0;

signal tone_signalA      :   STD_LOGIC := '0';
signal tone_signalG      :   STD_LOGIC := '0';
signal tone_signalC      :   STD_LOGIC := '0';
signal tone_signalE      :   STD_LOGIC := '0';

begin

    process(clk, reset)
        begin
            --A
            if reset = '1' then
                counterA <= 0;
                tone_signalA <= '0';
             elsif rising_edge(clk) then
                if counterA >= toggle_countA then
                    counterA <= 0;
                    tone_signalA <= NOT tone_signalA;
                 else
                    counterA <= counterA + 1;
                 end if;
               end if;
               
               --G
               if reset = '1' then
                counterG <= 0;
                tone_signalG <= '0';
             elsif rising_edge(clk) then
                if counterG >= toggle_countG then
                    counterG <= 0;
                    tone_signalG <= NOT tone_signalG;
                 else
                    counterG <= counterG + 1;
                 end if;
               end if;
               --C
               if reset = '1' then
                counterC <= 0;
                tone_signalC <= '0';
             elsif rising_edge(clk) then
                if counterC >= toggle_countC then
                    counterC <= 0;
                    tone_signalC <= NOT tone_signalC;
                 else
                    counterC <= counterC + 1;
                 end if;
               end if;
               --E
               if reset = '1' then
                counterE <= 0;
                tone_signalE <= '0';
             elsif rising_edge(clk) then
                if counterE >= toggle_countE then
                    counterE <= 0;
                    tone_signalE <= NOT tone_signalE;
                 else
                    counterE <= counterE + 1;
                 end if;
               end if;
               
            end process;
            
            tone_outA <= tone_signalA;
            tone_outG <= tone_signalG;
            tone_outC <= tone_signalC;
            tone_outE <= tone_signalE;
            

end Behavioral;
