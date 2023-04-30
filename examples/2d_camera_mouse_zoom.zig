const rl = @import("raylib");

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - 2d camera mouse zoom", .{});
    defer rl.window.close();

    var camera: rl.Camera2D = undefined;
    camera.zoom = 1;

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { // update
            if (rl.input.isMouseButtonDown(.right)) {
                var delta = rl.input.getMouseDelta().scale(-1 / camera.zoom);
                camera.target = rl.Vector2.fromCStruct(camera.target).add(delta).toCStruct();
            }

            const wheel = rl.input.getMouseWheelMove();
            if (wheel != 0) {
                camera.offset = rl.input.getMousePosition().toCStruct();
                const mouse_world_pos = rl.Vector2.fromCStruct(camera.offset).screenToWorld(camera);
                camera.target = mouse_world_pos.toCStruct();

                const zoom_increment = 0.125;
                camera.zoom += wheel * zoom_increment;

                if (camera.zoom < zoom_increment) {
                    camera.zoom = zoom_increment;
                }
            }
        }
        { // draw
            rl.draw.begin();
            defer rl.draw.end();

            rl.draw.clearBackground(rl.Color.BLACK);

            {
                rl.draw.beginMode2D(camera);
                defer rl.draw.endMode2D();

                {
                    rl.matrix.push();
                    defer rl.matrix.pop();

                    rl.matrix.translate(0, 25 * 50, 0);
                    rl.matrix.rotate(90, 1, 0, 0);
                    rl.draw.grid(100, 50);
                }

                rl.draw.circle(rl.Vector2.init(100, 100), 50, rl.Color.YELLOW, .{});
            }

            rl.draw.text(
                "Mouse right button drag to move, mouse wheel to zoom",
                .{ .position = rl.Vector2.init(10, 10), .font_size = 20, .color = rl.Color.WHITE },
            );
        }
    }
}
