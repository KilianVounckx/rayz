const lib = @import("../../lib.zig");
const structs = lib.c.raylib.structs;
const Color = structs.Color;
const Font = structs.Font;
const GlyphInfo = structs.GlyphInfo;
const Image = structs.Image;
const Rectangle = structs.Rectangle;
const Vector2 = structs.Vector2;

// Font loading/unloading functions
/// Get the default Font
pub extern fn GetFontDefault() Font;
/// Load font from file into GPU memory (VRAM)
pub extern fn LoadFont(fileName: [*c]const u8) Font;
/// Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
pub extern fn LoadFontEx(fileName: [*c]const u8, fontSize: c_int, fontChars: [*c]c_int, glyphCount: c_int) Font;
/// Load font from Image (XNA style)
pub extern fn LoadFontFromImage(image: Image, key: Color, firstChar: c_int) Font;
/// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub extern fn LoadFontFromMemory(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int, fontSize: c_int, fontChars: [*c]c_int, glyphCount: c_int) Font;
/// Check if a font is ready
pub extern fn IsFontReady(font: Font) bool;
/// Load font data for further use
pub extern fn LoadFontData(fileData: [*c]const u8, dataSize: c_int, fontSize: c_int, fontChars: [*c]c_int, glyphCount: c_int, type: c_int) [*c]GlyphInfo;
/// Generate image font atlas using chars info
pub extern fn GenImageFontAtlas(chars: [*c]const GlyphInfo, recs: [*c][*c]Rectangle, glyphCount: c_int, fontSize: c_int, padding: c_int, packMethod: c_int) Image;
/// Unload font chars info data (RAM)
pub extern fn UnloadFontData(chars: [*c]GlyphInfo, glyphCount: c_int) void;
/// Unload font from GPU memory (VRAM)
pub extern fn UnloadFont(font: Font) void;
/// Export font as code file, returns true on success
pub extern fn ExportFontAsCode(font: Font, fileName: [*c]const u8) bool;

// Text drawing functions
/// Draw current FPS
pub extern fn DrawFPS(posX: c_int, posY: c_int) void;
/// Draw text (using default font)
pub extern fn DrawText(text: [*c]const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void;
/// Draw text using font and additional parameters
pub extern fn DrawTextEx(font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;
/// Draw text using Font and pro parameters (rotation)
pub extern fn DrawTextPro(font: Font, text: [*c]const u8, position: Vector2, origin: Vector2, rotation: f32, fontSize: f32, spacing: f32, tint: Color) void;
/// Draw one character (codepoint)
pub extern fn DrawTextCodepoint(font: Font, codepoint: c_int, position: Vector2, fontSize: f32, tint: Color) void;
/// Draw multiple character (codepoint)
pub extern fn DrawTextCodepoints(font: Font, codepoints: [*c]const c_int, count: c_int, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void;

// Text font info functions
/// Measure string width for default font
pub extern fn MeasureText(text: [*c]const u8, fontSize: c_int) c_int;
/// Measure string size for Font
pub extern fn MeasureTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32) Vector2;
/// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub extern fn GetGlyphIndex(font: Font, codepoint: c_int) c_int;
/// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub extern fn GetGlyphInfo(font: Font, codepoint: c_int) GlyphInfo;
/// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
pub extern fn GetGlyphAtlasRec(font: Font, codepoint: c_int) Rectangle;

// Text codepoints management functions (unicode characters)
/// Load UTF-8 text encoded from codepoints array
pub extern fn LoadUTF8(codepoints: [*c]const c_int, length: c_int) [*c]u8;
/// Unload UTF-8 text encoded from codepoints array
pub extern fn UnloadUTF8(text: [*c]const u8) void;
/// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub extern fn LoadCodepoints(text: [*c]const u8, count: [*c]c_int) [*c]c_int;
/// Unload codepoints data from memory
pub extern fn UnloadCodepoints(codepoints: [*c]c_int) void;
/// Get total number of codepoints in a UTF-8 encoded string
pub extern fn GetCodepointCount(text: [*c]const u8) c_int;
/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern fn GetCodepoint(text: [*c]const u8, codepointSize: [*c]c_int) c_int;
/// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern fn GetCodepointNext(text: [*c]const u8, codepointSize: [*c]c_int) c_int;
/// Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern fn GetCodepointPrevious(text: [*c]const u8, codepointSize: [*c]c_int) c_int;
/// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
pub extern fn CodepointToUTF8(codepoint: c_int, utf8Size: [*c]c_int) [*c]const u8;

// Text strings management functions (no UTF-8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
/// Copy one string to another, returns bytes copied
pub extern fn TextCopy(dst: [*c]u8, src: [*c]const u8) c_int;
/// Check if two text string are equal
pub extern fn TextIsEqual(text1: [*c]const u8, text2: [*c]const u8) bool;
/// Get text length, checks for '\0' ending
pub extern fn TextLength(text: [*c]const u8) c_uint;
/// Text formatting with variables (sprintf() style)
pub extern fn TextFormat(text: [*c]const u8, ...) [*c]const u8;
/// Get a piece of a text string
pub extern fn TextSubtext(text: [*c]const u8, position: c_int, length: c_int) [*c]const u8;
/// Replace text string (WARNING: memory must be freed!)
pub extern fn TextReplace(text: [*c]u8, replace: [*c]const u8, by: [*c]const u8) [*c]u8;
/// Insert text in a position (WARNING: memory must be freed!)
pub extern fn TextInsert(text: [*c]const u8, insert: [*c]const u8, position: c_int) [*c]u8;
/// Join text strings with delimiter
pub extern fn TextJoin(textList: [*c]const [*c]u8, count: c_int, delimiter: [*c]const u8) [*c]const u8;
/// Split text into multiple strings
pub extern fn TextSplit(text: [*c]const u8, delimiter: u8, count: [*c]c_int) [*c]const [*c]u8;
/// Append text at specific position and move cursor!
pub extern fn TextAppend(text: [*c]u8, append: [*c]const u8, position: [*c]c_int) void;
/// Find first text occurrence within a string
pub extern fn TextFindIndex(text: [*c]const u8, find: [*c]const u8) c_int;
/// Get upper case version of provided string
pub extern fn TextToUpper(text: [*c]const u8) [*c]const u8;
/// Get lower case version of provided string
pub extern fn TextToLower(text: [*c]const u8) [*c]const u8;
/// Get Pascal case notation version of provided string
pub extern fn TextToPascal(text: [*c]const u8) [*c]const u8;
/// Get integer value from text (negative values not supported)
pub extern fn TextToInteger(text: [*c]const u8) c_int;
