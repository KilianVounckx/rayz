const rl = @import("raylib").c.raylib;
const Gesture = @import("raylib").input.Gesture;

const max_gesture_strings = 20;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.core.InitWindow(screen_width, screen_height, "raylib [core] example - input gestures");
    defer rl.core.CloseWindow();

    var touch_position = rl.structs.Vector2{ .x = 0, .y = 0 };
    const touch_area = rl.structs.Rectangle{
        .x = 220,
        .y = 10,
        .width = screen_width - 230,
        .height = screen_height - 20,
    };

    var gestures_count: usize = 0;
    var gesture_strings: [max_gesture_strings][32]u8 = undefined;

    var current_gesture = @enumToInt(Gesture.none);
    var previous_gesture = @enumToInt(Gesture.none);

    rl.core.SetTargetFPS(60);

    while (!rl.core.WindowShouldClose()) {
        { // update
            previous_gesture = current_gesture;
            current_gesture = rl.core.GetGestureDetected();
            touch_position = rl.core.GetTouchPosition(0);

            if (rl.shapes.CheckCollisionPointRec(touch_position, touch_area) and current_gesture != @enumToInt(Gesture.none)) {
                if (current_gesture != previous_gesture) {
                    switch (current_gesture) {
                        @enumToInt(Gesture.tap) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE TAP");
                        },
                        @enumToInt(Gesture.doubletap) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE DOUBLETAP");
                        },
                        @enumToInt(Gesture.hold) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE HOLD");
                        },
                        @enumToInt(Gesture.drag) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE DRAG");
                        },
                        @enumToInt(Gesture.swipe_right) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE RIGHT");
                        },
                        @enumToInt(Gesture.swipe_left) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE LEFT");
                        },
                        @enumToInt(Gesture.swipe_up) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE UP");
                        },
                        @enumToInt(Gesture.swipe_down) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE DOWN");
                        },
                        @enumToInt(Gesture.pinch_in) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE PINCH IN");
                        },
                        @enumToInt(Gesture.pinch_out) => {
                            _ = rl.text.TextCopy(&gesture_strings[gestures_count], "GESTURE PINCH OUT");
                        },
                        else => {},
                    }
                    gestures_count += 1;

                    if (gestures_count >= max_gesture_strings) {
                        for (0..max_gesture_strings) |i| {
                            _ = rl.text.TextCopy(&gesture_strings[i], &[_]u8{0});
                        }
                        gestures_count = 0;
                    }
                }
            }
        }
        { // draw
            rl.core.BeginDrawing();
            defer rl.core.EndDrawing();

            rl.core.ClearBackground(rl.colors.RAYWHITE);

            rl.shapes.DrawRectangleRec(touch_area, rl.colors.GRAY);
            rl.shapes.DrawRectangle(225, 15, screen_width - 240, screen_height - 30, rl.colors.RAYWHITE);

            rl.text.DrawText("GESTURES TEST AREA", screen_width - 270, screen_height - 40, 20, rl.textures.Fade(rl.colors.GRAY, 0.5));

            for (0..gestures_count) |i| {
                if (i % 2 == 0)
                    rl.shapes.DrawRectangle(10, 30 + 20 * @intCast(c_int, i), 200, 20, rl.textures.Fade(rl.colors.LIGHTGRAY, 0.5))
                else
                    rl.shapes.DrawRectangle(10, 30 + 20 * @intCast(c_int, i), 200, 20, rl.textures.Fade(rl.colors.LIGHTGRAY, 0.3));

                if (i < gestures_count - 1)
                    rl.text.DrawText(&gesture_strings[i], 35, 36 + 20 * @intCast(c_int, i), 10, rl.colors.DARKGRAY)
                else
                    rl.text.DrawText(&gesture_strings[i], 35, 36 + 20 * @intCast(c_int, i), 10, rl.colors.MAROON);
            }

            rl.shapes.DrawRectangleLines(10, 29, 200, screen_height - 50, rl.colors.GRAY);
            rl.text.DrawText("DETECTED GESTURES", 50, 15, 10, rl.colors.GRAY);

            if (current_gesture != @enumToInt(Gesture.none)) rl.shapes.DrawCircleV(touch_position, 30, rl.colors.MAROON);
        }
    }
}
