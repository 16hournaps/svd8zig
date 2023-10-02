const std = @import("std");
const Builder = std.build.Builder;

pub fn build(Build: *Builder) void {
    const mode = Build.standardOptimizeOption(.{});
    const exe = Build.addExecutable(.{
        .name = "svd8zig",
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = mode,
    });

    Build.installArtifact(exe);
}
