//! RGBA Color type

const std = @import("std");

const lib = @import("lib.zig");

const Self = @This();

/// Color red value
r: u8 = 0,
/// Color green value
g: u8 = 0,
/// Color blue value
b: u8 = 0,
/// Color alpha value
a: u8 = 255,

/// Create a new rgba color
pub fn init(r: u8, g: u8, b: u8, a: u8) Self {
    return .{ .r = r, .g = g, .b = b, .a = a };
}

/// Create a new rgb color
///
/// Alpha channel will be 255.
pub fn rgb(r: u8, g: u8, b: u8) Self {
    return init(r, g, b, 255);
}

/// Convert a c api Color to a zig Color
pub fn fromCStruct(c_struct: lib.c.Color) Self {
    return .{
        .r = c_struct.r,
        .g = c_struct.g,
        .b = c_struct.b,
        .a = c_struct.a,
    };
}

/// Convert a zig Color to a c api Color
pub fn toCStruct(self: Self) lib.c.Color {
    return .{
        .r = self.r,
        .g = self.g,
        .b = self.b,
        .a = self.a,
    };
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn fade(self: Self, alpha: f32) Self {
    return fromCStruct(lib.c.Fade(self.toCStruct(), alpha));
}

/// Light Gray
pub const LIGHTGRAY = fromCStruct(lib.c.LIGHTGRAY);
/// Gray
pub const GRAY = fromCStruct(lib.c.GRAY);
/// Dark Gray
pub const DARKGRAY = fromCStruct(lib.c.DARKGRAY);
/// Yellow
pub const YELLOW = fromCStruct(lib.c.YELLOW);
/// Gold
pub const GOLD = fromCStruct(lib.c.GOLD);
/// Orange
pub const ORANGE = fromCStruct(lib.c.ORANGE);
/// Pink
pub const PINK = fromCStruct(lib.c.PINK);
/// Red
pub const RED = fromCStruct(lib.c.RED);
/// Maroon
pub const MAROON = fromCStruct(lib.c.MAROON);
/// Green
pub const GREEN = fromCStruct(lib.c.GREEN);
/// Lime
pub const LIME = fromCStruct(lib.c.LIME);
/// Dark Green
pub const DARKGREEN = fromCStruct(lib.c.DARKGREEN);
/// Sky Blue
pub const SKYBLUE = fromCStruct(lib.c.SKYBLUE);
/// Blue
pub const BLUE = fromCStruct(lib.c.BLUE);
/// Dark Blue
pub const DARKBLUE = fromCStruct(lib.c.DARKBLUE);
/// Purple
pub const PURPLE = fromCStruct(lib.c.PURPLE);
/// Violet
pub const VIOLET = fromCStruct(lib.c.VIOLET);
/// Dark Purple
pub const DARKPURPLE = fromCStruct(lib.c.DARKPURPLE);
/// Beige
pub const BEIGE = fromCStruct(lib.c.BEIGE);
/// Brown
pub const BROWN = fromCStruct(lib.c.BROWN);
/// Dark Brown
pub const DARKBROWN = fromCStruct(lib.c.DARKBROWN);
/// White
pub const WHITE = fromCStruct(lib.c.WHITE);
/// Black
pub const BLACK = fromCStruct(lib.c.BLACK);
/// Blank (Transparent)
pub const BLANK = fromCStruct(lib.c.BLANK);
/// Magenta
pub const MAGENTA = fromCStruct(lib.c.MAGENTA);
/// Raylib White (raylib logo)
pub const RAYWHITE = fromCStruct(lib.c.RAYWHITE);
