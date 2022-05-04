BIN = call_func

all: $(BIN)

CFLAGS      = -O0 -mshstk -fno-stack-check -fno-stack-protector -no-pie
SHSTKFLAGS      = -O0 -mshstk -fcf-protection=return -fno-stack-check -fno-stack-protector -no-pie

call_func:
	gcc $(CFLAGS) -o call_func call_func.c

clean:
	rm -f $(BIN)
