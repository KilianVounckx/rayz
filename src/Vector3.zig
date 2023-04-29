//! Vector3, 3 components

const std = @import("std");

const lib = @import("lib.zig");
const Camera3D = lib.Camera3D;
const Vector2 = lib.Vector2;

const Self = @This();

/// Vector x component
x: f32 = 0,
/// Vector y component
y: f32 = 0,
/// Vector z component
z: f32 = 0,

/// Create a new 3D vector
pub fn init(x: f32, y: f32, z: f32) Self {
    return .{ .x = x, .y = y, .z = z };
}

/// Convert a c api Vector3 to a zig Vector3
pub fn fromCStruct(c_struct: lib.c.Vector3) Self {
    return .{
        .x = c_struct.x,
        .y = c_struct.y,
        .z = c_struct.z,
    };
}

/// Convert a zig Vector3 to a c api Vector3
pub fn toCStruct(self: Self) lib.c.Vector3 {
    return .{
        .x = self.x,
        .y = self.y,
        .z = self.z,
    };
}

/// Convert a Vector3 to a Vector2
pub fn withoutZ(self: Self) Vector2 {
    return .{ .x = self.x, .y = self.y };
}

/// Add two vectors (v1 + v2)
pub fn add(self: Self, other: Self) Self {
    return fromCStruct(lib.c.Vector3Add(self.toCStruct(), other.toCStruct()));
}

/// Add vector and float value
pub fn addValue(self: Self, value: f32) Self {
    return fromCStruct(lib.c.Vector3AddValue(self.toCStruct(), value));
}

/// Subtract two vectors (v1 - v2)
pub fn subtract(self: Self, other: Self) Self {
    return fromCStruct(lib.c.Vector3Subtract(self.toCStruct(), other.toCStruct()));
}

/// Scale vector (multiply by value)
pub fn scale(self: Self, factor: f32) Self {
    return fromCStruct(lib.c.Vector3Scale(self.toCStruct(), factor));
}

/// Calculate vector length
pub fn length(self: Self) f32 {
    return lib.c.Vector3Length(self.toCStruct());
}

/// Get the screen space position for a 3d world space position
pub fn worldToScreen(self: Self, camera: Camera3D) Vector2 {
    return Vector2.fromCStruct(lib.c.GetWorldToScreen(self.toCStruct(), camera.toCStruct()));
}
