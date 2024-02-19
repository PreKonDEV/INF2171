# lit deux chaines de caracteres et les convertit en majuscule

.data 

	.eqv strsize, 81   #grandeur max des strings
	.eqv str1, +0 #position dans la pile de str1
	.eqv str2, +81 #position dans la pile de str2
	
.text
	addi sp,sp, -176 # deux chaines de 81+ alignement
	
	#lire str1
	addi a0,sp,str1
	li a1, strsize
	call readString
	addi a0,sp,str2
	li a1,strsize
	call readString
	
	
	
	
