const rl = @import("raylib").c.raylib;

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - basic window");
    defer rl.CloseWindow();

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.RAYWHITE);
        rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY);
    }
}
