.data
### Bitmap Display ### 
# There are 2048 pixels that are each a word in length, 
# but expects a 24-bit color value.
# There are 32 columns and 64 rows.
#
# Settings to use:      (small display)              (big display)
#   Unit Width in Pixels:     8                          (16)
#   Unit Height in Pixels:    8                          (16)
#   Display Width in Pixels:  256                        (512)
#   Display Height in Pixels: 512                        (1024)
#   Base address for display: 0x10010000 (static data)
frameBuffer: .space 0x2000 # 2048 words = 8192 bytes

### Hex colors ###
purple:	 .word 0x32174d # Russian violet
blue:    .word 0x0000FF
navy:    .word 0x000080
steel:   .word 0x4b5f81
black:   .word 0x000000
white:   .word 0xFFFFFF
silver:  .word 0xC0C0C0

### Flowers ###
flowers: .space 40  # 10 flowers. A flower has a pixel location. (Non-adjusted)

### Player ###
# How to decompose player position:
# rowIndex * numberOfColumns + columnIndex
playerPos: .word 1936 # Default Player Position: 60 * 32 + 16

.text

# Procedure where execution begins.
# It does initial execution, and controls the game loop.
Main:
	jal GenerateFlowers
	addi $s0, $0, 0    # frame counter
	addi $s1, $0, 1000 # max number of frames
	
# Given basic generation, this procdure is where the main loop of the game exists.
# The loop only runs for so many frames
GameLoop:
	
	############################################################################################ 			
	# NOT what you want to do for a game, but this is a simple way to make frames              #
	# and control the speed of the program. Relies on Java's sleep method, so it has overhead! #
	# Sleep for sbout 50 milliseconds	                                                   #
	addi $a0, $0, 50									   #
	addi $v0, $0, 32									   #
	syscall											   #
	############################################################################################
	
	# Update logic for everything.
	addi $s0, $s0, 1
	jal Update
	
	# Draw everything
	jal Draw
	
	# Only update/draw so many frames for right now. 
	# (It's so I can let the program end naturally without having to interrupt it if I forget about it.)
	bne $s0, $s1, GameLoop
	
	j Exit


# Routine that updates all data.
Update:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Player Control
	jal GetInput
	move $a0, $v0
	#addi $a0, $0, -32
	jal UpdatePlayer
	
	# Background Control
	jal UpdateFlowers
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


# Routine that draws all objects. 
Draw:
	addi $sp, $sp, -4
	sw $ra 0($sp)
	
	# Draw the background
	lw $a0, purple
	jal DrawBackground
	
	# Draw the flowers.
	lw $a0, steel
	jal DrawFlowers	
	
	# Draw the Player.
	jal DrawPlayer
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	

	
# Creates 10 words representing pixel location of flowers.
# Affects $v0, $a0, $a1, $t0
GenerateFlowers:
	addi $t0, $0, 0

	GFLoop:
	# Generate a location for the flower (randomly)
	addi $v0, $0, 42
	addi $a1, $0, 2048
	syscall
	
	# Put pixel location into array.
	sw $a0, flowers($t0) 
	
	addi $t0, $t0, 4
	bne $t0, 40, GFLoop
	 
	jr $ra
	
	
##### Update Procedures #####

# Gets user's input and stores the value into $v0. 
# Do not hold a button for too long, and do not hold multiple buttons down!
# In our project, we will do MMIO differently so that isn't a problem, instead,
# we'll have an 8-bit value representing which buttons are held down.
# Affects registers $v0, $t1, $t2, $t3
GetInput:
	addi $v0, $0, 0 # if zero, user isn't inputting something, or input something ivalid.
	
	# Make sure we can grab something
	lui $t1, 0xFFFF
	lw $t2, 0($t1) # Receiver Control is at 0xffff0000 -> if the value is one, new data is in 
	andi $t2, $t2, 0x1   # if(!in_value)
	beqz $t2, inputDone  #   return 0; 
	
	# User has put in something. Sadly, MIPS only allows for one input at a time. Very limiting!
	# Do not hold a button down for too long, and do not hold multiple buttons, MIPS will crash and burn!
	lw $t2, 4($t1) # Receiver Data is at 0xffff0004
	
	# Could be more optimized, but let's try this first.
	
	beq $t2, 0x77, goUp    # w
	beq $t2, 0x61, goLeft  # a
	beq $t2, 0x73, goDown  # s
	beq $t2, 0x64, goRight # d
	
	# Not a valid input, don't do anything
	j inputDone
	
	goUp:
	addi $v0, $0, -32
	j inputDone 
	
	goLeft:
	addi $v0, $0, -1
	j inputDone
	
	goRight:
	addi $v0, $0, 1
	j inputDone
	
	goDown:
	addi $v0, $0, 32
	j inputDone
	
	# TODO: what about space?
	
	inputDone:
	jr $ra

# Update the player's position.
# Parameters: $a0: The offset for next movement. 
# Only accepts moving up, down, left, right by one pixel.
# Affects: $t0, $t1, $t2, 
UpdatePlayer:
	#addi $sp, $sp, -4
	#sw $ra 0($sp)
	
	lw $t0, playerPos
	beq $a0, $0, updatePos # if(!dp) return 0;
	add $t1, $t0, $a0      # Next position = current position + dp
	
	beq $a0, -32, moveUp
	beq $a0,  -1, moveLeft
	beq $a0,   1, moveRight
	beq $a0,  32, moveDown
	
	moveUp:
	# Top wall is from 0 to 31. To prevent silly errors, only allows player to go to second row.
	blt $t1, 32, updatePos	# if(next_pos < 0) return current_pos;
	move $t0, $t1
	j updatePos

	moveLeft:
	# Left walls occur on: 0, 32, 64, ...
	andi $t2, $t0, 0x1F                    #  if(current_pos % 32) current_pos = next_pos;
	beq $t2, $0, updatePos                 #  else                 current_pos = current_pos;
	move $t0, $t1
	j updatePos
	
	moveDown:
	# Bottom wall is from 2016 to 2047, anything greater is too far.
	# Only go to second-to-last row to prevent silly errors. You don't need to buckle against the bottom row.
	addi $t2, $0, 2015
	bgt $t1, $t2, updatePos
	move $t0, $t1
	j updatePos
	
	moveRight:	
	# Right walls occur on: 31, 63, 95, ...  
	andi $t2, $t1, 0x1F                     # if(next_pos % 32) current_pos = next_pos; 
	beq $t2, $0, updatePos                  # else              current_pos = current_pos;
	move $t0, $t1
	
	
	updatePos:
	sw $t0, playerPos

	#lw $ra 0($sp)
	#addi $sp, $sp, 4
	jr $ra


# Update flower positions.
# Parameters: None.
# Affects: $t0, $t1, $v0, $a0, $a1	
UpdateFlowers:
	addi $t0, $0, 0
	
	uFLoop:
	# Get Flower.
	lw $t1, flowers($t0)
	
	# Move it down one and right one.
	addi $t1, $t1, 65
	
	# If it still fits, put it back into array, otherwise give the flower a new location. 
	blt $t1, 2048, uFOkay
	
	addi $v0, $0, 42 # random int from 0 - 32
	addi $a1, $0, 32
	syscall
	
	move $t1, $a0
	
	uFOkay:
	sw $t1, flowers($t0)
	
	addi $t0, $t0, 4
	bne $t0, 40, uFLoop
	jr $ra




##### Draw Procedures #####

# Draws the Player.
# Affects $t0, $t1, $t2
DrawPlayer:
	# Get player position and adjust for display.
	lw $t3, playerPos # $t3 will hold Player's Position
	sll $t0, $t3, 2   # $t0 will hold position, adjusted for screen.
	
	# Draw them on screen.
	lw $t1, black
	sw $t1, frameBuffer($t0)
	
	# Draw other squares white for easy visibility.
	lw $t1, white
	
	# Draw white pixels next to player to make a simple character design.
	# Obviously make glyphs and things for actual assignment.
	
	# Don't worry about checking bottom/top since update procedure prevents that.
	# Draw up square 
	addi $t2, $t0, -128
	sw $t1, frameBuffer($t2)
	# Draw down square 
	addi $t2, $t0, 128
	sw $t1, frameBuffer($t2)
	
	# Draw left  square - Check for boundary
	andi $t4, $t3, 0x1F                    #  if(Player is on left edge)
	beq $t4, $0, skipLeft                  #     skip drawing left square
	
	addi $t2, $t0, -4
	sw $t1, frameBuffer($t2)
	
	skipLeft:
	# Draw right square - Check for boundary
	addi $t4, $t3, 1
	andi $t4, $t4, 0x1F                     # if(Player is on right edge)
	beq $t4, $0, skipRight                  #   skip drawing right square
	  
	addi $t2, $t0, 4
	sw $t1, frameBuffer($t2)	
        
        skipRight:	
	jr $ra


# Draws the flowers on the screen.
# Parameters: 24-bit color for flowers, store in $a0	
DrawFlowers:
	move $t0, $a0
	addi $t1, $0, 0	
	
	DFLoop:
	# Get flower location.
	lw $t2, flowers($t1)	
	
	# Write color to location.
	# Compute offset.
	sll $t2, $t2, 2
	
	# update location.
	sw $t0, frameBuffer($t2)
		
	addi $t1, $t1, 4
	bne $t1, 40, DFLoop
	
	jr $ra


# Draws the background for display. Currently only does one color.
# Parameters: 24-bit color for background, store in $a0
# Affects registers $t0, $t1,
DrawBackground:
	move $t0, $a0    # Background color
	addi $t1, $0, 0  # offset of display.	
	
	DrawBGLoop:
	sw $t0, frameBuffer($t1)   # Put color into background
	
	addi $t1, $t1, 4 	   
	bne $t1, 0x2000, DrawBGLoop 
	jr $ra
	



##### EXIT #####
Exit:
	li $v0, 10
	syscall # return 0;
