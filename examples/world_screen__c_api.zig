const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - world screen");
    defer rl.CloseWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };
    var cube_screen_position = rl.Vector2{ .x = 0, .y = 0 };

    rl.DisableCursor();

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            rl.UpdateCamera(&camera, rl.CAMERA_THIRD_PERSON);
            cube_screen_position = rl.GetWorldToScreen(.{ .x = cube_position.y, .y = cube_position.y + 2.5, .z = cube_position.z }, camera);
        }
        { //draw
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

            rl.DrawText(
                "Enemy: 100 / 100",
                @floatToInt(i32, cube_screen_position.x) - @divFloor(rl.MeasureText("Enemy: 100 / 100", 20), 2),
                @floatToInt(i32, cube_screen_position.y),
                20,
                rl.BLACK,
            );

            rl.DrawText(
                rl.TextFormat(
                    "Cube position in screen space coordinates: [%i, %i]",
                    @floatToInt(i32, cube_screen_position.x),
                    @floatToInt(i32, cube_screen_position.y),
                ),
                10,
                10,
                20,
                rl.LIME,
            );
            rl.DrawText("Text 2d should be always on top of the cube", 10, 40, 20, rl.GRAY);
        }
    }
}
