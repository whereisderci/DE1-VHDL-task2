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
    Port (
           BTND : in STD_LOGIC;
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
           LED16_B : out STD_LOGIC;
           LED  :   out STD_LOGIC_VECTOR (3 downto 0);
           output_song   :   out STD_LOGIC
           );
           
end top_level;

architecture Behavioral of top_level is

    signal  btn_debounced   :   STD_LOGIC;
    signal  clk_en          :   STD_LOGIC;
    signal  bin_value       :   STD_LOGIC_VECTOR(3 downto 0);
    signal  seg_signal      :   STD_LOGIC_VECTOR(6 downto 0);
    signal sig_count_4bit    :   STD_LOGIC_VECTOR(3 downto 0);
    
    signal sig_en_2ms : std_logic;
    signal sig_sticky : std_logic;
    signal sig_count : STD_LOGIC_VECTOR (3 downto 0);
    signal sig_seg1 : STD_LOGIC_VECTOR (6 downto 0);
    signal sig_seg2 : STD_LOGIC_VECTOR (6 downto 0);
    signal sig_dec : STD_LOGIC_VECTOR (3 downto 0);
    
 -- Signals to represent the generated tones from switches
    signal output_tone : STD_LOGIC_VECTOR(6 downto 0);

component clock_enable is
    generic (
            period : integer := 6
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end component;


 -- Component declaration for bin2se	
    component bin2seg is
        port (
            clear : in    std_logic;
            bin   : in    std_logic_vector(3 downto 0);
            seg   : out   std_logic_vector(6 downto 0)
        );
    end component;
    
 -- Component declaration for simple_counter	
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

        
-- Component declaration for seg_display
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

-- Component declaration for debounce
    component debounce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           bouncey : in STD_LOGIC;
           sticky : out STD_LOGIC);
    end component;

-- Component declaration sound signal A1-G1
    component signal_A1 is
        generic (
            FREQ_OUT    :   integer := 110
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_A1  :   out std_logic
         );
    end component;
    
    component signal_B1 is
        generic (
            FREQ_OUT    :   integer := 123
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_B1  :   out std_logic
         );
    end component;
    
    component signal_C1 is
        generic (
            FREQ_OUT    :   integer := 65
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_C1  :   out std_logic
         );
    end component;
    
    component signal_D1 is
        generic (
            FREQ_OUT    :   integer := 73
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_D1  :   out std_logic
         );
    end component;
    
    component signal_E1 is
        generic (
            FREQ_OUT    :   integer := 82
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_E1  :   out std_logic
         );
    end component;
    
   component signal_F1 is
        generic (
            FREQ_OUT    :   integer := 87
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_F1  :   out std_logic
         );
    end component;
    
    
    component signal_G1 is
        generic (
            FREQ_OUT    :   integer := 98
            );
         port (
         clk        :   in std_logic;
         reset      :   in std_logic;
         output_G1  :   out std_logic
         );
    end component;
    

begin

    -- Instantiate debounce component
     debouncer : debounce
        port map ( clk => CLK100MHZ,
           rst => BTND,
           en => sig_en_2ms,
           bouncey => BTNC,
           sticky => sig_sticky
           );
                 
       -- Instantiate clock enable component
     Clock_enabler    :   clock_enable
        generic map (
            PERIOD => 25_000_000
                    )
        port map (
            clk => CLK100MHZ,
            rst => BTND,
            pulse => clk_en
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
        
        A1  :   signal_A1
            port map (
                clk => BTNC,
                rst => BTND
            );
    
    AN <= "111111";
 
    DP <= '1';
 
    LED16_B <= sig_sticky;
    
    output_song <= output_A1;
    
end Behavioral;