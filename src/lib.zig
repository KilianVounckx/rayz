const std = @import("std");

pub const c = @import("c.zig");

test "c" {
    std.testing.refAllDeclsRecursive(c);
}
