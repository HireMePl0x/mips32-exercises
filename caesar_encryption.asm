.data
	prompt1: .asciiz "pls put in string: "
	prompt2: .asciiz "pls put in key: "
	text: .space 64
	
.text
	#main:
		li $v0,4
		la $a0,prompt1
		syscall
	
		li $v0,8 #read text
		la $a0,text
		li $a1,64
		syscall
	
		li $v0,4
		la $a0,prompt2
		syscall
	
		li $v0,5 #read key
		syscall
		move $t0,$v0 #t0 now contains key
		
		li $t3,0
		sub $t3,$t3,$t0 #t3 now contains negative key
	
		la $a0,text #a0 now contains text address
		
		jal print
		
		jal encrypt
		#return:
	
		jal print
		#return2:
		
		la $a0,text
		jal decrypt
		#return3:
		
		jal  print
	
		j end
	
	encrypt: #encrypt current letter
		
		lb $t2,($a0) #load letter to t2
		
		beq $t2,0x0a,return
		
		add $t2,$t2,$t0
		sb $t2,($a0) #override with new letter
		
		addi $a0,$a0,1 #increment address
		
		j encrypt
	
	decrypt:
		lb $t2,($a0) #load letter to t2
		
		beq $t2,0x0a,return
		
		add $t2,$t2,$t3
		sb $t2,($a0) #override with new letter
		
		addi $a0,$a0,1 #increment address
		
		j decrypt
		
	print:
		li $v0,4
		la $a0,text
		syscall
		j return
		
	return:
		jr $ra
	
	end:
	