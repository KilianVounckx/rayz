//! Ray, ray for raycasting

const lib = @import("lib.zig");
const BoundingBox = lib.BoundingBox;
const Vector3 = lib.Vector3;

const Self = @This();

/// Ray position (origin)
position: Vector3,
/// Ray direction
direction: Vector3,

/// Create a new 3D ray
pub fn init(position: Vector3, direction: Vector3) Self {
    return .{ .position = position, .direction = direction };
}

/// Convert a c api Ray to a zig Ray
pub fn from_c_struct(c_struct: lib.c.Ray) Self {
    return .{
        .position = Vector3.from_c_struct(c_struct.position),
        .direction = Vector3.from_c_struct(c_struct.direction),
    };
}

/// Convert a zig Ray to a c api Ray
pub fn to_c_struct(self: Self) lib.c.Ray {
    return .{
        .position = self.position.to_c_struct(),
        .direction = self.direction.to_c_struct(),
    };
}

/// Get collision info between ray and box
pub fn getCollisionBox(self: Self, box: BoundingBox) ?Collision {
    return Collision.from_c_struct(lib.c.GetRayCollisionBox(self.to_c_struct(), box));
}

// RayCollision, ray hit information
pub const Collision = struct {
    /// Distance to the nearest hit
    distance: f32,
    /// Point of the nearest hit
    point: Vector3,
    /// Surface normal of hit
    normal: Vector3,

    /// Convert a c api RayCollision to an optional zig Ray.Collision
    pub fn from_c_struct(c_struct: lib.c.RayCollision) ?Collision {
        if (!c_struct.hit) return null;
        return .{
            .distance = c_struct.distance,
            .point = Vector3.from_c_struct(c_struct.point),
            .normal = Vector3.from_c_struct(c_struct.normal),
        };
    }

    /// Convert an optional zig Ray.Collision to a c api RayCollision
    pub fn to_c_struct(self: ?Collision) lib.c.RayCollision {
        const collision = self orelse return .{
            .hit = false,
            .distance = undefined,
            .point = undefined,
            .normal = undefined,
        };
        return .{
            .hit = true,
            .distance = collision.distance,
            .point = collision.point.to_c_struct(),
            .normal = collision.normal.to_c_struct(),
        };
    }
};
