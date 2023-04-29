const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - 3d camera free");
    defer rl.CloseWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };

    rl.DisableCursor();

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // update
            rl.UpdateCamera(&camera, rl.CAMERA_FREE);
            if (rl.IsKeyDown('Z')) {
                camera.target = .{ .x = 0, .y = 0, .z = 0 };
            }
        }
        { // draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);

            {
                rl.BeginMode3D(camera);
                defer rl.EndMode3D();

                rl.DrawCube(cube_position, 2, 2, 2, rl.RED);
                rl.DrawCubeWires(cube_position, 2, 2, 2, rl.MAROON);

                rl.DrawGrid(10, 1);
            }

            rl.DrawRectangle(10, 10, 320, 133, rl.Fade(rl.SKYBLUE, 0.5));
            rl.DrawRectangle(10, 10, 320, 133, rl.BLUE);

            rl.DrawText("Free camera default controls:", 20, 20, 10, rl.BLACK);
            rl.DrawText("- Mouse wheel to zoom in-out", 40, 40, 10, rl.DARKGRAY);
            rl.DrawText("- Mouse wheel pressed to pan", 40, 60, 10, rl.DARKGRAY);
            rl.DrawText("- Alt + Mouse wheel pressed to rotate", 40, 80, 10, rl.DARKGRAY);
            rl.DrawText("- Alt + Ctrl + Mouse wheel pressed for smooth zoom", 40, 100, 10, rl.DARKGRAY);
            rl.DrawText("- Z to zoom to (0, 0, 0)", 40, 120, 10, rl.DARKGRAY);
        }
    }
}
