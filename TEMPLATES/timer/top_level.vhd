----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 01:40:48 PM
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
    Port ( BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 2);
           AN0 : out STD_LOGIC;
           AN1 : out STD_LOGIC;
           LED16_B : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is

component clock_enable is
    generic (
            period : integer := 6
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end component;

component debounce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           bouncey : in STD_LOGIC;
           sticky : out STD_LOGIC);
end component;

component simple_counter is
    generic (
            FrequencyHz : integer := 100000000;
            N : integer := 4
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (N-1 downto 0);
           dec : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component bin2seg is
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg1 : out STD_LOGIC_VECTOR (6 downto 0);
           seg2 : out STD_LOGIC_VECTOR (6 downto 0);
           dec : in STD_LOGIC_VECTOR (3 downto 0));
end component;

component seg_display is
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
end component;

signal sig_en_2ms : std_logic;
signal sig_sticky : std_logic;
signal sig_count : STD_LOGIC_VECTOR (3 downto 0);
signal sig_seg1 : STD_LOGIC_VECTOR (6 downto 0);
signal sig_seg2 : STD_LOGIC_VECTOR (6 downto 0);
signal sig_dec : STD_LOGIC_VECTOR (3 downto 0);


begin

clk_enable : clock_enable
    generic map(
            period => 200000
            )
    port map(
            clk => CLK100MHZ,
            rst => BTND,
            pulse => sig_en_2ms
            );
            
deb : debounce
    port map ( clk => CLK100MHZ,
           rst => BTND,
           en => sig_en_2ms,
           bouncey => BTNC,
           sticky => sig_sticky
           );
           
count : simple_counter
    generic map (
            FrequencyHz => 100000000,
            N => 4
            )
    port map ( 
            clk => CLK100MHZ,
            rst => BTND,
            en => sig_sticky,
            count => sig_count,
            dec => sig_dec
            );
            
b2s : bin2seg 
    port map ( 
            clear => BTND,
            bin => sig_count,
            seg1 => sig_seg1,
            seg2 => sig_seg2,
            dec => sig_dec
           );
           
disp : seg_display 
    generic map (
            FrequencyHz => 1000000
            )
    port map ( 
            clk => CLK100MHZ,
            en => sig_en_2ms,
            seg1 => sig_seg1,
            seg2 => sig_seg2,
            seg(6) => CA,
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG,
            AN0 => AN0,
            AN1 => AN1
            );
            
 AN <= "111111";
 
 DP <= '1';
 
 LED16_B <= sig_sticky;


end Behavioral;
