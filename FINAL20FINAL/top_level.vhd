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
           SW :   in  STD_LOGIC_VECTOR (8 downto 0);
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
           LED  :   out STD_LOGIC_VECTOR (8 downto 0);
           output_drumA1   :   out STD_LOGIC;
           output_drumB1    :   out STD_LOGIC;
           output_drumC1   :   out STD_LOGIC;
           output_drumD1    :   out STD_LOGIC;
           output_drumE1   :   out STD_LOGIC;
           output_drumF1    :   out STD_LOGIC;
           output_drumG1    :   out STD_LOGIC;
           output_song  :   out STD_LOGIC
           
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

    signal signal_LED_out   :   STD_LOGIC_VECTOR (8 downto 0);

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
            seg1   : out   std_logic_vector(6 downto 0);
            seg2   : out   std_logic_vector(6 downto 0)
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
            FREQ_OUT    :   integer := 50
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_A1  :   out std_logic
         );
    end component;
    
    component signal_B1 is
        generic (
            FREQ_OUT    :   integer := 5
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_B1  :   out std_logic
         );
    end component;
    
    component signal_C1 is
        generic (
            FREQ_OUT    :   integer := 50
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_C1  :   out std_logic
         );
    end component;
    
    component signal_D1 is
        generic (
            FREQ_OUT    :   integer := 5
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_D1  :   out std_logic
         );
    end component;
    
    component signal_E1 is
        generic (
            FREQ_OUT    :   integer := 50
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_E1  :   out std_logic
         );
    end component;
    
    component signal_F1 is
        generic (
            FREQ_OUT    :   integer := 5
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_F1  :   out std_logic
         );
    end component;
    
    component signal_G1 is
        generic (
            FREQ_OUT    :   integer := 50
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         output_G1  :   out std_logic
         );
    end component;
    
    --LED Control
    component LED_controller is
        generic(
            BLINK_FREQ  :   integer := 2
        );
        port (
            clk         :   in STD_LOGIC;
            rst         :   in STD_LOGIC;
            LED_out     :   out STD_LOGIC_VECTOR (8 downto 0)
        );
    end component;


-- Song components declaration

    component many_tone_signal is
        port(
           clk : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in std_logic;
           sw_01 : in STD_LOGIC;
           sw_02 : in STD_LOGIC;
           loop_on : in std_logic;
           A_out : out STD_LOGIC;
           G_out : out STD_LOGIC;
           C_out : out STD_LOGIC
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
            seg1(6) => CA,
            seg1(5) => CB,
            seg1(4) => CC,
            seg1(3) => CD,
            seg1(2) => CE,
            seg1(1) => CF,
            seg1(0) => CG,
            seg2(6) => CA,
            seg2(5) => CB,
            seg2(4) => CC,
            seg2(3) => CD,
            seg2(2) => CE,
            seg2(1) => CF,
            seg2(0) => CG
        );
        
        DRUMA1  :   signal_A1
            port map (
                clk => BTNC,
                rst => BTND,
                output_A1 => output_drumA1
                
            );
            
         DRUMB1  :   signal_B1
            port map (
                clk => BTNC,
                rst => BTND,
                output_B1 => output_drumB1
                
            );
            
            DRUMC1  :   signal_C1
            port map (
                clk => BTNC,
                rst => BTND,
                output_C1 => output_drumC1
                
            );
            
         DRUMD1  :   signal_D1
            port map (
                clk => BTNC,
                rst => BTND,
                output_D1 => output_drumD1
                
            );
            
            DRUME1  :   signal_E1
            port map (
                clk => BTNC,
                rst => BTND,
                output_E1 => output_drumE1
                
            );
            
         DRUMG1  :   signal_G1
            port map (
                clk => BTNC,
                rst => BTND,
                output_G1 => output_drumG1
                
            );
            
            
            
         LED_o  :   LED_controller
            port map (
                clk => CLK100MHz,
                rst => BTND,
                LED_out => LED
            );
            
            SONG    :   many_tone_signal
                port map(
                clk => CLK100MHz,
                BTND => BTND,
                BTNC => BTNC,
                sw_01 => SW(0),
                sw_02 => SW(1),
                loop_on => BTNC
                
                );
            
          
    
    AN <= "111111";
 
    DP <= '1';
 
    LED16_B <= sig_sticky;
    
    LED <= SW;
    
    output_drumA1 <= SW(2);
    output_drumB1 <= SW(3);
    output_drumC1 <= SW(4);
    output_drumD1 <= SW(5);
    output_drumE1 <= SW(6);
    output_drumF1 <= SW(7);
    output_drumG1 <= SW(8);
    
end Behavioral;