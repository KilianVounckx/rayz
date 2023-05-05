const rl = @import("raylib").c;

const max_filepath_recorded = 4096;
const max_filepath_size = 2048;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - drop files");
    defer rl.CloseWindow();

    var file_path_counter: usize = 0;

    var file_paths: [max_filepath_recorded][*:0]u8 = undefined;
    for (&file_paths) |*path| {
        path.* = @ptrCast([*:0]u8, rl.RL_CALLOC(max_filepath_size, 1).?);
    }
    defer for (file_paths) |path| {
        rl.RL_FREE(path);
    };

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            if (rl.IsFileDropped()) {
                const dropped_files = rl.LoadDroppedFiles();
                defer rl.UnloadDroppedFiles(dropped_files);
                var i: usize = 0;
                var offset = file_path_counter;
                while (i < dropped_files.count) : (i += 1) {
                    if (file_path_counter < max_filepath_recorded - 1) {
                        _ = rl.TextCopy(file_paths[offset + i], dropped_files.paths[i]);
                        file_path_counter += 1;
                    }
                }
            }
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);

            if (file_path_counter == 0) {
                rl.DrawText("Drop your files to this window!", 100, 40, 20, rl.DARKGRAY);
            } else {
                rl.DrawText("Dropped files:", 100, 40, 20, rl.DARKGRAY);
                for (file_paths[0..file_path_counter], 0..) |path, i| {
                    if (i % 2 == 0)
                        rl.DrawRectangle(0, 85 + 40 * @intCast(i32, i), screen_width, 40, rl.Fade(rl.LIGHTGRAY, 0.5))
                    else
                        rl.DrawRectangle(0, 85 + 40 * @intCast(i32, i), screen_width, 40, rl.Fade(rl.LIGHTGRAY, 0.3));

                    rl.DrawText(path, 120, 100 + 40 * @intCast(i32, i), 10, rl.GRAY);
                }
            }
        }
    }
}
