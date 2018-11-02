# 5 Somatório - Vetor está na posição 200 em diante de 4 em 4 bytes.
# Tamanho esta na posição 100
# Gravar o somatorio na posição 108

# preparação dos valores
addi		$s0, $gp, 200		# $s0 = 200
addi		$s1, $gp, 100		# $s1 = 100

li		$t4, 1		        # $t4 = 1
sw		$t4, 0($s0)			# v[0] = 1

li		$t4, 2		        # $t4 = 2
sw		$t4, 4($s0)			# v[2] = 2

li		$t4, 3		        # $t4 = 3
sw		$t4, 8($s0)			# v[2] = 3

li		$t4, 4		        # $t4 = 4
sw		$t4, 12($s0)		# v[3] = 4

li		$t4, 4		        # $t4 = 4
sw		$t4, 0($s1)			# tam = 4

# main
# le da memória
add		$s3, $s0, $zero		# $s3 = v;
lw      $s4, 0($s1)         # $s4 = n;

# $t3 = comp;

li		$s5, 0				# $s5 = sum = 0
addi	$s4, $s4, -1		# n = n - 1

loop:
	slt 	$t3, $s4, $zero		# comp = n < 0
	bne 	$t3, $zero, finish	# se n < 0 jump finish
	
	sll 	$t5, $s4, 2			# $t5 = i = n << 2
	add 	$t6, $s3, $t5		# $t6 = p = v + i
	lw		$t7, 0($t6)			# $t7 = val = *p

	add 	$s5, $s5, $t7		# sum = sum + val
	addi 	$s4, $s4, -1

	j loop
finish:

# salvar ordenadas
sw      $s5, 8($s1)        # $s5 = sum;
