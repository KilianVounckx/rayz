// ============== structs =================

/// Vector2, 2 components
pub const Vector2 = extern struct {
    /// Vector x component
    x: f32,
    /// Vector y component
    y: f32,
};

/// Vector3, 3 components
pub const Vector3 = extern struct {
    /// Vector x component
    x: f32,
    /// Vector y component
    y: f32,
    /// Vector z component
    z: f32,
};

/// Vector4, 4 components
pub const Vector4 = extern struct {
    /// Vector x component
    x: f32,
    /// Vector y component
    y: f32,
    /// Vector z component
    z: f32,
    /// Vector w component
    w: f32,
};


/// Quaternion, 4 components (Vector4 alias)
pub const Quaternion = Vector4;

/// Matrix, 4x4 components, column major, OpenGL style, right-handed
pub const Matrix = extern struct {
    /// Matrix first row (4 components)
    m0: f32, m4: f32, m8: f32, m12: f32,
    /// Matrix second row (4 components)
    m1: f32, m5: f32, m9: f32, m13: f32,
    /// Matrix third row (4 components)
    m2: f32, m6: f32, m10: f32, m14: f32,
    /// Matrix fourth row (4 components)
    m3: f32, m7: f32, m11: f32, m15: f32,
};

/// Rectangle, 4 components
pub const Rectangle = extern struct {
    /// Rectangle top-left corner position x
    x: f32,
    /// Rectangle top-left corner position y
    y: f32,
    /// Rectangle width
    width: f32,
    /// Rectangle height
    height: f32,
};

/// Image, pixel data stored in CPU memory (RAM)
pub const Image = extern struct {
    /// Image raw data
    data: ?[*c]anyopaque,
    /// Image base width
    width: c_int,
    /// Image base height
    height: c_int,
    /// Mipmap levels, 1 by default
    mipmaps: c_int,
    /// Data format (PixelFormat type)
    format: c_int,
};

/// Texture, tex data stored in GPU memory (VRAM)
pub const Texture = extern struct {
    /// OpenGL texture id
    id: c_uint,
    /// Texture base width
    width: c_int,
    /// Texture base height
    height: c_int,
    /// Mipmap levels, 1 by default
    mipmaps: c_int,
    /// Data format (PixelFormat type)
    format: c_int,
};

/// Texture2D, same as Texture
pub const Texture2D = Texture;

/// TextureCubemap, same as Texture
pub const TextureCubemap = TextureCubemap;

/// RenderTexture, fbo for texture rendering
pub const RenderTexture = extern struct {
    /// OpenGl framebuffer object id
    id: c_uint,
    /// Color buffer attachment texture
    texture: Texture,
    /// Depth buffer attachment texture
    depth: Texture,
};

/// RenderTexture2D, same as RenderTexture
pub const RenderTexture2D = RenderTexture;

// NPatchInfo, n-patch layout info
pub const NPatchInfo = extern struct{
    /// Texture source rectangle
    source: Rectangle,         
    /// Left border offset
    left: c_int,               
    /// Top border offset
    top: c_int,                
    /// Right border offset
    right: c_int,              
    /// Bottom border offset
    bottom: c_int,             
    /// Layout of the n-patch: 3x3, 1x3 or 3x1
    layout: c_int,             
};

/// GlyphInfo, font characters glyphs info
pub const GlyphInfo = extern struct {
    /// Character value (Unicode)
    value: c_int,     
    /// Character offset X when drawing
    offsetX: c_int,   
    /// Character offset Y when drawing
    offsetY: c_int,   
    /// Character advance position X
    advanceX: c_int,  
    /// Character image data
    image: Image,     
};

// Font, font texture and GlyphInfo array data
pub const Font = extern struct {
    /// Base size (default chars height)
    baseSize: c_int,       
    /// Number of glyph characters
    glyphCount: c_int,     
    /// Padding around the glyph characters
    glyphPadding: c_int,   
    /// Texture atlas containing the glyphs
    texture: Texture2D,    
    /// Rectangles in texture for the glyphs
    recs: ?[*c]Rectangle,  
    /// Glyphs info data
    glyphs: ?[*c]GlyphInfo,
};

/// Camera, defines position/orientation in 3d space
pub const Camera3D = extern struct {
    /// Camera position
    position: Vector3,
    /// Camera target it looks at
    target: Vector3,
    /// Camera up vector (rotation over its axis)
    up: Vector3,
    /// Camera field-of-view aperture in Y (degrees) in perspective, used as near plane in orthographic
    fovy: f32,
    /// Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    projection: c_int,
};

/// Camera2D, defines position/orientation in 2d space
pub const Camera2D = extern struct {
    /// Camera offset (displacement from target)
    offset: Vector2,
    /// Camera target (rotation and zoom origin)
    target: Vector2,
    /// Camera rotation in degrees
    rotation: f32,
    /// Camera zoom (scaling), should be 1.0f by default
    zoom: f32,
};

/// Mesh, vertex data and vao/vbo
pub const Mesh = extern struct {
    /// Number of vertices stored in arrays
    vertexCount: c_int,    
    /// Number of triangles stored (indexed or not)
    triangleCount: c_int,  

    // Vertex attributes data
    /// Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    vertices: ?[*c]f32,  
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: ?[*c]f32, 
    /// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    texcoords2: ?[*c]f32,
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    normals: ?[*c]f32,   
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    tangents: ?[*c]f32,  
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: ?[*c]u8,     
    /// Vertex indices (in case vertex data comes indexed)
    indices: ?[*c]u16,   

    // Animation vertex data
    /// Animated vertex positions (after bones transformations)
    animVertices: ?[*c] f32,   
    /// Animated normals (after bones transformations)
    animNormals: ?[*c] f32,    
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneIds: ?[*c] u8,         
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    boneWeights: ?[*c] f32,    

    // OpenGL identifiers
    /// OpenGL Vertex Array Object id
    vaoId: c_uint,     
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    vboId: ?[*c] c_uint,    
};

/// Shader
pub const Shader = extern struct {
    /// Shader program id
    id: c_uint,        
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    locs: ?[*c]c_int,  
};

/// MaterialMap
pub const MaterialMap = extern struct {
    /// Material map texture
    texture: Texture2D,
    /// Material map color
    color: Color,         
    /// Material map value
    value: f32,           
};


/// Material, includes shader and maps
pub const Material = extern struct {
    /// Material shader
    shader: Shader,
    /// Material maps array (MAX_MATERIAL_MAPS)
    maps: ?[*c]MaterialMap,
    /// Material generic parameters (if required)
    params: [4]f32,
};

/// Transform, vertex transformation data
pub const Transform = extern struct {
    /// Translation
    translation: Vector3,     
    /// Rotation
    rotation: Quaternion,     
    /// Scale
    scale: Vector3,           
};

/// Bone, skeletal animation bone
pub const BoneInfo = extern struct {
    /// Bone name
    name: [32]u8,          
    /// Bone parent
    parent: c_int          
};

/// Model, meshes, materials and animation data
pub const Model = extern struct {
    /// Local transform matrix
    transform: Matrix,       

    /// Number of meshes
    meshCount: c_int,        
    /// Number of materials
    materialCount: c_int,    
    /// Meshes array
    meshes: ?[*c]Mesh,       
    /// Materials array
    materials: ?[*c]Material, 
    /// Mesh material number
    meshMaterial: ?[*c]c_int, 

    // Animation data
    /// Number of bones
    boneCount: c_int,        
    /// Bones information (skeleton)
    bones: ?[*c]BoneInfo,    
    /// Bones base transformation (pose)
    bindPose: ?[*c]Transform,
};


/// ModelAnimation
pub const ModelAnimation = extern struct {
    /// Number of bones
    boneCount: c_int,                
    /// Number of animation frames
    frameCount: c_int,               
    /// Bones information (skeleton)
    bones: ?[*c]BoneInfo,            
    /// Poses array by frame
    framePoses: ?[*c]?[*c]Transform, 
};

/// Ray, ray for raycasting
pub const Ray = extern struct {
    /// Ray position (origin)
    position: Vector3,        
    /// Ray direction
    direction: Vector3,       
};

/// RayCollision, ray hit information
pub const RayCollision = extern struct {
    /// Did the ray hit something?
    hit: bool,               
    /// Distance to the nearest hit
    distance: f32,           
    /// Point of the nearest hit
    point: Vector3,          
    /// Surface normal of hit
    normal: Vector3,         
};

/// BoundingBox
pub const BoundingBox = extern struct {
    /// Minimum vertex box-corner
    min: Vector3,            
    /// Maximum vertex box-corner
    max: Vector3,            
};

/// Wave, audio wave data
pub const Wave = extern struct {
    /// Total number of frames (considering channels)
    frameCount: c_uint,    
    /// Frequency (samples per second)
    sampleRate: c_uint,    
    /// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    sampleSize: c_uint,    
    /// Number of channels (1-mono, 2-stereo, ...)
    channels: c_uint,      
    /// Buffer data pointer
    data: ?[*c]anyopaque,  
};

// Opaque structs declaration
// NOTE: Actual structs are defined internally in raudio module
pub const rAudioBuffer = rAudioBuffer;
pub const rAudioProcessor = rAudioProcessor;

/// AudioStream, custom audio stream
pub const AudioStream = extern struct {
    /// Pointer to internal data used by the audio system
    buffer: ?[*c]rAudioBuffer,        
    /// Pointer to internal data processor, useful for audio effects
    processor: ?[*c] rAudioProcessor, 

    /// Frequency (samples per second)
    sampleRate: c_uint,               
    /// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    sampleSize: c_uint,               
    /// Number of channels (1-mono, 2-stereo, ...)
    channels: c_uint,                 
};

/// Sound
pub const Sound = extern struct {
    /// Audio stream
    stream: AudioStream,       
    /// Total number of frames (considering channels)
    frameCount: c_uint,    
};

// Music, audio stream, anything longer than ~10 seconds should be streamed
pub const Music = extern struct {
    AudioStream stream;         // Audio stream
    unsigned int frameCount;    // Total number of frames (considering channels)
    bool looping;               // Music looping enable

    int ctxType;                // Type of music context (audio filetype)
    void *ctxData;              // Audio context data, depends on type
};

/// VrDeviceInfo, Head-Mounted-Display device parameters
pub const VrDeviceInfo = extern struct {
    /// Horizontal resolution in pixels
    hResolution: c_int,            
    /// Vertical resolution in pixels
    vResolution: c_int,            
    /// Horizontal size in meters
    hScreenSize: f32,              
    /// Vertical size in meters
    vScreenSize: f32,              
    /// Screen center in meters
    vScreenCenter: f32,            
    /// Distance between eye and display in meters
    eyeToScreenDistance: f32,      
    /// Lens separation distance in meters
    lensSeparationDistance: f32,   
    /// IPD (distance between pupils) in meters
    interpupillaryDistance: f32,   
    /// Lens distortion constant parameters
    lensDistortionValues: [4]f32,  
    /// Chromatic aberration correction parameters
    chromaAbCorrection: [4]f32,    
};

/// VrStereoConfig, VR stereo rendering configuration for simulator
pub const VrStereoConfig = extern struct {
    /// VR projection matrices (per eye)
    projection: [2]Matrix,         
    /// VR view offset matrices (per eye)
    viewOffset: [2]Matrix,         
    /// VR left lens center
    leftLensCenter: [2]f32,        
    /// VR right lens center
    rightLensCenter: [2]f32,       
    /// VR left screen center
    leftScreenCenter: [2]f32,      
    /// VR right screen center
    rightScreenCenter: [2]f32,     
    /// VR distortion scale
    scale: [2]f32,                 
    /// VR distortion scale in
    scaleIn: [2]f32,               
};

/// File path list
pub const FilePathList = extern struct {
    /// Filepaths max entries
    capacity: c_uint,          
    /// Filepaths entries count
    count: c_uint,             
    /// Filepaths entries
    paths: ?[*c]?[*c]u8,       
};

// ============== core =================
// Window-related functions
pub extern fn InitWindow(width: c_int, height: c_int, title: ?[*c]const u8) void;  // Initialize window and OpenGL context
pub extern fn WindowShouldClose() bool;                                            // Check if KEY_ESCAPE pressed or Close icon pressed
pub extern fn CloseWindow() void;                                                  // Close window and unload OpenGL context
pub extern fn IsWindowReady() bool;                                                // Check if window has been initialized successfully
pub extern fn IsWindowFullscreen() bool;                                           // Check if window is currently fullscreen
pub extern fn IsWindowHidden() bool;                                               // Check if window is currently hidden (only PLATFORM_DESKTOP)
pub extern fn IsWindowMinimized() bool;                                            // Check if window is currently minimized (only PLATFORM_DESKTOP)
pub extern fn IsWindowMaximized() bool;                                            // Check if window is currently maximized (only PLATFORM_DESKTOP)
pub extern fn IsWindowFocused() bool;                                              // Check if window is currently focused (only PLATFORM_DESKTOP)
pub extern fn IsWindowResized() bool;                                              // Check if window has been resized last frame
pub extern fn IsWindowState(flag: c_uint) bool;                                    // Check if one specific window flag is enabled
pub extern fn SetWindowState(flags: c_uint) void;                                  // Set window configuration state using flags (only PLATFORM_DESKTOP)
pub extern fn ClearWindowState(flags: c_uint) void;                                // Clear window configuration state flags
pub extern fn ToggleFullscreen() void;                                             // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub extern fn MaximizeWindow() void;                                               // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub extern fn MinimizeWindow() void;                                               // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub extern fn RestoreWindow() void;                                                // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub extern fn SetWindowIcon(image: Image) void;                                    // Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern fn SetWindowIcons(images: ?[*c]Image, count: c_int) void;               // Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern fn SetWindowTitle(title: ?[*c]const u8) void;                           // Set title for window (only PLATFORM_DESKTOP)
pub extern fn SetWindowPosition(x: c_int, y: c_int) void;                          // Set window position on screen (only PLATFORM_DESKTOP)
pub extern fn SetWindowMonitor(monitor: c_int) void;                               // Set monitor for the current window (fullscreen mode)
pub extern fn SetWindowMinSize(width: c_int, height: c_int) void;                  // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub extern fn SetWindowSize(width: c_int, height: c_int) void;                     // Set window dimensions
pub extern fn SetWindowOpacity(opacity: f32) void;                                 // Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub extern fn GetWindowHandle() ?[*c]anyopaque;                                    // Get native window handle
pub extern fn GetScreenWidth() c_int;                                              // Get current screen width
pub extern fn GetScreenHeight() c_int;                                             // Get current screen height
pub extern fn GetRenderWidth() c_int;                                              // Get current render width (it considers HiDPI)
pub extern fn GetRenderHeight() c_int;                                             // Get current render height (it considers HiDPI)
pub extern fn GetMonitorCount() c_int;                                             // Get number of connected monitors
pub extern fn GetCurrentMonitor() c_int;                                           // Get current connected monitor
pub extern fn GetMonitorPosition(monitor: c_int) Vector2;                          // Get specified monitor position
pub extern fn GetMonitorWidth(monitor: c_int) c_int;                               // Get specified monitor width (current video mode used by monitor)
pub extern fn GetMonitorHeight(monitor: c_int) c_int;                              // Get specified monitor height (current video mode used by monitor)
pub extern fn GetMonitorPhysicalWidth(monitor: c_int) c_int;                       // Get specified monitor physical width in millimetres
pub extern fn GetMonitorPhysicalHeight(monitor: c_int) c_int;                      // Get specified monitor physical height in millimetres
pub extern fn GetMonitorRefreshRate(monitor: c_int) c_int;                         // Get specified monitor refresh rate
pub extern fn GetWindowPosition() Vector2;                                         // Get window position XY on monitor
pub extern fn GetWindowScaleDPI() Vector2;                                         // Get window scale DPI factor
pub extern fn GetMonitorName(monitor: c_int) ?[*c]const u8;                        // Get the human-readable, UTF-8 encoded name of the primary monitor
pub extern fn SetClipboardText(text: ?[*c]const u8) void;                          // Set clipboard text content
pub extern fn GetClipboardText() ?[*c]const u8;                                    // Get clipboard text content
pub extern fn EnableEventWaiting() void;                                           // Enable waiting for events on EndDrawing(), no automatic event polling
pub extern fn DisableEventWaiting() void;                                          // Disable waiting for events on EndDrawing(), automatic events polling

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
pub extern fn SwapScreenBuffer() void;                                             // Swap back buffer with front buffer (screen drawing)
pub extern fn PollInputEvents() void;                                              // Register all input events
pub extern fn WaitTime(seconds: f64) void;                                         // Wait for some time (halt program execution)

// Cursor-related functions
pub extern fn ShowCursor() void ;                                      // Shows cursor
pub extern fn HideCursor() void ;                                      // Hides cursor
pub extern fn IsCursorHidden() bool ;                                  // Check if cursor is not visible
pub extern fn EnableCursor() void ;                                    // Enables cursor (unlock cursor)
pub extern fn DisableCursor() void ;                                   // Disables cursor (lock cursor)
pub extern fn IsCursorOnScreen() bool;                                // Check if cursor is on the screen

// Drawing-related functions
pub extern fn ClearBackground(color: Color) void;                          // Set background color (framebuffer clear color)
pub extern fn BeginDrawing() void;                                    // Setup canvas (framebuffer) to start drawing
pub extern fn EndDrawing() void;                                      // End canvas drawing and swap buffers (double buffering)
pub extern fn BeginMode2D(camera: Camera2D) void;                          // Begin 2D mode with custom camera (2D)
pub extern fn EndMode2D() void;                                       // Ends 2D mode with custom camera
pub extern fn BeginMode3D(camera: Camera3D) void;                          // Begin 3D mode with custom camera (3D)
pub extern fn EndMode3D() void;                                       // Ends 3D mode and returns to default 2D orthographic mode
pub extern fn BeginTextureMode(target: RenderTexture2D) void;              // Begin drawing to render texture
void EndTextureMode(void);                                  // Ends drawing to render texture
void BeginShaderMode(Shader shader);                        // Begin custom shader drawing
void EndShaderMode(void);                                   // End custom shader drawing (use default shader)
void BeginBlendMode(int mode);                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)
void EndBlendMode(void);                                    // End blending mode (reset to default: alpha blending)
void BeginScissorMode(int x, int y, int width, int height); // Begin scissor mode (define screen area for following drawing)
void EndScissorMode(void);                                  // End scissor mode
void BeginVrStereoMode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)
void EndVrStereoMode(void);                                 // End stereo rendering (requires VR simulator)

// VR stereo config functions for VR simulator
VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters
void UnloadVrStereoConfig(VrStereoConfig config);           // Unload VR stereo config

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
Shader LoadShader(const char *vsFileName, const char *fsFileName);   // Load shader from files and bind default locations
Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode); // Load shader from code strings and bind default locations
bool IsShaderReady(Shader shader);                                   // Check if a shader is ready
int GetShaderLocation(Shader shader, const char *uniformName);       // Get shader uniform location
int GetShaderLocationAttrib(Shader shader, const char *attribName);  // Get shader attribute location
void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               // Set shader uniform value
void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   // Set shader uniform value vector
void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         // Set shader uniform value (matrix 4x4)
void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); // Set shader uniform value for texture (sampler2d)
void UnloadShader(Shader shader);                                    // Unload shader from GPU memory (VRAM)

// Screen-space-related functions
Ray GetMouseRay(Vector2 mousePosition, Camera camera);      // Get a ray trace from mouse position
Matrix GetCameraMatrix(Camera camera);                      // Get camera transform matrix (view matrix)
Matrix GetCameraMatrix2D(Camera2D camera);                  // Get camera 2d transform matrix
Vector2 GetWorldToScreen(Vector3 position, Camera camera);  // Get the screen space position for a 3d world space position
Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera); // Get the world space position for a 2d camera screen space position
Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); // Get size position for a 3d world space position
Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera); // Get the screen space position for a 2d camera world space position

// Timing-related functions
void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
int GetFPS(void);                                           // Get current FPS
float GetFrameTime(void);                                   // Get time in seconds for last frame drawn (delta time)
double GetTime(void);                                       // Get elapsed time in seconds since InitWindow()

// Misc. functions
int GetRandomValue(int min, int max);                       // Get a random value between min and max (both included)
void SetRandomSeed(unsigned int seed);                      // Set the seed for the random number generator
void TakeScreenshot(const char *fileName);                  // Takes a screenshot of current screen (filename extension defines format)
void SetConfigFlags(unsigned int flags);                    // Setup init configuration flags (view FLAGS)

void TraceLog(int logLevel, const char *text, ...);         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
void SetTraceLogLevel(int logLevel);                        // Set the current threshold (minimum) log level
void *MemAlloc(unsigned int size);                          // Internal memory allocator
void *MemRealloc(void *ptr, unsigned int size);             // Internal memory reallocator
void MemFree(void *ptr);                                    // Internal memory free

void OpenURL(const char *url);                              // Open URL with default system browser (if available)

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
void SetTraceLogCallback(TraceLogCallback callback);         // Set custom trace log
void SetLoadFileDataCallback(LoadFileDataCallback callback); // Set custom file binary data loader
void SetSaveFileDataCallback(SaveFileDataCallback callback); // Set custom file binary data saver
void SetLoadFileTextCallback(LoadFileTextCallback callback); // Set custom file text data loader
void SetSaveFileTextCallback(SaveFileTextCallback callback); // Set custom file text data saver

// Files management functions
unsigned char *LoadFileData(const char *fileName, unsigned int *bytesRead);       // Load file data as byte array (read)
void UnloadFileData(unsigned char *data);                   // Unload file data allocated by LoadFileData()
bool SaveFileData(const char *fileName, void *data, unsigned int bytesToWrite);   // Save data to file from byte array (write), returns true on success
bool ExportDataAsCode(const unsigned char *data, unsigned int size, const char *fileName); // Export data to code (.h), returns true on success
char *LoadFileText(const char *fileName);                   // Load text data from file (read), returns a '\0' terminated string
void UnloadFileText(char *text);                            // Unload file text data allocated by LoadFileText()
bool SaveFileText(const char *fileName, char *text);        // Save text data to file (write), string must be '\0' terminated, returns true on success
bool FileExists(const char *fileName);                      // Check if file exists
bool DirectoryExists(const char *dirPath);                  // Check if a directory path exists
bool IsFileExtension(const char *fileName, const char *ext); // Check file extension (including point: .png, .wav)
int GetFileLength(const char *fileName);                    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
const char *GetFileExtension(const char *fileName);         // Get pointer to extension for a filename string (includes dot: '.png')
const char *GetFileName(const char *filePath);              // Get pointer to filename for a path string
const char *GetFileNameWithoutExt(const char *filePath);    // Get filename string without extension (uses static string)
const char *GetDirectoryPath(const char *filePath);         // Get full path for a given fileName with path (uses static string)
const char *GetPrevDirectoryPath(const char *dirPath);      // Get previous directory path for a given path (uses static string)
const char *GetWorkingDirectory(void);                      // Get current working directory (uses static string)
const char *GetApplicationDirectory(void);                  // Get the directory if the running application (uses static string)
bool ChangeDirectory(const char *dir);                      // Change working directory, return true on success
bool IsPathFile(const char *path);                          // Check if a given path is a file or a directory
FilePathList LoadDirectoryFiles(const char *dirPath);       // Load directory filepaths
FilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bool scanSubdirs); // Load directory filepaths with extension filtering and recursive directory scan
void UnloadDirectoryFiles(FilePathList files);              // Unload filepaths
bool IsFileDropped(void);                                   // Check if a file has been dropped into window
FilePathList LoadDroppedFiles(void);                        // Load dropped filepaths
void UnloadDroppedFiles(FilePathList files);                // Unload dropped filepaths
long GetFileModTime(const char *fileName);                  // Get file modification time (last write time)

// Compression/Encoding functionality
unsigned char *CompressData(const unsigned char *data, int dataSize, int *compDataSize);        // Compress data (DEFLATE algorithm), memory must be MemFree()
unsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize);  // Decompress data (DEFLATE algorithm), memory must be MemFree()
char *EncodeDataBase64(const unsigned char *data, int dataSize, int *outputSize);               // Encode data to Base64 string, memory must be MemFree()
unsigned char *DecodeDataBase64(const unsigned char *data, int *outputSize);                    // Decode Base64 string data, memory must be MemFree()

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
bool IsKeyPressed(int key);                             // Check if a key has been pressed once
bool IsKeyDown(int key);                                // Check if a key is being pressed
bool IsKeyReleased(int key);                            // Check if a key has been released once
bool IsKeyUp(int key);                                  // Check if a key is NOT being pressed
void SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)
int GetKeyPressed(void);                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
int GetCharPressed(void);                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty

// Input-related functions: gamepads
bool IsGamepadAvailable(int gamepad);                   // Check if a gamepad is available
const char *GetGamepadName(int gamepad);                // Get gamepad internal name id
bool IsGamepadButtonPressed(int gamepad, int button);   // Check if a gamepad button has been pressed once
bool IsGamepadButtonDown(int gamepad, int button);      // Check if a gamepad button is being pressed
bool IsGamepadButtonReleased(int gamepad, int button);  // Check if a gamepad button has been released once
bool IsGamepadButtonUp(int gamepad, int button);        // Check if a gamepad button is NOT being pressed
int GetGamepadButtonPressed(void);                      // Get the last gamepad button pressed
int GetGamepadAxisCount(int gamepad);                   // Get gamepad axis count for a gamepad
float GetGamepadAxisMovement(int gamepad, int axis);    // Get axis movement value for a gamepad axis
int SetGamepadMappings(const char *mappings);           // Set internal gamepad mappings (SDL_GameControllerDB)

// Input-related functions: mouse
bool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once
bool IsMouseButtonDown(int button);                     // Check if a mouse button is being pressed
bool IsMouseButtonReleased(int button);                 // Check if a mouse button has been released once
bool IsMouseButtonUp(int button);                       // Check if a mouse button is NOT being pressed
int GetMouseX(void);                                    // Get mouse position X
int GetMouseY(void);                                    // Get mouse position Y
Vector2 GetMousePosition(void);                         // Get mouse position XY
Vector2 GetMouseDelta(void);                            // Get mouse delta between frames
void SetMousePosition(int x, int y);                    // Set mouse position XY
void SetMouseOffset(int offsetX, int offsetY);          // Set mouse offset
void SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling
float GetMouseWheelMove(void);                          // Get mouse wheel movement for X or Y, whichever is larger
Vector2 GetMouseWheelMoveV(void);                       // Get mouse wheel movement for both X and Y
void SetMouseCursor(int cursor);                        // Set mouse cursor

// Input-related functions: touch
int GetTouchX(void);                                    // Get touch position X for touch point 0 (relative to screen size)
int GetTouchY(void);                                    // Get touch position Y for touch point 0 (relative to screen size)
Vector2 GetTouchPosition(int index);                    // Get touch position XY for a touch point index (relative to screen size)
int GetTouchPointId(int index);                         // Get touch point identifier for given index
int GetTouchPointCount(void);                           // Get number of touch points

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------
void SetGesturesEnabled(unsigned int flags);      // Enable a set of gestures using flags
bool IsGestureDetected(int gesture);              // Check if a gesture have been detected
int GetGestureDetected(void);                     // Get latest detected gesture
float GetGestureHoldDuration(void);               // Get gesture hold time in milliseconds
Vector2 GetGestureDragVector(void);               // Get gesture drag vector
float GetGestureDragAngle(void);                  // Get gesture drag angle
Vector2 GetGesturePinchVector(void);              // Get gesture pinch delta
float GetGesturePinchAngle(void);                 // Get gesture pinch angle

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------
void UpdateCamera(Camera *camera, int mode);      // Update camera position for selected mode
void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom); // Update camera movement/rotation
