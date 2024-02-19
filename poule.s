#Nathan Lambert LAMN81050707

#TP1 Creer un jeu de Poule-Poule

	.eqv ReadChar, 12
	.eqv Exit, 10
	.eqv PrintChar, 11
	.eqv PrintInt, 1
	
	li s1, 0 #Compteur d oeuf
	li s2, 0 #compteur de poule
	li s3, 0 #Compteur de Chien
	li s4, 0 #Compteur de ver
ResetCompteur:
	li s0, 1 #compteur permettant de tenir compte des multiplicateurs
SaisieUtilisateur: #Collecter la saisiee de l utilisateur et rediriger dans les fonctions prevue

	li a7, ReadChar
	ecall
	li t1, 'o'
	beq a0, t1, AjoutOeuf
	li t1, 'r'
	beq a0, t1, AjoutRenard
	li t1, 'p'
	beq a0, t1, AjoutPoule
	li t1, 'c'
	beq a0, t1, AjoutChien
	li t1, 'v'
	beq a0, t1, AjoutVer
	li t1, 'a'
	beq a0, t1, Affichage
	li t1, 'q'
	beq a0, t1, Coq
	li t1, '0'
	blt a0, t1, EntreeNonValide
	li t1, '9'
	bgt a0, t1, EntreeNonValide
	li s0, 0

Compteur:
	li t1, '0'
	beq a0, t1, SaisieUtilisateur
	addi s0, s0, 1
	addi a0, a0, -1
	j Compteur
	
AjoutOeuf:
	add s1, s1, s0
	j ResetCompteur

AjoutRenard:
	beqz s0, ResetCompteur
	bgtz s3, PresenceChien
	beqz s2, ResetCompteur
	addi s0, s0, -1
	addi s1, s1, 1
	addi s2, s2, -1
	j AjoutRenard

AjoutPoule:
	beqz s0, ResetCompteur
	bgtz s4, PresenceVer
	beqz s1, ResetCompteur
	addi s0, s0, -1
	addi s1, s1, -1
	addi s2, s2, 1
	j AjoutPoule

AjoutChien:
	add s3, s3, s0
	j ResetCompteur

PresenceChien:
	addi s0, s0, -1
	addi s3, s3, -1
	j AjoutRenard
	
	
AjoutVer:
	add s4, s4, s0
	j ResetCompteur
	
PresenceVer:
	addi s0, s0, -1
	addi s4, s4, -1
	j AjoutPoule

Affichage:
	li a0, 0
	add a0, a0, s1
	li a7, PrintInt
	ecall
	li a0, '\n'
	li a7, PrintChar
	ecall
	j ResetCompteur
	
EntreeNonValide:
	li a0, 'E'
	li a7, PrintChar
	ecall
	li a0, 'r'
	ecall
	ecall
	
Coq:

	li a7, Exit
	ecall

	
