----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2024 09:07:47 AM
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_counter is
    generic (
            FrequencyHz : integer := 100
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           dec : out STD_LOGIC_VECTOR (3 downto 0));
end simple_counter;

architecture Behavioral of simple_counter is

signal tick: integer range 0 to FrequencyHz - 1 := 0;
signal seconds: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sig_dec: STD_LOGIC_VECTOR (3 downto 0) := "0000";
--signal sig_delayed: std_logic;
--signal pos_edge: std_logic;

begin


--    delay : process (clk) is
--    begin
--        if rising_edge(clk) then
--            sig_delayed <= en;
--        end if;
--    end process delay;
    
--    pos_edge <= en and not sig_delayed;


process (clk)
begin
   if rising_edge(clk) then
--      if pos_edge='1' then
--         tick <= 0;
--         seconds <= (others => '0');
--         sig_dec <= (others => '0');
--      end if;
      if rst='1' then
         tick <= 0;
         seconds <= (others => '0');
         sig_dec <= (others => '0');
      elsif en='1' then
         if tick = FrequencyHz - 1 then
                tick <= 0;
                if seconds = 9 then  -- ADDED MODULUS 4 test for counter
                    seconds <= (others => '0');
                    if sig_dec = 5 then
                        sig_dec <= (others => '0');
                    else
                        sig_dec <= sig_dec + 1;
                    end if;
                else
                    seconds <= seconds + 1;
                end if;
            else
                tick <= tick + 1;
            end if;
      end if;
   end if;
end process;

count <= seconds;

dec <= sig_dec;

end Behavioral;
