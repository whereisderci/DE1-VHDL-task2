----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2024 09:14:34 AM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           bouncey : in STD_LOGIC;
           sticky : out STD_LOGIC);
end debounce;

architecture behavioral of debounce is
    -- Define states for the FSM
    type   state_type is (OFF, PRE_ON, ONN, PRE_OFF);
    signal state : state_type;

    -- Define number of periods for debounce counter
    constant DEB_COUNT : integer := 5;

    -- Define signals for debounce counter
    signal sig_count : integer range 0 to DEB_COUNT;

    -- Debounced signal
    signal sig_clean : std_logic;
    
    signal sig_just_pressed : std_logic;
    
begin


    
    -- Process implementing a finite state machine (FSM) for
    -- button debouncing. Handles transitions between different
    -- states based on clock signal and bouncey button input.
    p_fsm : process (clk) is
    begin

        if rising_edge(clk) then
            if (bouncey = '0') then
                sig_just_pressed <= '0';
            end if;
            -- Active-high reset
            if (rst = '1') then
                state <= OFF;
            -- Clock enable
            elsif (en = '1') then
                -- Define transitions between states
                case state is

                    when OFF =>
                        -- If bouncey button = 1 then clear counter and change to PRE_PRESSED;
                        if bouncey = '1' then
                            if (sig_just_pressed = '0') then
                                sig_count <= 0;
                                state <= PRE_ON;
                            end if;
                        end if;

                    when PRE_ON =>
                        -- If button = 1 increment counter
                        if bouncey = '1' then
                                sig_count <= sig_count + 1;

                                -- if counter = DEB_COUNT-1 change to PRESSED
                                if sig_count = DEB_COUNT - 1 then
                                    state <= ONN;
                                    sig_just_pressed <= '1';
                                end if;

                        -- else change to RELEASED
                        else
                            state <= OFF;
                        end if;

                    when ONN =>
                        -- If button = 0 then clear counter and change to PRE_RELEASED;
                        if bouncey = '1' then
                            if (sig_just_pressed = '0') then
                                sig_count <= 0;
                                state <= PRE_OFF;
                            end if;
                        end if;

                    when PRE_OFF =>
                        -- If button = 0 then increment counter
                        if bouncey = '1' then
                                sig_count <= sig_count + 1;

                                -- if counter = DEB_COUNT-1 change to RELEASED;
                                if sig_count = DEB_COUNT - 1 then
                                    state <= OFF;
                                    sig_just_pressed <= '1';
                                end if;

                        -- else change to PRESSED;
                        else
                            state <= ONN;
                        end if;

                    -- Prevent unhandled cases
                    when others =>
                        null;
                end case;
            end if;
        end if;

    end process p_fsm;

    -- Set clean signal value = 1 when states PRESSED or PRE_RELEASED
    sig_clean <= '1' when (state = ONN or state = PRE_OFF) else '0';

    -- Assign output debounced signal
    sticky <= sig_clean;

end Behavioral;
