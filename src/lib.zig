const std = @import("std");

pub const BoundingBox = c.BoundingBox;
pub const Camera2D = c.Camera2D;
pub const Camera3D = @import("Camera3D.zig");
pub const Color = @import("Color.zig");
pub const Ray = @import("Ray.zig");
pub const Rectangle = c.Rectangle;
pub const RenderTexture = @import("RenderTexture.zig");
pub const Texture = @import("Texture.zig");
pub const Vector2 = @import("Vector2.zig");
pub const Vector3 = @import("Vector3.zig");
pub const c = @import("c.zig");
pub const collision = @import("collision.zig");
pub const draw = @import("draw.zig");
pub const input = @import("input.zig");
pub const matrix = @import("matrix.zig");
pub const window = @import("window.zig");

/// Set target FPS (maximum)
pub fn setTargetFps(fps: i32) void {
    c.SetTargetFPS(fps);
}

/// Get time in seconds for last frame drawn (delta time)
pub fn getFrameTime() f32 {
    return c.GetFrameTime();
}

/// Disables cursor (lock cursor)
pub fn disableCursor() void {
    c.DisableCursor();
}

/// Enables cursor (unlock cursor)
pub fn enableCursor() void {
    c.EnableCursor();
}

/// Check if cursor is not visible
pub fn isCursorHidden() bool {
    return c.IsCursorHidden();
}

/// Get current screen size
///
/// This function combines `GetScreenWidth` and `GetScreenHeight` from the c api
pub fn getScreenSize() Vector2 {
    return .{
        .x = @intToFloat(f32, c.GetScreenWidth()),
        .y = @intToFloat(f32, c.GetScreenHeight()),
    };
}

test "c" {
    std.testing.refAllDeclsRecursive(@This());
}
