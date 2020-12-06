#This function is going read into R14 the data from phone and move the ship or
#fire a bullet depending on input--> left moves ship left / right moves ship
#right / A button fires bullet
MOVI 0x01, R0 #This instruction is a sentinel instruction to ensure stuff works
LUI 0x01, R11 #Left method location
LUI 0x02, R12 #Right method location
LUI 0x03, R13 #A btn location
MOVI 0x80, R1 #Temp for comparison
PHONE R0, R14 #Grab phone instruction into R14
MOV   R14, R15#Move Phone Data into R15 for comparisons
CMP R1, R15
JEQ R11
MOVI 0x10, R1
MOV R14, R15
CMP R1, R15
JEQ R12
MOVI 0x01, R1
MOV R14, R15
CMP R1, R15
JEQ R13
ANDI 0x00, R0
JUC R0

@0100
#This method moves the player ship to the left by 1 glyph space
LUI 0xA0, R1 #Base address of Player
LUI 0x0F, R10 #Load method position to jump to update
LOAD R1, R2   #Load Player Position into R2
ADDI -1, R3   #Move -1 into R3
ADD R3, R2    #Add R3 + R2 --> R2 
STOR R2, R1   #Store data into Player Position
JUC R10       #Draw 
@0200
#This method moves the player ship to the right by 1 glyph space
LUI 0xA0, R1 #Base address of Player
LUI 0x0F, R10#Load method position to jump to update
LOAD R1, R2  #Load Player Position into R2
MOVI 1, R3   #Load 1 into R3  
ADD R3, R2   #R3 + R2 --> R2
STOR R2, R1  #Store data into player position
JUC R10      #Draw
@0300
LUI 0xA0, R3   #load ship position into address
LOAD R3, R4    #Save ship position to perform subtraction
MOVI 0x01, R10 #A useful incrementor :)
ADD  R10, R3   #Add 1 to R3 to get memory location for bullet alive variable
STOR R10, R3   #Let the processor know the bullet needs to be drawn
ADD  R10, R3   #Add 1 to R3 to get memory location for bullet position
MOVI 0x08, R11 #Moving dGlyph
LUI  0x01, R5  #Create 284
MOVI 0x1c, R7  #This will finish 284
ADD  R5, R7    #This creates 284 finally
SUB  R7, R4    #Ship pos - 284 --> Hopefully Centers bullet with ship glyph
MOV  R4, R6    #This is the starting drawing position
STOR R4, R3    #Store the bullet position for later use

MOVI 127, R12  #Vertical Shift
MOVI 30, R2
ADD R2, R12
	   
LUI 0x05, R9 #Glyph 1--> upper Left
ADD R10, R9  #This addition I believe gets the actual starting position
STOR R9, R6  # Start Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row1 #This may be where I need to move to next row
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row1 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row2 (Complete)
BUC -1

@0F00
#This method calls a series of sub methods to update game data
#Updates: Player
LUI 0xA0, R7   #XPos
ADDI 0x01, R10 #Moving dXPos
ADDI 0x10, R11 #Moving dGlyph
ADDI 157, R12  #Vertical Shift
	
LOAD R6, R7   
LUI 0x00, R9 #Glyph 1--> upper Left
STOR R9, R6  # Start Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row1 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row2 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row3
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row3
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row3
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row3 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row4
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row4
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row4
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row4 (Complete)

ADD R10, R7
LOAD R7, R6
LUI 0x00, R1
CMP R1, R6
JEQ R0
ADD R10, R7
LOAD R7, R6
SUB R12, R6
STOR R6, R7

LOAD R7, R6   
LUI 0x05, R9 #Glyph 1--> upper Left
STOR R9, R6  # Start Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row1 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row2 (Complete)


LOAD R6, R7   
LUI 0x00, R9 #Glyph 1--> upper Left
STOR R9, R6  # Start Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row1
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row1 (Complete)

ADD R12, R6 # Shifts
ADD R11, R9
STOR R9, R6 # Glyph 1--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 2--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 3--> Row2
ADD R10, R6
ADD R11, R9
STOR R9, R6 # Glyph 4--> Row2 (Complete)



JUC R0

#Player Starting position
#@A000
#D000

#Player Bullet alive position
#@A001
#0

#Player Bullet Spawn position
#@A002
#D000 - 157 


#Enemy Positions
# b99a
# b9a4
#
#
#
#
#
#
#
#
#
#
#
#
	

#XPos = F50E

