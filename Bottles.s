# script qui permet d afficher les 100 couplets de la chanson 99 Bottles a l envers

#etiquettes utilise 
	.eqv PrintInt, 1
	.eqv PrintString, 4
	.eqv Exit, 10

#initilialisation variables
	li s0, 99
	
#inversion des couplets de la chanson

loop:
	mv a0,s0
	li a7, PrintInt
	ecall
	la a0, bot1
	li a7 PrintString
	ecall
	mv a0,s0
	li a7, PrintInt
	ecall
	la a0, bot2
	li a7 PrintString
	ecall
	addi s0,s0,-1
	li a0, 1
	ble s0,a0,final
	

	mv a0,s0
	li a7, PrintInt
	ecall
	la a0, bot3
	li a7 PrintString
	ecall
	j loop

final:
	li a7, PrintInt
	ecall
	la a0, bot4
	li a7,PrintString
	ecall
	la a0, fin
	ecall
	addi,s0,s0,98
	mv a0,s0
	li a7, PrintInt
	ecall
	la a0,bot3
	li a7,PrintString
	ecall
	
	
	
	.data
	bot1: .string " bottles of beer on the wall, "
	bot2: .string "bottles of beer.\nTake one down and pass it around,"
	bot3: .string "bottles of beer on the wall,\n \n"
	bot4: .string "bottle of beer on the wall,\n "
	fin: .string "No more bottles of beer on the wall, no more bottles of beer.\n Go to the store and buy some more,"
