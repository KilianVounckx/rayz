//! RGBA Color type
//!
//! Simple wrapper around raylib's Color type

const lib = @import("lib.zig");

const Self = @This();

c_struct: lib.c.Color,

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

pub fn fade(self: Self, alpha: f32) Self {
    return .{ .c_struct = lib.c.Fade(self.c_struct, alpha) };
}

/// Light Gray
pub const LIGHTGRAY = Self{ .c_struct = lib.c.LIGHTGRAY };
/// Gray
pub const GRAY = Self{ .c_struct = lib.c.GRAY };
/// Dark Gray
pub const DARKGRAY = Self{ .c_struct = lib.c.DARKGRAY };
/// Yellow
pub const YELLOW = Self{ .c_struct = lib.c.YELLOW };
/// Gold
pub const GOLD = Self{ .c_struct = lib.c.GOLD };
/// Orange
pub const ORANGE = Self{ .c_struct = lib.c.ORANGE };
/// Pink
pub const PINK = Self{ .c_struct = lib.c.PINK };
/// Red
pub const RED = Self{ .c_struct = lib.c.RED };
/// Maroon
pub const MAROON = Self{ .c_struct = lib.c.MAROON };
/// Green
pub const GREEN = Self{ .c_struct = lib.c.GREEN };
/// Lime
pub const LIME = Self{ .c_struct = lib.c.LIME };
/// Dark Green
pub const DARKGREEN = Self{ .c_struct = lib.c.DARKGREEN };
/// Sky Blue
pub const SKYBLUE = Self{ .c_struct = lib.c.SKYBLUE };
/// Blue
pub const BLUE = Self{ .c_struct = lib.c.BLUE };
/// Dark Blue
pub const DARKBLUE = Self{ .c_struct = lib.c.DARKBLUE };
/// Purple
pub const PURPLE = Self{ .c_struct = lib.c.PURPLE };
/// Violet
pub const VIOLET = Self{ .c_struct = lib.c.VIOLET };
/// Dark Purple
pub const DARKPURPLE = Self{ .c_struct = lib.c.DARKPURPLE };
/// Beige
pub const BEIGE = Self{ .c_struct = lib.c.BEIGE };
/// Brown
pub const BROWN = Self{ .c_struct = lib.c.BROWN };
/// Dark Brown
pub const DARKBROWN = Self{ .c_struct = lib.c.DARKBROWN };
/// White
pub const WHITE = Self{ .c_struct = lib.c.WHITE };
/// Black
pub const BLACK = Self{ .c_struct = lib.c.BLACK };
/// Blank (Transparent)
pub const BLANK = Self{ .c_struct = lib.c.BLANK };
/// Magenta
pub const MAGENTA = Self{ .c_struct = lib.c.MAGENTA };
/// Raylib White (raylib logo)
pub const RAYWHITE = Self{ .c_struct = lib.c.RAYWHITE };
