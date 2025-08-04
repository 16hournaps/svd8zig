const std = @import("std");

pub fn build(Build: *std.Build) void {
    const mode = Build.standardOptimizeOption(.{});

    const target = Build.standardTargetOptions(.{});

    const module = Build.addModule("main", .{
        .target = target,
        .optimize = mode,
        .root_source_file = .{
            .cwd_relative = "src/main.zig",
        },
    });

    const exe = Build.addExecutable(.{
        .name = "svd8zig",
        .root_module = module,
    });

    Build.installArtifact(exe);
}
