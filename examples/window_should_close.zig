const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - window should close", .{});
    defer rl.window.close();

    rl.input.setExitKey(.null);

    var exit_window_requested = false;
    var exit_window = false;

    rl.setTargetFps(60);

    while (!exit_window) {
        { //update
            if (rl.window.shouldClose() or rl.input.isKeyPressed(.escape)) {
                exit_window_requested = true;
            }
            if (exit_window_requested) {
                if (rl.input.isKeyPressed(.y)) {
                    exit_window = true;
                } else if (rl.input.isKeyPressed(.n)) {
                    exit_window_requested = false;
                }
            }
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);

            if (exit_window_requested) {
                rl.draw.rectangle(.{ .x = 0, .y = 100, .width = screen_width, .height = 200 }, rl.Color.BLACK, .{});
                rl.draw.text("Are you sure you want to exit program? [Y/N]", .{ .position = .{ .x = 40, .y = 100 }, .font_size = 30, .color = rl.Color.WHITE });
            } else {
                rl.draw.text("Try to close the window to get confirmation message!", .{ .position = .{ .x = 120, .y = 200 }, .font_size = 20, .color = rl.Color.LIGHTGRAY });
            }
        }
    }
}
