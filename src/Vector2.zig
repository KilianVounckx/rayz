//! Vector2, 2 components

const std = @import("std");

const lib = @import("lib.zig");
const Camera2D = lib.Camera2D;

const Self = @This();

x: f32 = 0,
y: f32 = 0,

pub fn init(x: f32, y: f32) Self {
    return .{ .x = x, .y = y };
}

pub fn from_c_struct(c_struct: lib.c.Vector2) Self {
    var self: Self = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(self, field) = @field(c_struct, field);
    }
    return self;
}

pub fn to_c_struct(self: Self) lib.c.Vector2 {
    var c_struct: lib.c.Vector2 = undefined;
    inline for (comptime std.meta.fieldNames(Self)) |field| {
        @field(c_struct, field) = @field(self, field);
    }
    return c_struct;
}

pub fn add(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector2Add(self.to_c_struct(), other.to_c_struct()));
}

pub fn subtract(self: Self, other: Self) Self {
    return from_c_struct(lib.c.Vector2Subtract(self.to_c_struct(), other.to_c_struct()));
}

pub fn scale(self: Self, factor: f32) Self {
    return from_c_struct(lib.c.Vector2Scale(self.to_c_struct(), factor));
}

pub fn length(self: Self) f32 {
    return lib.c.Vector2Length(self.to_c_struct());
}

pub fn screenToWorld2D(self: Self, camera: Camera2D) Self {
    return from_c_struct(lib.c.GetScreenToWorld2D(self.to_c_struct(), camera));
}

pub fn worldToScreen2D(self: Self, camera: Camera2D) Self {
    return from_c_struct(lib.c.GetWorldToScreen2D(self.to_c_struct(), camera));
}
