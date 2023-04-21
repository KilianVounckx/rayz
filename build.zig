const std = @import("std");

const raylib = @import("libs/raylib/src/build.zig");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "rayz",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibrary(raylib.addRaylib(b, target, optimize));

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/lib.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_main_tests = b.addRunArtifact(main_tests);

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build test`
    // This will evaluate the `test` step rather than the default, which is "install".
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);

    { // examples
        var dir = try std.fs.cwd().openIterableDir("examples", .{});
        defer dir.close();
        var walker = try dir.walk(b.allocator);
        defer walker.deinit();
        while (try walker.next()) |entry| {
            if (entry.kind != .File) continue;
            if (!std.mem.eql(u8, std.fs.path.extension(entry.basename), ".zig")) continue;

            const full_path = try std.fmt.allocPrint(b.allocator, "examples/{s}", .{entry.path});
            defer b.allocator.free(full_path);

            const exe_name = try b.allocator.dupe(u8, entry.path[0 .. entry.path.len - 4]);
            defer b.allocator.free(exe_name);
            for (exe_name) |*c| {
                if (c.* == std.fs.path.sep) {
                    c.* = '-';
                }
            }

            const exe = b.addExecutable(.{
                .name = exe_name,
                // In this case the main source file is merely a path, however, in more
                // complicated build scripts, this could be a generated file.
                .root_source_file = .{ .path = full_path },
                .target = target,
                .optimize = optimize,
            });
            exe.step.dependOn(&lib.step);

            exe.override_dest_dir = .{ .custom = "examples" };

            link("raylib", b, exe);

            // This declares intent for the executable to be installed into the
            // standard location when the user invokes the "install" step (the default
            // step when running `zig build`).
            b.installArtifact(exe);

            // This *creates* a RunStep in the build graph, to be executed when another
            // step is evaluated that depends on it. The next line below will establish
            // such a dependency.
            const run_cmd = b.addRunArtifact(exe);

            // By making the run step depend on the install step, it will be run from the
            // installation directory rather than directly from within the cache directory.
            // This is not necessary, however, if the application depends on other installed
            // files, this ensures they will be present and in the expected location.
            run_cmd.step.dependOn(b.getInstallStep());

            // This allows the user to pass arguments to the application in the build
            // command itself, like this: `zig build run -- arg1 arg2 etc`
            if (b.args) |args| {
                run_cmd.addArgs(args);
            }

            const run_name = try std.fmt.allocPrint(b.allocator, "run-{s}", .{exe_name});
            defer b.allocator.free(run_name);

            const run_help_name = try std.fmt.allocPrint(b.allocator, "Run the {s} example", .{exe_name});
            defer b.allocator.free(run_help_name);

            // This creates a build step. It will be visible in the `zig build --help` menu,
            // and can be selected like this: `zig build run`
            // This will evaluate the `run` step rather than the default, which is "install".
            const run_step = b.step(run_name, run_help_name);
            run_step.dependOn(&run_cmd.step);
        }
    }
}

pub fn link(name: []const u8, b: *std.Build, step: *std.build.CompileStep) void {
    step.addModule(name, b.createModule(.{ .source_file = .{ .path = "src/lib.zig" } }));
    step.linkLibrary(raylib.addRaylib(b, step.target, step.optimize));
}
