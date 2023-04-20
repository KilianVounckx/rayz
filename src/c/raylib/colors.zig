const lib = @import("../../lib.zig");
const Color = lib.c.structs.Color;

// Custom raylib color palette for amazing visuals on WHITE background
/// Light Gray
pub const LIGHTGRAY = Color{ .r = 200, .g = 200, .b = 200, .a = 255 };
/// Gray
pub const GRAY = Color{ .r = 130, .g = 130, .b = 130, .a = 255 };
/// Dark Gray
pub const DARKGRAY = Color{ .r = 80, .g = 80, .b = 80, .a = 255 };
/// Yellow
pub const YELLOW = Color{ .r = 253, .g = 249, .b = 0, .a = 255 };
/// Gold
pub const GOLD = Color{ .r = 255, .g = 203, .b = 0, .a = 255 };
/// Orange
pub const ORANGE = Color{ .r = 255, .g = 161, .b = 0, .a = 255 };
/// Pink
pub const PINK = Color{ .r = 255, .g = 109, .b = 194, .a = 255 };
/// Red
pub const RED = Color{ .r = 230, .g = 41, .b = 55, .a = 255 };
/// Maroon
pub const MAROON = Color{ .r = 190, .g = 33, .b = 55, .a = 255 };
/// Green
pub const GREEN = Color{ .r = 0, .g = 228, .b = 48, .a = 255 };
/// Lime
pub const LIME = Color{ .r = 0, .g = 158, .b = 47, .a = 255 };
/// Dark Green
pub const DARKGREEN = Color{ .r = 0, .g = 117, .b = 44, .a = 255 };
/// Sky Blue
pub const SKYBLUE = Color{ .r = 102, .g = 191, .b = 255, .a = 255 };
/// Blue
pub const BLUE = Color{ .r = 0, .g = 121, .b = 241, .a = 255 };
/// Dark Blue
pub const DARKBLUE = Color{ .r = 0, .g = 82, .b = 172, .a = 255 };
/// Purple
pub const PURPLE = Color{ .r = 200, .g = 122, .b = 255, .a = 255 };
/// Violet
pub const VIOLET = Color{ .r = 135, .g = 60, .b = 190, .a = 255 };
/// Dark Purple
pub const DARKPURPLE = Color{ .r = 112, .g = 31, .b = 126, .a = 255 };
/// Beige
pub const BEIGE = Color{ .r = 211, .g = 176, .b = 131, .a = 255 };
/// Brown
pub const BROWN = Color{ .r = 127, .g = 106, .b = 79, .a = 255 };
/// Dark Brown
pub const DARKBROWN = Color{ .r = 76, .g = 63, .b = 47, .a = 255 };
/// White
pub const WHITE = Color{ .r = 255, .g = 255, .b = 255, .a = 255 };
/// Black
pub const BLACK = Color{ .r = 0, .g = 0, .b = 0, .a = 255 };
/// Blank (Transparent)
pub const BLANK = Color{ .r = 0, .g = 0, .b = 0, .a = 0 };
/// Magenta
pub const MAGENTA = Color{ .r = 255, .g = 0, .b = 255, .a = 255 };
/// My own White (raylib logo)
pub const RAYWHITE = Color{ .r = 245, .g = 245, .b = 245, .a = 255 };
