const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(
        screen_width,
        screen_height,
        "raylib [core] example - window flags",
        .{
            //.window_transparent = true
        },
    );
    defer rl.window.close();

    var ball_position = rl.getScreenSize().scale(0.5);
    var ball_speed = rl.Vector2{ .x = 5, .y = 4 };
    const ball_radius = 20;

    var frame_counter: u32 = 0;

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { //update
            const screen_size = rl.getScreenSize();
            if (rl.input.isKeyPressed(.f))
                rl.window.toggleFullscreen();

            if (rl.input.isKeyPressed(.r)) {
                if (rl.window.isState(.window_resizable))
                    rl.window.clearState(.{ .window_resizable = true })
                else
                    rl.window.setState(.{ .window_resizable = true });
            }

            if (rl.input.isKeyPressed(.d)) {
                if (rl.window.isState(.window_undecorated))
                    rl.window.clearState(.{ .window_undecorated = true })
                else
                    rl.window.setState(.{ .window_undecorated = true });
            }

            if (rl.input.isKeyPressed(.h)) {
                if (!rl.window.isState(.window_hidden))
                    rl.window.setState(.{ .window_hidden = true });
                frame_counter = 0;
            }
            if (rl.window.isState(.window_hidden)) {
                frame_counter += 1;
                if (frame_counter >= 240)
                    rl.window.clearState(.{ .window_hidden = true });
            }

            if (rl.input.isKeyPressed(.n)) {
                if (!rl.window.isState(.window_minimized))
                    rl.window.minimize();
                frame_counter = 0;
            }

            if (rl.window.isState(.window_minimized)) {
                frame_counter += 1;
                if (frame_counter >= 240)
                    rl.window.restore();
            }

            if (rl.input.isKeyPressed(.m)) {
                if (rl.window.isState(.window_maximized))
                    rl.window.restore()
                else
                    rl.window.maximize();
            }

            if (rl.input.isKeyPressed(.u)) {
                if (rl.window.isState(.window_unfocused))
                    rl.window.clearState(.{ .window_unfocused = true })
                else
                    rl.window.setState(.{ .window_unfocused = true });
            }

            if (rl.input.isKeyPressed(.t)) {
                if (rl.window.isState(.window_topmost))
                    rl.window.clearState(.{ .window_topmost = true })
                else
                    rl.window.setState(.{ .window_topmost = true });
            }

            if (rl.input.isKeyPressed(.a)) {
                if (rl.window.isState(.window_always_run))
                    rl.window.clearState(.{ .window_always_run = true })
                else
                    rl.window.setState(.{ .window_always_run = true });
            }

            if (rl.input.isKeyPressed(.v)) {
                if (rl.window.isState(.vsync_hint))
                    rl.window.clearState(.{ .vsync_hint = true })
                else
                    rl.window.setState(.{ .vsync_hint = true });
            }

            ball_position.x += ball_speed.x;
            ball_position.y += ball_speed.y;

            if (ball_position.x >= screen_size.x - ball_radius or
                ball_position.x <= ball_radius)
            {
                ball_speed.x *= -1;
            }
            if (ball_position.y >= screen_size.y - ball_radius or
                ball_position.y <= ball_radius)
            {
                ball_speed.y *= -1;
            }
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();

            rl.draw.clearBackground(if (rl.window.isState(.window_transparent)) rl.Color.BLANK else rl.Color.RAYWHITE);

            const screen_size = rl.getScreenSize();
            rl.draw.circle(ball_position, ball_radius, rl.Color.MAROON, .{});
            rl.draw.rectangle(.{
                .x = 0,
                .y = 0,
                .width = screen_size.x,
                .height = screen_size.y,
            }, rl.Color.RAYWHITE, .{ .fill = false, .thickness = 4 });

            rl.draw.circle(rl.input.getMousePosition(), 10, rl.Color.DARKBLUE, .{});

            rl.draw.fps(.{ .x = 10, .y = 10 });

            const size_text = try std.fmt.allocPrintZ(allocator, "Screen Size: {d} {d}", .{ screen_size.x, screen_size.y });
            defer allocator.free(size_text);
            rl.draw.text(size_text, .{ .position = .{ .x = 10, .y = 40 }, .font_size = 10, .color = rl.Color.GREEN });

            rl.draw.text("Following flags can be set after window creation:", .{ .position = .{ .x = 10, .y = 60 }, .font_size = 10, .color = rl.Color.GRAY });
            if (rl.window.isState(.fullscreen_mode))
                rl.draw.text("[F] FLAG_FULLSCREEN_MODE: on", .{ .position = .{ .x = 10, .y = 80 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[F] FLAG_FULLSCREEN_MODE: off", .{ .position = .{ .x = 10, .y = 80 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_resizable))
                rl.draw.text("[R] FLAG_WINDOW_RESIZABLE: on", .{ .position = .{ .x = 10, .y = 100 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[R] FLAG_WINDOW_RESIZABLE: off", .{ .position = .{ .x = 10, .y = 100 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_undecorated))
                rl.draw.text("[D] FLAG_WINDOW_UNDECORATED: on", .{ .position = .{ .x = 10, .y = 120 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[D] FLAG_WINDOW_UNDECORATED: off", .{ .position = .{ .x = 10, .y = 120 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_hidden))
                rl.draw.text("[H] FLAG_WINDOW_HIDDEN: on", .{ .position = .{ .x = 10, .y = 140 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[H] FLAG_WINDOW_HIDDEN: off", .{ .position = .{ .x = 10, .y = 140 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_minimized))
                rl.draw.text("[N] FLAG_WINDOW_MINIMIZED: on", .{ .position = .{ .x = 10, .y = 160 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[N] FLAG_WINDOW_MINIMIZED: off", .{ .position = .{ .x = 10, .y = 160 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_maximized))
                rl.draw.text("[M] FLAG_WINDOW_MAXIMIZED: on", .{ .position = .{ .x = 10, .y = 180 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[M] FLAG_WINDOW_MAXIMIZED: off", .{ .position = .{ .x = 10, .y = 180 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_unfocused))
                rl.draw.text("[G] FLAG_WINDOW_UNFOCUSED: on", .{ .position = .{ .x = 10, .y = 200 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[U] FLAG_WINDOW_UNFOCUSED: off", .{ .position = .{ .x = 10, .y = 200 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_topmost))
                rl.draw.text("[T] FLAG_WINDOW_TOPMOST: on", .{ .position = .{ .x = 10, .y = 220 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[T] FLAG_WINDOW_TOPMOST: off", .{ .position = .{ .x = 10, .y = 220 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_always_run))
                rl.draw.text("[A] FLAG_WINDOW_ALWAYS_RUN: on", .{ .position = .{ .x = 10, .y = 240 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[A] FLAG_WINDOW_ALWAYS_RUN: off", .{ .position = .{ .x = 10, .y = 240 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.vsync_hint))
                rl.draw.text("[V] FLAG_VSYNC_HINT: on", .{ .position = .{ .x = 10, .y = 260 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("[V] FLAG_VSYNC_HINT: off", .{ .position = .{ .x = 10, .y = 260 }, .font_size = 10, .color = rl.Color.MAROON });

            rl.draw.text("Following flags can only be set before window creation:", .{ .position = .{ .x = 10, .y = 300 }, .font_size = 10, .color = rl.Color.GRAY });
            if (rl.window.isState(.window_highdpi))
                rl.draw.text("FLAG_WINDOW_HIGHDPI: on", .{ .position = .{ .x = 10, .y = 320 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("FLAG_WINDOW_HIGHDPI: off", .{ .position = .{ .x = 10, .y = 320 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.window_transparent))
                rl.draw.text("FLAG_WINDOW_TRANSPARENT: on", .{ .position = .{ .x = 10, .y = 340 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("FLAG_WINDOW_TRANSPARENT: off", .{ .position = .{ .x = 10, .y = 340 }, .font_size = 10, .color = rl.Color.MAROON });
            if (rl.window.isState(.msaa_4x_hint))
                rl.draw.text("FLAG_MSAA_4X_HINT: on", .{ .position = .{ .x = 10, .y = 360 }, .font_size = 10, .color = rl.Color.LIME })
            else
                rl.draw.text("FLAG_MSAA_4X_HINT: off", .{ .position = .{ .x = 10, .y = 360 }, .font_size = 10, .color = rl.Color.MAROON });
        }
    }
}
