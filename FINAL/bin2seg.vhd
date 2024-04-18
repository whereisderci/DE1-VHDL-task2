----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 09:13:05 AM
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
use IEEE.std_logic_unsigned.all;

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
           seg1 : out STD_LOGIC_VECTOR (6 downto 0);
           seg2 : out STD_LOGIC_VECTOR (6 downto 0);
           dec : in STD_LOGIC_VECTOR (3 downto 0)
           );
end bin2seg;

architecture Behavioral of bin2seg is

begin

p_7seg_decoder : process (bin, clear) is
begin

  if (clear = '1') then
    seg1 <= "1111111";  -- Clear the display
    seg2 <= "1111111";
  else

    case bin is
      when x"0" =>     -- x"0" means "0000" in hexadec.
        seg1 <= "0000001";
      when x"1" =>
        seg1 <= "1001111";
      when x"2" =>
        seg1 <= "0010010";
      when x"3" =>
        seg1 <= "0000110";
      when x"4" =>
        seg1 <= "1001100";
      when x"5" =>
        seg1 <= "0100100";
      when x"6" =>
        seg1 <= "0100000";
      when x"7" =>
        seg1 <= "0001111";
      when x"8" =>
        seg1 <= "0000000";
      when x"9" =>
        seg1 <= "0000100";
      when others =>
        seg1 <= "0111000";
    end case;
    
    case dec is
      when x"0" =>     -- x"0" means "0000" in hexadec.
        seg2 <= "0000001";
      when x"1" =>
        seg2 <= "1001111";
      when x"2" =>
        seg2 <= "0010010";
      when x"3" =>
        seg2 <= "0000110";
      when x"4" =>
        seg2 <= "1001100";
      when x"5" =>
        seg2 <= "0100100";
      when others =>
        seg2 <= "0111000";
    end case;
    


  end if;    
end process p_7seg_decoder;


end Behavioral;
