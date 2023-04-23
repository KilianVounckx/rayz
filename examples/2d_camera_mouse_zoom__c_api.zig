const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - 2d camera mouse zoom");
    defer rl.CloseWindow();

    var camera: rl.Camera2D = undefined;
    camera.zoom = 1;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // update
            if (rl.IsMouseButtonDown(rl.MOUSE_BUTTON_RIGHT)) {
                var delta = rl.GetMouseDelta();
                delta = rl.Vector2Scale(delta, -1 / camera.zoom);
                camera.target = rl.Vector2Add(camera.target, delta);
            }

            const wheel = rl.GetMouseWheelMove();
            if (wheel != 0) {
                camera.offset = rl.GetMousePosition();
                const mouse_world_pos = rl.GetScreenToWorld2D(camera.offset, camera);
                camera.target = mouse_world_pos;

                const zoom_increment = 0.125;
                camera.zoom += wheel * zoom_increment;

                if (camera.zoom < zoom_increment) {
                    camera.zoom = zoom_increment;
                }
            }
        }
        { // draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            rl.ClearBackground(rl.BLACK);

            {
                rl.BeginMode2D(camera);
                defer rl.EndMode2D();

                {
                    rl.rlPushMatrix();
                    defer rl.rlPopMatrix();

                    rl.rlTranslatef(0, 25 * 50, 0);
                    rl.rlRotatef(90, 1, 0, 0);
                    rl.DrawGrid(100, 50);
                }

                rl.DrawCircle(100, 100, 50, rl.YELLOW);
            }

            rl.DrawText("Mouse right button drag to move, mouse wheel to zoom", 10, 10, 20, rl.WHITE);
        }
    }
}
