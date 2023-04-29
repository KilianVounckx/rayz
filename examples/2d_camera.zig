const std = @import("std");

const rl = @import("raylib");

const max_buildings = 100;

pub fn main() void {
    var prng = std.rand.DefaultPrng.init(0);
    const random = prng.random();

    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - 2d camera", .{});
    defer rl.closeWindow();

    var player = rl.Rectangle{ .x = 400, .y = 280, .width = 40, .height = 40 };
    var buildings: [max_buildings]rl.Rectangle = undefined;
    var build_colors: [max_buildings]rl.Color = undefined;

    var spacing: f32 = 0;
    for (&buildings, &build_colors) |*building, *build_color| {
        building.width = @intToFloat(f32, random.intRangeAtMost(i32, 50, 200));
        building.height = @intToFloat(f32, random.intRangeAtMost(i32, 100, 800));
        building.y = screen_height - 130 - building.height;
        building.x = spacing - 6000;

        spacing += building.width;

        build_color.* = rl.Color.rgb(
            random.intRangeAtMost(u8, 200, 240),
            random.intRangeAtMost(u8, 200, 240),
            random.intRangeAtMost(u8, 200, 250),
        );
    }

    var camera = rl.Camera2D{
        .offset = .{ .x = player.x + 20, .y = player.y + 20 },
        .target = .{ .x = screen_width / 2, .y = screen_height / 2 },
        .rotation = 0,
        .zoom = 1,
    };

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            if (rl.input.isKeyDown(.left)) {
                player.x -= 2;
            }
            if (rl.input.isKeyDown(.right)) {
                player.x += 2;
            }

            camera.target = .{ .x = player.x + 20, .y = player.y + 20 };

            if (rl.input.isKeyDown(.a)) {
                camera.rotation -= 1;
            }
            if (rl.input.isKeyDown(.s)) {
                camera.rotation += 1;
            }

            if (camera.rotation > 40) {
                camera.rotation = 40;
            }
            if (camera.rotation < -40) {
                camera.rotation = -40;
            }

            camera.zoom += rl.input.getMouseWheelMove() * 0.05;

            if (camera.zoom > 3) {
                camera.zoom = 3;
            }
            if (camera.zoom < 0.1) {
                camera.zoom = 0.1;
            }

            if (rl.input.isKeyPressed(.r)) {
                camera.zoom = 1;
                camera.rotation = 0;
            }
        }
        { // draw
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.RAYWHITE);

            {
                rl.beginMode2D(camera);
                defer rl.endMode2D();

                rl.draw.rectangle(
                    .{ .x = -6000, .y = 320, .width = 13000, .height = 8000 },
                    rl.Color.DARKGRAY,
                    .{},
                );

                for (buildings, build_colors) |building, color|
                    rl.draw.rectangle(building, color, .{});

                rl.draw.rectangle(player, rl.Color.RED, .{});

                rl.draw.line(
                    rl.Vector2.init(camera.target.x, -screen_height * 10),
                    rl.Vector2.init(camera.target.x, screen_height * 10),
                    rl.Color.GREEN,
                    .{},
                );
                rl.draw.line(
                    rl.Vector2.init(-screen_width * 10, camera.target.y),
                    rl.Vector2.init(screen_width * 10, camera.target.y),
                    rl.Color.GREEN,
                    .{},
                );
            }

            rl.draw.text(
                "SCREEN AREA",
                .{ .position = rl.Vector2.init(640, 10), .font_size = 20, .color = rl.Color.RED },
            );

            rl.draw.rectangle(.{ .x = 0, .y = 0, .width = screen_width, .height = 5 }, rl.Color.RED, .{});
            rl.draw.rectangle(.{ .x = 0, .y = 5, .width = 5, .height = screen_height - 10 }, rl.Color.RED, .{});
            rl.draw.rectangle(.{ .x = screen_width - 5, .y = 5, .width = 5, .height = screen_height - 10 }, rl.Color.RED, .{});
            rl.draw.rectangle(.{ .x = 0, .y = screen_height - 5, .width = screen_width, .height = 5 }, rl.Color.RED, .{});

            rl.draw.rectangle(.{ .x = 10, .y = 10, .width = 250, .height = 113 }, rl.Color.SKYBLUE.fade(0.5), .{});
            rl.draw.rectangle(.{ .x = 10, .y = 10, .width = 250, .height = 113 }, rl.Color.BLUE, .{ .fill = false });

            rl.draw.text("Free 2d camera controls:", .{ .position = rl.Vector2.init(20, 20), .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Right/Left to move Offset", .{ .position = rl.Vector2.init(40, 40), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Mouse Wheel to Zoom in-out", .{ .position = rl.Vector2.init(40, 60), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- A / S to Rotate", .{ .position = rl.Vector2.init(40, 80), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- R to reset Zoom and Rotation", .{ .position = rl.Vector2.init(40, 100), .font_size = 10, .color = rl.Color.DARKGRAY });
        }
    }
}
