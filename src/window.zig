const std = @import("std");

const lib = @import("lib.zig");

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

/// Initialize window and OpenGL context
pub fn init(width: u16, height: u16, title: [:0]const u8, flags: ConfigFlags) void {
    lib.c.SetConfigFlags(@bitCast(u32, flags));
    lib.c.InitWindow(width, height, title);
}

/// Close window and unload OpenGL context
pub fn close() void {
    lib.c.CloseWindow();
}

/// Check if KEY_ESCAPE pressed or Close icon pressed
pub fn shouldClose() bool {
    return lib.c.WindowShouldClose();
}

/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
///
/// Wrapper around `ToggleFullscreen` from the c api
pub fn toggleFullscreen() void {
    lib.c.ToggleFullscreen();
}

/// Check if one specific window flag is enabled
///
/// Wrapper around `IsWindowState` from the c api
pub fn isState(flag: std.meta.FieldEnum(ConfigFlags)) bool {
    var flags = ConfigFlags{};
    inline for (comptime std.meta.fields(ConfigFlags)) |field| {
        if (field.type == bool and std.mem.eql(u8, field.name, @tagName(flag))) {
            @field(flags, field.name) = true;
        }
    }
    return lib.c.IsWindowState(@bitCast(u32, flags));
}

/// Clear window configuration state flags
///
/// Wrapper around `ClearWindowState` from the c api
pub fn clearState(flags: ConfigFlags) void {
    lib.c.ClearWindowState(@bitCast(u32, flags));
}

/// Set window configuration state using flags (only PLATFORM_DESKTOP)
///
/// Wrapper around `SetWindowState` from the c api
pub fn setState(flags: ConfigFlags) void {
    lib.c.SetWindowState(@bitCast(u32, flags));
}

/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
///
/// Wrapper around `MinimizeWindow` from the c api
pub fn minimize() void {
    lib.c.MinimizeWindow();
}

/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
///
/// Wrapper around `MaximizeWindow` from the c api
pub fn maximize() void {
    lib.c.MaximizeWindow();
}

/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
///
/// Wrapper around `RestoreWindow` from the c api
pub fn restore() void {
    lib.c.RestoreWindow();
}
