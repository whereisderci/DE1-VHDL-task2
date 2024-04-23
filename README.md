# Relay-Controlled Sound Synthesizer

Team members:

1. Adam Petrů
2. Jakub Kupčík
3. Hana Larvová
4. David Muzikář

Design codes
Test benches
Hardware configuration
Code debugging
Implementation on board
Presentation

Theoretical description and explanation:  
Signal files, connect each signal to clock enable, those signals will create a song played on first relay
Second and third relays are drums that will be speed up or slowed down by defined frequency. Those relays will simultaneously play with first one.
With these relays will be counting time on seven segment display. Start button will start timer, signals if switches are on and LEDS. The same button is also a stop button.
Second button will reset whole process.

Hardware description of demo application:  
The main part is Nexys A7 programmable FPGA board, which generates signals to three relays connected through Pmod connectors. Each relay is responsible for different sound. Breadboard is used to connect Arduino Uno to the Nexys A7 and relays.

Software description:

Instructions:


References:


![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/757d180d-983b-4ae8-bd75-5e5e95284f86)

Tady pro spoustu component zatím chybý test banche 

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/86e970c3-bc22-4e0b-a2ac-fdad84a23dd7)

s tím že ten fsm diagram nění přesně podle kódu ke konci jsem ho pak byl líný upravovat... 

![image](https://github.com/whereisderci/DE1-VHDL-task2/assets/165771404/1e023bef-df65-49d4-a017-cac0af75854e)

a tohle je ta písnička s tím že jednotlivý čísla znamenají v závěru kolik se provede úderů a nějaký stanovený časový úsek Tempem (viz. global schéma). 
