const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - 3d camera mode");
    defer rl.CloseWindow();

    const camera = rl.Camera3D{
        .position = .{ .x = 0, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
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

        rl.DrawText("Welcome to the third dimension!", 10, 40, 20, rl.DARKGRAY);
        rl.DrawFPS(10, 10);
    }
}
