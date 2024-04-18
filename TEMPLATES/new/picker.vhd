----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2024 18:00:01
-- Design Name: 
-- Module Name: picker - Behavioral
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

entity picker is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           s0 : out STD_LOGIC;
           s1 : out STD_LOGIC);
end picker;

architecture Behavioral of picker is
signal round : integer := 0;
signal central_count : integer := 0;
signal pseu_block : integer := 0;
signal switch_block : integer := 0;
            
begin
    process(clk)
        begin
            if rising_edge(clk) then
                if rst = '1' then
                elsif en = '1' then
                    if (pseu_block = 0) and (switch_block = 0) and (round = 0) and (central_count <= 2)then
                        s0 <= '1';
                        s1 <= '0';
                        central_count <= central_count + 1;
                    end if;
                    
                    if (pseu_block = 1) then 
                        s0 <= '0';
                        s1 <= '1';
                        
                        
                        
                    
                   
                        
                        
                        
                    

end Behavioral;
