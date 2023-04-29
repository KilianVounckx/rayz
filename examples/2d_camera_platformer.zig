const std = @import("std");

const rl = @import("raylib");

const gravity = 400;
const player_jump_speed = 350;
const player_horizontal_speed = 200;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "raylib [core] example - 2d camera", .{});
    defer rl.closeWindow();

    var player = Player{
        .position = rl.Vector2.xy(400, 280),
        .speed = 0,
        .can_jump = false,
    };

    const env_items = [_]EnvItem{
        .{ .rectangle = .{ .x = 0, .y = 0, .width = 1000, .height = 400 }, .blocking = false, .color = rl.Color.LIGHTGRAY },
        .{ .rectangle = .{ .x = 0, .y = 400, .width = 1000, .height = 200 }, .blocking = true, .color = rl.Color.GRAY },
        .{ .rectangle = .{ .x = 300, .y = 200, .width = 400, .height = 10 }, .blocking = true, .color = rl.Color.GRAY },
        .{ .rectangle = .{ .x = 250, .y = 300, .width = 100, .height = 10 }, .blocking = true, .color = rl.Color.GRAY },
        .{ .rectangle = .{ .x = 650, .y = 300, .width = 100, .height = 10 }, .blocking = true, .color = rl.Color.GRAY },
    };

    var camera = rl.Camera2D{
        .target = player.position.c_struct,
        .offset = .{ .x = screen_width / 2, .y = screen_height / 2 },
        .rotation = 0,
        .zoom = 1,
    };

    const camera_options = [_]struct {
        updater: *const fn (*rl.Camera2D, Player, []const EnvItem, f32, i32, i32) void,
        description: [:0]const u8,
    }{
        .{
            .updater = updateCameraCenter,
            .description = "Follow player center",
        },
        .{
            .updater = updateCameraCenterInsideMap,
            .description = "Follow player, but clamp to map edges",
        },
        .{
            .updater = updateCameraCenterSmoothFollow,
            .description = "Follow player, smoothed",
        },
        .{
            .updater = updateCameraEventOutOnLanding,
            .description = "Follow player horizontally, update player center vertically after landing",
        },
        .{
            .updater = updateCameraPlayerBoundsPush,
            .description = "Player push camera on getting too close to screen edge",
        },
    };
    var camera_option: usize = 0;

    rl.setTargetFps(60);

    while (!rl.windowShouldClose()) {
        { // update
            const delta_time = rl.getFrameTime();

            player.update(&env_items, delta_time);

            camera.zoom += rl.input.getMouseWheelMove() * 0.05;
            camera.zoom = std.math.clamp(camera.zoom, 0.25, 3);

            if (rl.input.isKeyPressed(.r)) {
                camera.zoom = 1;
                player.position = rl.Vector2.xy(400, 280);
            }

            if (rl.input.isKeyPressed(.c)) {
                camera_option = (camera_option + 1) % camera_options.len;
            }

            camera_options[camera_option].updater(&camera, player, &env_items, delta_time, screen_width, screen_height);
        }
        { // draw
            rl.beginDrawing();
            defer rl.endDrawing();
            rl.clearBackground(rl.Color.LIGHTGRAY);
            {
                rl.beginMode2D(camera);
                defer rl.endMode2D();

                for (env_items) |item| rl.draw.rectangle(item.rectangle, item.color, .{});

                const player_rect = rl.Rectangle{
                    .x = player.position.x() - 20,
                    .y = player.position.y() - 40,
                    .width = 40,
                    .height = 40,
                };
                rl.draw.rectangle(player_rect, rl.Color.RED, .{});
            }
            rl.draw.text("Controls:", .{ .position = rl.Vector2.xy(20, 20), .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text("- Left/Right to move", .{ .position = rl.Vector2.xy(40, 40), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Space to jump", .{ .position = rl.Vector2.xy(40, 60), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- Mouse wheel to zoom", .{ .position = rl.Vector2.xy(40, 80), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("- C to change camera mode", .{ .position = rl.Vector2.xy(40, 100), .font_size = 10, .color = rl.Color.DARKGRAY });
            rl.draw.text("Current camera mode:", .{ .position = rl.Vector2.xy(20, 120), .font_size = 10, .color = rl.Color.BLACK });
            rl.draw.text(camera_options[camera_option].description, .{ .position = rl.Vector2.xy(40, 140), .font_size = 10, .color = rl.Color.DARKGRAY });
        }
    }
}

fn updateCameraCenter(
    camera: *rl.Camera2D,
    player: Player,
    env_items: []const EnvItem,
    delta: f32,
    screen_width: i32,
    screen_height: i32,
) void {
    _ = delta;
    _ = env_items;
    camera.offset = .{ .x = @intToFloat(f32, screen_width) / 2, .y = @intToFloat(f32, screen_height) / 2 };
    camera.target = player.position.c_struct;
}

fn updateCameraCenterInsideMap(
    camera: *rl.Camera2D,
    player: Player,
    env_items: []const EnvItem,
    delta: f32,
    screen_width: i32,
    screen_height: i32,
) void {
    _ = delta;
    camera.target = player.position.c_struct;
    camera.offset = .{ .x = @intToFloat(f32, screen_width) / 2, .y = @intToFloat(f32, screen_height) / 2 };

    var min_x: f32 = 1000;
    var min_y: f32 = 1000;
    var max_x: f32 = -1000;
    var max_y: f32 = -1000;
    for (env_items) |item| {
        min_x = std.math.min(item.rectangle.x, min_x);
        min_y = std.math.min(item.rectangle.y, min_y);
        max_x = std.math.max(item.rectangle.x + item.rectangle.width, max_x);
        max_y = std.math.max(item.rectangle.y + item.rectangle.height, max_y);
    }

    const min = rl.Vector2.xy(min_x, min_y).worldToScreen2D(camera.*);
    const max = rl.Vector2.xy(max_x, max_y).worldToScreen2D(camera.*);

    if (min.x() > 0) {
        camera.offset.x = @intToFloat(f32, screen_width) / 2 - min.x();
    }
    if (min.y() > 0) {
        camera.offset.y = @intToFloat(f32, screen_height) / 2 - min.x();
    }
    if (max.x() < @intToFloat(f32, screen_width)) {
        camera.offset.x = @intToFloat(f32, screen_width) - (max.x() - @intToFloat(f32, screen_width) / 2);
    }
    if (max.y() < @intToFloat(f32, screen_height)) {
        camera.offset.y = @intToFloat(f32, screen_height) - (max.y() - @intToFloat(f32, screen_height) / 2);
    }
}

fn updateCameraCenterSmoothFollow(
    camera: *rl.Camera2D,
    player: Player,
    env_items: []const EnvItem,
    delta: f32,
    screen_width: i32,
    screen_height: i32,
) void {
    _ = env_items;
    const min_speed = 30;
    const min_effect_length = 10;
    const fraction_speed = 0.8;

    camera.offset = .{ .x = @intToFloat(f32, screen_width) / 2, .y = @intToFloat(f32, screen_height) / 2 };
    const diff = player.position.subtract(.{ .c_struct = camera.target });
    const length = diff.length();

    if (length > min_effect_length) {
        const speed = std.math.max(fraction_speed * length, min_speed);
        camera.target = (rl.Vector2{ .c_struct = camera.target }).add(diff.scale(speed * delta / length)).c_struct;
    }
}

fn updateCameraEventOutOnLanding(
    camera: *rl.Camera2D,
    player: Player,
    env_items: []const EnvItem,
    delta: f32,
    screen_width: i32,
    screen_height: i32,
) void {
    _ = env_items;
    const statics = struct {
        var event_out_speed: f32 = 700;
        var even_out_target: ?f32 = null;
    };

    camera.offset = .{ .x = @intToFloat(f32, screen_width) / 2, .y = @intToFloat(f32, screen_height) / 2 };
    camera.target.x = player.position.x();

    if (statics.even_out_target) |target| {
        if (target > camera.target.y) {
            camera.target.y += statics.event_out_speed * delta;
            if (camera.target.y > target) {
                camera.target.y = target;
                statics.even_out_target = null;
            }
        } else {
            camera.target.y -= statics.event_out_speed * delta;
            if (camera.target.y < target) {
                camera.target.y = target;
                statics.even_out_target = null;
            }
        }
    } else {
        if (player.can_jump and player.speed == 0 and player.position.y() != camera.target.y) {
            statics.even_out_target = player.position.y();
        }
    }
}

fn updateCameraPlayerBoundsPush(
    camera: *rl.Camera2D,
    player: Player,
    env_items: []const EnvItem,
    delta: f32,
    screen_width: i32,
    screen_height: i32,
) void {
    _ = delta;
    _ = env_items;
    const bounding_box = rl.Vector2.xy(0.2, 0.2);

    const bounding_box_world_min = rl.Vector2.xy(
        (1 - bounding_box.x()) * 0.5 * @intToFloat(f32, screen_width),
        (1 - bounding_box.y()) * 0.5 * @intToFloat(f32, screen_height),
    ).screenToWorld2D(camera.*);
    const bounding_box_world_max = rl.Vector2.xy(
        (1 + bounding_box.x()) * 0.5 * @intToFloat(f32, screen_width),
        (1 + bounding_box.y()) * 0.5 * @intToFloat(f32, screen_height),
    ).screenToWorld2D(camera.*);

    camera.offset = .{
        .x = (1 - bounding_box.x()) * 0.5 * @intToFloat(f32, screen_width),
        .y = (1 - bounding_box.y()) * 0.5 * @intToFloat(f32, screen_height),
    };

    if (player.position.x() < bounding_box_world_min.x()) {
        camera.target.x = player.position.x();
    }
    if (player.position.y() < bounding_box_world_min.y()) {
        camera.target.y = player.position.y();
    }
    if (player.position.x() > bounding_box_world_max.x()) {
        camera.target.x = bounding_box_world_min.x() + (player.position.x() - bounding_box_world_max.x());
    }
    if (player.position.y() > bounding_box_world_max.y()) {
        camera.target.y = bounding_box_world_min.y() + (player.position.y() - bounding_box_world_max.y());
    }
}

const Player = struct {
    position: rl.Vector2,
    speed: f32,
    can_jump: bool,

    fn update(player: *Player, env_items: []const EnvItem, delta: f32) void {
        if (rl.input.isKeyDown(.left)) {
            player.position.c_struct.x -= player_horizontal_speed * delta;
        }
        if (rl.input.isKeyDown(.right)) {
            player.position.c_struct.x += player_horizontal_speed * delta;
        }
        if (rl.input.isKeyDown(.space) and player.can_jump) {
            player.speed = -player_jump_speed;
            player.can_jump = false;
        }

        var hit_obstacle = false;
        for (env_items) |item| {
            const position = player.position;
            if (item.blocking and
                item.rectangle.x <= position.x() and
                item.rectangle.x + item.rectangle.width >= position.x() and
                item.rectangle.y >= position.y() and
                item.rectangle.y <= position.y() + player.speed * delta)
            {
                hit_obstacle = true;
                player.position.c_struct.y = item.rectangle.y;
            }
        }

        if (!hit_obstacle) {
            player.position.c_struct.y += player.speed * delta;
            player.speed += gravity * delta;
            player.can_jump = false;
        } else {
            player.speed = 0;
            player.can_jump = true;
        }
    }
};

const EnvItem = struct {
    rectangle: rl.Rectangle,
    blocking: bool,
    color: rl.Color,
};
