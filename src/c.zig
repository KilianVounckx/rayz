const std = @import("std");

const lib = @import("lib.zig");

pub usingnamespace @cImport({
    @cDefine("RL_MALLOC", "zig_malloc");
    @cDefine("RL_CALLOC", "zig_calloc");
    @cDefine("RL_REALLOC", "zig_realloc");
    @cDefine("RL_FREE", "zig_free");

    @cInclude("rayz.h");

    @cInclude("raylib.h");
    @cInclude("raymath.h");
    @cInclude("rcamera.h");
    @cInclude("rlgl.h");
});

pub var allocator_instance = std.heap.GeneralPurposeAllocator(.{}){};
pub var rl_allocator = allocator_instance.allocator();

export fn zig_malloc(size: usize) ?[*]u8 {
    var bytes = rl_allocator.rawAlloc(@sizeOf(usize) + size, 0, 0) orelse return null;
    std.mem.writeIntBig(usize, bytes[0..@sizeOf(usize)], size);
    return bytes + @sizeOf(usize);
}

export fn zig_calloc(nitems: usize, size: usize) ?[*]u8 {
    const len = nitems * size;
    var bytes = zig_malloc(len) orelse return null;
    @memset(bytes, 0, len);
    return bytes;
}

export fn zig_realloc(maybe_ptr: ?[*]u8, size: usize) ?[*]u8 {
    const ptr = maybe_ptr orelse return zig_malloc(size);
    var new_ptr = zig_malloc(size) orelse return null;
    const old_size_ptr = ptr - @sizeOf(usize);
    const old_size = std.mem.readIntBig(usize, old_size_ptr[0..@sizeOf(usize)]);
    @memcpy(new_ptr, ptr, old_size);
    zig_free(ptr);
    return new_ptr;
}

export fn zig_free(maybe_ptr: ?[*]u8) void {
    const ptr = maybe_ptr orelse return;
    const size_ptr = ptr - @sizeOf(usize);
    const size = std.mem.readIntBig(usize, size_ptr[0..@sizeOf(usize)]);
    rl_allocator.rawFree(size_ptr[0 .. @sizeOf(usize) + size], 0, 0);
}
