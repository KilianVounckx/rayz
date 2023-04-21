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
pub const LIGHTGRAY = Self{ .c_struct = lib.c.raylib.colors.LIGHTGRAY };
/// Gray
pub const GRAY = Self{ .c_struct = lib.c.raylib.colors.GRAY };
/// Dark Gray
pub const DARKGRAY = Self{ .c_struct = lib.c.raylib.colors.DARKGRAY };
/// Yellow
pub const YELLOW = Self{ .c_struct = lib.c.raylib.colors.YELLOW };
/// Gold
pub const GOLD = Self{ .c_struct = lib.c.raylib.colors.GOLD };
/// Orange
pub const ORANGE = Self{ .c_struct = lib.c.raylib.colors.ORANGE };
/// Pink
pub const PINK = Self{ .c_struct = lib.c.raylib.colors.PINK };
/// Red
pub const RED = Self{ .c_struct = lib.c.raylib.colors.RED };
/// Maroon
pub const MAROON = Self{ .c_struct = lib.c.raylib.colors.MAROON };
/// Green
pub const GREEN = Self{ .c_struct = lib.c.raylib.colors.GREEN };
/// Lime
pub const LIME = Self{ .c_struct = lib.c.raylib.colors.LIME };
/// Dark Green
pub const DARKGREEN = Self{ .c_struct = lib.c.raylib.colors.DARKGREEN };
/// Sky Blue
pub const SKYBLUE = Self{ .c_struct = lib.c.raylib.colors.SKYBLUE };
/// Blue
pub const BLUE = Self{ .c_struct = lib.c.raylib.colors.BLUE };
/// Dark Blue
pub const DARKBLUE = Self{ .c_struct = lib.c.raylib.colors.DARKBLUE };
/// Purple
pub const PURPLE = Self{ .c_struct = lib.c.raylib.colors.PURPLE };
/// Violet
pub const VIOLET = Self{ .c_struct = lib.c.raylib.colors.VIOLET };
/// Dark Purple
pub const DARKPURPLE = Self{ .c_struct = lib.c.raylib.colors.DARKPURPLE };
/// Beige
pub const BEIGE = Self{ .c_struct = lib.c.raylib.colors.BEIGE };
/// Brown
pub const BROWN = Self{ .c_struct = lib.c.raylib.colors.BROWN };
/// Dark Brown
pub const DARKBROWN = Self{ .c_struct = lib.c.raylib.colors.DARKBROWN };
/// White
pub const WHITE = Self{ .c_struct = lib.c.raylib.colors.WHITE };
/// Black
pub const BLACK = Self{ .c_struct = lib.c.raylib.colors.BLACK };
/// Blank (Transparent)
pub const BLANK = Self{ .c_struct = lib.c.raylib.colors.BLANK };
/// Magenta
pub const MAGENTA = Self{ .c_struct = lib.c.raylib.colors.MAGENTA };
/// Raylib White (raylib logo)
pub const RAYWHITE = Self{ .c_struct = lib.c.raylib.colors.RAYWHITE };