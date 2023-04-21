const rl = @import("raylib").c.raylib;
const KeyboardKey = @import("raylib").input.KeyboardKey;

const max_buildings = 100;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.core.InitWindow(screen_width, screen_height, "raylib [core] example - 2d camera");
    defer rl.core.CloseWindow();

    var player = rl.structs.Rectangle{ .x = 400, .y = 280, .width = 40, .height = 40 };
    var buildings: [max_buildings]rl.structs.Rectangle = undefined;
    var build_colors: [max_buildings]rl.structs.Color = undefined;

    var spacing: f32 = 0;
    for (&buildings, &build_colors) |*building, *build_color| {
        building.width = @intToFloat(f32, rl.core.GetRandomValue(50, 200));
        building.height = @intToFloat(f32, rl.core.GetRandomValue(100, 800));
        building.y = screen_height - 130 - building.height;
        building.x = spacing - 6000;

        spacing += building.width;

        build_color.* = .{
            .r = @intCast(u8, rl.core.GetRandomValue(200, 240)),
            .g = @intCast(u8, rl.core.GetRandomValue(200, 240)),
            .b = @intCast(u8, rl.core.GetRandomValue(200, 250)),
            .a = 255,
        };
    }

    var camera = rl.structs.Camera2D{
        .offset = .{ .x = player.x + 20, .y = player.y + 20 },
        .target = .{ .x = screen_width / 2, .y = screen_height / 2 },
        .rotation = 0,
        .zoom = 1,
    };

    rl.core.SetTargetFPS(60);

    while (!rl.core.WindowShouldClose()) {
        { // update
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.left))) {
                player.x -= 2;
            }
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.right))) {
                player.x += 2;
            }

            camera.target = .{ .x = player.x + 20, .y = player.y + 20 };

            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.a))) {
                camera.rotation -= 1;
            }
            if (rl.core.IsKeyDown(@enumToInt(KeyboardKey.s))) {
                camera.rotation += 1;
            }

            if (camera.rotation > 40) {
                camera.rotation = 40;
            }
            if (camera.rotation < -40) {
                camera.rotation = -40;
            }

            camera.zoom += rl.core.GetMouseWheelMove() * 0.05;

            if (camera.zoom > 3) {
                camera.zoom = 3;
            }
            if (camera.zoom < 0.1) {
                camera.zoom = 0.1;
            }

            if (rl.core.IsKeyPressed(@enumToInt(KeyboardKey.r))) {
                camera.zoom = 1;
                camera.rotation = 0;
            }
        }
        { // draw
            rl.core.BeginDrawing();
            defer rl.core.EndDrawing();

            rl.core.ClearBackground(rl.colors.RAYWHITE);

            {
                rl.core.BeginMode2D(camera);
                defer rl.core.EndMode2D();

                rl.shapes.DrawRectangle(-6000, 320, 13000, 8000, rl.colors.DARKGRAY);

                for (buildings, build_colors) |building, color| rl.shapes.DrawRectangleRec(building, color);

                rl.shapes.DrawRectangleRec(player, rl.colors.RED);

                rl.shapes.DrawLine(
                    @floatToInt(c_int, camera.target.x),
                    -screen_height * 10,
                    @floatToInt(c_int, camera.target.x),
                    screen_height * 10,
                    rl.colors.GREEN,
                );
                rl.shapes.DrawLine(
                    -screen_width * 10,
                    @floatToInt(c_int, camera.target.y),
                    screen_width * 10,
                    @floatToInt(c_int, camera.target.y),
                    rl.colors.GREEN,
                );
            }

            rl.text.DrawText("SCREEN AREA", 640, 10, 20, rl.colors.RED);

            rl.shapes.DrawRectangle(0, 0, screen_width, 5, rl.colors.RED);
            rl.shapes.DrawRectangle(0, 5, 5, screen_height - 10, rl.colors.RED);
            rl.shapes.DrawRectangle(screen_width - 5, 5, 5, screen_height - 10, rl.colors.RED);
            rl.shapes.DrawRectangle(0, screen_height - 5, screen_width, 5, rl.colors.RED);

            rl.shapes.DrawRectangle(10, 10, 250, 113, rl.textures.Fade(rl.colors.SKYBLUE, 0.5));
            rl.shapes.DrawRectangleLines(10, 10, 250, 113, rl.colors.BLUE);

            rl.text.DrawText("Free 2d camera controls:", 20, 20, 10, rl.colors.BLACK);
            rl.text.DrawText("- Right/Left to move Offset", 40, 40, 10, rl.colors.DARKGRAY);
            rl.text.DrawText("- Mouse Wheel to Zoom in-out", 40, 60, 10, rl.colors.DARKGRAY);
            rl.text.DrawText("- A / S to Rotate", 40, 80, 10, rl.colors.DARKGRAY);
            rl.text.DrawText("- R to reset Zoom and Rotation", 40, 100, 10, rl.colors.DARKGRAY);
        }
    }
}
