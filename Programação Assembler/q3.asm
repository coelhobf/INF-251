# 3 - C= A * B = (B + B + B + ... + B)
# r0 = 0, r1 = 100, a, b e c. armazenadas na memória 100 e 108 e 116

# preparação dos valores
addi		$s0, $gp, 100		# $s0 = 100

li		$t4, 3		        # $t4 = 3
sw		$t4, 0($s0)			# inicializa A como 3

li		$t4, 3		        # $t4 = 3
sw		$t4, 8($s0)			# inicializa B como 3

li		$t4, 7		        # $t4 = 7
sw		$t4, 16($s0)		# inicializa C como 7
0
# main
# le da memória
lw		$s3, 0($s0)		    # $s3 = A;
lw      $s4, 8($s0)         # $s4 = B;

# $t3 = comp;

li		$s5, 0				# $s5 = C;
loop:
slt $t3, $zero, $s3
beq $s3, $zero, finish
	add $s5, $s5, $s4
	addi $s3, $s3, -1
	j loop
finish:
# salvar ordenadas
sw      $s5, 16($s0)        # $s5 = C;
