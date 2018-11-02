# 2 - Seja as variaveis a, b e c. armazenadas na memória 100 e 108 e 116
# Seja r2 = 100, r0 = 0, Ordenar a, b e c de forma crescente

# preparação dos valores
addi		$s0, $gp, 100		# $s0 = 100

li		$t4, 9		        # $t4 = 45
sw		$t4, 0($s0)			# inicializa A como 45

li		$t4, 8		        # $t4 = 45
sw		$t4, 8($s0)			# inicializa B como 50

li		$t4, 7		        # $t4 = 60
sw		$t4, 16($s0)		# inicializa C como 60

# main
# le da memória
lw		$s3, 0($s0)		    # $s3 = A;
lw      $s4, 8($s0)         # $s4 = B;
lw      $s5, 16($s0)        # $s5 = C;

# $t3 = comp;

slt $t3, $s4, $s3			# comp = b < a
beq $t3, $zero, p1
	xor $s3, $s3, $s4
	xor $s4, $s3, $s4
	xor $s3, $s3, $s4
	
p1:

slt $t3, $s5, $s3			# comp = c < a
beq $t3, $zero, p2
	xor $s3, $s3, $s5
	xor $s5, $s3, $s5
	xor $s3, $s3, $s5
	
p2:

slt $t3, $s5, $s4			# comp = c < b
beq $t3, $zero, p3
	xor $s4, $s4, $s5
	xor $s5, $s4, $s5
	xor $s4, $s4, $s5
	
p3:
# salvar ordenadas
sw		$s3, 0($s0)		    # $s3 = A;
sw      $s4, 8($s0)         # $s4 = B;
sw      $s5, 16($s0)        # $s5 = C;
