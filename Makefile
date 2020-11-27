all:
	zig build-exe -target x86_64-freestanding -Tlinker.ld src/kernel.zig
