const std = @import("std");

pub const Camera2D = c.raylib.structs.Camera2D;
pub const Color = @import("Color.zig");
pub const Rectangle = c.raylib.structs.Rectangle;
pub const Vector2 = c.raylib.structs.Vector2;
pub const c = @import("c.zig");
pub const collision = @import("collision.zig");
pub const draw = @import("draw.zig");
pub const input = @import("input.zig");

/// System/Window config flags
/// By default all flags are set to false
pub const ConfigFlags = packed struct(u32) {
    _pad1: u1 = 0,
    /// Set to run program in fullscreen
    fullscreen_mode: bool = false,
    /// Set to allow resizable window
    window_resizable: bool = false,
    /// Set to disable window decoration (frame and buttons)
    window_undecorated: bool = false,
    /// Set to allow transparent framebuffer
    window_transparent: bool = false,
    /// Set to try enabling MSAA 4X
    msaa_4x_hint: bool = false,
    /// Set to try enabling V-Sync on GPU
    vsync_hint: bool = false,
    /// Set to hide window
    window_hidden: bool = false,
    /// Set to allow windows running while minimized
    window_always_run: bool = false,
    /// Set to minimize window (iconify)
    window_minimized: bool = false,
    /// Set to maximize window (expanded to monitor)
    window_maximized: bool = false,
    /// Set to window non focused
    window_unfocused: bool = false,
    /// Set to window always on top
    window_topmost: bool = false,
    /// Set to support HighDPI
    window_highdpi: bool = false,
    /// Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    window_mouse_passthrough: bool = false,
    /// Set to try enabling interlaced video format (for V3D)
    interlaced_hint: bool = false,
    _pad2: u16 = 0,
};

pub fn initWindow(width: i32, height: i32, title: [:0]const u8, flags: ConfigFlags) void {
    c.raylib.core.SetConfigFlags(@bitCast(u32, flags));
    c.raylib.core.InitWindow(width, height, title);
}

pub fn closeWindow() void {
    c.raylib.core.CloseWindow();
}

pub fn setTargetFps(fps: i32) void {
    c.raylib.core.SetTargetFPS(fps);
}

pub fn windowShouldClose() bool {
    return c.raylib.core.WindowShouldClose();
}

pub fn beginDrawing() void {
    c.raylib.core.BeginDrawing();
}

pub fn endDrawing() void {
    c.raylib.core.EndDrawing();
}

pub fn clearBackground(color: Color) void {
    c.raylib.core.ClearBackground(color.c_struct);
}

pub fn beginMode2D(camera: Camera2D) void {
    c.raylib.core.BeginMode2D(camera);
}

pub fn endMode2D() void {
    c.raylib.core.EndMode2D();
}

test "c" {
    std.testing.refAllDeclsRecursive(@This());
}
