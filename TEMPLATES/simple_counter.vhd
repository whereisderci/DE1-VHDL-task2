----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2024 03:08:08 PM
-- Design Name: 
-- Module Name: simple_counter - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_counter is
generic (
        N : integer := 4
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (N-1 downto 0));
end simple_counter;

architecture Behavioral of simple_counter is



    signal sig_count : STD_LOGIC_VECTOR (N-1 downto 0);
    
begin
    
    process (clk)
    begin
       if clk ='1' and clk'event then
          if rst='1' then
             sig_count <= (others => '0');
          elsif en ='1' then
             sig_count <= sig_count + 1;
          end if;
       end if;
    end process;
    
    count <= sig_count;
    
end Behavioral;
