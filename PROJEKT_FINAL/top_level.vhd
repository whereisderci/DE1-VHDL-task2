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
           SW0 :   in  STD_LOGIC;
           SW1 :   in  STD_LOGIC;
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
           LED0  :   out STD_LOGIC;
           LED1  :   out STD_LOGIC;

           output_drumA1   :   out STD_LOGIC;
           output_drumB1   :   out STD_LOGIC;           
           output_song_o1  :   out STD_LOGIC;
           output_song_o2  :   out STD_LOGIC;
           output_song_o3  :   out STD_LOGIC
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
    
    signal signals_A1 : STD_LOGIC;
    signal signals_B1 : STD_LOGIC;
    
    signal fr_01 : std_logic;
    signal fr_02 : std_logic;
    signal fr_03 : std_logic;

    signal signal_LED_out   :   STD_LOGIC;

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
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg1 : out STD_LOGIC_VECTOR (6 downto 0);
           seg2 : out STD_LOGIC_VECTOR (6 downto 0);
           dec : in STD_LOGIC_VECTOR (3 downto 0));
end component;
    
 -- Component declaration for simple_counter	
    component simple_counter is
    generic (
            FrequencyHz : integer := 100000000
            
            );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
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
            OUT_FREQ    :   integer := 50
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         en         :   in STD_LOGIC;
         output_A1  :   out std_logic
         );
    end component;
    
    component signal_B1 is
        generic (
            OUT_FREQ    :   integer := 5
            );
         port (
         clk        :   in std_logic;
         rst      :   in std_logic;
         en         :   in STD_LOGIC;
         output_B1  :   out std_logic
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
            LED_out     :   out STD_LOGIC
        );
    end component;


-- Song components declaration

    component beta is
        port(
           CLK100MHZ : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in std_logic;
           --sw_01 : in STD_LOGIC;
          -- sw_02 : in STD_LOGIC;
           OUTP1 : out STD_LOGIC;
           OUTP2 : out STD_LOGIC;
           OUTP3 : out STD_LOGIC
        );
    end component;
    
begin

    -- Instantiate debounce component
     debouncer : debounce
        port map ( clk => CLK100MHZ,
           rst => BTND,
           en => clk_en,
           bouncey => BTNC,
           sticky => sig_sticky
           );
                 
       -- Instantiate clock enable component
     Clock_enabler    :   clock_enable
        generic map (
            PERIOD => 25_000
                    )
        port map (
            clk => CLK100MHZ,
            rst => BTND,
            pulse => clk_en
                 );
                 
     count : simple_counter
        generic map (
            FrequencyHz => 100000000
            )
        port map ( 
            clk => CLK100MHZ,
            rst => BTND,
            en => sig_sticky,
            count => sig_count,
            dec => sig_dec
            );
            
        -- Instantiate binary to 7-segment converter component
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
        
        DRUMA1  :   signal_A1
        generic map (
            OUT_FREQ => 50
            )
            port map (
                clk => CLK100MHZ,
                rst => BTND,
                en =>SW0,
                output_A1 => signals_A1
                
            );
            
         DRUMB1  :   signal_B1
         generic map (
            OUT_FREQ => 10
            )
            port map (
                clk => CLK100MHZ,
                rst => BTND,
                en => SW1,
                output_B1 => signals_B1
                
            );
            
           
            
            
         LED_o  :   LED_controller
            port map (
                clk => CLK100MHZ,
                rst => BTND,
                LED_out => signal_LED_out
            );
            
            SONG    :   beta
                port map(
                CLK100MHZ => CLK100MHZ,
                BTND => BTND,
                BTNC => sig_sticky,
                OUTP1 => fr_01,
                OUTP2 => fr_02,
                OUTP3 => fr_03
                
                );
            
          
    
    AN <= "111111";
 
    DP <= '1';
 
    LED16_B <= sig_sticky;
    --LED output
    LED0 <= SW0;
    LED1 <= SW1;
    --LED <= SW(2);
    --LED <= SW(3);
    --LED <= SW(4);
    --LED <= SW(5);
    --LED <= SW(6);
    --LED <= SW(7);
    --LED <= SW(8);
   -- LED <= signal_LED_out;
  
  output_drumA1 <= signals_A1;
  output_drumB1 <= signals_B1;
  

  
  output_song_o1 <= fr_01;
  output_song_o2 <= fr_02; 
  output_song_o3 <= fr_03;
  
  
  
end Behavioral;