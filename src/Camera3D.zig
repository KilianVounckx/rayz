//! Camera, defines position/orientation in 3d space

const std = @import("std");

const lib = @import("lib.zig");
const Vector3 = lib.Vector3;

const Self = @This();

/// Camera position
position: Vector3,
/// Camera target it looks-at
target: Vector3,
/// Camera up vector (rotation over its axis)
up: Vector3,
/// Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
fovy: f32,
/// Camera projection: perspective or orthographic
projection: Projection,

pub fn from_c_struct(c_struct: lib.c.Camera3D) Self {
    return .{
        .position = Vector3.from_c_struct(c_struct.position),
        .target = Vector3.from_c_struct(c_struct.target),
        .up = Vector3.from_c_struct(c_struct.up),
        .fovy = c_struct.fovy,
        .projection = @intToEnum(Projection, c_struct.projection),
    };
}

pub fn to_c_struct(self: Self) lib.c.Camera3D {
    return .{
        .position = self.position.to_c_struct(),
        .target = self.target.to_c_struct(),
        .up = self.up.to_c_struct(),
        .fovy = self.fovy,
        .projection = @enumToInt(self.projection),
    };
}

pub fn update(self: *Self, mode: Mode) void {
    var c_struct = self.to_c_struct();
    lib.c.UpdateCamera(&c_struct, @enumToInt(mode));
    self.* = from_c_struct(c_struct);
}

/// Camera projection
pub const Projection = enum(u8) {
    /// Perspective projection
    perspective = 0,
    /// Orthographic projection
    orthographic,
};

/// Camera system modes
pub const Mode = enum(u8) {
    /// Camera custom, controlled by user (UpdateCamera() does nothing)
    custom = 0,
    /// Camera free mode
    free,
    /// Camera orbital, around target, zoom supported
    orbital,
    /// Camera first person
    first_person,
    /// Camera third person
    third_person,
};
