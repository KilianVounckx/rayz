const rl = @import("raylib").c;
const KeyboardKey = @import("raylib").input.KeyboardKey;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - keyboard input");
    defer rl.CloseWindow();

    var ball_position = rl.Vector2{ .x = screen_width / 2.0, .y = screen_height / 2.0 };

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // Update
            if (rl.IsKeyDown(@enumToInt(KeyboardKey.left))) ball_position.x -= 2.0;
            if (rl.IsKeyDown(@enumToInt(KeyboardKey.right))) ball_position.x += 2.0;
            if (rl.IsKeyDown(@enumToInt(KeyboardKey.up))) ball_position.y -= 2.0;
            if (rl.IsKeyDown(@enumToInt(KeyboardKey.down))) ball_position.y += 2.0;
        }
        { // Draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            rl.ClearBackground(rl.RAYWHITE);
            rl.DrawText("move the ball with arrow keys", 10, 10, 20, rl.DARKGRAY);
            rl.DrawCircleV(ball_position, 50, rl.MAROON);
        }
    }
}
