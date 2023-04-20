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
    m0: f32,
    m4: f32,
    m8: f32,
    m12: f32,
    /// Matrix second row (4 components)
    m1: f32,
    m5: f32,
    m9: f32,
    m13: f32,
    /// Matrix third row (4 components)
    m2: f32,
    m6: f32,
    m10: f32,
    m14: f32,
    /// Matrix fourth row (4 components)
    m3: f32,
    m7: f32,
    m11: f32,
    m15: f32,
};

// Color, 4 components, R8G8B8A8 (32bit)
pub const Color = extern struct {
    /// Color red value
    r: u8,
    /// Color green value
    g: u8,
    /// Color blue value
    b: u8,
    /// Color alpha value
    a: u8,
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
    data: ?*anyopaque,
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
pub const TextureCubemap = Texture;

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
pub const NPatchInfo = extern struct {
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
    recs: [*c]Rectangle,
    /// Glyphs info data
    glyphs: [*c]GlyphInfo,
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

/// Camera type fallback, defaults to Camera3D
pub const Camera = Camera3D;

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
    vertices: [*c]f32,
    /// Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords: [*c]f32,
    /// Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    texcoords2: [*c]f32,
    /// Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    normals: [*c]f32,
    /// Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    tangents: [*c]f32,
    /// Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    colors: [*c]u8,
    /// Vertex indices (in case vertex data comes indexed)
    indices: [*c]c_ushort,

    // Animation vertex data
    /// Animated vertex positions (after bones transformations)
    animVertices: [*c]f32,
    /// Animated normals (after bones transformations)
    animNormals: [*c]f32,
    /// Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneIds: [*c]u8,
    /// Vertex bone weight, up to 4 bones influence by vertex (skinning)
    boneWeights: [*c]f32,

    // OpenGL identifiers
    /// OpenGL Vertex Array Object id
    vaoId: c_uint,
    /// OpenGL Vertex Buffer Objects id (default vertex data)
    vboId: [*c]c_uint,
};

/// Shader
pub const Shader = extern struct {
    /// Shader program id
    id: c_uint,
    /// Shader locations array (RL_MAX_SHADER_LOCATIONS)
    locs: [*c]c_int,
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
    maps: [*c]MaterialMap,
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
    parent: c_int,
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
    meshes: [*c]Mesh,
    /// Materials array
    materials: [*c]Material,
    /// Mesh material number
    meshMaterial: [*c]c_int,

    // Animation data
    /// Number of bones
    boneCount: c_int,
    /// Bones information (skeleton)
    bones: [*c]BoneInfo,
    /// Bones base transformation (pose)
    bindPose: [*c]Transform,
};

/// ModelAnimation
pub const ModelAnimation = extern struct {
    /// Number of bones
    boneCount: c_int,
    /// Number of animation frames
    frameCount: c_int,
    /// Bones information (skeleton)
    bones: [*c]BoneInfo,
    /// Poses array by frame
    framePoses: [*c]Transform,
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
    data: ?*anyopaque,
};

// Opaque structs declaration
// NOTE: Actual structs are defined internally in raudio module
pub const rAudioBuffer = opaque {};
pub const rAudioProcessor = opaque {};

/// AudioStream, custom audio stream
pub const AudioStream = extern struct {
    /// Pointer to internal data used by the audio system
    buffer: ?*rAudioBuffer,
    /// Pointer to internal data processor, useful for audio effects
    processor: ?*rAudioProcessor,

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

/// Music, audio stream, anything longer than ~10 seconds should be streamed
pub const Music = extern struct {
    /// Audio stream
    stream: AudioStream,
    /// Total number of frames (considering channels)
    frameCount: c_uint,
    /// Music looping enable
    looping: bool,

    /// Type of music context (audio filetype)
    ctxType: c_int,
    /// Audio context data, depends on type
    ctxData: ?*anyopaque,
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
    paths: [*c]u8,
};
