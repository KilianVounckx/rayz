const lib = @import("lib.zig");
const Camera2D = lib.Camera2D;
const Camera3D = lib.Camera3D;
const Color = lib.Color;
const Vector2 = lib.Vector2;
const Vector3 = lib.Vector3;
const Font = lib.c.Font;
const Rectangle = lib.Rectangle;

/// Setup canvas (framebuffer) to start drawing
pub fn begin() void {
    lib.c.BeginDrawing();
}

/// End canvas drawing and swap buffers (double buffering)
pub fn end() void {
    lib.c.EndDrawing();
}

/// Set background color (framebuffer clear color)
pub fn clearBackground(color: Color) void {
    lib.c.ClearBackground(color.to_c_struct());
}

/// Begin 2D mode with custom camera (2D)
pub fn beginMode2D(camera: Camera2D) void {
    lib.c.BeginMode2D(camera);
}

/// Ends 2D mode with custom camera
pub fn endMode2D() void {
    lib.c.EndMode2D();
}

/// Begin 3D mode with custom camera (3D)
pub fn beginMode3D(camera: Camera3D) void {
    lib.c.BeginMode3D(camera.to_c_struct());
}
/// Ends 3D mode and returns to default 2D orthographic mode
pub fn endMode3D() void {
    lib.c.EndMode3D();
}

/// Configuration for `text`
pub const DrawTextConfig = struct {
    /// Position to draw to
    position: Vector2,
    /// Font
    font: ?Font = null,
    /// Font size
    font_size: f32,
    /// Text color
    color: Color,
    /// Spacing between letters
    spacing: ?f32 = null,
    /// Rotation point
    rotation_origin: Vector2 = .{},
    /// Rotation angle
    rotation_angle: f32 = 0,
};

/// Draw text
///
/// This combines `DrawText`, `DrawTextEx`, and `DrawTextPro` from the c api
pub fn text(msg: [:0]const u8, config: DrawTextConfig) void {
    const spacing = if (config.spacing) |spacing|
        spacing
    else blk: {
        const default_font_size = 10;
        break :blk config.font_size / default_font_size;
    };
    const font = if (config.font) |font|
        font
    else
        lib.c.GetFontDefault();

    lib.c.DrawTextPro(
        font,
        msg,
        config.position.to_c_struct(),
        config.rotation_origin.to_c_struct(),
        config.rotation_angle,
        config.font_size,
        spacing,
        config.color.to_c_struct(),
    );
}

/// Configuration for `circle`
pub const DrawCircleConfig = struct {
    /// If this value is true, the circle is colored, otherwise, only the border
    fill: bool = true,
};

/// Draw circle
///
/// This function combines `DrawCircle`, `DrawCircleV`, and `DrawCircleLines` from the c api
pub fn circle(center: Vector2, radius: f32, color: Color, config: DrawCircleConfig) void {
    if (config.fill) {
        lib.c.DrawCircleV(center.to_c_struct(), radius, color.to_c_struct());
    } else {
        lib.c.DrawCircleLines(
            @floatToInt(i32, center.to_c_struct().x),
            @floatToInt(i32, center.to_c_struct().y),
            radius,
            color.to_c_struct(),
        );
    }
}

/// Configuration for `rectangle`
pub const DrawRectangleConfig = struct {
    /// If this value is true, the rectangle is colored, otherwise, only the border
    fill: bool = true,
    /// The border thickness, ignored if `fill` is true
    thickness: f32 = 1,
    /// The roundness of the corners (corner radius in pixels)
    roundness: f32 = 0,
    /// The number of segments for the round corners, higher is smoother line
    segments: i32 = 1,
};

/// Draw rectangle
///
/// This function combines `DrawRectangle`, `DrawRectangleV`, `DrawRectangleRec`,
/// `DrawRectangleRounded`, `DrawRectangleLines`, `DrawRectangleLinesEx`, and
/// `DrawRectangleRoundedLines` from the c api
pub fn rectangle(rect: Rectangle, color: Color, config: DrawRectangleConfig) void {
    if (config.fill) {
        if (config.roundness == 0) {
            lib.c.DrawRectangleRec(rect, color.to_c_struct());
        } else {
            lib.c.DrawRectangleRounded(rect, config.roundness, config.segments, color.to_c_struct());
        }
    } else {
        if (config.roundness == 0) {
            lib.c.DrawRectangleLinesEx(rect, config.thickness, color.to_c_struct());
        } else {
            lib.c.DrawRectangleRoundedLines(rect, config.roundness, config.segments, config.thickness, color.to_c_struct());
        }
    }
}

/// Configuration for `line`
pub const DrawLineConfig = struct {
    /// Line thinckess in pixels
    thickness: f32 = 1,
};

/// Draw line
///
/// This function combines `DrawLine`, `DrawLineV`, and `DrawLineEx` from the c api
pub fn line(start: Vector2, _end: Vector2, color: Color, config: DrawLineConfig) void {
    if (config.thickness == 1) {
        lib.c.DrawLineV(start.to_c_struct(), _end.to_c_struct(), color.to_c_struct());
    } else {
        lib.c.DrawLineEx(start.to_c_struct(), _end.to_c_struct(), config.thickness, color.to_c_struct());
    }
}

/// Draw grid
///
/// Wrapper around `DrawGrid` from the c api
pub fn grid(slices: i32, spacing: f32) void {
    lib.c.DrawGrid(slices, spacing);
}

/// Draw fps
///
/// Wrapper around `DrawFPS` from the c api
pub fn fps(position: Vector2) void {
    lib.c.DrawFPS(@floatToInt(i32, position.x), @floatToInt(i32, position.y));
}

/// Configuration for `cube`
pub const DrawCubeConfig = struct {
    /// If this value is true, the cube is full, otherwise, only the wires are shown
    fill: bool = true,
};

/// Draw Cube
///
/// This function combines `DrawCube`, `DrawCubeV`, `DrawCubeWires`, and `DrawCubeWiresV` from
/// the c api
pub fn cube(position: Vector3, size: Vector3, color: Color, config: DrawCubeConfig) void {
    if (config.fill) {
        lib.c.DrawCubeV(position.to_c_struct(), size.to_c_struct(), color.to_c_struct());
    } else {
        lib.c.DrawCubeWiresV(position.to_c_struct(), size.to_c_struct(), color.to_c_struct());
    }
}
