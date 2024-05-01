# Relay-Controlled Sound Synthesizer

Team members:

1. Adam Petrů (made signal, that indicates Star Wars theme, testbench for the theme song signal)
2. Jakub Kupčík (made timer, button stop/play and reset, testbench for timer and buttons)
3. Hana Larvová (testbenches for top_level, signals and switches, hardware, documentation)
4. David Muzikář (created top_level, test signals, hardware, documentation)

## Theoretical description and explanation:
The aim of this project is to develop and implement a sound synthesizer utilizing relays on the Nexys A7 FPGA board. Users can compose and play basic melodies by turning the relays on trough switches. Push buttons serve as controls for start and stop, while LEDs and seven-segment display provide some visualization.  
### Solution:
Signal files connect each signal to clock enable and create a song played on the first, second and third relay. This song starts to play when the BTNC button is pressed. At the same time, a timer starts to count. The timer is visualized on the seven-segment display, counting to 60. When it reaches 60 seconds, it resets to zero and starts counting again. The same button also serves as a stop button and the BTND button resets the whole process. When the song plays, the RGB LED lights up.

## Hardware description of demo application:
The main part is Nexys A7 programmable FPGA board, which generates signals to three relays connected through Pmod connectors. Each relay is responsible for different sound. Relays need to be charged by 5V and Nexys A7 is capable only 3.3V. This is the reason why the Arduino Uno is needed. It serves as 5V source to relays. Then there is used breadboard with convertor 3.3V and 5V.   

### Hardware solution:


Connection between FPGA board, signal (voltage) amplifier and relays

Entire circuit
![IMG_1684](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/ee179646-03f1-43c5-9d8a-596ebedb40c9)

Connection of pins on board
![IMG_1683](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/05c7c25a-8e40-4199-9d2d-ab6d650c038d)

Connection to relays
![IMG_1682](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/188c9eea-721d-4e24-abc6-a3f09074ee1e)

Connection of 5V from Arduino to amplifier
![IMG_1681](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/f7ad601b-0744-40bd-b0dd-f40e041ea32c)

Connection to the amplifier
![IMG_1680](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/4c163163-9772-41e5-895b-ccdd7d3d0fdd)


  Nexys A7 50T:
  
  ![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/27fc30ae-9109-4832-a9a4-a75c11b14744)
  
  Relays:
  
  ![2-channel-relay_description](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/12fa3287-5be4-45a0-ad9f-725d65269041)
  
  
  
## Software solution:

### Schematic of top_level:    

<img width="600" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/0e1f7d3f-e036-482a-a4ab-9a32418d6beb">

### Schematic of simpe_counter:

  <img width="600" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/87c899e9-cd5d-4154-9590-280bd87a5ad6">

### Schematic of clock enable:

  <img width="600" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/a7c18117-ec28-4f6c-bff4-84d4fdd7295b">

### Schematic of song:

  <img width="600" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/3e58ce18-2669-42bf-bda4-c90abd8f5092">

### Schematic of debouncer:

  <img width="1134" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/d13e0509-4b09-4c1e-a058-dee26ec768e7">

### Schematic of relay:
  
  ![2-channel-relay_schematic](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/cf3f89a9-5809-40a4-8512-3aad8a123a69)


### Components simulation

## Instructions:
### Manual:
First you have to turn on the Nexys A7 FPGA board. Then when you press the BTNC button, timer starts to count and song starts to play. When you want to pause the song, press again BTNC button. Timer stops too. Then when you want to reset the timer and stop song, press BTND button.
### Short demonstration video:

https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/bf1c21e9-2a33-4d76-a430-1c2afc91b4b1

### Simulations
The key element was making a song that would click at a specific moment in a specific order. Different clicks (tones) were distributed across various relays to create an easier and better solution for us. There were many attempts to create one signal, which would have all the tones in it, but that took a lot of precious time, so this was the only solution.

![simulation_beta](https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/495af2de-ab8c-4432-87c5-736caa9f7846)
<img width="848" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/e9dac29f-24f6-4b56-abc4-8fb5bc1d2e65">


### Description of working process
For a long time, our main problem was implementing a basic signal on the Nexys board, which would cause some sort of clicking in the connected relay. The simulation for the signal worked, but the implementation had its bugs to fix. Right after accomplishing this task, the same problem appeared with the melody, where the simulation worked, but the implementation did not.

After many attempts and numerous test projects, we came to the final stage of connecting everything together through the final top-level module. The top-level module had many bugs and had to be fixed right before implementing everything on the board. Our vision for the LEDs was to make them flicker when the switch for the signal was turned on. This application had problems that we couldn't resolve. That's why we had to abandon the thought.

You can notice that our folder contains many other codes. These were initially meant to be added to the song to create background clicking (similar to drums making background noise). Along with that, a code for LED control had to make the LEDs pulse at a specific frequency when the switch for a specific tone was turned on.
### Parts of code used in project:

 #### Clock enable : 
 [PROJEKT_FINAL/clk_en.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/clk_en.vhd)
      
      entity clk_enable is
        generic (
            N_PERIODS : integer := 3 
        );
        
      p_clk_enable : process (clk) is
        begin

            if (rising_edge(clk)) then                   
                if (rst = '1') then                     
                    sig_count <= 0;
    
                elsif (sig_count < (N_PERIODS - 1)) then
                    sig_count <= sig_count + 1;          

                else
                    sig_count <= 0;
                end if;                                 
            end if;
    
    end process p_clk_enable;

 #### Bin2seg: 
 [PROJEKT_FINAL/bin2seg.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/bin2seg.vhd)
  
      p_7seg_decoder : process (bin, clear) is
    begin
  
    if (clear = '1') then
      seg1 <= "1111111";  -- Clear the display
      seg2 <= "1111111";
    else
  
    case bin is
      when x"0" =>     -- x"0" means "0000" in hexadec.
        seg1 <= "0000001";
      when x"1" =>
        seg1 <= "1001111";
...

       case dec is
      when x"0" =>     -- x"0" means "0000" in hexadec.
        seg2 <= "0000001";
      when x"1" =>
        seg2 <= "1001111";
...

  #### Simple counter: 
  [PROJEKT_FINAL/simple_counter.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/simple_counter.vhd)
          
          generic (
            FrequencyHz : integer := 100
            );
... 
    
          signal tick: integer range 0 to FrequencyHz - 1 := 0;
          signal seconds: STD_LOGIC_VECTOR (3 downto 0) := "0000";
          signal sig_dec: STD_LOGIC_VECTOR (3 downto 0) := "0000";
...

          if rst='1' then
         tick <= 0;
         seconds <= (others => '0');
         sig_dec <= (others => '0');
      elsif en='1' then
         if tick = FrequencyHz - 1 then
                tick <= 0;
                if seconds = 9 then  
                    seconds <= (others => '0');
                    if sig_dec = 5 then
                        sig_dec <= (others => '0');
                    else
                        sig_dec <= sig_dec + 1;
                    end if;
                else
                    seconds <= seconds + 1;
                end if;
            else
                tick <= tick + 1;
            end if;

#### My FSM: 
[PROJEKT_FINAL/my_fsm.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/my_fsm.vhd)
... 

      case b is
                when 0 =>
                    s <= "01";
                when 1 =>
                    s <= "10";
                when 3 =>
                    s <= "11";
                when others =>
                    s <= "00";
            end case;



#### Demux: 
[PROJEKT_FINAL/demux.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/demux.vhd)
...
      
        begin
            if s = "00" then 
                y0 <= d; 
                y1 <= '0';
                y2 <= '0';
                y3 <= '0';

...

       else
                y0 <= '0'; 
                y1 <= '0';
                y2 <= '0';
                y3 <= d;
            end if;

#### Top level: 
[PROJEKT_FINAL/top_level.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/top_level.vhd)

...  adding components, such as simple_counter:

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
...
        
           b2s : bin2seg 
              port map ( 
                clear => BTND,
                bin => sig_count,
                seg1 => sig_seg1,
                seg2 => sig_seg2,
                dec => sig_dec
               );

### Links for other codes:
  ##### Beta (underneath top_level, connects song components together): [PROJEKT_FINAL/beta.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/beta.vhd)
  
  ##### Debounce: [PROJEKT_FINAL/debounce.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/debounce.vhd)
  
  ##### Cleaner: [PROJEKT_FINAL/cleaner2.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/cleaner2.vhd)
  
  ##### Signal A1: [PROJEKT_FINAL/signal_A1.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/signal_A1.vhd)
    
  ##### Signal B1: [PROJEKT_FINAL/signal_B1.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/signal_B1.vhd)
  
  ##### Counter22: [PROJEKT_FINAL/counter22.vhd](https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/counter22.vhd)


  ## Testbenches:
  
  ### Top level:
  https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/TestBenches/tb_top_level.vhd
  ### simple counter:
  https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/TestBenches/tb_count.vhd
  ### bin2seg:
  https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/TestBenches/tb_b2s.vhd
  ### Signals (My FSM):
  https://github.com/whereisderci/DE1-VHDL-task2/blob/main/PROJEKT_FINAL/TestBenches/tb_tone_signal.vhd
    
### One of solutions recreating song for relay:

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/757d180d-983b-4ae8-bd75-5e5e95284f86)

#### First schematic, melody is played via demux and 3 different frequency modulations. 

![state diagram](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/55fd353b-9efe-4e25-a79c-a00710ba6ca8)

#### State diagram: 

![data_digit](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/c098e97b-8b76-4040-8662-25e16618771a)


Image represents the whole melody, where numbers represent the quantity of hits by each relay. Different tones are played on different relays. Three relays are used for the melody of the Star Wars Imperial theme song, while the other two relays are for optional drums and tones. In the project, only two are implemented due to the deadline.

## References:
https://vhdl.lapinoo.net/testbench/  
https://github.com/tomas-fryza/vhdl-course/tree/33a0aaf4fb018f0b1f5b19dacd7ed9942d025153/lab8-project/images

