const rl = @import("raylib");

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - basic window", .{});
    defer rl.window.close();

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        rl.draw.begin();
        defer rl.draw.end();

        rl.draw.clearBackground(rl.Color.RAYWHITE);
        rl.draw.text(
            "Congrats! You created your first window!",
            .{ .position = rl.Vector2.init(190, 200), .font_size = 20, .color = rl.Color.LIGHTGRAY },
        );
    }
}
