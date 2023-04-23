//! Vector2, 2 components
//!
//! Simple wrapper around raylib's Color type

const lib = @import("lib.zig");
const Camera2D = lib.Camera2D;

const Self = @This();

c_struct: lib.c.Vector2,

pub fn xy(_x: f32, _y: f32) Self {
    return .{ .c_struct = .{ .x = _x, .y = _y } };
}

pub fn x(self: Self) f32 {
    return self.c_struct.x;
}

pub fn y(self: Self) f32 {
    return self.c_struct.y;
}

pub fn add(self: Self, other: Self) Self {
    return .{ .c_struct = lib.c.Vector2Add(self.c_struct, other.c_struct) };
}

pub fn scale(self: Self, factor: f32) Self {
    return .{ .c_struct = lib.c.Vector2Scale(self.c_struct, factor) };
}

pub fn screenToWorld2D(self: Self, camera: Camera2D) Self {
    return .{ .c_struct = lib.c.GetScreenToWorld2D(self.c_struct, camera) };
}
