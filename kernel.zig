

const Stivale2 = packed struct {
    entry_point: u64,
    stack: u64,
    flags: u64,
    tags: u64,
};

export var stivalehdr linksection(".stivale2hdr") = Stivale2{
    .entry_point = 0,
    .stack = 0,
    .flags = 0,
    .tags = 0,
};

export fn _start() callconv(.Naked) noreturn {
    while (true) {}
}