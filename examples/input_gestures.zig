const std = @import("std");

const rl = @import("raylib");

const max_gesture_strings = 20;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - input gestures", .{});
    defer rl.closeWindow();

    var touch_position = rl.Vector2{ .x = 0, .y = 0 };
    const touch_area = rl.Rectangle{
        .x = 220,
        .y = 10,
        .width = screen_width - 230,
        .height = screen_height - 20,
    };

    var gestures_count: usize = 0;
    var gesture_strings: [max_gesture_strings][32:0]u8 = undefined;

    var current_gesture = rl.input.Gesture.none;
    var previous_gesture = rl.input.Gesture.none;

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            previous_gesture = current_gesture;
            current_gesture = rl.input.getGestureDetected();
            touch_position = rl.input.getTouchPosition(0);

            if (rl.collision.checkPointRec(touch_position, touch_area) and current_gesture != .none) {
                if (current_gesture != previous_gesture) {
                    switch (current_gesture) {
                        .none => {},
                        inline else => |tag| {
                            const prefix = "GESTURE ";
                            std.mem.copy(u8, &gesture_strings[gestures_count], prefix);
                            const tag_name = @tagName(tag);
                            for (gesture_strings[gestures_count][prefix.len .. prefix.len + tag_name.len], tag_name) |*dest, src| {
                                dest.* = std.ascii.toUpper(src);
                            }
                            gesture_strings[gestures_count][prefix.len + @tagName(tag).len] = 0;
                        },
                    }
                    gestures_count += 1;

                    if (gestures_count >= max_gesture_strings) {
                        for (&gesture_strings) |*str| str[0] = 0;
                        gestures_count = 0;
                    }
                }
            }
        }
        { // draw
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.RAYWHITE);

            rl.draw.rectangle(touch_area, rl.Color.GRAY, .{});
            rl.draw.rectangle(.{ .x = 225, .y = 15, .width = screen_width - 240, .height = screen_height - 30 }, rl.Color.RAYWHITE, .{});

            rl.draw.text(
                "GESTURES TEST AREA",
                .{
                    .position = .{ .x = screen_width - 270, .y = screen_height - 40 },
                    .font_size = 20,
                    .color = rl.Color.GRAY.fade(0.5),
                },
            );

            for (gesture_strings[0..gestures_count], 0..) |str, i| {
                rl.draw.rectangle(
                    .{ .x = 10, .y = 30 + 20 * @intToFloat(f32, i), .width = 200, .height = 20 },
                    rl.Color.LIGHTGRAY.fade(if (i % 2 == 0) 0.5 else 0.3),
                    .{},
                );

                rl.draw.text(&str, .{
                    .position = .{ .x = 35, .y = 36 + 20 * @intToFloat(f32, i) },
                    .font_size = 10,
                    .color = if (i < gestures_count - 1) rl.Color.DARKGRAY else rl.Color.MAROON,
                });
            }

            rl.draw.rectangle(
                .{ .x = 10, .y = 29, .width = 200, .height = screen_height - 50 },
                rl.Color.GRAY,
                .{ .fill = false },
            );
            rl.draw.text(
                "DETECTED GESTURES",
                .{
                    .position = .{ .x = 50, .y = 15 },
                    .font_size = 10,
                    .color = rl.Color.GRAY,
                },
            );

            if (current_gesture != .none) rl.draw.circle(touch_position, 30, rl.Color.MAROON, .{});
        }
    }
}
