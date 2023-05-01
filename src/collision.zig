const lib = @import("lib.zig");
const Rectangle = lib.Rectangle;
const Vector2 = lib.Vector2;

/// Check collision between two rectangles
pub fn checkRecs(rec1: Rectangle, rec2: Rectangle) bool {
    return lib.c.CheckCollisionRecs(rec1, rec2);
}

/// Check collision between two circles
pub fn checkCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool {
    return lib.c.CheckCollisionCircles(center1.toCStruct(), radius1, center2.toCStruct(), radius2);
}

/// Check collision between circle and rectangle
pub fn checkCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool {
    return lib.c.CheckCollisionCircleRec(center.toCStruct(), radius, rec);
}

/// Check if point is inside rectangle
pub fn checkPointRec(point: Vector2, rec: Rectangle) bool {
    return lib.c.CheckCollisionPointRec(point.toCStruct(), rec);
}

/// Check if point is inside circle
pub fn checkPointCircle(point: Vector2, center: Vector2, radius: f32) bool {
    return lib.c.CheckCollisionPointCircle(point.toCStruct(), center.toCStruct(), radius);
}

/// Check if point is inside a triangle
pub fn checkPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool {
    return lib.c.CheckCollisionPointTriangle(point.toCStruct(), p1.toCStruct(), p2.toCStruct(), p3.toCStruct());
}

/// Check if point is within a polygon described by slice of vertices
pub fn checkPointPoly(point: Vector2, points: []lib.c.Vector2) bool {
    return lib.c.CheckCollisionPointPoly(point.toCStruct(), points.ptr, @intCast(c_int, points.len));
}

/// Check the collision between two lines defined by two points each, returns collision point by reference
pub fn checkLines(start_pos1: Vector2, end_pos1: Vector2, start_pos2: Vector2, end_pos2: Vector2) ?Vector2 {
    var collision_point: lib.c.Vector2 = undefined;
    return if (lib.c.CheckCollisionLines(
        start_pos1.toCStruct(),
        end_pos1.toCStruct(),
        start_pos2.toCStruct(),
        end_pos2.toCStruct(),
        &collision_point,
    )) Vector2.fromCStruct(collision_point) else null;
}

/// Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub fn checkPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: i32) bool {
    return lib.c.CheckCollisionPointLine(point.toCStruct(), p1.toCStruct(), p2.toCStruct(), threshold);
}

/// Get collision rectangle for two rectangles collision
pub fn getRec(rec1: Rectangle, rec2: Rectangle) Rectangle {
    return lib.c.GetCollisionRec(rec1, rec2);
}
