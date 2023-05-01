const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    var rng = std.rand.DefaultPrng.init(0);
    const random = rng.random();

    const window_width = 800;
    const window_height = 450;

    rl.window.init(
        window_width,
        window_height,
        "raylib [core] - window scale letterbox",
        .{
            .window_resizable = true,
            .vsync_hint = true,
        },
    );
    defer rl.window.close();

    rl.window.setMinimumSize(320, 240);

    const game_screen_width = 640;
    const game_screen_height = 480;

    const target = rl.RenderTexture.load(game_screen_width, game_screen_height);
    defer target.unload();
    target.texture.setFilter(.bilinear);

    var colors: [10]rl.Color = undefined;
    for (&colors) |*color| {
        color.* = .{
            .r = random.intRangeLessThan(u8, 100, 250),
            .g = random.intRangeLessThan(u8, 50, 150),
            .b = random.intRangeLessThan(u8, 10, 100),
            .a = 255,
        };
    }

    var virtual_mouse: rl.Vector2 = undefined;
    var scale: f32 = undefined;

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        const screen_size = rl.getScreenSize();
        const mouse = rl.input.getMousePosition();
        { //update
            scale = std.math.min(
                screen_size.x / game_screen_width,
                screen_size.y / game_screen_height,
            );

            if (rl.input.isKeyPressed(.space)) {
                for (&colors) |*color| {
                    color.* = .{
                        .r = random.intRangeLessThan(u8, 100, 250),
                        .g = random.intRangeLessThan(u8, 50, 150),
                        .b = random.intRangeLessThan(u8, 10, 100),
                        .a = 255,
                    };
                }
            }

            virtual_mouse = mouse.subtract(
                screen_size
                    .subtract(rl.Vector2.init(game_screen_width, game_screen_height)
                    .scale(scale))
                    .scale(0.5),
            )
                .scale(1 / scale)
                .clamp(.{ .x = 0, .y = 0 }, .{ .x = game_screen_width, .y = game_screen_height });
        }
        { //draw
            {
                rl.draw.beginTextureMode(target);
                defer rl.draw.endTextureMode();

                rl.draw.clearBackground(rl.Color.RAYWHITE);
                for (colors, 0..) |color, i| {
                    rl.draw.rectangle(
                        .{
                            .x = 0,
                            .y = @intToFloat(f32, game_screen_height / colors.len * i),
                            .width = game_screen_width,
                            .height = @intToFloat(f32, game_screen_height / colors.len),
                        },
                        color,
                        .{},
                    );
                }

                const mouse_text = try std.fmt.allocPrintZ(
                    allocator,
                    "Default Mouse: [{d}, {d}]",
                    .{ @floatToInt(i32, mouse.x), @floatToInt(i32, mouse.y) },
                );
                defer allocator.free(mouse_text);
                const virtual_mouse_text = try std.fmt.allocPrintZ(
                    allocator,
                    "Virtual Mouse: [{d}, {d}]",
                    .{ @floatToInt(i32, virtual_mouse.x), @floatToInt(i32, virtual_mouse.y) },
                );
                defer allocator.free(virtual_mouse_text);

                rl.draw.text(
                    "If executed inside a window,\nyou can resize the window,\nand see the screen scaling!",
                    .{ .position = .{ .x = 10, .y = 25 }, .font_size = 20, .color = rl.Color.WHITE },
                );
                rl.draw.text(mouse_text, .{ .position = .{ .x = 350, .y = 25 }, .font_size = 20, .color = rl.Color.GREEN });
                rl.draw.text(virtual_mouse_text, .{ .position = .{ .x = 350, .y = 55 }, .font_size = 20, .color = rl.Color.YELLOW });
            }
            {
                rl.draw.begin();
                defer rl.draw.end();

                rl.draw.clearBackground(rl.Color.BLACK);
                rl.draw.texture(
                    target.texture,
                    screen_size.subtract(rl.Vector2.init(game_screen_width, game_screen_height).scale(scale)).scale(0.5),
                    rl.Color.WHITE,
                    .{
                        .size = .{
                            .x = game_screen_width * scale,
                            .y = game_screen_height * scale,
                        },
                        .source = .{
                            .x = 0,
                            .y = 0,
                            .width = @intToFloat(f32, target.texture.width),
                            .height = -@intToFloat(f32, target.texture.height),
                        },
                    },
                );
            }
        }
    }
}
