const lib = @import("lib.zig");

const Self = @This();

/// OpenGL texture id
id: u32,
/// Texture base width
width: u16,
/// Texture base height
height: u16,
/// Mipmap levels, 1 by default
mipmaps: u16,
/// Data format (PixelFormat type)
format: PixelFormat,

/// Convert a c api Texture to a zig Color
pub fn fromCStruct(c_struct: lib.c.Texture) Self {
    return .{
        .id = c_struct.id,
        .width = @intCast(u16, c_struct.width),
        .height = @intCast(u16, c_struct.height),
        .mipmaps = @intCast(u16, c_struct.mipmaps),
        .format = @intToEnum(PixelFormat, c_struct.format),
    };
}

/// Convert a zig Texture to a c api Color
pub fn toCStruct(self: Self) lib.c.Texture {
    return .{
        .id = self.id,
        .width = self.width,
        .height = self.height,
        .mipmaps = self.mipmaps,
        .format = @enumToInt(self.format),
    };
}

/// Set texture scaling filter mode
///
/// Wrapper around `SetTextureFilter` from the c api
pub fn setFilter(self: Self, filter: Filter) void {
    lib.c.SetTextureFilter(self.toCStruct(), @enumToInt(filter));
}

// Pixel formats
// Note: Support depends on OpenGL version and platform
const PixelFormat = enum(u16) {
    /// 8 bit per pixel (no alpha)
    uncompressed_grayscale = 1,
    /// 8*2 bpp (2 channels)
    uncompressed_gray_alpha,
    /// 16 bpp
    uncompressed_r5g6b5,
    /// 24 bpp
    uncompressed_r8g8b8,
    /// 16 bpp (1 bit alpha)
    uncompressed_r5g5b5a1,
    /// 16 bpp (4 bit alpha)
    uncompressed_r4g4b4a4,
    /// 32 bpp
    uncompressed_r8g8b8a8,
    /// 32 bpp (1 channel - float)
    uncompressed_r32,
    /// 32*3 bpp (3 channels - float)
    uncompressed_r32g32b32,
    /// 32*4 bpp (4 channels - float)
    uncompressed_r32g32b32a32,
    /// 4 bpp (no alpha)
    compressed_dxt1_rgb,
    /// 4 bpp (1 bit alpha)
    compressed_dxt1_rgba,
    /// 8 bpp
    compressed_dxt3_rgba,
    /// 8 bpp
    compressed_dxt5_rgba,
    /// 4 bpp
    compressed_etc1_rgb,
    /// 4 bpp
    compressed_etc2_rgb,
    /// 8 bpp
    compressed_etc2_eac_rgba,
    /// 4 bpp
    compressed_pvrt_rgb,
    /// 4 bpp
    compressed_pvrt_rgba,
    /// 8 bpp
    compressed_astc_4X4_rgba,
    /// 2 bpp
    compressed_astc_8X8_rgba,
};

/// Texture parameters: filter mode
/// Note 1: Filtering considers mipmaps if available in the texture
/// Note 2: Filter is accordingly set for minification and magnification
const Filter = enum(u16) {
    /// No filter, just pixel approximation
    point = 0,
    /// Linear filtering
    bilinear,
    /// Trilinear filtering (linear with mipmaps)
    trilinear,
    /// Anisotropic filtering 4x
    anisotropic_4x,
    /// Anisotropic filtering 8x
    anisotropic_8x,
    /// Anisotropic filtering 16x
    anisotropic_16x,
};
