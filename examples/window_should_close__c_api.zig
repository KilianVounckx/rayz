const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - window should close");
    defer rl.CloseWindow();

    rl.SetExitKey(rl.KEY_NULL);

    var exit_window_requested = false;
    var exit_window = false;

    rl.SetTargetFPS(60);

    while (!exit_window) {
        { //update
            if (rl.WindowShouldClose() or rl.IsKeyPressed(rl.KEY_ESCAPE)) {
                exit_window_requested = true;
            }
            if (exit_window_requested) {
                if (rl.IsKeyPressed(rl.KEY_Y)) {
                    exit_window = true;
                } else if (rl.IsKeyPressed(rl.KEY_N)) {
                    exit_window_requested = false;
                }
            }
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);

            if (exit_window_requested) {
                rl.DrawRectangle(0, 100, screen_width, 200, rl.BLACK);
                rl.DrawText("Are you sure you want to exit program? [Y/N]", 40, 100, 30, rl.WHITE);
            } else {
                rl.DrawText("Try to close the window to get confirmation message!", 120, 200, 20, rl.LIGHTGRAY);
            }
        }
    }
}
