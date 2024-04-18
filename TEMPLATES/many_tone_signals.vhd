library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity many_tone_signals is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in std_logic;
           sw_01 : in STD_LOGIC;
           sw_02 : in STD_LOGIC;
           C_in : in STD_LOGIC;
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

component clk_en
    generic(N_PERIODS : integer);
    port(
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic  
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
        
begin
    
    sig01 : component signals
        generic map (target_frequency => 200)
        port map (
                    clk => CLK100MHZ,
                    reset => centr_res,
                    en => en_1,
                    tone_out => A_out
                    );
                 
    sig02 : component signals
        generic map (target_frequency => 160)
        port map (
                    clk => CLK100MHZ,
                    reset => centr_res,
                    en => en_2,
                    tone_out => G_out
                    );   
                    
    sig03 : component signals
        generic map (target_frequency => 170)
        port map (
                    clk => CLK100MHZ,
                    reset => centr_res,
                    en => en_3,
                    tone_out => C_out
                    ); 
                    
    decoder : component demux
        port map (
                d => n_centr_res,
                s => sig_s,
                y0 => gnd,
                y1 => en_1,
                y2 => en_2,
                y3 => en_3
                );
                
    c_en_1 : component clk_en
        generic map(
                    N_PERIODS => 3 
                    )
        port map(
                 clk => CLK100MHZ,
                 rst => n_out_0,
                 pulse => 
                 );
                 
    c_en_06 : component clk_en
        generic map(
                    N_PERIODS => 3 
                    )
        port map(
                 clk => CLK100MHZ,
                 rst => n_out_1,
                 pulse => 
                 );
                 
     c_en_14 : component clk_en
        generic map(
                    N_PERIODS => 3 
                    )
        port map(
                 clk => CLK100MHZ,
                 rst => n_out_2,
                 pulse => 
                 );
                 
    c_en_sng : component clk_en
        generic map(
                    N_PERIODS => 6 
                    )
        port map(
                 clk => CLK100MHZ,
                 rst => gnd,
                 pulse => song_time
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
                
     
    
                    
end architecture Behavioral;
