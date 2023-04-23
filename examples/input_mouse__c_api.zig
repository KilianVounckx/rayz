const rl = @import("raylib").c;
const MouseButton = @import("raylib").input.MouseButton;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - mouse input");
    defer rl.CloseWindow();

    var ball_position = rl.Vector2{ .x = -100, .y = 100 };
    var ball_color = rl.DARKBLUE;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // update
            ball_position = rl.GetMousePosition();

            ball_color = if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.left)))
                rl.MAROON
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.middle)))
                rl.LIME
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.right)))
                rl.DARKBLUE
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.side)))
                rl.PURPLE
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.extra)))
                rl.YELLOW
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.forward)))
                rl.ORANGE
            else if (rl.IsMouseButtonPressed(@enumToInt(MouseButton.back)))
                rl.BEIGE
            else
                ball_color;
        }
        { // draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawCircleV(ball_position, 40, ball_color);
            rl.DrawText(
                "move ball with mouse and click mouse button to change color",
                10,
                10,
                20,
                rl.DARKGRAY,
            );
        }
    }
}
