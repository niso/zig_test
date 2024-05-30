const std = @import("std");
const Compile = std.Build.Step.Compile;

fn set_neurala_deps(comp: *const *Compile) void {
    comp.*.addIncludePath(.{ .cwd_relative = "C:/Program Files/Neurala/InspectorLib/include" });
    comp.*.addLibraryPath(.{ .cwd_relative = "C:/Program Files/Neurala/InspectorLib/lib" });
    comp.*.linkSystemLibrary("NeuralaInspectorLib");
    comp.*.linkLibC();
}

fn build_test(b: *std.Build, target: *const std.Build.ResolvedTarget, optimize: *const std.builtin.OptimizeMode) void {
    const zig_tests = b.addTest(.{ .name = "zig_tests", .target = target.*, .optimize = optimize.*, .root_source_file = .{ .cwd_relative = "src/tests.zig" } });

    zig_tests.addCSourceFile(.{ .file = b.path("src/test.c") });
    zig_tests.addIncludePath(b.path("src"));
    set_neurala_deps(&zig_tests);

    const run_zig_tests = b.addRunArtifact(zig_tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_zig_tests.step);
}

fn build_zig_exe(b: *std.Build, target: *const std.Build.ResolvedTarget, optimize: *const std.builtin.OptimizeMode) void {
    const zig_example = b.addExecutable(.{ .name = "zig_example", .target = target.*, .optimize = optimize.*, .root_source_file = .{ .cwd_relative = "src/example_api.zig" } });
    zig_example.addIncludePath(.{ .cwd_relative = "include" });
    set_neurala_deps(&zig_example);
    b.installArtifact(zig_example);
}

fn build_c_exe(b: *std.Build, target: *const std.Build.ResolvedTarget, optimize: *const std.builtin.OptimizeMode) void {
    const c_example = b.addExecutable(.{
        .name = "c_example",
        .target = target.*,
        .optimize = optimize.*,
    });
    c_example.addCSourceFiles(.{ .root = b.path("src"), .files = &.{ "test.c", "example_api.c" } });
    set_neurala_deps(&c_example);
    b.installArtifact(c_example);
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    build_c_exe(b, &target, &optimize);
    build_zig_exe(b, &target, &optimize);
    build_test(b, &target, &optimize);
}
