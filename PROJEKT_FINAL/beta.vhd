----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2024 02:06:11
-- Design Name: 
-- Module Name: beta - Behavioral
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

entity beta is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           OUTP1 : out STD_LOGIC;
           OUTP2 : out STD_LOGIC;
           OUTP3 : out STD_LOGIC;
           LED : out STD_LOGIC);
end beta;

architecture Behavioral of beta is

    component my_fsm 
        port(
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           s : out std_logic_vector(1 downto 0)
            );
    end component;
    
    component signals
        generic(toggle_count : integer
                --;target_frequency    :   integer := 440 -- Default to A (440 Hz)
                );
        port(
             clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             r_rst : in std_logic;
             en : in std_logic;
             tone_out : out STD_LOGIC
             );
    end component;

    component demux
    port(
        d : in std_logic;
        s : in std_logic_vector (1 downto 0);
        y0 : out std_logic;
        y1 : out std_logic;
        y2 : out std_logic;
        y3 : out std_logic
        );
    end component;
    
    component clk_enable
        generic(N_PERIODS : integer);
        port(
            clk   : in    std_logic; 
            rst   : in    std_logic; 
            --en    : in    std_logic;
            pulse : out   std_logic  
            );
    end component;
    
    component clk_enable2
        generic(N_PERIODS : integer);
        port(
            clk   : in    std_logic; 
            rst   : in    std_logic; 
            pulse : out   std_logic  
            );
    end component;
    
    component cleaner2
        generic(N_PERIOD : integer);
        port(
            clk   : in std_logic;  
            rst   : in std_logic; 
            --en    : in std_logic;  
            outp : out std_logic 
            ); 
    end component;
    
    component rozdvoj
        port(inp : in std_logic;
            outp : out std_logic
            );
    end component;
    
--    component asyn_to_syn
--        port(
--            clk : in std_logic;
--            rst : in std_logic;
--            outp : out std_logic);
--    end component;

    signal centr_clk : std_logic;
    signal reset : std_logic;
    signal n_reset : std_logic := not reset;
    signal sig_en : std_logic;
    signal fr_01 : std_logic;
    signal fr_02 : std_logic;
    signal fr_03 : std_logic;
    signal sig_s : std_logic_vector(1 downto 0);
    signal y0 : std_logic;
    signal y1 : std_logic;
    signal y2 : std_logic;
    signal y3 : std_logic;
    signal to_song : std_logic;
    signal period_res : std_logic;
--    signal a_t_s_01 : std_logic;
--    signal a_t_s_02 : std_logic;

begin
    sig01 : component signals
        generic map (toggle_count => 6
                    --target_frequency    => 50 -- Default to A (440 Hz)
                    )
        port map (
                    clk => centr_clk,
                    reset => reset,
                    r_rst => period_res,
                    en => y1,
                    tone_out => fr_01
                    );
                    
     sig02 : component signals
        generic map (toggle_count => 4
                    --target_frequency    => 80
                    )
        port map (
                    clk => centr_clk,
                    reset => reset,
                    r_rst => period_res,
                    en => y2,
                    tone_out => fr_02
                    );
                    
     sig03 : component signals
        generic map (toggle_count => 3
                    --target_frequency    => 25
                    )
        port map (
                    clk => centr_clk,
                    reset => reset,
                    r_rst => period_res,
                    en => y3,
                    tone_out => fr_03
                    );
                    
     decoder : component demux
        port map (
                d => BTNC,
                s => sig_s,
                y0 => y0,
                y1 => y1,
                y2 => y2,
                y3 => y3
                );
                
     c_en_1 : component clk_enable
        generic map(N_PERIODS => 4545455)
        port map(
                 clk => CLK100MHZ,
                 rst => '0',
                 --en => BTNC,
                 pulse => centr_clk
                 );
                 
     c_en_clk : component clk_enable2
        generic map(N_PERIODS => 11)
        port map(
                 clk => centr_clk,
                 rst => reset,
                 pulse => to_song
                 );
                 
     song : component my_fsm
        port map(
                clk => to_song,--song_time,
                rst => reset,
                en => BTNC,
                s => sig_s
                );
                
     period_reset : component cleaner2
        generic map(N_PERIOD => 11)
        port map(
                clk => centr_clk,
                rst => BTND,
                --en  => BTNC,
                outp => period_res
                );
                
     spoj : component rozdvoj
        port map(
                inp => BTND,
                outp => reset);
                
--     convertor_1 : asyn_to_syn 
--        port map(
--                clk => a_t_s_01,
--                rst => n_reset,
--                outp => centr_clk);
    
--    convertor_2 : asyn_to_syn 
--        port map(
--                clk => a_t_s_02,
--                rst => n_reset,
--                outp => to_song);
         
    --BTND => reset;
    OUTP1 <= fr_01;
    OUTP2 <= fr_02;
    OUTP3 <= fr_03;
    
    LED <= BTNC;
end Behavioral;
