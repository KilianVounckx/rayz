const rl = @import("raylib").c;

const max_columns = 20;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - 3d camera first person");
    defer rl.CloseWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 0, .y = 2, .z = 4 },
        .target = .{ .x = 0, .y = 2, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 60,
        .projection = rl.CAMERA_PERSPECTIVE,
    };

    var camera_mode = rl.CAMERA_FIRST_PERSON;

    var columns: [max_columns]struct {
        height: f32,
        position: rl.Vector3,
        color: rl.Color,
    } = undefined;
    for (&columns) |*column| {
        column.height = @intToFloat(f32, rl.GetRandomValue(1, 12));
        column.position = .{
            .x = @intToFloat(f32, rl.GetRandomValue(-15, 15)),
            .y = column.height / 2,
            .z = @intToFloat(f32, rl.GetRandomValue(-15, 15)),
        };
        column.color = .{
            .r = @intCast(u8, rl.GetRandomValue(20, 255)),
            .g = @intCast(u8, rl.GetRandomValue(10, 55)),
            .b = 30,
            .a = 255,
        };
    }

    rl.DisableCursor();

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            if (rl.IsKeyPressed(rl.KEY_ONE)) {
                camera_mode = rl.CAMERA_FREE;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.IsKeyPressed(rl.KEY_TWO)) {
                camera_mode = rl.CAMERA_FIRST_PERSON;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.IsKeyPressed(rl.KEY_THREE)) {
                camera_mode = rl.CAMERA_THIRD_PERSON;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.IsKeyPressed(rl.KEY_FOUR)) {
                camera_mode = rl.CAMERA_ORBITAL;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }

            if (rl.IsKeyPressed(rl.KEY_P)) {
                if (camera.projection == rl.CAMERA_PERSPECTIVE) {
                    camera_mode = rl.CAMERA_THIRD_PERSON;
                    camera = .{
                        .position = .{ .x = 0, .y = 2, .z = -100 },
                        .target = .{ .x = 0, .y = 2, .z = 0 },
                        .up = .{ .x = 0, .y = 1, .z = 0 },
                        .fovy = 20,
                        .projection = rl.CAMERA_ORTHOGRAPHIC,
                    };
                    rl.CameraYaw(&camera, -135 * rl.DEG2RAD, true);
                    rl.CameraPitch(&camera, -45 * rl.DEG2RAD, true, true, false);
                } else if (camera.projection == rl.CAMERA_ORTHOGRAPHIC) {
                    camera_mode = rl.CAMERA_THIRD_PERSON;
                    camera = .{
                        .position = .{ .x = 0, .y = 2, .z = 10 },
                        .target = .{ .x = 0, .y = 2, .z = 0 },
                        .up = .{ .x = 0, .y = 1, .z = 0 },
                        .fovy = 60,
                        .projection = rl.CAMERA_PERSPECTIVE,
                    };
                }
            }
            rl.UpdateCamera(&camera, camera_mode);
        }
        { //draw
            rl.BeginDrawing();
            defer rl.EndDrawing();
            rl.ClearBackground(rl.RAYWHITE);
            {
                rl.BeginMode3D(camera);
                defer rl.EndMode3D();

                rl.DrawPlane(.{ .x = 0, .y = 0, .z = 0 }, .{ .x = 32, .y = 32 }, rl.LIGHTGRAY);
                rl.DrawCube(.{ .x = -16, .y = 2.5, .z = 0 }, 1, 5, 32, rl.BLUE);
                rl.DrawCube(.{ .x = 16, .y = 2.5, .z = 0 }, 1, 5, 32, rl.LIME);
                rl.DrawCube(.{ .x = 0, .y = 2.5, .z = 16 }, 32, 5, 1, rl.GOLD);

                for (columns) |column| {
                    rl.DrawCube(column.position, 2, column.height, 2, column.color);
                    rl.DrawCubeWires(column.position, 2, column.height, 2, rl.MAROON);
                }

                if (camera_mode == rl.CAMERA_THIRD_PERSON) {
                    rl.DrawCube(camera.target, 0.5, 0.5, 0.5, rl.PURPLE);
                    rl.DrawCubeWires(camera.target, 0.5, 0.5, 0.5, rl.DARKPURPLE);
                }
            }

            rl.DrawRectangle(5, 5, 330, 100, rl.Fade(rl.SKYBLUE, 0.5));
            rl.DrawRectangleLines(5, 5, 330, 100, rl.BLUE);

            rl.DrawText("Camera controls:", 15, 15, 10, rl.BLACK);
            rl.DrawText("- Move keys: W, A, S, D, Space, Left-Ctrl", 15, 30, 10, rl.BLACK);
            rl.DrawText("- Look around: arrow keys or mouse", 15, 45, 10, rl.BLACK);
            rl.DrawText("- Camera mode keys: 1, 2, 3, 4", 15, 60, 10, rl.BLACK);
            rl.DrawText("- Zoom keys: num-plus, num-minus or mouse scroll", 15, 75, 10, rl.BLACK);
            rl.DrawText("- Camera projection key: P", 15, 90, 10, rl.BLACK);

            rl.DrawRectangle(600, 5, 195, 100, rl.Fade(rl.SKYBLUE, 0.5));
            rl.DrawRectangleLines(600, 5, 195, 100, rl.BLUE);

            rl.DrawText("Camera status:", 610, 15, 10, rl.BLACK);
            rl.DrawText(rl.TextFormat(
                "- Mode: %s",
                @as([*:0]const u8, if (camera_mode == rl.CAMERA_FREE)
                    "FREE"
                else if (camera_mode == rl.CAMERA_FIRST_PERSON)
                    "FIRST_PERSON"
                else if (camera_mode == rl.CAMERA_THIRD_PERSON)
                    "THIRD_PERSON"
                else if (camera_mode == rl.CAMERA_ORBITAL)
                    "ORBITAL"
                else
                    "CUSTOM"),
            ), 610, 30, 10, rl.BLACK);
            rl.DrawText(rl.TextFormat(
                "- Projection: %s",
                @as([*:0]const u8, if (camera.projection == rl.CAMERA_PERSPECTIVE)
                    "PERSPECTIVE"
                else if (camera.projection == rl.CAMERA_ORTHOGRAPHIC)
                    "ORTHOGRAPHIC"
                else
                    "CUSTOM"),
            ), 610, 45, 10, rl.BLACK);
            rl.DrawText(rl.TextFormat("- Position: (%06.3f, %06.3f, %06.3f)", camera.position.x, camera.position.y, camera.position.z), 610, 60, 10, rl.BLACK);
            rl.DrawText(rl.TextFormat("- Target: (%06.3f, %06.3f, %06.3f)", camera.target.x, camera.target.y, camera.target.z), 610, 75, 10, rl.BLACK);
            rl.DrawText(rl.TextFormat("- Up: (%06.3f, %06.3f, %06.3f)", camera.up.x, camera.up.y, camera.up.z), 610, 90, 10, rl.BLACK);
        }
    }
}
