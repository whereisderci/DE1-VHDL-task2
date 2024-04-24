# Relay-Controlled Sound Synthesizer

Team members:

1. Adam Petrů
2. Jakub Kupčík
3. Hana Larvová
4. David Muzikář

## Theoretical description and explanation:
The aim of this project is to develop and implement a sound synthesizer utilizing relays on the Nexys A7 FPGA board. Users can compose and play basic melodies by turning the relays on trough switches. Push buttons serve as controls for start and stop, while LEDs and seven-segment display provide some visualization.  
### Solution:
Signal files connect each signal to clock enable and create a song played on the first relay. The second and third relays are drums. The first one has a higher frequency, and the other one has a lower frequency, and they can be played simultaneously while the song on the first relay plays. These two relays with drums are connected to two switches, and when one of the switches is on, the LED above lights up.
A timer starts when the BTNC button is pressed and is visualized on the seven-segment display. The same button is also a stop button. BTND button resets the whole process.

## Hardware description of demo application:
The main part is Nexys A7 programmable FPGA board, which generates signals to three relays connected through Pmod connectors. Each relay is responsible for different sound. Relays need to be charged by 5V and Nexys A7 is capable only 3.3V. This is the reason why the Arduino Uno is needed. It serves as 5V source to relays. Then there is used breadboard with convertor 3.3V and 5V.   
  
## Software description:
Schematic of top_level:    
![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/114295996/e4fd61c0-c4f9-4882-b5e0-4758214a87c9)
### Components simulation

## Instructions:
### Manual:
First you have to turn on the Nexys A7 FPGA board. Then when you press the BTNC button timer starts to count and song starts to play. If you turn on one of the two switches, drums adds to song. At the same time LED above the switch lights up. When you want to pause the song, press again BTNC button. Timer stops too. Then when you want to reset the timer and stop songs, press BTND button.
### Short app video:

## References:



![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/757d180d-983b-4ae8-bd75-5e5e95284f86)

Tady pro spoustu component zatím chybý test banche 

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/86e970c3-bc22-4e0b-a2ac-fdad84a23dd7)

s tím že ten fsm diagram nění přesně podle kódu ke konci jsem ho pak byl líný upravovat... 

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/1e023bef-df65-49d4-a017-cac0af75854e)

a tohle je ta písnička s tím že jednotlivý čísla znamenají v závěru kolik se provede úderů a nějaký stanovený časový úsek Tempem (viz. global schéma). 
