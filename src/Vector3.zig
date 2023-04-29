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
pub fn from_c_struct(c_struct: lib.c.Vector3) Self {
    var self: Self = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(self, field) = @field(c_struct, field);
    }
    return self;
}

/// Convert a zig Vector3 to a c api Vector3
pub fn to_c_struct(self: Self) lib.c.Vector3 {
    var c_struct: lib.c.Vector3 = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(c_struct, field) = @field(self, field);
    }
    return c_struct;
}

/// Convert a Vector3 to a Vector2
pub fn withoutZ(self: Self) Vector2 {
    return .{ .x = self.x, .y = self.y };
}

/// Add two vectors (v1 + v2)
pub fn add(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector3Add(self.to_c_struct(), other.to_c_struct()));
}

/// Add vector and float value
pub fn addValue(self: Self, value: f32) Self {
    return from_c_struct(lib.c.Vector3AddValue(self.to_c_struct(), value));
}

/// Subtract two vectors (v1 - v2)
pub fn subtract(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector3Subtract(self.to_c_struct(), other.to_c_struct()));
}

/// Scale vector (multiply by value)
pub fn scale(self: Self, factor: f32) Self {
    return from_c_struct(lib.c.Vector3Scale(self.to_c_struct(), factor));
}

/// Calculate vector length
pub fn length(self: Self) f32 {
    return lib.c.Vector3Length(self.to_c_struct());
}

/// Get the screen space position for a 3d world space position
pub fn worldToScreen(self: Self, camera: Camera3D) Vector2 {
    return Vector2.from_c_struct(lib.c.GetWorldToScreen(self.to_c_struct(), camera.to_c_struct()));
}
