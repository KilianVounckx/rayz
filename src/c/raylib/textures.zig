const lib = @import("../../lib.zig");
const structs = lib.c.raylib.structs;
const Color = structs.Color;
const Font = structs.Font;
const Image = structs.Image;
const NPatchInfo = structs.NPatchInfo;
const Rectangle = structs.Rectangle;
const RenderTexture2D = structs.RenderTexture2D;
const Texture = structs.Texture;
const Texture2D = structs.Texture2D;
const TextureCubeMap = structs.TextureCubeMap;
const Vector2 = structs.Vector2;
const Vector3 = structs.Vector3;
const Vector4 = structs.Vector4;

// Image loading functions
// NOTE: These functions do not require GPU access
/// Load image from file into CPU memory (RAM)
pub extern fn LoadImage(fileName: [*c]const u8) Image;
/// Load image from RAW file data
pub extern fn LoadImageRaw(fileName: [*c]const u8, width: c_int, height: c_int, format: c_int, headerSize: c_int) Image;
/// Load image sequence from file (frames appended to image.data)
pub extern fn LoadImageAnim(fileName: [*c]const u8, frames: [*c]c_int) Image;
/// Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub extern fn LoadImageFromMemory(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int) Image;
/// Load image from GPU texture data
pub extern fn LoadImageFromTexture(texture: Texture2D) Image;
/// Load image from screen buffer and (screenshot)
pub extern fn LoadImageFromScreen() Image;
/// Check if an image is ready
pub extern fn IsImageReady(image: Image) bool;
/// Unload image from CPU memory (RAM)
pub extern fn UnloadImage(image: Image) void;
/// Export image data to file, returns true on success
pub extern fn ExportImage(image: Image, fileName: [*c]const u8) bool;
/// Export image as code file defining an array of bytes, returns true on success
pub extern fn ExportImageAsCode(imag: Image, fileName: [*c]const u8) bool;

// Image generation functions
/// Generate image: plain color
pub extern fn GenImageColor(width: c_int, height: c_int, color: Color) Image;
/// Generate image: vertical gradient
pub extern fn GenImageGradientV(width: c_int, height: c_int, top: Color, bottom: Color) Image;
/// Generate image: horizontal gradient
pub extern fn GenImageGradientH(width: c_int, height: c_int, left: Color, right: Color) Image;
/// Generate image: radial gradient
pub extern fn GenImageGradientRadial(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image;
/// Generate image: checked
pub extern fn GenImageChecked(width: c_int, height: c_int, checksX: c_int, checksY: c_int, col1: Color, col2: Color) Image;
/// Generate image: white noise
pub extern fn GenImageWhiteNoise(width: c_int, height: c_int, factor: f32) Image;
/// Generate image: perlin noise
pub extern fn GenImagePerlinNoise(width: c_int, height: c_int, offsetX: c_int, offsetY: c_int, scale: f32) Image;
/// Generate image: cellular algorithm, bigger tileSize means bigger cells
pub extern fn GenImageCellular(width: c_int, height: c_int, tileSize: c_int) Image;
/// Generate image: grayscale image from text data
pub extern fn GenImageText(width: c_int, height: c_int, text: [*c]const u8) Image;

// Image manipulation functions
/// Create an image duplicate (useful for transformations)
pub extern fn ImageCopy(image: Image) Image;
/// Create an image from another image piece
pub extern fn ImageFromImage(image: Image, rec: Rectangle) Image;
/// Create an image from text (default font)
pub extern fn ImageText(text: [*c]const u8, fontSize: c_int, color: Color) Image;
/// Create an image from text (custom sprite font)
pub extern fn ImageTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, tint: Color) Image;
/// Convert image data to desired format
pub extern fn ImageFormat(image: [*c]Image, newFormat: c_uint) void;
/// Convert image to POT (power-of-two)
pub extern fn ImageToPOT(image: [*c]Image, fill: Color) void;
/// Crop an image to a defined rectangle
pub extern fn ImageCrop(image: [*c]Image, crop: Rectangle) void;
/// Crop image depending on alpha value
pub extern fn ImageAlphaCrop(image: [*c]Image, threshold: f32) void;
/// Clear alpha channel to desired color
pub extern fn ImageAlphaClear(image: [*c]Image, color: Color, threshold: f32) void;
/// Apply alpha mask to image
pub extern fn ImageAlphaMask(image: [*c]Image, alphaMask: Image) void;
/// Premultiply alpha channel
pub extern fn ImageAlphaPremultiply(image: [*c]Image) void;
/// Apply Gaussian blur using a box blur approximation
pub extern fn ImageBlurGaussian(image: [*c]Image, blurSize: c_int) void;
/// Resize image (Bicubic scaling algorithm)
pub extern fn ImageResize(image: [*c]Image, newWidth: c_int, newHeight: c_int) void;
/// Resize image (Nearest-Neighbor scaling algorithm)
pub extern fn ImageResizeNN(image: [*c]Image, newWidth: c_int, newHeight: c_int) void;
/// Resize canvas and fill with color
pub extern fn ImageResizeCanvas(image: [*c]Image, newWidth: c_int, newHeight: c_int, offsetX: c_int, offsetY: c_int, fill: Color) void;
/// Compute all mipmap levels for a provided image
pub extern fn ImageMipmaps(image: [*c]Image) void;
/// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub extern fn ImageDither(image: [*c]Image, rBpp: c_int, gBpp: c_int, bBpp: c_int, aBpp: c_int) void;
/// Flip image vertically
pub extern fn ImageFlipVertical(image: [*c]Image) void;
/// Flip image horizontally
pub extern fn ImageFlipHorizontal(image: [*c]Image) void;
/// Rotate image clockwise 90deg
pub extern fn ImageRotateCW(image: [*c]Image) void;
/// Rotate image counter-clockwise 90deg
pub extern fn ImageRotateCCW(image: [*c]Image) void;
/// Modify image color: tint
pub extern fn ImageColorTint(image: [*c]Image, color: Color) void;
/// Modify image color: invert
pub extern fn ImageColorInvert(image: [*c]Image) void;
/// Modify image color: grayscale
pub extern fn ImageColorGrayscale(image: [*c]Image) void;
/// Modify image color: contrast (-100 to 100)
pub extern fn ImageColorContrast(image: [*c]Image, contrast: f32) void;
/// Modify image color: brightness (-255 to 255)
pub extern fn ImageColorBrightness(image: [*c]Image, brightness: c_int) void;
/// Modify image color: replace color
pub extern fn ImageColorReplace(image: [*c]Image, color: Color, replace: Color) void;
/// Load color data from image as a Color array (RGBA - 32bit)
pub extern fn LoadImageColors(image: Image) [*c]Color;
/// Load colors palette from image as a Color array (RGBA - 32bit)
pub extern fn LoadImagePalette(image: Image, maxPaletteSize: c_int, colorCount: [*c]c_int) [*c]Color;
/// Unload color data loaded with LoadImageColors()
pub extern fn UnloadImageColors(colors: [*c]Color) void;
/// Unload colors palette loaded with LoadImagePalette()
pub extern fn UnloadImagePalette(colors: [*c]Color) void;
/// Get image alpha border rectangle
pub extern fn GetImageAlphaBorder(image: Image, threshold: f32) Rectangle;
/// Get image pixel color at (x, y) position
pub extern fn GetImageColor(image: Image, x: c_int, y: c_int) Color;

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
/// Clear image background with given color
pub extern fn ImageClearBackground(dst: [*c]Image, color: Color) void;
/// Draw pixel within an image
pub extern fn ImageDrawPixel(dst: [*c]Image, posX: c_int, posY: c_int, color: Color) void;
/// Draw pixel within an image (Vector version)
pub extern fn ImageDrawPixelV(dst: [*c]Image, position: Vector2, color: Color) void;
/// Draw line within an image
pub extern fn ImageDrawLine(dst: [*c]Image, startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void;
/// Draw line within an image (Vector version)
pub extern fn ImageDrawLineV(dst: [*c]Image, start: Vector2, end: Vector2, color: Color) void;
/// Draw a filled circle within an image
pub extern fn ImageDrawCircle(dst: [*c]Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void;
/// Draw a filled circle within an image (Vector version)
pub extern fn ImageDrawCircleV(dst: [*c]Image, center: Vector2, radius: c_int, color: Color) void;
/// Draw circle outline within an image
pub extern fn ImageDrawCircleLines(dst: [*c]Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void;
/// Draw circle outline within an image (Vector version)
pub extern fn ImageDrawCircleLinesV(dst: [*c]Image, center: Vector2, radius: c_int, color: Color) void;
/// Draw rectangle within an image
pub extern fn ImageDrawRectangle(dst: [*c]Image, posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
/// Draw rectangle within an image (Vector version)
pub extern fn ImageDrawRectangleV(dst: [*c]Image, position: Vector2, size: Vector2, color: Color) void;
/// Draw rectangle within an image
pub extern fn ImageDrawRectangleRec(dst: [*c]Image, rec: Rectangle, color: Color) void;
/// Draw rectangle lines within an image
pub extern fn ImageDrawRectangleLines(dst: [*c]Image, rec: Rectangle, thick: c_int, color: Color) void;
/// Draw a source image within a destination image (tint applied to source)
pub extern fn ImageDraw(dst: [*c]Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) void;
/// Draw text (using default font) within an image (destination)
pub extern fn ImageDrawText(dst: [*c]Image, text: [*c]const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void;
/// Draw text (custom sprite font) within an image (destination)
pub extern fn ImageDrawTextEx(dst: [*c]Image, font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;

// Texture loading functions
// NOTE: These functions require GPU access
/// Load texture from file into GPU memory (VRAM)
pub extern fn LoadTexture(fileName: [*c]const u8) Texture2D;
/// Load texture from image data
pub extern fn LoadTextureFromImage(image: Image) Texture2D;
/// Load cubemap from image, multiple image cubemap layouts supported
pub extern fn LoadTextureCubemap(image: Image, layout: c_int) TextureCubeMap;
/// Load texture for rendering (framebuffer)
pub extern fn LoadRenderTexture(width: c_int, height: c_int) RenderTexture2D;
/// Check if a texture is ready
pub extern fn IsTextureReady(texture: Texture2D) bool;
/// Unload texture from GPU memory (VRAM)
pub extern fn UnloadTexture(texture: Texture2D) void;
/// Check if a render texture is ready
pub extern fn IsRenderTextureReady(target: RenderTexture2D) void;
/// Unload render texture from GPU memory (VRAM)
pub extern fn UnloadRenderTexture(target: RenderTexture2D) void;
/// Update GPU texture with new data
pub extern fn UpdateTexture(texture: RenderTexture2D, pixels: [*c]const anyopaque) void;
/// Update GPU texture rectangle with new data
pub extern fn UpdateTextureRec(texture: Texture, rec: Rectangle, pixels: [*c]const anyopaque) void;

// Texture configuration functions
/// Generate GPU mipmaps for a texture
pub extern fn GenTextureMipmaps(texture: [*c]Texture2D) void;
/// Set texture scaling filter mode
pub extern fn SetTextureFilter(texture: Texture2D, filter: c_int) void;
/// Set texture wrapping mode
pub extern fn SetTextureWrap(texture: Texture2D, wrap: c_int) void;

// Texture drawing functions
/// Draw a Texture2D
pub extern fn DrawTexture(texture: Texture2D, posX: c_int, posY: c_int, tint: Color) void;
/// Draw a Texture2D with position defined as Vector2
pub extern fn DrawTextureV(texture: Texture2D, position: Vector2, tint: Color) void;
/// Draw a Texture2D with extended parameters
pub extern fn DrawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void;
/// Draw a part of a texture defined by a rectangle
pub extern fn DrawTextureRec(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) void;
/// Draw a part of a texture defined by a rectangle with 'pro' parameters
pub extern fn DrawTexturePro(texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
/// Draws a texture (or part of it) that stretches or shrinks nicely
pub extern fn DrawTextureNPatch(texture: Texture, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;

// Color/pixel related functions
/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub extern fn Fade(color: Color, alpha: f32) Color;
/// Get hexadecimal value for a Color
pub extern fn ColorToInt(color: Color) c_int;
/// Get Color normalized as float [0..1]
pub extern fn ColorNormalize(color: Color) Vector4;
/// Get Color from normalized values [0..1]
pub extern fn ColorFromNormalized(normalized: Vector4) Color;
/// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub extern fn ColorToHSV(color: Color) Vector3;
/// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub extern fn ColorFromHSV(hue: f32, saturation: f32, value: f32) Color;
/// Get color multiplied with another color
pub extern fn ColorTint(color: Color, tint: Color) Color;
/// Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
pub extern fn ColorBrightness(color: Color, factor: f32) Color;
/// Get color with contrast correction, contrast values between -1.0f and 1.0f
pub extern fn ColorContrast(color: Color, contrast: f32) Color;
/// Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub extern fn ColorAlpha(color: Color, alpha: f32) Color;
/// Get src alpha-blended into dst color with tint
pub extern fn ColorAlphaBlend(dst: Color, src: Color, tint: Color) Color;
/// Get Color structure from hexadecimal value
pub extern fn GetColor(hexValue: c_uint) Color;
/// Get Color from a source pixel pointer of certain format
pub extern fn GetPixelColor(srcPtr: [*c]anyopaque, format: c_int) Color;
/// Set color formatted into destination pixel pointer
pub extern fn SetPixelColor(dstPtr: [*c]anyopaque, color: Color, format: c_int) void;
/// Get pixel data size in bytes for certain format
pub extern fn GetPixelDataSize(width: c_int, height: c_int, format: c_int) c_int;
