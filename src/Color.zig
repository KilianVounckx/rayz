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
pub fn from_c_struct(c_struct: lib.c.Color) Self {
    return .{
        .r = c_struct.r,
        .g = c_struct.g,
        .b = c_struct.b,
        .a = c_struct.a,
    };
}

/// Convert a zig Color to a c api Color
pub fn to_c_struct(self: Self) lib.c.Color {
    return .{
        .r = self.r,
        .g = self.g,
        .b = self.b,
        .a = self.a,
    };
}

/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub fn fade(self: Self, alpha: f32) Self {
    return from_c_struct(lib.c.Fade(self.to_c_struct(), alpha));
}

/// Light Gray
pub const LIGHTGRAY = from_c_struct(lib.c.LIGHTGRAY);
/// Gray
pub const GRAY = from_c_struct(lib.c.GRAY);
/// Dark Gray
pub const DARKGRAY = from_c_struct(lib.c.DARKGRAY);
/// Yellow
pub const YELLOW = from_c_struct(lib.c.YELLOW);
/// Gold
pub const GOLD = from_c_struct(lib.c.GOLD);
/// Orange
pub const ORANGE = from_c_struct(lib.c.ORANGE);
/// Pink
pub const PINK = from_c_struct(lib.c.PINK);
/// Red
pub const RED = from_c_struct(lib.c.RED);
/// Maroon
pub const MAROON = from_c_struct(lib.c.MAROON);
/// Green
pub const GREEN = from_c_struct(lib.c.GREEN);
/// Lime
pub const LIME = from_c_struct(lib.c.LIME);
/// Dark Green
pub const DARKGREEN = from_c_struct(lib.c.DARKGREEN);
/// Sky Blue
pub const SKYBLUE = from_c_struct(lib.c.SKYBLUE);
/// Blue
pub const BLUE = from_c_struct(lib.c.BLUE);
/// Dark Blue
pub const DARKBLUE = from_c_struct(lib.c.DARKBLUE);
/// Purple
pub const PURPLE = from_c_struct(lib.c.PURPLE);
/// Violet
pub const VIOLET = from_c_struct(lib.c.VIOLET);
/// Dark Purple
pub const DARKPURPLE = from_c_struct(lib.c.DARKPURPLE);
/// Beige
pub const BEIGE = from_c_struct(lib.c.BEIGE);
/// Brown
pub const BROWN = from_c_struct(lib.c.BROWN);
/// Dark Brown
pub const DARKBROWN = from_c_struct(lib.c.DARKBROWN);
/// White
pub const WHITE = from_c_struct(lib.c.WHITE);
/// Black
pub const BLACK = from_c_struct(lib.c.BLACK);
/// Blank (Transparent)
pub const BLANK = from_c_struct(lib.c.BLANK);
/// Magenta
pub const MAGENTA = from_c_struct(lib.c.MAGENTA);
/// Raylib White (raylib logo)
pub const RAYWHITE = from_c_struct(lib.c.RAYWHITE);
