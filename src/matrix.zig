const lib = @import("lib.zig");

/// Push the current matrix to stack
pub fn push() void {
    lib.c.rlPushMatrix();
}

/// Pop latest inserted matrix from stack
pub fn pop() void {
    lib.c.rlPopMatrix();
}

/// Reset current matrix to identity matrix
pub fn loadIdentity() void {
    lib.c.rlLoadIdentity();
}

/// Multiply the current matrix by a translation matrix
pub fn translate(x: f32, y: f32, z: f32) void {
    lib.c.rlTranslatef(x, y, z);
}

/// Multiply the current matrix by a rotation matrix
pub fn rotate(angle: f32, x: f32, y: f32, z: f32) void {
    lib.c.rlRotatef(angle, x, y, z);
}

/// Multiply the current matrix by a scaling matrix
pub fn scale(x: f32, y: f32, z: f32) void {
    lib.c.rlScalef(x, y, z);
}

/// Multiply the current matrix by another matrix
pub fn multMatrix(matrix: [16]f32) void {
    lib.c.rlMultMatrix(matrix);
}
