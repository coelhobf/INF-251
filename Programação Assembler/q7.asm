# 7 - Procurar um elemento no vetor.
# Elemento a ser procurado na posição 104
# Guarda na posição 108 o indice do elemento no vetor, se não achar -1


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

li		$t4, 3		        # $t4 = 3
sw		$t4, 4($s1)			# el = 3

# main
# le da memória
add		$s3, $s0, $zero		# $s3 <- v;
lw      $s4, 0($s1)         # $s4 <- n;
lw		$s5, 4($s1)			# $s5 <- el;

# $t3 = comp;

li		$s6, -1				# $s6 = pos = -1
addi 	$s4, $s4, -1		# n = n - 1

loop:

	slt 	$t3, $s4, $zero		# $t3 <- comp = n < 0
	bne 	$t3, $zero, finish	# se n < 0 jump finish

	sll 	$t4, $s4, 2			# $t4 <- i = n << 2
	add		$t5, $s3, $t4		# $t5 <- p = v + i
	lw		$t6, 0($t5)			# $t6 <- val = *v	

	bne		$t6, $s5, out		# val != el jump out
		addi 	$s6, $s4, 0			# pos = n
out:
	addi $s4, $s4, -1
	j 	loop
finish:
# salvar ordenadas
sw      $s6, 8($s1)        # $s5 = sum;
