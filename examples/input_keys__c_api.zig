const rl = @import("raylib").c.raylib;
const KeyboardKey = @import("raylib").input.KeyboardKey;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.core.InitWindow(screen_width, screen_height, "raylib [core] example - keyboard input");

    var ball_position = rl.structs.Vector2{ .x = screen_width / 2.0, .y = screen_height / 2.0 };

    rl.core.SetTargetFPS(60);

    while (!rl.core.WindowShouldClose()) {
        { // Update
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.left))) ball_position.x -= 2.0;
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.right))) ball_position.x += 2.0;
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.up))) ball_position.y -= 2.0;
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.down))) ball_position.y += 2.0;
        }
        { // Draw
            rl.core.BeginDrawing();
            defer rl.core.EndDrawing();

            rl.core.ClearBackground(rl.colors.RAYWHITE);
            rl.text.DrawText("move the ball with arrow keys", 10, 10, 20, rl.colors.DARKGRAY);
            rl.shapes.DrawCircleV(ball_position, 50, rl.colors.MAROON);
        }
    }
}
