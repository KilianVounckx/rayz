const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - 3d camera free", .{});
    defer rl.closeWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = .perspective,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };

    rl.disableCursor();

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            camera.update(.free);
            if (rl.input.isKeyDown(.z)) {
                camera.target = .{ .x = 0, .y = 0, .z = 0 };
            }
        }
        { // draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);

            {
                rl.draw.beginMode3D(camera);
                defer rl.draw.endMode3D();

                rl.draw.cube(cube_position, .{ .x = 2, .y = 2, .z = 2 }, rl.Color.RED, .{});
                rl.draw.cube(cube_position, .{ .x = 2, .y = 2, .z = 2 }, rl.Color.MAROON, .{ .fill = false });

                rl.draw.grid(10, 1);
            }

            rl.draw.rectangle(.{ .x = 10, .y = 10, .width = 320, .height = 133 }, rl.Color.SKYBLUE.fade(0.5), .{});
            rl.draw.rectangle(.{ .x = 10, .y = 10, .width = 320, .height = 133 }, rl.Color.BLUE, .{ .fill = false });

            rl.draw.text("Free camera default controls:", .{ .position = .{ .x = 20, .y = 20 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Mouse wheel to zoom in-out", .{ .position = .{ .x = 40, .y = 40 }, .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Mouse wheel pressed to pan", .{ .position = .{ .x = 40, .y = 60 }, .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Alt + Mouse wheel pressed to rotate", .{ .position = .{ .x = 40, .y = 80 }, .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Alt + Ctrl + Mouse wheel pressed for smooth zoom", .{ .position = .{ .x = 40, .y = 100 }, .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Z to zoom to (0, 0, 0)", .{ .position = .{ .x = 40, .y = 120 }, .font_size = 10, .color = rl.Color.DARKGRAY });
        }
    }
}
