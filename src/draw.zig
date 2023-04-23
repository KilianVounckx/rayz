const lib = @import("lib.zig");
const Color = lib.Color;
const Vector2 = lib.Vector2;
const Font = lib.c.raylib.Font;
const Rectangle = lib.Rectangle;

/// Configuration for drawText
pub const DrawTextConfig = struct {
    /// Position to draw to
    position: Vector2,
    /// Font
    font: ?Font = null,
    /// Font size
    font_size: f32,
    /// Text color
    color: Color,
    /// Spacing between letters
    spacing: ?f32 = null,
    /// Rotation point
    rotation_origin: Vector2 = .{ .x = 0, .y = 0 },
    /// Rotation angle
    rotation_angle: f32 = 0,
};

/// Draw text (using default font)
///
/// This combines DrawText, DrawTextEx, and DrawTextPro from the c api
pub fn text(msg: [:0]const u8, config: DrawTextConfig) void {
    const spacing = if (config.spacing) |spacing|
        spacing
    else blk: {
        const default_font_size = 10;
        break :blk config.font_size / default_font_size;
    };
    const font = if (config.font) |font|
        font
    else
        lib.c.raylib.GetFontDefault();

    lib.c.raylib.DrawTextPro(
        font,
        msg,
        config.position,
        config.rotation_origin,
        config.rotation_angle,
        config.font_size,
        spacing,
        config.color.c_struct,
    );
}

pub const DrawCircleConfig = struct {
    fill: bool = true,
};

pub fn circle(center: Vector2, radius: f32, color: Color, config: DrawCircleConfig) void {
    if (config.fill) {
        lib.c.raylib.DrawCircleV(center, radius, color.c_struct);
    } else {
        lib.c.raylib.DrawCircleLines(
            @floatToInt(i32, center.x),
            @floatToInt(i32, center.y),
            radius,
            color.c_struct,
        );
    }
}

pub const DrawRectangleConfig = struct {
    fill: bool = true,
    thickness: f32 = 1,
    roundness: f32 = 0,
    segments: i32 = 1,
};

pub fn rectangle(rect: Rectangle, color: Color, config: DrawRectangleConfig) void {
    if (config.fill) {
        if (config.roundness == 0) {
            lib.c.raylib.DrawRectangleRec(rect, color.c_struct);
        } else {
            lib.c.raylib.DrawRectangleRounded(rect, config.roundness, config.segments, color.c_struct);
        }
    } else {
        if (config.roundness == 0) {
            lib.c.raylib.DrawRectangleLinesEx(rect, config.thickness, color.c_struct);
        } else {
            lib.c.raylib.DrawRectangleRoundedLines(rect, config.roundness, config.segments, config.thickness, color.c_struct);
        }
    }
}

pub const DrawLineConfig = struct {
    thickness: f32 = 1,
};

pub fn line(start: Vector2, end: Vector2, color: Color, config: DrawLineConfig) void {
    lib.c.raylib.DrawLineEx(start, end, config.thickness, color.c_struct);
}
