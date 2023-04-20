const lib = @import("../../lib.zig");
const structs = lib.c.raylib.structs;
const Camera = structs.Camera;
const Camera2D = structs.Camera2D;
const Camera3D = structs.Camera3D;
const Color = structs.Color;
const FilePathList = structs.FilePathList;
const Image = structs.Image;
const Matrix = structs.Matrix;
const Ray = structs.Ray;
const RenderTexture2D = structs.RenderTexture2D;
const Shader = structs.Shader;
const Texture = structs.Texture;
const Vector2 = structs.Vector2;
const Vector3 = structs.Vector3;
const VrDeviceInfo = structs.VrDeviceInfo;
const VrStereoConfig = structs.VrStereoConfig;

// ============== callbacks =================

// Callbacks to hook some internal functions
// WARNING: These callbacks are intended for advance users
/// Logging: Redirect trace log messages
pub const TraceLogCallback = ?*const fn (logLevel: c_int, text: [*c]const u8, ...) callconv(.C) void;
/// FileIO: Load binary data
pub const LoadFileDataCallback = ?*const fn (filename: [*c]const u8, bytesRead: [*c]c_uint) callconv(.C) [*c]u8;
/// FileIO: Save binary data
pub const SaveFileDataCallback = ?*const fn (filename: [*c]const u8, bytesToWrite: c_uint) callconv(.C) bool;
/// FileIO: Load text data
pub const LoadFileTextCallback = ?*const fn (filename: [*c]const u8) callconv(.C) [*c]const u8;
/// FileIO: Save text data
pub const SaveFileTextCallback = ?*const fn (filename: [*c]const u8, text: [*c]u8) bool;

// Color red value

// ============== core =================

// Window-related functions
/// Initialize window and OpenGL context
pub extern fn InitWindow(width: c_int, height: c_int, title: [*c]const u8) void;
/// Check if KEY_ESCAPE pressed or Close icon pressed
pub extern fn WindowShouldClose() bool;
/// Close window and unload OpenGL context
pub extern fn CloseWindow() void;
/// Check if window has been initialized successfully
pub extern fn IsWindowReady() bool;
/// Check if window is currently fullscreen
pub extern fn IsWindowFullscreen() bool;
/// Check if window is currently hidden (only PLATFORM_DESKTOP)
pub extern fn IsWindowHidden() bool;
/// Check if window is currently minimized (only PLATFORM_DESKTOP)
pub extern fn IsWindowMinimized() bool;
/// Check if window is currently maximized (only PLATFORM_DESKTOP)
pub extern fn IsWindowMaximized() bool;
/// Check if window is currently focused (only PLATFORM_DESKTOP)
pub extern fn IsWindowFocused() bool;
/// Check if window has been resized last frame
pub extern fn IsWindowResized() bool;
/// Check if one specific window flag is enabled
pub extern fn IsWindowState(flag: c_uint) bool;
/// Set window configuration state using flags (only PLATFORM_DESKTOP)
pub extern fn SetWindowState(flags: c_uint) void;
/// Clear window configuration state flags
pub extern fn ClearWindowState(flags: c_uint) void;
/// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub extern fn ToggleFullscreen() void;
/// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub extern fn MaximizeWindow() void;
/// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub extern fn MinimizeWindow() void;
/// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub extern fn RestoreWindow() void;
/// Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern fn SetWindowIcon(image: Image) void;
/// Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern fn SetWindowIcons(images: [*c]Image, count: c_int) void;
/// Set title for window (only PLATFORM_DESKTOP)
pub extern fn SetWindowTitle(title: [*c]const u8) void;
/// Set window position on screen (only PLATFORM_DESKTOP)
pub extern fn SetWindowPosition(x: c_int, y: c_int) void;
/// Set monitor for the current window (fullscreen mode)
pub extern fn SetWindowMonitor(monitor: c_int) void;
/// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub extern fn SetWindowMinSize(width: c_int, height: c_int) void;
/// Set window dimensions
pub extern fn SetWindowSize(width: c_int, height: c_int) void;
/// Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub extern fn SetWindowOpacity(opacity: f32) void;
/// Get native window handle
pub extern fn GetWindowHandle() ?*anyopaque;
/// Get current screen width
pub extern fn GetScreenWidth() c_int;
/// Get current screen height
pub extern fn GetScreenHeight() c_int;
/// Get current render width (it considers HiDPI)
pub extern fn GetRenderWidth() c_int;
/// Get current render height (it considers HiDPI)
pub extern fn GetRenderHeight() c_int;
/// Get number of connected monitors
pub extern fn GetMonitorCount() c_int;
/// Get current connected monitor
pub extern fn GetCurrentMonitor() c_int;
/// Get specified monitor position
pub extern fn GetMonitorPosition(monitor: c_int) Vector2;
/// Get specified monitor width (current video mode used by monitor)
pub extern fn GetMonitorWidth(monitor: c_int) c_int;
/// Get specified monitor height (current video mode used by monitor)
pub extern fn GetMonitorHeight(monitor: c_int) c_int;
/// Get specified monitor physical width in millimetres
pub extern fn GetMonitorPhysicalWidth(monitor: c_int) c_int;
/// Get specified monitor physical height in millimetres
pub extern fn GetMonitorPhysicalHeight(monitor: c_int) c_int;
/// Get specified monitor refresh rate
pub extern fn GetMonitorRefreshRate(monitor: c_int) c_int;
/// Get window position XY on monitor
pub extern fn GetWindowPosition() Vector2;
/// Get window scale DPI factor
pub extern fn GetWindowScaleDPI() Vector2;
/// Get the human-readable, UTF-8 encoded name of the primary monitor
pub extern fn GetMonitorName(monitor: c_int) [*c]const u8;
/// Set clipboard text content
pub extern fn SetClipboardText(text: [*c]const u8) void;
/// Get clipboard text content
pub extern fn GetClipboardText() [*c]const u8;
/// Enable waiting for events on EndDrawing(), no automatic event polling
pub extern fn EnableEventWaiting() void;
/// Disable waiting for events on EndDrawing(), automatic events polling
pub extern fn DisableEventWaiting() void;

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
/// Swap back buffer with front buffer (screen drawing)
pub extern fn SwapScreenBuffer() void;
/// Register all input events
pub extern fn PollInputEvents() void;
/// Wait for some time (halt program execution)
pub extern fn WaitTime(seconds: f64) void;

// Cursor-related functions
/// Shows cursor
pub extern fn ShowCursor() void;
/// Hides cursor
pub extern fn HideCursor() void;
/// Check if cursor is not visible
pub extern fn IsCursorHidden() bool;
/// Enables cursor (unlock cursor)
pub extern fn EnableCursor() void;
/// Disables cursor (lock cursor)
pub extern fn DisableCursor() void;
/// Check if cursor is on the screen
pub extern fn IsCursorOnScreen() bool;

// Drawing-related functions
/// Set background color (framebuffer clear color)
pub extern fn ClearBackground(color: Color) void;
/// Setup canvas (framebuffer) to start drawing
pub extern fn BeginDrawing() void;
/// End canvas drawing and swap buffers (double buffering)
pub extern fn EndDrawing() void;
/// Begin 2D mode with custom camera (2D)
pub extern fn BeginMode2D(camera: Camera2D) void;
/// Ends 2D mode with custom camera
pub extern fn EndMode2D() void;
/// Begin 3D mode with custom camera (3D)
pub extern fn BeginMode3D(camera: Camera3D) void;
/// Ends 3D mode and returns to default 2D orthographic mode
pub extern fn EndMode3D() void;
/// Begin drawing to render texture
pub extern fn BeginTextureMode(target: RenderTexture2D) void;
/// Ends drawing to render texture
pub extern fn EndTextureMode() void;
/// Begin custom shader drawing
pub extern fn BeginShaderMode(shader: Shader) void;
/// End custom shader drawing (use default shader)
pub extern fn EndShaderMode() void;
/// Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub extern fn BeginBlendMode(mode: c_int) void;
/// End blending mode (reset to default: alpha blending)
pub extern fn EndBlendMode() void;
/// Begin scissor mode (define screen area for following drawing)
pub extern fn BeginScissorMode(x: c_int, y: c_int, width: c_int, height: c_int) void;
/// End scissor mode
pub extern fn EndScissorMode() void;
/// Begin stereo rendering (requires VR simulator)
pub extern fn BeginVrStereoMode(config: VrStereoConfig) void;
/// End stereo rendering (requires VR simulator)
pub extern fn EndVrStereoMode() void;

// VR stereo config functions for VR simulator
/// Load VR stereo config for VR simulator device parameters
pub extern fn LoadVrStereoConfig(device: VrDeviceInfo) VrStereoConfig;
/// Unload VR stereo config
pub extern fn UnloadVrStereoConfig(config: VrStereoConfig) void;

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
/// Load shader from files and bind default locations
pub extern fn LoadShader(vsFileName: [*c]const u8, fsFileName: [*c]const u8) Shader;
/// Load shader from code strings and bind default locations
pub extern fn LoadShaderFromMemory(vsCode: [*c]const u8, fsCode: [*c]const u8) Shader;
/// Check if a shader is ready
pub extern fn IsShaderReady(shader: Shader) bool;
/// Get shader uniform location
pub extern fn GetShaderLocation(shader: Shader, uniformName: [*c]const u8) c_int;
/// Get shader attribute location
pub extern fn GetShaderLocationAttrib(shader: Shader, attribName: [*c]const u8) c_int;
/// Set shader uniform value
pub extern fn SetShaderValue(shader: Shader, locIndex: c_int, value: ?*const anyopaque, uniformType: c_int) void;
/// Set shader uniform value vector
pub extern fn SetShaderValueV(shader: Shader, locIndex: c_int, value: ?*const anyopaque, uniformType: c_int, count: c_int) void;
/// Set shader uniform value (matrix 4x4)
pub extern fn SetShaderValueMatrix(shader: Shader, locIndex: c_int, mat: Matrix) void;
/// Set shader uniform value for texture (sampler2d)
pub extern fn SetShaderValueTexture(shader: Shader, locIndex: c_int, texture: Texture) void;
/// Unload shader from GPU memory (VRAM)
pub extern fn UnloadShader(shader: Shader) void;

// Screen-space-related functions
/// Get a ray trace from mouse position
pub extern fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray;
/// Get camera transform matrix (view matrix)
pub extern fn GetCameraMatrix(camera: Camera) Matrix;
/// Get camera 2d transform matrix
pub extern fn GetCameraMatrix2D(camera: Camera2D) Matrix;
/// Get the screen space position for a 3d world space position
pub extern fn GetWorldToScreen(position: Vector3, camera: Camera) Vector2;
/// Get the world space position for a 2d camera screen space position
pub extern fn GetScreenToWorld2D(position: Vector2, camera: Camera2D) Vector2;
/// Get size position for a 3d world space position
pub extern fn GetWorldToScreenEx(position: Vector3, camera: Camera, width: c_int, height: c_int) Vector2;
/// Get the screen space position for a 2d camera world space position
pub extern fn GetWorldToScreen2D(position: Vector2, camera: Camera2D) Vector2;

// Timing-related functions
/// Set target FPS (maximum)
pub extern fn SetTargetFPS(fps: c_int) void;
/// Get current FPS
pub extern fn GetFPS() c_int;
/// Get time in seconds for last frame drawn (delta time)
pub extern fn GetFrameTime() f32;
/// Get elapsed time in seconds since InitWindow()
pub extern fn GetTime() f64;

// Misc. functions
/// Get a random value between min and max (both included)
pub extern fn GetRandomValue(min: c_int, max: c_int) c_int;
/// Set the seed for the random number generator
pub extern fn SetRandomSeed(seed: c_uint) void;
/// Takes a screenshot of current screen (filename extension defines format)
pub extern fn TakeScreenshot(fileName: [*c]const u8) void;
/// Setup init configuration flags (view FLAGS)
pub extern fn SetConfigFlags(flags: c_uint) void;

/// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub extern fn TraceLog(logLevel: c_int, text: [*c]const u8, ...) void;
/// Set the current threshold (minimum) log level
pub extern fn SetTraceLogLevel(logLevel: c_int) void;
/// Internal memory allocator
pub extern fn MemAlloc(size: c_uint) ?*anyopaque;
/// Internal memory reallocator
pub extern fn MemRealloc(ptr: ?*anyopaque, size: c_uint) ?*anyopaque;
/// Internal memory free
pub extern fn MemFree(ptr: ?*anyopaque) void;

/// Open URL with default system browser (if available)
pub extern fn OpenURL(url: ?*anyopaque) void;

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
/// Set custom trace log
pub extern fn SetTraceLogCallback(callback: TraceLogCallback) void;
/// Set custom file binary data loader
pub extern fn SetLoadFileDataCallback(callback: LoadFileDataCallback) void;
/// Set custom file binary data saver
pub extern fn SetSaveFileDataCallback(callback: SaveFileDataCallback) void;
/// Set custom file text data loader
pub extern fn SetLoadFileTextCallback(callback: LoadFileTextCallback) void;
/// Set custom file text data saver
pub extern fn SetSaveFileTextCallback(callback: SaveFileTextCallback) void;

// Files management functions
/// Load file data as byte array (read)
pub extern fn LoadFileData(fileName: [*c]const u8, bytesRead: [*c]c_uint) [*c]u8;
/// Unload file data allocated by LoadFileData()
pub extern fn UnloadFileData(data: [*c]const u8) void;
/// Save data to file from byte array (write), returns true on success
pub extern fn SaveFileData(fileName: [*c]const u8, data: ?*anyopaque, bytesToWrite: c_uint) bool;
/// Export data to code (.h), returns true on success
pub extern fn ExportDataAsCode(data: [*c]const u8, size: c_uint, fileName: [*c]const u8) bool;
/// Load text data from file (read), returns a '\0' terminated string
pub extern fn LoadFileText(fileName: [*c]const u8) u8;
/// Unload file text data allocated by LoadFileText()
pub extern fn UnloadFileText(text: [*c]u8) void;
/// Save text data to file (write), string must be '\0' terminated, returns true on success
pub extern fn SaveFileText(fileName: [*c]const u8, text: [*c]u8) bool;
/// Check if file exists
pub extern fn FileExists(fileName: [*c]const u8) bool;
/// Check if a directory path exists
pub extern fn DirectoryExists(dirPath: [*c]const u8) bool;
/// Check file extension (including point: .png, .wav)
pub extern fn IsFileExtension(fileName: [*c]const u8, ext: [*c]const u8) bool;
/// Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub extern fn GetFileLength(fileName: [*c]const u8) c_int;
/// Get pointer to extension for a filename string (includes dot: '.png')
pub extern fn GetFileExtension(fileName: [*c]const u8) [*c]u8;
/// Get pointer to filename for a path string
pub extern fn GetFileName(filePath: [*c]const u8) [*c]u8;
/// Get filename string without extension (uses static string)
pub extern fn GetFileNameWithoutExt(filePath: [*c]const u8) [*c]u8;
/// Get full path for a given fileName with path (uses static string)
pub extern fn GetDirectoryPath(filePath: [*c]const u8) [*c]u8;
/// Get previous directory path for a given path (uses static string)
pub extern fn GetPrevDirectoryPath(dirPath: [*c]const u8) [*c]u8;
/// Get current working directory (uses static string)
pub extern fn GetWorkingDirectory() [*c]u8;
/// Get the directory if the running application (uses static string)
pub extern fn GetApplicationDirectory() [*c]u8;
/// Change working directory, return true on success
pub extern fn ChangeDirectory(dir: [*c]const u8) bool;
/// Check if a given path is a file or a directory
pub extern fn IsPathFile(path: [*c]const u8) bool;
/// Load directory filepaths
pub extern fn LoadDirectoryFiles(dirPath: [*c]const u8) FilePathList;
/// Load directory filepaths with extension filtering and recursive directory scan
pub extern fn LoadDirectoryFilesEx(basePath: [*c]const u8, filter: [*c]const u8, scanSubdirs: bool) FilePathList;
/// Unload filepaths
pub extern fn UnloadDirectoryFiles(files: FilePathList) FilePathList;
/// Check if a file has been dropped into window
pub extern fn IsFileDropped() bool;
/// Load dropped filepaths
pub extern fn LoadDroppedFiles() FilePathList;
/// Unload dropped filepaths
pub extern fn UnloadDroppedFiles(files: FilePathList) void;
/// Get file modification time (last write time)
pub extern fn GetFileModTime(fileName: [*c]const u8) c_long;

// Compression/Encoding functionality
/// Compress data (DEFLATE algorithm), memory must be MemFree()
pub extern fn CompressData(data: [*c]const u8, dataSize: c_int, compDataSize: [*c]c_int) [*c]u8;
/// Decompress data (DEFLATE algorithm), memory must be MemFree()
pub extern fn DecompressData(compData: [*c]const u8, compDataSize: c_int, dataSize: [*c]c_int) [*c]u8;
/// Encode data to Base64 string, memory must be MemFree()
pub extern fn EncodeDataBase64(data: [*c]const u8, dataSize: c_int, outputSize: [*c]c_int) [*c]const u8;
/// Decode Base64 string data, memory must be MemFree()
pub extern fn DecodeDataBase64(data: [*c]const u8, outputSize: [*c]c_int) [*c]const u8;

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
/// Check if a key has been pressed once
pub extern fn IsKeyPressed(key: c_int) bool;
/// Check if a key is being pressed
pub extern fn IsKeyDown(key: c_int) bool;
/// Check if a key has been released once
pub extern fn IsKeyReleased(key: c_int) bool;
/// Check if a key is NOT being pressed
pub extern fn IsKeyUp(key: c_int) bool;
/// Set a custom key to exit program (default is ESC)
pub extern fn SetExitKey(key: c_int) bool;
/// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub extern fn GetKeyPressed() c_int;
/// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub extern fn GetCharPressed() c_int;

// Input-related functions: gamepads
/// Check if a gamepad is available
pub extern fn IsGamepadAvailable(gamepad: c_int) bool;
/// Get gamepad internal name id
pub extern fn GetGamepadName(gamepad: c_int) [*c]const u8;
/// Check if a gamepad button has been pressed once
pub extern fn IsGamepadButtonPressed(gamepad: c_int, button: c_int) bool;
/// Check if a gamepad button is being pressed
pub extern fn IsGamepadButtonDown(gamepad: c_int, button: c_int) bool;
/// Check if a gamepad button has been released once
pub extern fn IsGamepadButtonReleased(gamepad: c_int, button: c_int) bool;
/// Check if a gamepad button is NOT being pressed
pub extern fn IsGamepadButtonUp(gamepad: c_int, button: c_int) bool;
/// Get the last gamepad button pressed
pub extern fn GetGamepadButtonPressed() c_int;
/// Get gamepad axis count for a gamepad
pub extern fn GetGamepadAxisCount(gamepad: c_int) c_int;
/// Get axis movement value for a gamepad axis
pub extern fn GetGamepadAxisMovement(gamepad: c_int, axis: c_int) f32;
/// Set internal gamepad mappings (SDL_GameControllerDB)
pub extern fn SetGamepadMappings(mappings: [*c]const u8) c_int;

// Input-related functions: mouse
/// Check if a mouse button has been pressed once
pub extern fn IsMouseButtonPressed(button: c_int) bool;
/// Check if a mouse button is being pressed
pub extern fn IsMouseButtonDown(button: c_int) bool;
/// Check if a mouse button has been released once
pub extern fn IsMouseButtonReleased(button: c_int) bool;
/// Check if a mouse button is NOT being pressed
pub extern fn IsMouseButtonUp(button: c_int) bool;
/// Get mouse position X
pub extern fn GetMouseX() c_int;
/// Get mouse position Y
pub extern fn GetMouseY() c_int;
/// Get mouse position XY
pub extern fn GetMousePosition() Vector2;
/// Get mouse delta between frames
pub extern fn GetMouseDelta() Vector2;
/// Set mouse position XY
pub extern fn SetMousePosition(x: c_int, y: c_int) void;
/// Set mouse offset
pub extern fn SetMouseOffset(offsetX: c_int, offsetY: c_int) void;
/// Set mouse scaling
pub extern fn SetMouseScale(scaleX: f32, scaleY: f32) void;
/// Get mouse wheel movement for X or Y, whichever is larger
pub extern fn GetMouseWheelMove() f32;
/// Get mouse wheel movement for both X and Y
pub extern fn GetMouseWheelMoveV() Vector2;
/// Set mouse cursor
pub extern fn SetMouseCursor(cursor: c_int) void;

// Input-related functions: touch
/// Get touch position X for touch point 0 (relative to screen size)
pub extern fn GetTouchX() c_int;
/// Get touch position Y for touch point 0 (relative to screen size)
pub extern fn GetTouchY() c_int;
/// Get touch position XY for a touch point index (relative to screen size)
pub extern fn GetTouchPosition(index: c_int) Vector2;
/// Get touch point identifier for given index
pub extern fn GetTouchPointId(index: c_int) c_int;
/// Get number of touch points
pub extern fn GetTouchPointCount() c_int;

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------
/// Enable a set of gestures using flags
pub extern fn SetGesturesEnabled(flags: c_uint) void;
/// Check if a gesture have been detected
pub extern fn IsGestureDetected(gesture: c_int) bool;
/// Get latest detected gesture
pub extern fn GetGestureDetected() c_int;
/// Get gesture hold time in milliseconds
pub extern fn GetGestureHoldDuration() f32;
/// Get gesture drag vector
pub extern fn GetGestureDragVector() Vector2;
/// Get gesture drag angle
pub extern fn GetGestureDragAngle() f32;
/// Get gesture pinch delta
pub extern fn GetGesturePinchVector() Vector2;
/// Get gesture pinch angle
pub extern fn GetGesturePinchAngle() f32;

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------
/// Update camera position for selected mode
pub extern fn UpdateCamera(camera: [*c]Camera, mode: c_int) void;
/// Update camera movement/rotation
pub extern fn UpdateCameraPro(camera: [*c]Camera, movement: Vector3, rotation: Vector3, zoom: f32) void;
