----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2024 22:18:37
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (3 downto 0);
           AN : out STD_LOGIC_VECTOR (1 downto 0);
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0);
           CA  : out STD_LOGIC;
           CB  : out STD_LOGIC;
           CC  : out STD_LOGIC;
           CD  : out STD_LOGIC;
           CE  : out STD_LOGIC;
           CF  : out STD_LOGIC;
           CG  : out STD_LOGIC);
           
end top_level;

architecture Behavioral of top_level is

    signal  btn_debounced   :   STD_LOGIC;
    signal  clk_en          :   STD_LOGIC;
    signal  bin_value       :   STD_LOGIC_VECTOR(3 downto 0);
    signal  seg_signal      :   STD_LOGIC_VECTOR(6 downto 0);
    
    -- Signals to represent the generated tones from switches
    signal tone_A, tone_B, tone_C, tone_D   :   STD_LOGIC;

component clock_enable
generic (
   PERIOD : integer
);
port (
   clk : in std_logic;
   rst : in std_logic;
   pulse : out std_logic
);
end component;


 -- Component declaration for bin2se	
component bin2seg is
        port (
            clear : in    std_logic;
            bin   : in    std_logic_vector(3 downto 0);
            seg   : out   std_logic_vector(6 downto 0)
        );
    end component;
begin

    -- Instantiate debounce component
    debouncer   :    debounce
        generic map(
            PERIOD => 200_000   -- Value for 5ms debounce time at 100MHz clock
                    )
        port map (
            clk => clk,
            rst => reset,
            bouncey => BTNC,
            clear => btn_debounced
                 );
                 
       -- Instantiate clock enable component
       Clock_enabler    :   clock_enable
        generic map (
            PERIOD => 25_000_000
                    )
        port map (
            clk => clk,
            rst => reset,
            pulse => clk_en
                 );
        -- Instantiate binary to 7-segment converter component
        display : component bin2seg
        port map (
            clear  => BTNC,
            bin    => sig_count_4bit,
            seg(6) => CA,
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG
        );

end Behavioral;
