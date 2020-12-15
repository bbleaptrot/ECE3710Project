Layout of turn-in archive:
Software-Code:	
 Contains - Arduino code, custom bluetooth android controller code, assembler.cpp, 
   	    the assembly code (Assembly.txt), the machine code (game.txt), the glyph file.
 
Test Benches:
 Self-explanitory

Verilog Code:
 Contains - All the verilog files used throughout the semester.  Lab 4 contains the project
            that should be compiled.

To compile and run on a board open the lab4 project inside of the Verilog Code folder.
It should be noted that this is programmed to take input from an arduino which connects
to a custom android mobile application via bluetooth. The code for both can be found in
the Software-Code folder. You can change the pins to be switches instead but this is very
buggy as it wasnt programmed for this.  If you choose to do this the best results come 
from the following pin layouts:
	in_7 -> SW9
	in_6 -> SW8
	...
	in_1 -> SW3
	in_0 -> SW2