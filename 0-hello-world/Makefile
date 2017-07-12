AS := as
LD := ld
RM := rm

hello: hello-world.o
	$(LD) -o hello-world $<

%.o: %.S
	$(AS) -o $@ $<

clean:
	$(RM) *.o
	$(RM) hello-world
