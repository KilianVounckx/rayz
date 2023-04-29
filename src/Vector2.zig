//! Vector2, 2 components

const std = @import("std");

const lib = @import("lib.zig");
const Camera2D = lib.Camera2D;
const Vector3 = lib.Vector3;

const Self = @This();

/// Vector x component
x: f32 = 0,
/// Vector y component
y: f32 = 0,

/// Create a new 2D vector
pub fn init(x: f32, y: f32) Self {
    return .{ .x = x, .y = y };
}

/// Convert a c api Vector2 to a zig Vector2
pub fn fromCStruct(c_struct: lib.c.Vector2) Self {
    return .{
        .x = c_struct.x,
        .y = c_struct.y,
    };
}

/// Convert a zig Vector2 to a c api Vector2
pub fn toCStruct(self: Self) lib.c.Vector2 {
    return .{
        .x = self.x,
        .y = self.y,
    };
}

/// Convert a Vector2 to a Vector3
pub fn withZ(self: Self, z: f32) Vector3 {
    return .{ .x = self.x, .y = self.y, .z = z };
}

/// Add two vectors (v1 + v2)
pub fn add(self: Self, other: Self) Self {
    return fromCStruct(lib.c.Vector2Add(self.toCStruct(), other.toCStruct()));
}

/// Add vector and float value
pub fn addValue(self: Self, value: f32) Self {
    return fromCStruct(lib.c.Vector2AddValue(self.toCStruct(), value));
}

/// Subtract two vectors (v1 - v2)
pub fn subtract(self: Self, other: Self) Self {
    return fromCStruct(lib.c.Vector2Subtract(self.toCStruct(), other.toCStruct()));
}

/// Scale vector (multiply by value)
pub fn scale(self: Self, factor: f32) Self {
    return fromCStruct(lib.c.Vector2Scale(self.toCStruct(), factor));
}

/// Calculate vector length
pub fn length(self: Self) f32 {
    return lib.c.Vector2Length(self.toCStruct());
}

/// Get the world space position for a 2d camera screen space position
pub fn screenToWorld(self: Self, camera: Camera2D) Self {
    return fromCStruct(lib.c.GetScreenToWorld2D(self.toCStruct(), camera));
}

/// Get the screen space position for a 2d camera world space position
pub fn worldToScreen(self: Self, camera: Camera2D) Self {
    return fromCStruct(lib.c.GetWorldToScreen2D(self.toCStruct(), camera));
}
