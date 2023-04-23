const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - mouse input", .{});
    defer rl.closeWindow();

    var ball_position = rl.Vector2.xy(-100, 100);
    var ball_color = rl.Color.DARKBLUE;

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            ball_position = rl.input.getMousePosition();

            ball_color = if (rl.input.isMouseButtonPressed(.left))
                rl.Color.MAROON
            else if (rl.input.isMouseButtonPressed(.middle))
                rl.Color.LIME
            else if (rl.input.isMouseButtonPressed(.right))
                rl.Color.DARKBLUE
            else if (rl.input.isMouseButtonPressed(.side))
                rl.Color.PURPLE
            else if (rl.input.isMouseButtonPressed(.extra))
                rl.Color.YELLOW
            else if (rl.input.isMouseButtonPressed(.forward))
                rl.Color.ORANGE
            else if (rl.input.isMouseButtonPressed(.back))
                rl.Color.BEIGE
            else
                ball_color;
        }
        { // draw
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.RAYWHITE);

            rl.draw.circle(ball_position, 40, ball_color, .{});
            rl.draw.text(
                "move ball with mouse and click mouse button to change color",
                .{
                    .position = rl.Vector2.xy(10, 10),
                    .font_size = 20,
                    .color = rl.Color.DARKGRAY,
                },
            );
        }
    }
}
