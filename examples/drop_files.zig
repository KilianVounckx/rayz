const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

const max_filepath_recorded = 4096;
const max_filepath_size = 2048;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - drop files", .{});
    defer rl.window.close();
    _ = rl.setAllocator(allocator);

    var file_path_counter: usize = 0;

    var file_paths: [max_filepath_recorded][:0]u8 = undefined;
    for (&file_paths) |*path| {
        path.* = try allocator.allocSentinel(u8, max_filepath_size, 0);
    }
    defer for (file_paths) |path| allocator.free(path);

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { //update
            if (rl.isFileDropped()) {
                const dropped_files = rl.loadDroppedFiles();
                defer rl.unloadDroppedFiles(dropped_files);
                var i: usize = 0;
                const offset = file_path_counter;
                while (i < dropped_files.count) : (i += 1) {
                    if (file_path_counter < max_filepath_recorded - 1) {
                        std.mem.copy(u8, file_paths[offset + i], std.mem.span(dropped_files.paths[i]));
                        file_path_counter += 1;
                    }
                }
            }
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);

            if (file_path_counter == 0) {
                rl.draw.text("Drop your files to this window!", .{ .position = .{ .x = 100, .y = 40 }, .font_size = 20, .color = rl.Color.DARKGRAY });
            } else {
                rl.draw.text("Dropped files:", .{ .position = .{ .x = 100, .y = 40 }, .font_size = 20, .color = rl.Color.DARKGRAY });
                for (file_paths[0..file_path_counter], 0..) |path, i| {
                    if (i % 2 == 0)
                        rl.draw.rectangle(
                            .{ .x = 0, .y = 85 + 40 * @intToFloat(f32, i), .width = screen_width, .height = 40 },
                            rl.Color.LIGHTGRAY.fade(0.5),
                            .{},
                        )
                    else
                        rl.draw.rectangle(
                            .{ .x = 0, .y = 85 + 40 * @intToFloat(f32, i), .width = screen_width, .height = 40 },
                            rl.Color.LIGHTGRAY.fade(0.3),
                            .{},
                        );

                    rl.draw.text(path, .{ .position = .{ .x = 120, .y = 100 + 40 * @intToFloat(f32, i) }, .font_size = 10, .color = rl.Color.GRAY });
                }
            }
        }
    }
}
