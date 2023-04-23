const lib = @import("lib.zig");

pub fn push() void {
    lib.c.rlPushMatrix();
}

pub fn pop() void {
    lib.c.rlPopMatrix();
}

pub fn translate(x: f32, y: f32, z: f32) void {
    lib.c.rlTranslatef(x, y, z);
}

pub fn rotate(angle: f32, x: f32, y: f32, z: f32) void {
    lib.c.rlRotatef(angle, x, y, z);
}
