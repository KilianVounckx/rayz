const rl = @import("raylib");

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - basic window", .{});
    defer rl.closeWindow();

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        rl.draw.begin();
        defer rl.draw.end();

        rl.draw.clearBackground(rl.Color.RAYWHITE);
        rl.draw.text(
            "Congrats! You created your first window!",
            .{ .position = rl.Vector2.init(190, 200), .font_size = 20, .color = rl.Color.LIGHTGRAY },
        );
    }
}
