const lib = @import("lib.zig");
const Color = lib.Color;
const Vector2 = lib.c.raylib.structs.Vector2;
const Font = lib.c.raylib.structs.Font;

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
pub fn drawText(text: [:0]const u8, config: DrawTextConfig) void {
    const spacing = if (config.spacing) |spacing|
        spacing
    else blk: {
        const default_font_size = 10;
        break :blk config.font_size / default_font_size;
    };
    const font = if (config.font) |font|
        font
    else
        lib.c.raylib.text.GetFontDefault();

    lib.c.raylib.text.DrawTextPro(
        font,
        text,
        config.position,
        config.rotation_origin,
        config.rotation_angle,
        config.font_size,
        spacing,
        config.color.c_struct,
    );
}
