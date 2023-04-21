const rl = @import("raylib").c.raylib;
const MouseButton = @import("raylib").input.MouseButton;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.core.InitWindow(screen_width, screen_height, "raylib [core] example - mouse input");
    defer rl.core.CloseWindow();

    var ball_position = rl.structs.Vector2{ .x = -100, .y = 100 };
    var ball_color = rl.colors.DARKBLUE;

    rl.core.SetTargetFPS(60);

    while (!rl.core.WindowShouldClose()) {
        { // update
            ball_position = rl.core.GetMousePosition();

            ball_color = if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.left)))
                rl.colors.MAROON
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.middle)))
                rl.colors.LIME
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.right)))
                rl.colors.DARKBLUE
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.side)))
                rl.colors.PURPLE
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.extra)))
                rl.colors.YELLOW
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.forward)))
                rl.colors.ORANGE
            else if (rl.core.IsMouseButtonPressed(@enumToInt(MouseButton.back)))
                rl.colors.BEIGE
            else
                ball_color;
        }
        { // draw
            rl.core.BeginDrawing();
            defer rl.core.EndDrawing();

            rl.core.ClearBackground(rl.colors.RAYWHITE);

            rl.shapes.DrawCircleV(ball_position, 40, ball_color);
            rl.text.DrawText(
                "move ball with mouse and click mouse button to change color",
                10,
                10,
                20,
                rl.colors.DARKGRAY,
            );
        }
    }
}
