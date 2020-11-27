const VGA = @import("vga.zig");

const Stivale2 = packed struct {
    entry_point: u64,
    stack: u64,
    flags: u64,
    tags: u64,
};

export var stack: [16 * 1024]u8 align(16) linksection(".bss") = undefined;
const stack_slice = stack[0..];

export var stivalehdr linksection(".stivale2hdr") = Stivale2{
    .entry_point = 0,
    .stack = 0,
    .flags = 0,
    .tags = 0,
};

export fn _start() callconv(.Naked) noreturn {
    @call(.{ .stack = stack_slice }, kmain, .{});
    while (true) {}
}

fn kmain() void {
    VGA.clear();
    VGA.putstr("Hello x64 World\nFrom Zig");
}