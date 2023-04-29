const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - world screen", .{});
    defer rl.closeWindow();

    var camera = rl.Camera3D{
        .position = .{ .x = 10, .y = 10, .z = 10 },
        .target = .{ .x = 0, .y = 0, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 45,
        .projection = .perspective,
    };

    const cube_position = rl.Vector3{ .x = 0, .y = 0, .z = 0 };
    var cube_screen_position = rl.Vector2{ .x = 0, .y = 0 };

    rl.disableCursor();

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { //update
            camera.update(.third_person);
            cube_screen_position = cube_position.add(.{ .y = 2.5 }).worldToScreen(camera);
        }
        { //draw
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

            rl.draw.text(
                "Enemy: 100 / 100",
                .{
                    .position = cube_screen_position.subtract(.{ .x = rl.draw.measureText("Enemy: 100 / 100", .{ .font_size = 20 }).x / 2 }),
                    .font_size = 20,
                    .color = rl.Color.BLACK,
                },
            );

            const text = try std.fmt.allocPrintZ(
                allocator,
                "Cube position in screen space coordinates: [{d}, {d}]",
                .{
                    @floatToInt(i32, cube_screen_position.x),
                    @floatToInt(i32, cube_screen_position.y),
                },
            );
            defer allocator.free(text);
            rl.draw.text(text, .{ .position = .{ .x = 10, .y = 10 }, .font_size = 20, .color = rl.Color.LIME });
            rl.draw.text("Text 2d should be always on top of the cube", .{ .position = .{ .x = 10, .y = 40 }, .font_size = 20, .color = rl.Color.GRAY });
        }
    }
}
