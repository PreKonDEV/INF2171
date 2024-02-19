#LAMN81050207  gr020 NATHAN LAMBERT
#POTA89040106  gr030 ALEXIS POTVIN

# TP2 ---- Jeux de Puissance 4

# Puissance 4 est un jeux à 2 joueurs chacuns leurs tours, les joueurs jouent une pièce
# dans l'une des 7 colonnes. Le but du jeu est d'aligner 4 pièces horizontalement,verticalement ou diagonalement.
#Si un joueur fait déborder une colonne il perd la partie.

# Ainsi, les à leur tour les joueur entrent un numero de colonne de 1-7
# les joueurs peuvent entrer `d` pour afficher le jeux
# La commande `q` permet de quitter le jeu

# Appels systemes utilise :

	.eqv PrintString, 4
	.eqv ReadString, 8
	.eqv Exit, 10
	.eqv PrintChar, 11
	.eqv ReadChar, 12
	.eqv d, 100 #valeur ascii de d
	.eqv q, 113 #valeur ascii de q
	
.data
	#pieces

	
	#Messages pouvant etre afficher
	tourJoueurX:	.asciz "Le joueur X doit jouer."
	tourJoueurO:	.asciz "Le joueur O doit jouer."
	sautLigne: 	.asciz "\n",
	joueurXperd:	.asciz "Le joueur X perd"
	joueurOperd:	.asciz "Le joueur O perd"
	joueurXgagne:	.asciz "Le joueur X gagne"
	joueurOgagne:	.asciz "Le joueur O gagne"
	messageErreur:	.asciz "Erreur d'entree."
	
	# Grille de jeu
	#faire 7 rangée pour etre capable de gerer les debordements
	.eqv pieceX, 88
	.eqv pieceO, 79
	.align 8
	
	range7: .word 58, 46, 46, 46, 46, 46, 46, 46, 
	range6:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	range5:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	range4:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	range3:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	range2:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	range1:	.word 58, 46, 46, 46, 46, 46, 46, 46, 
	
	
	mat: .dword range1, range2, range3, range4, range5, range6, range7
	.eqv matM, 8 #nombre colonnes
	.eqv matN, 7 # nombre lignes
.text

	#initialisation de variables 
	#variable de joueur actuel
	li s8,0
	li s9, pieceX
	li s10, pieceO
	la s11, mat
	
inputJoueur:
	#lecteur de l entre du jouer
	li a7, ReadChar
	ecall
	
	 #traitement
	 li t0, d 
	 li a2,0
	 mv a2, a0
	 beq a0, t0, affichageGrille
	 li t0, q
	 beq a0, t0, terminerPartie
	 #verifier entree de 1-7
	 li t0, 49
	 blt a0, t0, erreurEntre
	 li t0, 55
	 bgt a0, t0, erreurEntre
	 
	 addi t0, a0, -48
	 
placementPiece:
	#ici on trouve la premiere rangee qui est vide pour la colonne donnee en input
	li t1, 0
	li t2, 0 #compteur pour  se rendre jusqu a la colonne en input
loop:
	beq t2, t0, rangee1Vide
	addi t2,t2, 1
	addi t1, t1,4
	j loop
	
rangee1Vide:
	li t5, 46 #code ascii pour '.'
	#regarde si rangee1 est vide
	la t3, range1
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee2Vide:
	la t3, range2
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee3Vide:
	la t3, range3
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee4Vide:
	la t3, range4
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee5Vide:
	la t3, range5
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee6Vide:
	la t3, range6
	add t3, t3, t1
	lw t4, (t3)
	beq t4, t5, addPieceX
	
rangee7Vide:
	#rangee 7 est certainement vide donc on regarde quelle joueur place une piece sur cette rangee
	#et le faisont perdre
	la t3, range7
	add t3, t3, t1
	lw t4, (t3)
	li t6,1
	beq s8, t6, rangee7X
	sw s9, (t3)
	
	j joueurActuelPerd
	
rangee7X:
	sw s10, (t3)
	j joueurActuelPerd
addPieceX:
	#ajoute la piece dans la grille de Jeux
	li t6, 1
	beq s8, t6, addPieceO
	sw s9, (t3)
	j checkGagnant
	
addPieceO:
	sw s10, (t3)
	j checkGagnant

afficherRangee7:
	li t1, 7
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range7
	parcourRangee7:
		ecall
		addi a0, a0, 4
		beq t0, t1, affichageGrille
		addi t0, t0, 1
		j parcourRangee7	
	
affichageGrille:
#parcourir la matrice afin d'afficher tout les éléments
#pour ce faire il faut parcourir toute les colones de chaque rangee
	li t0, 0
	li t1, 7
	li a7, PrintString
	la a0, sautLigne
	ecall
	
afficherRangee6:
	la a0, range6
	parcourRangee6:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee5
		addi t0, t0, 1
		j parcourRangee6
		
afficherRangee5:
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range5
	parcourRangee5:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee4
		addi t0, t0, 1
		j parcourRangee5
		
afficherRangee4:
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range4
	parcourRangee4:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee3
		addi t0, t0, 1
		j parcourRangee4
		
afficherRangee3:
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range3
	parcourRangee3:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee2
		addi t0, t0, 1
		j parcourRangee3
		
afficherRangee2:
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range2
	parcourRangee2:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee1
		addi t0, t0, 1
		j parcourRangee2
		
afficherRangee1:
	li t0, 0
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	la a0, range1
	parcourRangee1:
		ecall
		addi a0, a0, 4
		beq t0, t1, afficherRangee0
		addi t0, t0, 1
		j parcourRangee1
		
afficherRangee0:
	li a0, 58
	li a7, PrintChar
	ecall
	li a7, PrintString
	la a0, sautLigne
	ecall
	li t0, d
	beq a2,t0, retourInput
	li t0,39
	beq s3,t0, affichagePerdu
	j joueurActuelGagneFin
	
retourInput:
	j inputJoueur
	
affichagePerdu:
	j joueurActuelPerdFin

	
	# Afficher le message du joueur actuel
	beqz s8, afficherJoueurO
	li a7, PrintString
	la a0, tourJoueurX
	ecall
	j finAffichage
	
afficherJoueurO:
	li a7, PrintString
	la a0, tourJoueurO
	ecall
	
finAffichage:
	# Prochaine entree
	j inputJoueur
	
erreurEntre:
	# Afficher le message d'erreur
	li a7, PrintString
	la a0, messageErreur
	ecall
	# prochaine entree
	j inputJoueur
	
changeJoueur:
	# Changer de joueur
	xori s8, s8, 1
	# Prochaine entree
	j inputJoueur

checkGagnant:

checkHorizontal:
checkHorizontalRangee1:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee1:
			addi t2, t2, 1
			beq t2,t0, checkHorizontalRangee2
			la s1, range1
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint1
			beq s4, s9, dansLoopHorizontalRangee1
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee1
			
			dansLoopHorizontalRangee1:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee1
				
			loopHorizontalPoint1:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee1
				
	checkHorizontalRangee2:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee2:
			addi t2, t2, 1
			beq t2,t0, checkHorizontalRangee3
			la s1, range2
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint2
			beq s4, s9, dansLoopHorizontalRangee2
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee2
			
			dansLoopHorizontalRangee2:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee2
				
			loopHorizontalPoint2:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee2

checkHorizontalRangee3:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee3:
			addi t2, t2, 1
			beq t2,t0, checkHorizontalRangee4
			la s1, range3
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint3
			beq s4, s9, dansLoopHorizontalRangee3
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee3
			
			dansLoopHorizontalRangee3:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee3
				
			loopHorizontalPoint3:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee3
				
checkHorizontalRangee4:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee4:
			addi t2, t2, 1
			beq t2,t0, checkHorizontalRangee5
			la s1, range4
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint4
			beq s4, s9, dansLoopHorizontalRangee4
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee4
			
			dansLoopHorizontalRangee4:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee4
			
			loopHorizontalPoint4:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee4
				
checkHorizontalRangee5:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee5:
			addi t2, t2, 1
			beq t2,t0, checkHorizontalRangee6
			la s1, range5
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint5
			beq s4, s9, dansLoopHorizontalRangee5
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee5
			
			dansLoopHorizontalRangee5:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee5
				
			loopHorizontalPoint5:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee5
checkHorizontalRangee6:
	li s0, 0 
	li s2, 0 #compteur piece X
	li s3, 0 #compteur piece O
	li t0, 8
	li t2, 0#colonne actuelle
	li t3, 4 #nombre de piece pour gagner
		loopHorizontalRangee6:
			addi t2, t2, 1
			beq t2,t0,checkVertical 
			la s1, range6
			addi s0,s0,4
			add s1, s1, s0
			lw s4, (s1)
			li t1, 46 # Code ASCII de '.'
			beq s4,t1, loopHorizontalPoint6
			beq s4, s9, dansLoopHorizontalRangee6
			li s3, 0
			addi s2,s2,1
			beq s2, t3, joueurActuelGagne
			j loopHorizontalRangee6
			
			dansLoopHorizontalRangee6:
				li s2, 0
				addi s3,s3,1
				beq s3, t3, joueurActuelGagne
				j loopHorizontalRangee6	
				
			loopHorizontalPoint6:
			li s3, 0	
			li s2, 0
			j loopHorizontalRangee6	



checkVertical:
	li s0, 1 #index de la colonne courante
	li t3, 4 #nombre de piece necessaire
	loopColonne:
		li t0 matM
		bge s0, t0, checkDiagonale
		li s1, 0 #indice ligne courante
		li t1, 0 #nombre de X
		li t2, 0 #nombre de O
	loopRangee:
		li t0, matN
		beq t1,t3, joueurActuelGagne
		beq t2,t3, joueurActuelGagne
		bge s1, t0, verticalNextColonne
		# Adresse du pointeur vers la ligne
		slli s4,s1,3
		add s4,s4, s11
		ld s4 (s4)
		
		slli s3, s0, 2
		add s3, s3, s4
		lw s5, 0(s3)
		addi s1,s1, 1
		beq s9, s5, verticalX
		beq s10, s5,verticalO
		j loopRangee
		
verticalX:
	addi t1, t1, 1
	li t2, 0
	j loopRangee
		
verticalO:
	addi t2, t2, 1
	li t1, 0
	j loopRangee
	
verticalNextColonne:
	addi s0,s0,1
	j loopColonne
checkDiagonale:
    li t0, 6  # nombre de colonnes
    li t1, 5  # nombre de lignes
    li t2, 0  # colonne actuelle
    li t3, 4  # nombre de pièces pour gagner

    # Vérification des diagonales ascendantes
    li t4, 0  # compteur de pièces alignées
    li t5, 0  # indice de la ligne

loopDiagonaleAsc:
    beq t2, t0, checkDiagonaleDesc
    la s0, mat
    slli s1, t5, 3
    add s0, s0, s1
    slli s2, t2, 2
    add s0, s0, s2
    lw s3, 0(s0)
    li t6, 46  # Code ASCII de '.'
    beq s3, t6, resetDiagonaleAsc
    beq s3, s9, incrementDiagonaleAscX
    beq s3, s10, incrementDiagonaleAscO

resetDiagonaleAsc:
    li t4, 0
    j incrementDiagonaleAsc

incrementDiagonaleAscX:
    addi t4, t4, 1
    beq t4, t3, joueurActuelGagne
    j incrementDiagonaleAsc

incrementDiagonaleAscO:
    li t4, 0
    j incrementDiagonaleAsc

incrementDiagonaleAsc:
    addi t5, t5, 1
     bne t5, t1, loopDiagonaleAsc     

checkDiagonaleDesc:
    # Vérification des diagonales descendantes
    li t5, 3  # nombre de pièces pour gagner
    li t4, 0  # compteur de pièces alignées
    
loopDiagonaleDesc:
    beq t2, t0, nextColonneDesc
    la s0, mat
    slli s1, t4, 3
    add s0, s0, s1
    slli s2, t2, 2
    add s0, s0, s2
    lw s3, 0(s0)
    li t6, 46  # Code ASCII de '.'
    beq s3, t6, resetDiagonaleDesc
    beq s3, s9, incrementDiagonaleDescX
    beq s3, s10, incrementDiagonaleDescO

resetDiagonaleDesc:
    li t4, 0
    j incrementDiagonaleDescX

incrementDiagonaleDescX:
    addi t4, t4, 1
    beq t4, t5, joueurActuelGagne
    j nextColonneDesc

incrementDiagonaleDescO:
    li t4, 0
    j nextColonneDesc

nextColonneDesc:
    addi t2, t2, 1
    bne t2, t0, loopDiagonaleDesc  # Ajout de la vérification s'il y a toujours des colonnes à vérifier
    j changeJoueur  # Aucun gagnant, changer de joueur
	
	
joueurActuelGagne:
	jal affichageGrille
joueurActuelGagneFin:
	li a7,PrintString
	beqz s8, JoueurXGagne
	la a0, joueurOgagne
	ecall
	j terminerPartie
	
JoueurXGagne:
	la a0, joueurXgagne
	ecall
	j terminerPartie
	
joueurActuelPerd:
	li s3, 39
	j afficherRangee7
joueurActuelPerdFin:
	li a7,PrintString
	beqz s8, JoueurXPerd
	la a0, joueurOperd
	ecall
	j terminerPartie
	
JoueurXPerd:
	la a0, joueurXperd
	ecall
	j terminerPartie

terminerPartie:
	# Terminer le programme
	li a7, Exit
	ecall
	

	
	
	
	 
	  
	
	


	

	
	
	
	
	
	
