const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.SetConfigFlags(rl.FLAG_WINDOW_TRANSPARENT);
    rl.InitWindow(screen_width, screen_height, "raylib [core] example - window flags");
    defer rl.CloseWindow();

    var ball_position = rl.Vector2{ .x = @intToFloat(f32, rl.GetScreenWidth()) / 2, .y = @intToFloat(f32, rl.GetScreenHeight()) / 2 };
    var ball_speed = rl.Vector2{ .x = 5, .y = 4 };
    const ball_radius = 20;

    var frame_counter: u32 = 0;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            if (rl.IsKeyPressed(rl.KEY_F))
                rl.ToggleFullscreen();

            if (rl.IsKeyPressed(rl.KEY_R)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_RESIZABLE))
                    rl.ClearWindowState(rl.FLAG_WINDOW_RESIZABLE)
                else
                    rl.SetWindowState(rl.FLAG_WINDOW_RESIZABLE);
            }

            if (rl.IsKeyPressed(rl.KEY_D)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_UNDECORATED))
                    rl.ClearWindowState(rl.FLAG_WINDOW_UNDECORATED)
                else
                    rl.SetWindowState(rl.FLAG_WINDOW_UNDECORATED);
            }

            if (rl.IsKeyPressed(rl.KEY_H)) {
                if (!rl.IsWindowState(rl.FLAG_WINDOW_HIDDEN))
                    rl.SetWindowState(rl.FLAG_WINDOW_HIDDEN);
                frame_counter = 0;
            }
            if (rl.IsWindowState(rl.FLAG_WINDOW_HIDDEN)) {
                frame_counter += 1;
                if (frame_counter >= 240)
                    rl.ClearWindowState(rl.FLAG_WINDOW_HIDDEN);
            }

            if (rl.IsKeyPressed(rl.KEY_N)) {
                if (!rl.IsWindowState(rl.FLAG_WINDOW_MINIMIZED))
                    rl.MinimizeWindow();
                frame_counter = 0;
            }

            if (rl.IsWindowState(rl.FLAG_WINDOW_MINIMIZED)) {
                frame_counter += 1;
                if (frame_counter >= 240)
                    rl.RestoreWindow();
            }

            if (rl.IsKeyPressed(rl.KEY_M)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_MAXIMIZED))
                    rl.RestoreWindow()
                else
                    rl.MaximizeWindow();
            }

            if (rl.IsKeyPressed(rl.KEY_U)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_UNFOCUSED))
                    rl.ClearWindowState(rl.FLAG_WINDOW_UNFOCUSED)
                else
                    rl.SetWindowState(rl.FLAG_WINDOW_UNFOCUSED);
            }

            if (rl.IsKeyPressed(rl.KEY_T)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_TOPMOST))
                    rl.ClearWindowState(rl.FLAG_WINDOW_TOPMOST)
                else
                    rl.SetWindowState(rl.FLAG_WINDOW_TOPMOST);
            }

            if (rl.IsKeyPressed(rl.KEY_A)) {
                if (rl.IsWindowState(rl.FLAG_WINDOW_ALWAYS_RUN))
                    rl.ClearWindowState(rl.FLAG_WINDOW_ALWAYS_RUN)
                else
                    rl.SetWindowState(rl.FLAG_WINDOW_ALWAYS_RUN);
            }

            if (rl.IsKeyPressed(rl.KEY_V)) {
                if (rl.IsWindowState(rl.FLAG_VSYNC_HINT))
                    rl.ClearWindowState(rl.FLAG_VSYNC_HINT)
                else
                    rl.SetWindowState(rl.FLAG_VSYNC_HINT);
            }

            ball_position.x += ball_speed.x;
            ball_position.y += ball_speed.y;

            if (ball_position.x >= @intToFloat(f32, rl.GetScreenWidth()) - ball_radius or
                ball_position.x <= ball_radius)
            {
                ball_speed.x *= -1;
            }
            if (ball_position.y >= @intToFloat(f32, rl.GetScreenHeight()) - ball_radius or
                ball_position.y <= ball_radius)
            {
                ball_speed.y *= -1;
            }
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            if (rl.IsWindowState(rl.FLAG_WINDOW_TRANSPARENT))
                rl.ClearBackground(rl.BLANK)
            else
                rl.ClearBackground(rl.RAYWHITE);

            rl.DrawCircleV(ball_position, ball_radius, rl.MAROON);
            rl.DrawRectangleLinesEx(.{
                .x = 0,
                .y = 0,
                .width = @intToFloat(f32, rl.GetScreenWidth()),
                .height = @intToFloat(f32, rl.GetScreenHeight()),
            }, 4, rl.RAYWHITE);

            rl.DrawCircleV(rl.GetMousePosition(), 10, rl.DARKBLUE);

            rl.DrawFPS(10, 10);

            rl.DrawText(rl.TextFormat(
                "Screen Size: [%i, %i]",
                @intToFloat(f32, rl.GetScreenWidth()),
                @intToFloat(f32, rl.GetScreenHeight()),
            ), 10, 40, 10, rl.GREEN);

            rl.DrawText("Following flags can be set after window creation:", 10, 60, 10, rl.GRAY);
            if (rl.IsWindowState(rl.FLAG_FULLSCREEN_MODE))
                rl.DrawText("[F] FLAG_FULLSCREEN_MODE: on", 10, 80, 10, rl.LIME)
            else
                rl.DrawText("[F] FLAG_FULLSCREEN_MODE: off", 10, 80, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_RESIZABLE))
                rl.DrawText("[R] FLAG_WINDOW_RESIZABLE: on", 10, 100, 10, rl.LIME)
            else
                rl.DrawText("[R] FLAG_WINDOW_RESIZABLE: off", 10, 100, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_UNDECORATED))
                rl.DrawText("[D] FLAG_WINDOW_UNDECORATED: on", 10, 120, 10, rl.LIME)
            else
                rl.DrawText("[D] FLAG_WINDOW_UNDECORATED: off", 10, 120, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_HIDDEN))
                rl.DrawText("[H] FLAG_WINDOW_HIDDEN: on", 10, 140, 10, rl.LIME)
            else
                rl.DrawText("[H] FLAG_WINDOW_HIDDEN: off", 10, 140, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_MINIMIZED))
                rl.DrawText("[N] FLAG_WINDOW_MINIMIZED: on", 10, 160, 10, rl.LIME)
            else
                rl.DrawText("[N] FLAG_WINDOW_MINIMIZED: off", 10, 160, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_MAXIMIZED))
                rl.DrawText("[M] FLAG_WINDOW_MAXIMIZED: on", 10, 180, 10, rl.LIME)
            else
                rl.DrawText("[M] FLAG_WINDOW_MAXIMIZED: off", 10, 180, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_UNFOCUSED))
                rl.DrawText("[G] FLAG_WINDOW_UNFOCUSED: on", 10, 200, 10, rl.LIME)
            else
                rl.DrawText("[U] FLAG_WINDOW_UNFOCUSED: off", 10, 200, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_TOPMOST))
                rl.DrawText("[T] FLAG_WINDOW_TOPMOST: on", 10, 220, 10, rl.LIME)
            else
                rl.DrawText("[T] FLAG_WINDOW_TOPMOST: off", 10, 220, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_ALWAYS_RUN))
                rl.DrawText("[A] FLAG_WINDOW_ALWAYS_RUN: on", 10, 240, 10, rl.LIME)
            else
                rl.DrawText("[A] FLAG_WINDOW_ALWAYS_RUN: off", 10, 240, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_VSYNC_HINT))
                rl.DrawText("[V] FLAG_VSYNC_HINT: on", 10, 260, 10, rl.LIME)
            else
                rl.DrawText("[V] FLAG_VSYNC_HINT: off", 10, 260, 10, rl.MAROON);

            rl.DrawText("Following flags can only be set before window creation:", 10, 300, 10, rl.GRAY);
            if (rl.IsWindowState(rl.FLAG_WINDOW_HIGHDPI))
                rl.DrawText("FLAG_WINDOW_HIGHDPI: on", 10, 320, 10, rl.LIME)
            else
                rl.DrawText("FLAG_WINDOW_HIGHDPI: off", 10, 320, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_WINDOW_TRANSPARENT))
                rl.DrawText("FLAG_WINDOW_TRANSPARENT: on", 10, 340, 10, rl.LIME)
            else
                rl.DrawText("FLAG_WINDOW_TRANSPARENT: off", 10, 340, 10, rl.MAROON);
            if (rl.IsWindowState(rl.FLAG_MSAA_4X_HINT))
                rl.DrawText("FLAG_MSAA_4X_HINT: on", 10, 360, 10, rl.LIME)
            else
                rl.DrawText("FLAG_MSAA_4X_HINT: off", 10, 360, 10, rl.MAROON);
        }
    }
}
