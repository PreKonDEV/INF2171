.data
d:	.dword 0x0123456789ABCDEF
.text
	la s0, d
	lb s1, 0(s0)
	lb s2, 0(s0)
	lb s3, 1(s0)
	lbu s4, 2(s0)
	lw s5, 0(s0)
	lhu s6, 4(s0)
	lhu s7, 2(s0)
