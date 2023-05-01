const std = @import("std");

const rl = @import("raylib").c;

pub fn main() void {
    const window_width = 800;
    const window_height = 450;

    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE | rl.FLAG_VSYNC_HINT);
    rl.InitWindow(window_width, window_height, "raylib [core] - window scale letterbox");
    defer rl.CloseWindow();

    rl.SetWindowMinSize(320, 240);

    const game_screen_width = 640;
    const game_screen_height = 480;

    const target = rl.LoadRenderTexture(game_screen_width, game_screen_height);
    defer rl.UnloadRenderTexture(target);
    rl.SetTextureFilter(target.texture, rl.TEXTURE_FILTER_BILINEAR);

    var colors: [10]rl.Color = undefined;
    for (&colors) |*color| {
        color.* = .{
            .r = @intCast(u8, rl.GetRandomValue(100, 250)),
            .g = @intCast(u8, rl.GetRandomValue(50, 150)),
            .b = @intCast(u8, rl.GetRandomValue(10, 100)),
            .a = 255,
        };
    }

    var virtual_mouse: rl.Vector2 = undefined;
    var scale: f32 = undefined;

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { //update
            scale = std.math.min(
                @intToFloat(f32, rl.GetScreenWidth()) / game_screen_width,
                @intToFloat(f32, rl.GetScreenHeight()) / game_screen_height,
            );

            if (rl.IsKeyPressed(rl.KEY_SPACE)) {
                for (&colors) |*color| {
                    color.* = .{
                        .r = @intCast(u8, rl.GetRandomValue(100, 250)),
                        .g = @intCast(u8, rl.GetRandomValue(50, 150)),
                        .b = @intCast(u8, rl.GetRandomValue(10, 100)),
                        .a = 255,
                    };
                }
            }

            const mouse = rl.GetMousePosition();
            virtual_mouse = .{
                .x = (mouse.x - (@intToFloat(f32, rl.GetScreenWidth()) - game_screen_width * scale) * 0.5) / scale,
                .y = (mouse.y - (@intToFloat(f32, rl.GetScreenHeight()) - game_screen_height * scale) * 0.5) / scale,
            };
            virtual_mouse = rl.Vector2Clamp(virtual_mouse, .{ .x = 0, .y = 0 }, .{ .x = game_screen_width, .y = game_screen_height });
        }
        { //draw
            {
                rl.BeginTextureMode(target);
                defer rl.EndTextureMode();

                rl.ClearBackground(rl.RAYWHITE);
                for (colors, 0..) |color, i| {
                    rl.DrawRectangle(
                        0,
                        @intCast(i32, game_screen_height / colors.len * i),
                        game_screen_width,
                        @intCast(i32, game_screen_height / colors.len),
                        color,
                    );
                }

                const mouse = rl.GetMousePosition();
                rl.DrawText("If executed inside a window,\nyou can resize the window,\nand see the screen scaling!", 10, 25, 20, rl.WHITE);
                rl.DrawText(rl.TextFormat(
                    "Default Mouse: [%i , %i]",
                    @floatToInt(i32, mouse.x),
                    @floatToInt(i32, mouse.y),
                ), 350, 25, 20, rl.GREEN);
                rl.DrawText(
                    rl.TextFormat(
                        "Virtual Mouse: [%i , %i]",
                        @floatToInt(i32, virtual_mouse.x),
                        @floatToInt(i32, virtual_mouse.y),
                    ),
                    350,
                    55,
                    20,
                    rl.YELLOW,
                );
                rl.EndTextureMode();
            }
            {
                rl.BeginDrawing();
                defer rl.EndDrawing();

                rl.ClearBackground(rl.BLACK);
                rl.DrawTexturePro(
                    target.texture,
                    .{
                        .x = 0,
                        .y = 0,
                        .width = @intToFloat(f32, target.texture.width),
                        .height = -@intToFloat(f32, target.texture.height),
                    },
                    .{
                        .x = (@intToFloat(f32, rl.GetScreenWidth()) - game_screen_width * scale) * 0.5,
                        .y = (@intToFloat(f32, rl.GetScreenHeight()) - game_screen_height * scale) * 0.5,
                        .width = game_screen_width * scale,
                        .height = game_screen_height * scale,
                    },
                    .{ .x = 0, .y = 0 },
                    0,
                    rl.WHITE,
                );
            }
        }
    }
}
