const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - 3d camera mode", .{});
    defer rl.closeWindow();

    const camera = rl.Camera3D{
        .position = .{ .x = 0, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = .perspective,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
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

        rl.draw.text("Welcome to the third dimension!", .{ .position = .{ .x = 10, .y = 40 }, .font_size = 20, .color = rl.Color.DARKGRAY });
        rl.draw.fps(.{ .x = 10, .y = 10 });
    }
}
