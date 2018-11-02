# 4 - Divisão, C = B / A

# preparação dos valores
addi		$s0, $gp, 100		# $s0 = 100

li		$t4, 3		        # $t4 = 3
sw		$t4, 0($s0)			# inicializa A como 3

li		$t4, 15		        # $t4 = 15
sw		$t4, 8($s0)			# inicializa B como 15

li		$t4, 7		        # $t4 = 7
sw		$t4, 16($s0)		# inicializa C como 7

# main
# le da memória
lw		$s3, 0($s0)		    # $s3 = A;
lw      $s4, 8($s0)         # $s4 = B;

# $t3 = comp;

li		$s5, 0				# $s5 = C;
loop:
slt $t3, $s4, $s3			# comp = b < a
bne $t3, $zero, finish		# se b < a jump finish

	addi $s5, $s5, 1
	sub $s4, $s4, $s3
	j loop

finish:
# salvar ordenadas
sw      $s5, 16($s0)        # $s5 = C;
