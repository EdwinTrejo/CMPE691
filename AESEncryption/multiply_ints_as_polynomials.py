def multiply_ints_as_polynomials(x, y):
	if x == 0 or y == 0
		return 0
	z = 0
	while x != 0:
		if x & 1 == 1:
			z ^= y
		y <<= 1
		x >>= 1
	return z
