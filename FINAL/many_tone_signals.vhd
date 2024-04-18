library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity many_tone_signals is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in std_logic;
           sw_01 : in STD_LOGIC;
           sw_02 : in STD_LOGIC;
           loop_on : in std_logic;
           A_out : out STD_LOGIC;
           G_out : out STD_LOGIC;
           C_out : out STD_LOGIC
           );
end many_tone_signals;

architecture Behavioral of many_tone_signals is

component signals
    generic(target_frequency : integer);
    port(
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
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

component my_fsm
    port(
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           s : out std_logic_vector(1 downto 0)  
        );        
end component;

component transfer
    port(
        inp : in std_logic;
        outp : out std_logic;
        n_outp : out std_logic
        );
end component;

component tempo
    port(
           sw_1 : in STD_LOGIC;
           sw_2 : in STD_LOGIC;
           out_1 : out STD_LOGIC;
           out_2 : out STD_LOGIC;
           out_0 : out STD_LOGIC
           );
end component;

component clk_enable
    generic(N_PERIODS : integer);
    port(
        clk   : in    std_logic; 
        rst   : in    std_logic; 
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

component counter_song
    generic(N_PERIODS : integer);
    port(
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic  
        );
end component;

component sbernice
    port(
         sng_loop : in STD_LOGIC;
         in_0 : in STD_LOGIC;
         in_1 : in STD_LOGIC;
         in_2 : in STD_LOGIC;
         in_3 : in STD_LOGIC;
         to_counter : out STD_LOGIC;
         out_1 : out STD_LOGIC;
         out_2 : out STD_LOGIC;
         out_3 : out STD_LOGIC);
end component;

component STOP
    port(
        x1 : in STD_LOGIC;
        x2 : in STD_LOGIC;
        x3 : in STD_LOGIC;
        x0 : in STD_LOGIC;
        y1 : out STD_LOGIC;
        y2 : out STD_LOGIC;
        y3 : out STD_LOGIC;
        y0 : out std_logic
        );
end component;

signal sig_s : std_logic_vector(1 downto 0);
signal en_1  : std_logic;
signal en_2 : std_logic;
signal en_3 :std_logic;
signal gnd :std_logic;
signal centr_res : std_logic;
signal n_centr_res : std_logic := not centr_res;
signal out_0 : std_logic;
signal out_1 : std_logic;
signal out_2 : std_logic;
signal n_out_0 : std_logic := not out_0;
signal n_out_1 : std_logic := not out_1;
signal n_out_2 : std_logic := not out_2;
signal high : std_logic;
signal song_time : std_logic;
signal s_and : std_logic;
signal out_count : std_logic;
signal centr_time : std_logic;
--signal s_loop : std_logic;
signal s_y0 : std_logic;
signal s_y1 : std_logic;
signal s_y2 : std_logic;
signal s_y3 : std_logic;
signal m_1 : std_logic;
signal m_2 : std_logic;
signal m_3 : std_logic;
        
begin
    
    sig01 : component signals
        generic map (target_frequency => 1)
        port map (
                    clk => centr_time,
                    reset => centr_res,
                    en => en_1,
                    tone_out => A_out
                    );
                 
    sig02 : component signals
        generic map (target_frequency => 2)
        port map (
                    clk => centr_time,
                    reset => centr_res,
                    en => en_2,
                    tone_out => G_out
                    );   
                    
    sig03 : component signals
        generic map (target_frequency => 3)
        port map (
                    clk => centr_time,
                    reset => centr_res,
                    en => en_3,
                    tone_out => C_out
                    ); 
                    
    decoder : component demux
        port map (
                d => n_centr_res,
                s => sig_s,
                y0 => s_y0,
                y1 => s_y1,
                y2 => s_y2,
                y3 => s_y3
                );
                
    c_en_1 : component clk_enable
        generic map(N_PERIODS => 1)
        port map(
                 clk => CLK100MHZ,
                 rst => out_0,
                 pulse => centr_time
                 );
                 
    c_en_06 : component clk_enable
        generic map(N_PERIODS => 2)
        port map(
                 clk => CLK100MHZ,
                 rst => out_1,
                 pulse => centr_time
                 );
                 
     c_en_14 : component clk_enable
        generic map(N_PERIODS => 3)
        port map(
                 clk => CLK100MHZ,
                 rst => out_2,
                 pulse => centr_time
                 );
                 
    c_en_sng : component clk_enable2
        generic map(N_PERIODS => 6)
        port map(
                 clk => centr_time,
                 rst => centr_res,
                 pulse => song_time
                 );
                 
   counter_song_1 : component counter_song
    generic map(N_PERIODS => 32)
    port map(
            clk => s_and,
            rst => centr_res,
            pulse => out_count       
            );
                    
                    
    song : component my_fsm
        port map(
                clk => song_time,
                rst => centr_res,
                en => BTNC,
                s => sig_s
                );
                
    tran : component transfer
        port map(
                inp => BTND,
                outp => centr_res,
                n_outp => gnd
                );
    gnd <= '0';
    high <= '1';
    
    time_tempo : component tempo
        port map(
                sw_1 => sw_01,
                sw_2 => sw_02,
                out_1 => out_1,
                out_2 => out_2,
                out_0 => out_0
                ); 
                
    data_taker : component sbernice
        port map(
                 sng_loop => loop_on,
                 in_0 => s_y0,
                 in_1 => s_y1,
                 in_2 => s_y2,
                 in_3 => s_y3,
                 to_counter => s_and,
                 out_1 => m_1,
                 out_2 => m_2,
                  out_3 => m_3
                 ); 
                 
    my_stop : component STOP
        port map(
                x1 => m_1,
                x2 => m_2,
                x3 => m_3,
                x0 => out_count,
                y1 => en_1,
                y2 => en_2,
                y3 => en_3,
                y0 => centr_res
                );
    
                    
end architecture Behavioral;
