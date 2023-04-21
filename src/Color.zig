//! RGBA Color type
//!
//! Simple wrapper around raylib's Color type

const lib = @import("lib.zig");

const Self = @This();

c_struct: lib.c.raylib.structs.Color,

/// Create a new rgba color
pub fn rgba(r: u8, g: u8, b: u8, a: u8) Self {
    return .{ .c_struct = .{ .r = r, .g = g, .b = b, .a = a } };
}

/// Create a new rgb color
///
/// Alpha channel will be 255.
pub fn rgb(r: u8, g: u8, b: u8) Self {
    return rgba(r, g, b, 255);
}

/// Light Gray
pub const LIGHTGRAY = rgba(200, 200, 200, 255);
/// Gray
pub const GRAY = rgba(130, 130, 130, 255);
/// Dark Gray
pub const DARKGRAY = rgba(80, 80, 80, 255);
/// Yellow
pub const YELLOW = rgba(253, 249, 0, 255);
/// Gold
pub const GOLD = rgba(255, 203, 0, 255);
/// Orange
pub const ORANGE = rgba(255, 161, 0, 255);
/// Pink
pub const PINK = rgba(255, 109, 194, 255);
/// Red
pub const RED = rgba(230, 41, 55, 255);
/// Maroon
pub const MAROON = rgba(190, 33, 55, 255);
/// Green
pub const GREEN = rgba(0, 228, 48, 255);
/// Lime
pub const LIME = rgba(0, 158, 47, 255);
/// Dark Green
pub const DARKGREEN = rgba(0, 117, 44, 255);
/// Sky Blue
pub const SKYBLUE = rgba(102, 191, 255, 255);
/// Blue
pub const BLUE = rgba(0, 121, 241, 255);
/// Dark Blue
pub const DARKBLUE = rgba(0, 82, 172, 255);
/// Purple
pub const PURPLE = rgba(200, 122, 255, 255);
/// Violet
pub const VIOLET = rgba(135, 60, 190, 255);
/// Dark Purple
pub const DARKPURPLE = rgba(112, 31, 126, 255);
/// Beige
pub const BEIGE = rgba(211, 176, 131, 255);
/// Brown
pub const BROWN = rgba(127, 106, 79, 255);
/// Dark Brown
pub const DARKBROWN = rgba(76, 63, 47, 255);
/// White
pub const WHITE = rgba(255, 255, 255, 255);
/// Black
pub const BLACK = rgba(0, 0, 0, 255);
/// Blank (Transparent)
pub const BLANK = rgba(0, 0, 0, 0);
/// Magenta
pub const MAGENTA = rgba(255, 0, 255, 255);
/// Raylib White (raylib logo)
pub const RAYWHITE = rgba(245, 245, 245, 255);
