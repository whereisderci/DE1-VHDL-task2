----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2024 09:46:53 AM
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
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_enable is
    generic (
            period : integer := 6
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable;

architecture Behavioral of clock_enable is
    --! Get number for needed bits for PERIOD value
    constant bits_needed : integer := integer(ceil(log2(real(PERIOD + 1))));

    --! Local counter with needed number of bits
    signal sig_count : std_logic_vector(bits_needed - 1 downto 0);

begin
    --! Generate clock enable signal. By default, enable signal
    --! is low and generated pulse is always one clock long.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            if rst='1' then

                sig_count <= (others => '0');
                pulse <= '0';

            elsif sig_count = period-1 then
                sig_count <= (others => '0');
                pulse <= '1';

            else
                sig_count <= sig_count + 1;
                pulse <= '0';

            end if;
        end if;

    end process p_clk_enable;

end Behavioral;