//! Vector3, 3 components

const std = @import("std");

const lib = @import("lib.zig");
const Camera3D = lib.Camera3D;

const Self = @This();

x: f32 = 0,
y: f32 = 0,
z: f32 = 0,

pub fn init(x: f32, y: f32, z: f32) Self {
    return .{ .x = x, .y = y, .z = z };
}

pub fn from_c_struct(c_struct: lib.c.Vector3) Self {
    var self: Self = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(self, field) = @field(c_struct, field);
    }
    return self;
}

pub fn to_c_struct(self: Self) lib.c.Vector3 {
    var c_struct: lib.c.Vector3 = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(c_struct, field) = @field(self, field);
    }
    return c_struct;
}

pub fn add(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector3Add(self.to_c_struct(), other.to_c_struct()));
}

pub fn subtract(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector3Subtract(self.to_c_struct(), other.to_c_struct()));
}

pub fn scale(self: Self, factor: f32) Self {
    return from_c_struct(lib.c.Vector3Scale(self.to_c_struct(), factor));
}

pub fn length(self: Self) f32 {
    return lib.c.Vector3Length(self.to_c_struct());
}

pub fn screenToWorld2D(self: Self, camera: Camera3D) Self {
    return from_c_struct(lib.c.GetScreenToWorld3D(self.to_c_struct(), camera));
}

pub fn worldToScreen2D(self: Self, camera: Camera3D) Self {
    return from_c_struct(lib.c.GetWorldToScreen3D(self.to_c_struct(), camera));
}
