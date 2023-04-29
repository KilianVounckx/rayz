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
pub fn from_c_struct(c_struct: lib.c.Vector2) Self {
    var self: Self = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(self, field) = @field(c_struct, field);
    }
    return self;
}

/// Convert a zig Vector2 to a c api Vector2
pub fn to_c_struct(self: Self) lib.c.Vector2 {
    var c_struct: lib.c.Vector2 = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(c_struct, field) = @field(self, field);
    }
    return c_struct;
}

/// Convert a Vector2 to a Vector3
pub fn withZ(self: Self, z: f32) Vector3 {
    return .{ .x = self.x, .y = self.y, .z = z };
}

/// Add two vectors (v1 + v2)
pub fn add(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector2Add(self.to_c_struct(), other.to_c_struct()));
}

/// Add vector and float value
pub fn addValue(self: Self, value: f32) Self {
    return from_c_struct(lib.c.Vector2AddValue(self.to_c_struct(), value));
}

/// Subtract two vectors (v1 - v2)
pub fn subtract(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector2Subtract(self.to_c_struct(), other.to_c_struct()));
}

/// Scale vector (multiply by value)
pub fn scale(self: Self, factor: f32) Self {
    return from_c_struct(lib.c.Vector2Scale(self.to_c_struct(), factor));
}

/// Calculate vector length
pub fn length(self: Self) f32 {
    return lib.c.Vector2Length(self.to_c_struct());
}

/// Get the world space position for a 2d camera screen space position
pub fn screenToWorld(self: Self, camera: Camera2D) Self {
    return from_c_struct(lib.c.GetScreenToWorld2D(self.to_c_struct(), camera));
}

/// Get the screen space position for a 2d camera world space position
pub fn worldToScreen(self: Self, camera: Camera2D) Self {
    return from_c_struct(lib.c.GetWorldToScreen2D(self.to_c_struct(), camera));
}
