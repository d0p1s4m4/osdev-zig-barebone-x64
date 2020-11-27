const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;
const vram = @intToPtr([*]volatile u16, 0xB8000);

var x: u8 = 0;
var y: u8 = 0;

pub fn clear() void {
    var w: u8 = 0;
    var h: u8 = 0;

    while (h < VGA_HEIGHT) : (h += 1) {
        w = 0;
        while (w < VGA_WIDTH) : (w += 1) {
            vram[h * VGA_WIDTH + w] = 0x0020;
        }
    }
}

fn scrollup() void {
    var w: u8 = 0;
    var h: u8 = 1;

    while (h < VGA_HEIGHT) : (h += 1) {
        w = 0;
        while (w < VGA_WIDTH) : (w += 1) {
            vram[(h - 1) * VGA_WIDTH + w] = vram[h * VGA_WIDTH + w];
        }
    }

    // clear last line
    h = VGA_HEIGHT - 1;
    w = 0;
    while (w < VGA_WIDTH) : (w += 1) {
        vram[(h - 1) * VGA_WIDTH + w] = 0x0020;
    }
}

fn putentry(c: u8, fg: u8, bg: u8) void {
    if (c == '\n') {
        y += 1;
        x = 0;
        if (y == VGA_HEIGHT) {
            scrollup();
        }
    } else {
        const color: u16 = fg | (bg << 4);
        vram[y * VGA_WIDTH + x] = c | (color << 8);
        x += 1;
    }
}

pub fn putchar(c: u8) void {
    putentry(c, 0xF, 0x0);
}

pub fn putstr(str: []const u8) void {
    for (str) |c| {
        putchar(c);
    }
}