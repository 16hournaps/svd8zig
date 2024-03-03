const std = @import("std");

pub fn build(Build: *std.Build) void {
    const target = Build.standardTargetOptions(.{});
    const mode = Build.standardOptimizeOption(.{});
    const exe = Build.addExecutable(.{
        .name = "svd8zig",
        .target = target,
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = mode,
    });

    Build.installArtifact(exe);
}
