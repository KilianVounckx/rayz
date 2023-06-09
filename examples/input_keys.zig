const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - keyboard input", .{});
    defer rl.window.close();

    var ball_position = rl.Vector2.init(screen_width / 2.0, screen_height / 2.0);

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { // Update
            if (rl.input.isKeyDown(.left)) ball_position.x -= 2.0;
            if (rl.input.isKeyDown(.right)) ball_position.x += 2.0;
            if (rl.input.isKeyDown(.up)) ball_position.y -= 2.0;
            if (rl.input.isKeyDown(.down)) ball_position.y += 2.0;
        }
        { // Draw
            rl.draw.begin();
            defer rl.draw.end();

            rl.draw.clearBackground(rl.Color.RAYWHITE);
            rl.draw.text(
                "move the ball with arrow keys",
                .{ .position = rl.Vector2.init(10, 10), .font_size = 20, .color = rl.Color.DARKGRAY },
            );
            rl.draw.circle(ball_position, 50, rl.Color.MAROON, .{});
        }
    }
}
