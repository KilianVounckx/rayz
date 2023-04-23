const rl = @import("raylib").c.raylib;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - input mouse wheel");
    defer rl.CloseWindow();

    var box_position_y: f32 = screen_height / 2 - 40;
    const scroll_speed = 4;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // update
            box_position_y -= rl.GetMouseWheelMove() * scroll_speed;
        }
        { // draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawRectangle(screen_width / 2 - 40, @floatToInt(i32, box_position_y), 80, 80, rl.MAROON);
            rl.DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, rl.GRAY);

            rl.DrawText(rl.TextFormat("Box position Y: %03i", box_position_y), 10, 40, 20, rl.LIGHTGRAY);
        }
    }
}
