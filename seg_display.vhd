----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 01:28:02 PM
-- Design Name: 
-- Module Name: seg_display - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg_display is
    generic (
            FrequencyHz : integer := 1000000
            );
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           seg1 : in STD_LOGIC_VECTOR (6 downto 0);
           seg2 : in STD_LOGIC_VECTOR (6 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           AN0 : out STD_LOGIC;
           AN1 : out STD_LOGIC);
end seg_display;

architecture Behavioral of seg_display is

signal tick: integer range 0 to FrequencyHz - 1 := 0;
signal sig_100HZ: std_logic :='0';

begin

    delay : process (clk) is
    begin
        if rising_edge(clk) then
             if tick = FrequencyHz - 1 then
                tick <= 0;
                if sig_100HZ = '0' then 
                    sig_100HZ <= '1';
                else
                    sig_100HZ <= '0';
                end if;
            else
                tick <= tick + 1;
            end if;
        end if;
   
    end process delay;
    
    ANsw: process (sig_100HZ) is
    begin
        if sig_100HZ = '0' then
            AN0 <= '0';
            AN1 <= '1';
        elsif sig_100HZ = '1' then
            AN0 <= '1';
            AN1 <= '0';
        end if;
    
    end process ANsw;
    
    segsw: process (sig_100HZ) is
    begin
        if sig_100HZ = '0' then
            seg <= seg1;
        elsif sig_100HZ = '1' then
            seg <= seg2;
        end if;
    
    end process segsw;

end Behavioral;