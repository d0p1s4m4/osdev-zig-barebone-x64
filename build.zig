const builtin = @import("builtin");
const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = std.zig.CrossTarget {
        .cpu_arch = .x86_64,
        .os_tag = .freestanding,
        .abi = .none,
    };
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("init-exe", "src/kernel.zig");
    exe.setLinkerScriptPath(std.build.FileSource{ .path = "linker.ld" });
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
