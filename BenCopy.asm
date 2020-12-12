#This function is going read into R14 the data from phone and move the ship or
#fire a bullet depending on input--> left moves ship left / right moves ship
#right / A button fires bullet
MOVI 0x04, R0
MOVI 0x04, R0
LUI 0x07, R15
JUC R15
@0004
MOVI 0x04, R0
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
MOVI 0x04, R0
JUC R0

@0100
#This method moves the player ship to the left by 1 glyph space
LUI 0xA0, R1 #Base address of Player
LOAD R1, R2  #Load Player Position into R2
LUI 0x01, R3
MOVI 0x09, R15
ADD R15, R3
MOV R2, R6
LUI 0x07, R9
LUI 0x10, R15
JUC R15

@0109
MOVI 0x01, R3
SUB R2, R3 
MOV R3, R2
STOR R2, R1  #Store data into player position
LUI 0x07, R15
JUC R15     #DrawLUI 0xA0, R1 #Base address of Player
	
@0200
#This method moves the player ship to the right by 1 glyph space
LUI 0xA0, R1 #Base address of Player
LUI 0x0F, R10#Load method position to jump to update
LOAD R1, R2  #Load Player Position into R2
LUI 0x02, R3
MOVI 0x0a, R15
ADD R15, R3
MOV R2, R6
LUI 0x07, R9
LUI 0x10, R15
JUC R15

@020a

MOVI 1, R3   #Load 1 into R3  
ADD R3, R2   #R3 + R2 --> R2
STOR R2, R1  #Store data into player position
LUI 0x07, R15
JUC R15     #Draw
	
@0300
LUI 0xA0, R3   #load ship position into address
LOAD R3, R4    #Grab ship position
LUI 0x07, R15  #Update Method
MOVI 0x01, R10 #A useful incrementor :)
ADD  R10, R3   #Add 1 to R3 to get memory location for bullet alive variable
LOAD R3, R9    #Load isShot into Register
CMP  R10, R9   #Compare
JEQ  R15       #There is already a bullet
STOR R10, R3   #This will save studs
ADD  R10, R3   #R10 + R3 --> R3 -> Bullet Position
LOAD R3, R5    #Grab bullet position
MOVI 4, R6     # 4 -> R6
ADD R6, R5     # Bullet pos + 4
LUI 0x04, R7   # R7 -> 0x0400
MOVI 0x4b, R8  # R8 -> 0x004b
ADD R8, R7
STOR R5, R3
JUC R15

@0400
LUI 0xA0, R1  # Go to data section
LUI 0x0F, R15 # Move Update Method Location to R15
MOVI 0x0D, R2 # Top Left enemy when added with 0xA000
MOVI 1, R3    # Incrementor for position
MOVI 2, R4    # Incrementor for ship position address
MOVI 1, R5    # Count
MOVI 15, R6   # Number of ships to keep account of
ADD R1, R2    # Get Address of top left enemy
MOV R5, R7    # Have Count Ready
LOAD R2, R8   # Get data
ADD  R3, R8   # Shift by 1
STOR R8, R2   # Store data in address space
CMP  R6, R7   # Check to see if we are done
JEQ  R15      # Jump to update when done
ADD  R4, R2   # Move to next ship address
ADD  R3, R5   # Increase count 
BUC  -9       # Shift to beginning of loop


@0500
LUI 0xA0, R1  # Move to data section / ship position
MOVI 1, R2    # Incrementor
ADD R2, R1    # Bullet Alive
ADD R2, R1    # Bullet Position
LUI 0x0F, R15 # Place Update method into R15 for jumping
LUI 0x01, R14 # Screen Width

LOAD R1, R6   # Ship Bullet Left X Pos
	
LOAD R3, R7   # Bullet 1 Top Left X Pos
LOAD R4, R8   # Bullet 2 Top Left X Pos
LOAD R5, R9   # Bullet 3 Top Left X Pos
	
MOVI 3, R3    # To Determine top left collision point
MOVI 4, R4    # To Determine bottom right collision point
ADD  R14, R3  # Add Screen width, now need b_xpos
ADD  R7, R3   # Complete top left bullet 1 collision point
ADD  R14, R4  # Add Screen width, Complete 5 more times
ADD  R14, R4  # Add Screen width, Complete 4 more times
ADD  R14, R4  # Add Screen width, Complete 3 more times
ADD  R14, R4  # Add Screen width, Complete 2 more times
ADD  R14, R4  # Add Screen width, Complete 1 more times
ADD  R14, R4  # Add Screen width, Complete 0 more times
ADD  R7,  R4  # Complete bottom_right bullet 1 collsion point

MOV  R6, R13  # Move Ship Top Left X Pos into R13
MOV  R4, R12  # Move bottom_right collision point
CMP  R12, R13 # Compare R13 to R12
JUC  R15      # Ship Top Left > Collision Point / Collision Did not occur
MOV  R6, R13  # Repeat Mov instruction
MOVI 15, R2   # Move 15 to R2 to add to ship pos
ADD  R2, R13  # Ship Pos + 15
CMP  R13, R12 # Collision Point > Ship top left + 15
JUC  R15      # Collision Did not Occur
MOVI 4, R2    # Collision Did occur
ADD  R1, R2   # Get position for lives
MOVI 1, R11   # Move 1 into R11 for subtraction
LOAD R2, R13  # Get Data from R2 and store in R13
SUB  R11, R13 # Lives - 1
STOR R13, R2  # Update Lives
JUC R15

@0600
LUI 0xA0, R3   #load enemy ship position into address
MOVI 0x2B, R4   #Get Offset for bullet life
ADD R4, R3     #Get bullet life position
LUI 0x0f, R15  #Update Method
MOVI 0x01, R10 #A useful incrementor :)
LOAD R3, R9    #Load isShot into Register
CMP  R10, R9   #Compare
JEQ  R15       #There is already a bullet
STOR R10, R3   #Set bullet to alive
JUC R15






@0F00
#This method calls a series of sub methods to update game data
#Updates: Player
LUI 0xA0, R7   #XPos
MOVI 0x01, R10 #Moving dXPos
MOVI 0x10, R11 #Moving dGlyph
MOVI 127, R12  #Vertical Shift
MOVI 30, R13
ADD R13, R12
	
LOAD R7, R6   
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

