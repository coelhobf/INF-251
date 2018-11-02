# 1 Maior - Seja as variaveis A e B armazenadas na memória 100 e 108
# Escrever na posição 116 o maior valor. Seja $s0 = 100, $zero = 0

# preparação dos valores
add		$s0, $gp, 100		# $s0 = 100

li		$t4, 45		        # $t4 = 45
sw		$t4, 0($s0)		# inicializa A como 45

li		$t4, 50		        # $t4 = 45
sw		$t4, 8($s0)		# inicializa B como 50

# main
lw		$t0, 0($s0)		    # $t0 = A;
lw      $t1, 8($s0)         # $t1 = B;

slt     $t3, $t0, $t1       # $t3 = $t0 < $t1 ? 1 : 0; se A < B;

beq		$t3, $zero, else	# if $t3 == $zero then else
	sw		$t1, 16($s0)    # mem($s0 + 16) <- $t1
	j		exit			# jump to exit
	
else:
	sw		$t0, 16($s0)    # mem($s0 + 16) <- $t0 
exit:


