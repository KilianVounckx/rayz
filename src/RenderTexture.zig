//! RenderTexture, fbo for texture rendering

const lib = @import("lib.zig");
const Texture = lib.Texture;

const Self = @This();

/// OpenGL framebuffer object id
id: u32,
/// Color buffer attachment texture
texture: Texture,
/// Depth buffer attachment texture
depth: Texture,

/// Load texture for rendering (framebuffer)
///
/// Wrapper around `LoadRenderTexture` from the c api
pub fn load(width: u16, height: u16) Self {
    var c_struct = lib.c.LoadRenderTexture(width, height);
    return fromCStruct(c_struct);
}

/// Unload render texture from GPU memory (VRAM)
///
/// Wrapper around `UnloadRenderTexture` from the c api
pub fn unload(self: Self) void {
    lib.c.UnloadRenderTexture(self.toCStruct());
}

/// Convert a c api RenderTexture to a zig Color
pub fn fromCStruct(c_struct: lib.c.RenderTexture) Self {
    return .{
        .id = c_struct.id,
        .texture = Texture.fromCStruct(c_struct.texture),
        .depth = Texture.fromCStruct(c_struct.depth),
    };
}

/// Convert a zig RenderTexture to a c api Color
pub fn toCStruct(self: Self) lib.c.RenderTexture {
    return .{
        .id = self.id,
        .texture = self.texture.toCStruct(),
        .depth = self.depth.toCStruct(),
    };
}

/// Check if a render texture is ready
///
/// Wrapper around `IsRenderTextureReady` from the c api
pub fn isReady(self: Self) bool {
    return lib.c.IsRenderTextureReady(self.toCStruct());
}
