const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - generate random values");
    defer rl.CloseWindow();

    var rand_value = rl.GetRandomValue(-8, 5);
    var frames_counter: usize = 0;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            frames_counter += 1;

            if ((frames_counter / 120) % 2 == 1) {
                rand_value = rl.GetRandomValue(-8, 5);
                frames_counter = 0;
            }
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawText("Every 2 seconds a new value is generated:", 130, 100, 20, rl.MAROON);
            rl.DrawText(rl.TextFormat("%i", rand_value), 360, 180, 80, rl.LIGHTGRAY);
        }
    }
}
