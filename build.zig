const std = @import("std");

pub fn build(b: *std.Build) !void {
    const exe = b.addExecutable(.{
        .name = "cmp2pcap",
        .root_source_file = b.path("main.zig"),
        .target = b.graph.host,
    });

    // Add include path for quicklz.h
    exe.addIncludePath(.{
        .src_path = .{
            .owner = b,
            .sub_path = "lib",
        },
    });

    // Add quicklz.c as a C source file
    exe.addCSourceFile(.{
        .file = b.path("lib/quicklz.c"),
        .flags = &.{},
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the program");
    run_step.dependOn(&run_cmd.step);
}

// zig 0.14.0-dev.3298
