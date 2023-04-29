const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - 3d picking", .{});
    defer rl.closeWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = .perspective,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 1, .z = 0 };
    const cube_size = rl.Vector3{ .x = 2, .y = 2, .z = 2 };

    var ray: rl.Ray = undefined;
    var maybe_collision: ?rl.Ray.Collision = null;

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { //update
            if (rl.isCursorHidden())
                camera.update(.first_person);

            if (rl.input.isMouseButtonPressed(.right)) {
                if (rl.isCursorHidden())
                    rl.enableCursor()
                else
                    rl.disableCursor();
            }

            if (rl.input.isMouseButtonPressed(.left)) {
                if (maybe_collision == null) {
                    ray = camera.getMouseRay(rl.input.getMousePosition());
                    maybe_collision = ray.getCollisionBox(.{
                        .min = .{ .x = cube_position.x - cube_size.x / 2, .y = cube_position.y - cube_size.y / 2, .z = cube_position.z - cube_size.z / 2 },
                        .max = .{ .x = cube_position.x + cube_size.x / 2, .y = cube_position.y + cube_size.y / 2, .z = cube_position.z + cube_size.z / 2 },
                    });
                } else {
                    maybe_collision = null;
                }
            }
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);

            {
                rl.draw.beginMode3D(camera);
                defer rl.draw.endMode3D();

                if (maybe_collision != null) {
                    rl.draw.cube(cube_position, cube_size, rl.Color.RED, .{});
                    rl.draw.cube(cube_position, cube_size, rl.Color.MAROON, .{ .fill = false });
                    rl.draw.cube(cube_position, cube_size.addValue(0.2), rl.Color.GREEN, .{ .fill = false });
                } else {
                    rl.draw.cube(cube_position, cube_size, rl.Color.GRAY, .{});
                    rl.draw.cube(cube_position, cube_size, rl.Color.DARKGRAY, .{ .fill = false });
                }

                rl.draw.ray(ray, rl.Color.MAROON);
                rl.draw.grid(10, 1);
            }

            rl.draw.text("Try clicking on the box with your mouse!", .{ .position = .{ .x = 240, .y = 10 }, .font_size = 20, .color = rl.Color.DARKGRAY });

            if (maybe_collision != null)
                rl.draw.text("BOX SELECTED", .{
                    .position = .{
                        .x = (screen_width - rl.draw.measureText("BOX SELECTED", .{ .font_size = 30 }).x) / 2,
                        .y = @floatToInt(i32, screen_height * 0.1),
                    },
                    .font_size = 30,
                    .color = rl.Color.GREEN,
                });

            rl.draw.text("Right click mouse to toggle camera controls", .{ .position = .{ .x = 10, .y = 430 }, .font_size = 10, .color = rl.Color.GRAY });
            rl.draw.fps(.{ .x = 10, .y = 10 });
        }
    }
}
