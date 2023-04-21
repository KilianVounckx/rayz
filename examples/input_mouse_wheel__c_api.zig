const rl = @import("raylib").c.raylib;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.core.InitWindow(screen_width, screen_height, "raylib [core] example - input mouse wheel");
    defer rl.core.CloseWindow();

    var box_position_y: f32 = screen_height / 2 - 40;
    const scroll_speed = 4;

    rl.core.SetTargetFPS(60);

    while (!rl.core.WindowShouldClose()) {
        { // update
            box_position_y -= rl.core.GetMouseWheelMove() * scroll_speed;
        }
        { // draw
            rl.core.BeginDrawing();
            defer rl.core.EndDrawing();

            rl.core.ClearBackground(rl.colors.RAYWHITE);

            rl.shapes.DrawRectangle(screen_width / 2 - 40, @floatToInt(i32, box_position_y), 80, 80, rl.colors.MAROON);
            rl.text.DrawText("Use mouse wheel to move the cube up and down!", 10, 10, 20, rl.colors.GRAY);

            rl.text.DrawText(rl.text.TextFormat("Box position Y: %03i", box_position_y), 10, 40, 20, rl.colors.LIGHTGRAY);
        }
    }
}
