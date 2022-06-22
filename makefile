
ewma: ewma.nim
	nim c -o:$@ $<

ewma.pdf: ewma.sil
	sile $<

