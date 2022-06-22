
icedewma: src/icedewma.nim
	nim c -o:$@ $<

ewma.pdf: ewma.sil
	sile $<

