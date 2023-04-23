const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - input mouse wheel", .{});
    defer rl.closeWindow();

    var box_position_y: f32 = screen_height / 2 - 40;
    const scroll_speed = 4;

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            box_position_y -= rl.input.getMouseWheelMove() * scroll_speed;
        }
        { // draw
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.RAYWHITE);

            rl.draw.rectangle(
                .{ .x = screen_width / 2 - 40, .y = box_position_y, .width = 80, .height = 80 },
                rl.Color.MAROON,
                .{},
            );
            rl.draw.text(
                "Use mouse wheel to move the cube up and down!",
                .{ .position = rl.Vector2.xy(10, 10), .font_size = 20, .color = rl.Color.GRAY },
            );

            var text = try std.fmt.allocPrintZ(allocator, "Box position Y: {d:0>3}", .{box_position_y});
            defer allocator.free(text);

            rl.draw.text(text, .{ .position = rl.Vector2.xy(10, 40), .font_size = 20, .color = rl.Color.LIGHTGRAY });
        }
    }
}
