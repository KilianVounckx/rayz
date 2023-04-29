//! Camera, defines position/orientation in 3d space

const std = @import("std");

const lib = @import("lib.zig");
const Ray = lib.Ray;
const Vector2 = lib.Vector2;
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

/// Convert a c api Camera3D to a zig Camera3D
pub fn fromCStruct(c_struct: lib.c.Camera3D) Self {
    return .{
        .position = Vector3.fromCStruct(c_struct.position),
        .target = Vector3.fromCStruct(c_struct.target),
        .up = Vector3.fromCStruct(c_struct.up),
        .fovy = c_struct.fovy,
        .projection = @intToEnum(Projection, c_struct.projection),
    };
}

/// Convert a zig Camera3D to a c api Camera3D
pub fn toCStruct(self: Self) lib.c.Camera3D {
    return .{
        .position = self.position.toCStruct(),
        .target = self.target.toCStruct(),
        .up = self.up.toCStruct(),
        .fovy = self.fovy,
        .projection = @enumToInt(self.projection),
    };
}

/// Update camera position for selected mode
pub fn update(self: *Self, mode: Mode) void {
    var c_struct = self.toCStruct();
    lib.c.UpdateCamera(&c_struct, @enumToInt(mode));
    self.* = fromCStruct(c_struct);
}

/// Config for `yaw`
pub const YawConfig = struct {
    /// if true rotate around target, else rotate around position
    rotate_around_target: bool = true,
};

/// Rotates the camera around its up vector
/// Yaw is "looking left and right"
/// Note: angle must be provided in radians
pub fn yaw(self: *Self, angle_radians: f32, config: YawConfig) void {
    var c_struct = self.toCStruct();
    lib.c.CameraYaw(&c_struct, angle_radians, config.rotate_around_target);
    self.* = fromCStruct(c_struct);
}

pub const PitchConfig = struct {
    /// Prevents overrotation (aka "somersaults")
    lock_view: bool = true,
    /// if true rotate around target, else rotate around position
    rotate_around_target: bool = true,
    ///  rotates the up direction as well (typically only usefull in `Mode.free`)
    rotate_up: bool = false,
};

/// Rotates the camera around its right vector
/// Pitch is "looking up and down"
/// Note: angle must be provided in radians
pub fn pitch(self: *Self, angle_radians: f32, config: PitchConfig) void {
    var c_struct = self.toCStruct();
    lib.c.CameraPitch(&c_struct, angle_radians, config.lock_view, config.rotate_around_target, config.rotate_up);
    self.* = fromCStruct(c_struct);
}

/// Rotates the camera around its forward vector
/// Roll is "turning your head sideways to the left or right"
/// Note: angle must be provided in radians
pub fn roll(self: *Self, angle_radians: f32) void {
    var c_struct = self.toCStruct();
    lib.c.CameraRoll(&c_struct, angle_radians);
    self.* = fromCStruct(c_struct);
}

/// Get a ray trace from mouse position
pub fn getMouseRay(self: Self, mouse_position: Vector2) Ray {
    return Ray.fromCStruct(lib.c.GetMouseRay(mouse_position.toCStruct(), self.toCStruct()));
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
