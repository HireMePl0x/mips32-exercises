.data
	sPrompt: .asciiz "Bitte geben Sie einen Satz ein oder q für quit: "
	lPrompt: .asciiz "Suche nach: "
	resText: .asciiz "Anzahl: "
	crlf: .asciiz "\n"
	sentence: .space 64
	
.text
	read:
	
		li $v0,4
		la $a0,sPrompt
		syscall
	
		li $v0,8 #read sentence
		la $a0,sentence
		la $a1, 64
		syscall
	
		li $v0,4
		la $a0,lPrompt
		syscall
		
		li $v0,12 #read char
		syscall
		move $t1,$v0 #save char in t1
		
		li $v0,4 #\n
		la $a0,crlf
		syscall
		
		la $a0,sentence #set a0 to sentence address
		
		li $t0,0 #init counter t0
	
		j search
	
	search:
		lb $t2,($a0) #get char
		beqz $t2,print
		beq $t2,$t1,found
		return:	
		addi $a0,$a0,1 #address++
		j search
		
	found:
		addi $t0,$t0,1
		j return
		
	print:
		li $v0,4
		la $a0,resText
		syscall
		
		li $v0,1
		la $a0,($t0)
		syscall
		
