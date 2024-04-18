----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2024 22:00:59
-- Design Name: 
-- Module Name: clock_enable - Behavioral
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

entity clock_enable is
    generic(
        PERIOD :    integer := 3
    );
    
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end entity clock_enable;

architecture Behavioral of clock_enable is

    signal sig_count    :   integer range 0 to PERIOD - 1;
    
begin

    clock_e : process (clk) is
    begin
    
        if (rising_edge(clk)) then
            if (rst = '1') then
                sig_count <= 0;
            elsif (sig_count < (PERIOD - 1)) then
                sig_count <= sig_count + 1;
                
             else
                sig_count <= 0;
             end if;
          end if;
             
      end process clock_e;
      
      pulse <= '1' when (sig_count = PERIOD - 1) else
               '0';       
            
end Behavioral;
