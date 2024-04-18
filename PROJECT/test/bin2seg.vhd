----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 03:21:30 PM
-- Design Name: 
-- Module Name: bin2seg - Behavioral
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

entity bin2seg is
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end bin2seg;

architecture Behavioral of bin2seg is

begin
    
    p_7seg_decoder : process (bin, clear) is
    begin
    
      if (clear = '1') then
        seg <= "1111111";  -- Clear the display
      else
    
        case bin is
          when x"0" =>     -- x"0" means "0000" in hexadec.
            seg <= "0000001";
            
          when x"1" =>      -- x"1" means "0001" in hexadec.
            seg <= "1001111";
    
           when x"2" =>     -- x"2" means "0010" in hexadec.
            seg <= "0010010";
            
          when x"3" =>      -- x"3" means "0011" in hexadec.
            seg <= "0000110";
            
            
          when x"4" =>     -- x"4" means "0100" in hexadec.
            seg <= "1001100";
            
          when x"5" =>      -- x"5" means "0101" in hexadec.
            seg <= "0100100";
            
          when x"6" =>     -- x"6" means "0110" in hexadec.
            seg <= "0100000";
    
          when x"7" =>      -- x"7" means "0111" in hexadec.
            seg <= "0001111";
            
          when x"8" =>      -- x"0" means "1000" in hexadec.
            seg <= "0000000";
    
          when x"9" =>      -- x"9" means "1001" in hexadec.
            seg <= "0000100";
          
          when x"A" =>     -- x"A" means "1010" in hexadec.
            seg <= "0001000";
            
          when x"b" =>      -- x"b" means "1011" in hexadec.
            seg <= "1100000";
            
          when x"C" =>      -- x"C" means "1100" in hexadec.
            seg <= "0110001";
            
          when x"d" =>      -- x"d" means "1101" in hexadec.
            seg <= "1000010";
    
          when x"E" =>      -- x"E" means "1110" in hexadec.
            seg <= "0110000";
            
          when others =>        --  means "1111" in hexadec.
            seg <= "0111000";
            
        end case;
    
      end if;    
    end process p_7seg_decoder;
    
end Behavioral;

