const std = @import("std");

const rl = @import("raylib");

pub fn main() void {
    var rng = std.rand.DefaultPrng.init(0);
    const random = rng.random();

    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - generate random values", .{});
    defer rl.window.close();

    var rand_value = random.intRangeAtMost(i8, -8, 5);
    var frames_counter: usize = 0;

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { //update
            frames_counter += 1;

            if ((frames_counter / 120) % 2 == 1) {
                rand_value = random.intRangeAtMost(i8, -8, 5);
                frames_counter = 0;
            }
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);

            rl.draw.text("Every 2 seconds a new value is generated:", .{ .position = .{ .x = 130, .y = 100 }, .font_size = 20, .color = rl.Color.MAROON });
            var buffer: [5:0]u8 = undefined;
            const value_text = std.fmt.bufPrintZ(&buffer, "{d}", .{rand_value}) catch unreachable;
            rl.draw.text(value_text, .{ .position = .{ .x = 360, .y = 180 }, .font_size = 80, .color = rl.Color.LIGHTGRAY });
        }
    }
}
