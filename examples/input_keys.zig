const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - keyboard input", .{});

    var ball_position = rl.Vector2.xy(screen_width / 2.0, screen_height / 2.0);

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // Update
            if (rl.input.isKeyDown(.left)) ball_position.c_struct.x -= 2.0;
            if (rl.input.isKeyDown(.right)) ball_position.c_struct.x += 2.0;
            if (rl.input.isKeyDown(.up)) ball_position.c_struct.y -= 2.0;
            if (rl.input.isKeyDown(.down)) ball_position.c_struct.y += 2.0;
        }
        { // Draw
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.RAYWHITE);
            rl.draw.text(
                "move the ball with arrow keys",
                .{ .position = rl.Vector2.xy(10, 10), .font_size = 20, .color = rl.Color.DARKGRAY },
            );
            rl.draw.circle(ball_position, 50, rl.Color.MAROON, .{});
        }
    }
}
