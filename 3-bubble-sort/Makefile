AS := as
LD := ld
RM := rm

bubble-sort: bubble-sort.o
	$(LD) -o bubble-sort $<					\
		 /usr/lib/x86_64-linux-gnu/crt1.o		\
		 /usr/lib/x86_64-linux-gnu/crti.o		\
		 -lc						\
		 /usr/lib/x86_64-linux-gnu/crtn.o		\
		 --dynamic-linker=/lib64/ld-linux-x86-64.so.2

%.o: %.S
	$(AS) -o $@ $<

clean:
	$(RM) *.o
	$(RM) bubble-sort
