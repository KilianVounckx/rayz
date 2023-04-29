const rl = @import("raylib").c;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - 3d picking");
    defer rl.CloseWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = rl.CAMERA_PERSPECTIVE,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 1, .z = 0 };
    const cube_size = rl.Vector3{ .x = 2, .y = 2, .z = 2 };

    var ray: rl.Ray = undefined;
    var collision: rl.RayCollision = undefined;
    collision.hit = false;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            if (rl.IsCursorHidden()) rl.UpdateCamera(&camera, rl.CAMERA_FIRST_PERSON);

            if (rl.IsMouseButtonPressed(rl.MOUSE_BUTTON_RIGHT)) {
                if (rl.IsCursorHidden())
                    rl.EnableCursor()
                else
                    rl.DisableCursor();
            }

            if (rl.IsMouseButtonPressed(rl.MOUSE_BUTTON_LEFT)) {
                if (!collision.hit) {
                    ray = rl.GetMouseRay(rl.GetMousePosition(), camera);
                    collision = rl.GetRayCollisionBox(ray, .{
                        .min = .{ .x = cube_position.x - cube_size.x / 2, .y = cube_position.y - cube_size.y / 2, .z = cube_position.z - cube_size.z / 2 },
                        .max = .{ .x = cube_position.x + cube_size.x / 2, .y = cube_position.y + cube_size.y / 2, .z = cube_position.z + cube_size.z / 2 },
                    });
                } else {
                    collision.hit = false;
                }
            }
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);

            {
                rl.BeginMode3D(camera);
                defer rl.EndMode3D();

                if (collision.hit) {
                    rl.DrawCube(cube_position, cube_size.x, cube_size.y, cube_size.z, rl.RED);
                    rl.DrawCubeWires(cube_position, cube_size.x, cube_size.y, cube_size.z, rl.MAROON);
                    rl.DrawCubeWires(cube_position, cube_size.x + 0.2, cube_size.y + 0.2, cube_size.z + 0.2, rl.GREEN);
                } else {
                    rl.DrawCube(cube_position, cube_size.x, cube_size.y, cube_size.z, rl.GRAY);
                    rl.DrawCubeWires(cube_position, cube_size.x, cube_size.y, cube_size.z, rl.DARKGRAY);
                }

                rl.DrawRay(ray, rl.MAROON);
                rl.DrawGrid(10, 1);
            }

            rl.DrawText("Try clicking on the box with your mouse!", 240, 10, 20, rl.DARKGRAY);

            if (collision.hit)
                rl.DrawText(
                    "BOX SELECTED",
                    @divFloor((screen_width - rl.MeasureText("BOX SELECTED", 30)), 2),
                    @floatToInt(i32, screen_height * 0.1),
                    30,
                    rl.GREEN,
                );

            rl.DrawText("Right click mouse to toggle camera controls", 10, 430, 10, rl.GRAY);
            rl.DrawFPS(10, 10);
        }
    }
}
