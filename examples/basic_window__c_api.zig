const rl = @import("raylib").c.raylib;
const rcore = rl.core;
const rcolors = rl.colors;
const rtext = rl.text;

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rcore.InitWindow(screen_width, screen_height, "raylib [core] example - basic window");
    defer rcore.CloseWindow();

    rcore.SetTargetFPS(60);

    while (!rcore.WindowShouldClose()) {
        rcore.BeginDrawing();
        defer rcore.EndDrawing();

        rcore.ClearBackground(rcolors.RAYWHITE);
        rtext.DrawText("Congrats! You created your first window!", 190, 200, 20, rcolors.LIGHTGRAY);
    }
}
