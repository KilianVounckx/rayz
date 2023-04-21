const lib = @import("../../lib.zig");
const structs = lib.c.raylib.structs;
const Color = structs.Color;
const Rectangle = structs.Rectangle;
const Texture2D = structs.Texture2D;
const Vector2 = structs.Vector2;

// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
/// Set texture and rectangle to be used on shapes drawing
pub extern fn SetShapesTexture(texture: Texture2D, source: Rectangle) void;

// Basic shapes drawing functions
/// Draw a pixel
pub extern fn DrawPixel(posX: c_int, posY: c_int, color: Color) void;
/// Draw a pixel (Vector version)
pub extern fn DrawPixelV(position: Vector2, color: Color) void;
/// Draw a line
pub extern fn DrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void;
/// Draw a line (Vector version)
pub extern fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void;
/// Draw a line defining thickness
pub extern fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
/// Draw a line using cubic-bezier curves in-out
pub extern fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void;
/// Draw line using quadratic bezier curves with a control point
pub extern fn DrawLineBezierQuad(startPos: Vector2, endPos: Vector2, controlPos: Vector2, thick: f32, color: Color) void;
/// Draw line using cubic bezier curves with 2 control points
pub extern fn DrawLineBezierCubic(startPos: Vector2, endPos: Vector2, startControlPos: Vector2, endControlPos: Vector2, thick: f32, color: Color) void;
/// Draw lines sequence
pub extern fn DrawLineStrip(points: [*c]Vector2, pointCount: c_int, color: Color) void;
/// Draw a color-filled circle
pub extern fn DrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
/// Draw a piece of a circle
pub extern fn DrawCircleSector(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
/// Draw circle sector outline
pub extern fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
/// Draw a gradient-filled circle
pub extern fn DrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: Color, color2: Color) void;
/// Draw a color-filled circle (Vector version)
pub extern fn DrawCircleV(center: Vector2, radius: f32, color: Color) void;
/// Draw circle outline
pub extern fn DrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: Color) void;
/// Draw ellipse
pub extern fn DrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
/// Draw ellipse outline
pub extern fn DrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void;
/// Draw ring
pub extern fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
/// Draw ring outline
pub extern fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void;
/// Draw a color-filled rectangle
pub extern fn DrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
/// Draw a color-filled rectangle (Vector version)
pub extern fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void;
/// Draw a color-filled rectangle
pub extern fn DrawRectangleRec(rec: Rectangle, color: Color) void;
/// Draw a color-filled rectangle with pro parameters
pub extern fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void;
/// Draw a vertical-gradient-filled rectangle
pub extern fn DrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void;
/// Draw a horizontal-gradient-filled rectangle
pub extern fn DrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: c_int, color2: c_int) void;
/// Draw a gradient-filled rectangle with custom vertex colors
pub extern fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void;
/// Draw rectangle outline
pub extern fn DrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void;
/// Draw rectangle outline with extended parameters
pub extern fn DrawRectangleLinesEx(rec: Rectangle, lineThick: f32, color: Color) void;
/// Draw rectangle with rounded edges
pub extern fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: c_int, color: Color) void;
/// Draw rectangle with rounded edges outline
pub extern fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: c_int, lineThick: f32, color: Color) void;
/// Draw a color-filled triangle (vertex in counter-clockwise order!)
pub extern fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
/// Draw triangle outline (vertex in counter-clockwise order!)
pub extern fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Vector2) void;
/// Draw a triangle fan defined by points (first vertex is the center)
pub extern fn DrawTriangleFan(points: [*c]Vector2, pointCount: c_int, color: Color) void;
/// Draw a triangle strip defined by points
pub extern fn DrawTriangleStrip(points: [*c]Vector2, pointCount: c_int, color: Color) void;
/// Draw a regular polygon (Vector version)
pub extern fn DrawPoly(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void;
/// Draw a polygon outline of n sides
pub extern fn DrawPolyLines(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void;
/// Draw a polygon outline of n sides with extended parameters
pub extern fn DrawPolyLinesEx(center: Vector2, sides: c_int, radius: f32, rotation: f32, lineThick: f32, color: Color) void;

// Basic shapes collision detection functions
/// Check collision between two rectangles
pub extern fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool;
/// Check collision between two circles
pub extern fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool;
/// Check collision between circle and rectangle
pub extern fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool;
/// Check if point is inside rectangle
pub extern fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool;
/// Check if point is inside circle
pub extern fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool;
/// Check if point is inside a triangle
pub extern fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool;
/// Check if point is within a polygon described by array of vertices
pub extern fn CheckCollisionPointPoly(point: Vector2, points: [*c]Vector2, pointCount: c_int) bool;
/// Check the collision between two lines defined by two points each, returns collision point by reference
pub extern fn CheckCollisionLines(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: [*c]Vector2) bool;
/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub extern fn CheckCollisionPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: c_int) bool;
/// Get collision rectangle for two rectangles collision
pub extern fn GetCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle;
