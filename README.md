# Relay-Controlled Sound Synthesizer

Team members:

1. Adam Petrů (made signal, that indicates Star Wars theme, testbench for the theme song signal)
2. Jakub Kupčík (made timer, button stop/play and reset, testbench for timer and buttons)
3. Hana Larvová (testbenches for top_level, signals and switches, hardware, documentation)
4. David Muzikář (created top_level, test signals, hardware, documentation)

## Theoretical description and explanation:
The aim of this project is to develop and implement a sound synthesizer utilizing relays on the Nexys A7 FPGA board. Users can compose and play basic melodies by turning the relays on trough switches. Push buttons serve as controls for start and stop, while LEDs and seven-segment display provide some visualization.  
### Solution:
Signal files connect each signal to clock enable and create a song played on the first and second relay. This song starts to play when the BTNC button is pressed. At the same time, a timer starts to count. The timer is visualized on the seven-segment display, counting to 60. When it reaches 60 seconds, it resets to zero and starts counting again. The same button also serves as a stop button and the BTND button resets the whole process. When the song plays, the RGB LED lights up.

## Hardware description of demo application:
The main part is Nexys A7 programmable FPGA board, which generates signals to three relays connected through Pmod connectors. Each relay is responsible for different sound. Relays need to be charged by 5V and Nexys A7 is capable only 3.3V. This is the reason why the Arduino Uno is needed. It serves as 5V source to relays. Then there is used breadboard with convertor 3.3V and 5V.   

  Nexys A7 50T:
  lab8-project/images/nexys-a7.png
  
## Software description:
Schematic of top_level:    
<img width="834" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/0e1f7d3f-e036-482a-a4ab-9a32418d6beb">

Schematic of simpe_counter:

<img width="834" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/87c899e9-cd5d-4154-9590-280bd87a5ad6">

Schematic of clock enable:

<img width="815" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/a7c18117-ec28-4f6c-bff4-84d4fdd7295b">

Schematic of song:

<img width="612" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/3e58ce18-2669-42bf-bda4-c90abd8f5092">

Schematic of debouncer:

<img width="1134" alt="image" src="https://github.com/whereisderci/DE1-VHDL-task2/assets/165037171/d13e0509-4b09-4c1e-a058-dee26ec768e7">


### Components simulation

## Instructions:
### Manual:
First you have to turn on the Nexys A7 FPGA board. Then when you press the BTNC button, timer starts to count and song starts to play. When you want to pause the song, press again BTNC button. Timer stops too. Then when you want to reset the timer and stop song, press BTND button.
### Short app video:

### Description of working process
For a long time, our main problem was implementing a basic signal on the Nexys board, which would cause some sort of clicking in the connected relay. The simulation for the signal worked, but the implementation had its bugs to fix. Right after accomplishing this task, the same problem appeared with the melody, where the simulation worked, but the implementation did not.

After many attempts and numerous test projects, we came to the final stage of connecting everything together through the final top-level module. The top-level module had many bugs and had to be fixed right before implementing everything on the board. Our vision for the LEDs was to make them flicker when the switch for the signal was turned on. This application had problems that we couldn't resolve. That's why we had to abandon the project.

One of solutions recreating song for relay:

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/757d180d-983b-4ae8-bd75-5e5e95284f86)

First schematic, melody is played via demux and 3 different frequency modulations. 

![state diagram](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/55fd353b-9efe-4e25-a79c-a00710ba6ca8)

State diagram: 

![data_digit](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/c098e97b-8b76-4040-8662-25e16618771a)


The whole melody, where numbers represent the quantity of hits by each relay. Different tones are played on different relays. Three relays are used for the melody of the Star Wars Imperial theme song, while the other two relays are for optional drums and tones. In the project, only two are implemented due to the deadline.

## References:
https://vhdl.lapinoo.net/testbench/  

