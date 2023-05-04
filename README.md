# RAYZ

[Raylib](https://www.raylib.com) bindings for zig.

I started this because the existing binding libraries 
[raylib.zig](https://github.com/ryupold/raylib.zig) and 
[raylib-zig](https://github.com/Not-Nik/raylib-zig) are not idiomatic enough for my taste.

The raw c api is exported (in the `c` namespace) through zig's excellent c interop and automatic 
c header file inclusion. This means everything that can be done with the c library should be 
possible with this zig library. I am going through the 
[examples](https://www.raylib.com/examples.html) and adding ziggified bindings when needed for the
example.

## Usage

I have not yet implemented this as an official zig package through the new zig package manager, 
because it is not stable yet, and I don't want to figure out how it works before it is stable.
For now you can use these bindings the old fashioned way: clone this repo in a libs folder in
your project's root.

In your build.zig add the following:
```zig
const raylib = @import("libs/rayz/build.zig");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        // exe options
    });
    // Setup executable

    raylib.link("raylib", b, exe);
}
```

In the `link` function, you can change the name to whatever you want.

In your project source, you can than use the bindings with `@import`:
```zig
const rl = @import("raylib");

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.window.init(screen_width, screen_height, "raylib [core] example - basic window", .{});
    defer rl.window.close();

    rl.setTargetFps(60);

    while (!rl.window.shouldClose()) {
        rl.draw.begin();
        defer rl.draw.end();

        rl.draw.clearBackground(rl.Color.RAYWHITE);
        rl.draw.text(
            "Congrats! You created your first window!",
            .{ .position = .{ .x = 190, .y = 200 }, .font_size = 20, .color = rl.Color.LIGHTGRAY },
        );
    }
}
```

I try to document every function and struct with the raylib's original documentation. Because i 
use more zig-like naming conventions, I also try to add the original raylib function name in each 
functions documentation.

## Examples

Look in the examples folder for all the examples implemented so far. I am going through 
[the official raylib examples](https://www.raylib.com/examples.html) on my own pace. I leave in 
both the c api as the ziggified bindings as a comparison. Even the raw c bindings are often more 
ergonomic than the c implementation, once again showing 'zig is a better c than c'.
