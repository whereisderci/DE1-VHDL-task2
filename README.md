# Relay-Controlled Sound Synthesizer

Team members:

1. Adam Petrů
2. Jakub Kupčík
3. Hana Larvová
4. David Muzikář

## Theoretical description and explanation:
The aim of this project is to develop and implement a sound synthesizer utilizing relays on the Nexys A7 FPGA board. Users can compose and play basic melodies by turning the relays on trough switches. Push buttons serve as controls for start and stop, while LEDs and seven-segment display provide some visualization.  
### Solution:
Signal files connect each signal to clock enable and create a song played on the first and second relay. This song starts to play when the BTNC button is pressed. At the same time, a timer starts to count. The timer is visualized on the seven-segment display. The same button also serves as a stop button and the BTND button resets the whole process.

## Hardware description of demo application:
The main part is Nexys A7 programmable FPGA board, which generates signals to three relays connected through Pmod connectors. Each relay is responsible for different sound. Relays need to be charged by 5V and Nexys A7 is capable only 3.3V. This is the reason why the Arduino Uno is needed. It serves as 5V source to relays. Then there is used breadboard with convertor 3.3V and 5V.   
  
## Software description:
Schematic of top_level:    
![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/114295996/e4fd61c0-c4f9-4882-b5e0-4758214a87c9)
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

