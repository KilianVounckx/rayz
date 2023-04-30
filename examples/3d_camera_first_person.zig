const std = @import("std");
const assert = std.debug.assert;

const rl = @import("raylib");

const max_columns = 20;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer assert(!gpa.deinit());
    const allocator = gpa.allocator();

    var rng = std.rand.DefaultPrng.init(0);
    const random = rng.random();

    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - 3d camera first person", .{});
    defer rl.window.close();

    var camera = rl.Camera3D{
        .position = .{ .x = 0, .y = 2, .z = 4 },
        .target = .{ .x = 0, .y = 2, .z = 0 },
        .up = .{ .x = 0, .y = 1, .z = 0 },
        .fovy = 60,
        .projection = .perspective,
    };

    var camera_mode = rl.Camera3D.Mode.first_person;

    var columns: [max_columns]struct {
        height: f32,
        position: rl.Vector3,
        color: rl.Color,
    } = undefined;
    for (&columns) |*column| {
        column.height = @intToFloat(f32, random.intRangeLessThan(u8, 1, 12));
        column.position = .{
            .x = @intToFloat(f32, random.intRangeLessThan(i8, -15, 15)),
            .y = column.height / 2,
            .z = @intToFloat(f32, random.intRangeLessThan(i8, -15, 15)),
        };
        column.color = .{
            .r = random.intRangeLessThan(u8, 20, 255),
            .g = random.intRangeLessThan(u8, 10, 55),
            .b = 30,
            .a = 255,
        };
    }

    rl.disableCursor();

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        { //update
            if (rl.input.isKeyPressed(.one)) {
                camera_mode = .free;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.input.isKeyPressed(.two)) {
                camera_mode = .first_person;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.input.isKeyPressed(.three)) {
                camera_mode = .third_person;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }
            if (rl.input.isKeyPressed(.four)) {
                camera_mode = .orbital;
                camera.up = .{ .x = 0, .y = 1, .z = 0 };
            }

            if (rl.input.isKeyPressed(.p)) {
                if (camera.projection == .perspective) {
                    camera_mode = .third_person;
                    camera = .{
                        .position = .{ .x = 0, .y = 2, .z = -100 },
                        .target = .{ .x = 0, .y = 2, .z = 0 },
                        .up = .{ .x = 0, .y = 1, .z = 0 },
                        .fovy = 20,
                        .projection = .orthographic,
                    };
                    camera.yaw(std.math.degreesToRadians(f32, -135), .{});
                    camera.pitch(std.math.degreesToRadians(f32, -45), .{});
                } else if (camera.projection == .orthographic) {
                    camera_mode = .third_person;
                    camera = .{
                        .position = .{ .x = 0, .y = 2, .z = 10 },
                        .target = .{ .x = 0, .y = 2, .z = 0 },
                        .up = .{ .x = 0, .y = 1, .z = 0 },
                        .fovy = 60,
                        .projection = .perspective,
                    };
                }
            }
            camera.update(camera_mode);
        }
        { //draw
            rl.draw.begin();
            defer rl.draw.end();
            rl.draw.clearBackground(rl.Color.RAYWHITE);
            {
                rl.draw.beginMode3D(camera);
                defer rl.draw.endMode3D();

                rl.draw.plane(.{ .x = 0, .y = 0, .z = 0 }, .{ .x = 32, .y = 32 }, rl.Color.LIGHTGRAY);
                rl.draw.cube(.{ .x = -16, .y = 2.5, .z = 0 }, .{ .x = 1, .y = 5, .z = 32 }, rl.Color.BLUE, .{});
                rl.draw.cube(.{ .x = 16, .y = 2.5, .z = 0 }, .{ .x = 1, .y = 5, .z = 32 }, rl.Color.LIME, .{});
                rl.draw.cube(.{ .x = 0, .y = 2.5, .z = 16 }, .{ .x = 32, .y = 5, .z = 1 }, rl.Color.GOLD, .{});

                for (columns) |column| {
                    rl.draw.cube(column.position, .{ .x = 2, .y = column.height, .z = 2 }, column.color, .{});
                    rl.draw.cube(column.position, .{ .x = 2, .y = column.height, .z = 2 }, rl.Color.MAROON, .{ .fill = false });
                }

                if (camera_mode == .third_person) {
                    rl.draw.cube(camera.target, .{ .x = 0.5, .y = 0.5, .z = 0.5 }, rl.Color.PURPLE, .{});
                    rl.draw.cube(camera.target, .{ .x = 0.5, .y = 0.5, .z = 0.5 }, rl.Color.DARKPURPLE, .{ .fill = false });
                }
            }

            rl.draw.rectangle(.{ .x = 5, .y = 5, .width = 330, .height = 100 }, rl.Color.SKYBLUE.fade(0.5), .{});
            rl.draw.rectangle(.{ .x = 5, .y = 5, .width = 330, .height = 100 }, rl.Color.BLUE, .{ .fill = false });

            rl.draw.text("Camera controls:", .{ .position = .{ .x = 15, .y = 15 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Move keys: W, A, S, D, Space, Left-Ctrl", .{ .position = .{ .x = 15, .y = 30 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Look around: arrow keys or mouse", .{ .position = .{ .x = 15, .y = 45 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Camera mode keys: 1, 2, 3, 4", .{ .position = .{ .x = 15, .y = 60 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Zoom keys: num-plus, num-minus or mouse scroll", .{ .position = .{ .x = 15, .y = 75 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Camera projection key: P", .{ .position = .{ .x = 15, .y = 90 }, .font_size = 10, .color = rl.Color.BLACK });

            rl.draw.rectangle(.{ .x = 600, .y = 5, .width = 195, .height = 100 }, rl.Color.SKYBLUE.fade(0.5), .{});
            rl.draw.rectangle(.{ .x = 600, .y = 5, .width = 195, .height = 100 }, rl.Color.BLUE, .{ .fill = false });

            const mode_text = try std.fmt.allocPrintZ(allocator, "- Mode: {s}", .{
                switch (camera_mode) {
                    inline else => |tag| comptime blk: {
                        var tagname = @tagName(tag).*;
                        for (&tagname) |*c| {
                            c.* = std.ascii.toUpper(c.*);
                        }
                        break :blk @as(*const [tagname.len:0]u8, &tagname);
                    },
                },
            });
            defer allocator.free(mode_text);

            const projection_text = try std.fmt.allocPrintZ(allocator, " -Projection: {s}", .{
                switch (camera.projection) {
                    inline else => |tag| comptime blk: {
                        var tagname = @tagName(tag).*;
                        for (&tagname) |*c| {
                            c.* = std.ascii.toUpper(c.*);
                        }
                        break :blk @as(*const [tagname.len:0]u8, &tagname);
                    },
                },
            });
            defer allocator.free(projection_text);

            const position_text = try std.fmt.allocPrintZ(
                allocator,
                "- Position: ({d:06.3}, {d:06.3}, {d:06.3})",
                .{ camera.position.x, camera.position.y, camera.position.z },
            );
            defer allocator.free(position_text);
            const target_text = try std.fmt.allocPrintZ(
                allocator,
                "- Target: ({d:06.3}, {d:06.3}, {d:06.3})",
                .{ camera.target.x, camera.target.y, camera.target.z },
            );
            defer allocator.free(target_text);
            const up_text = try std.fmt.allocPrintZ(
                allocator,
                "- Up: ({d:06.3}, {d:06.3}, {d:06.3})",
                .{ camera.up.x, camera.up.y, camera.up.z },
            );
            defer allocator.free(up_text);

            rl.draw.text("Camera status:", .{ .position = .{ .x = 610, .y = 15 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(mode_text, .{ .position = .{ .x = 610, .y = 30 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(projection_text, .{ .position = .{ .x = 610, .y = 45 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(position_text, .{ .position = .{ .x = 610, .y = 60 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(target_text, .{ .position = .{ .x = 610, .y = 75 }, .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(up_text, .{ .position = .{ .x = 610, .y = 90 }, .font_size = 10, .color = rl.Color.BLACK });
        }
    }
}
