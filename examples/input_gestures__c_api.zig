const rl = @import("raylib").c.raylib;
const Gesture = @import("raylib").input.Gesture;

const max_gesture_strings = 20;

pub fn main() void {
    const screen_width = 800;
    const screen_height = 450;

    rl.InitWindow(screen_width, screen_height, "raylib [core] example - input gestures");
    defer rl.CloseWindow();

    var touch_position = rl.Vector2{ .x = 0, .y = 0 };
    const touch_area = rl.Rectangle{
        .x = 220,
        .y = 10,
        .width = screen_width - 230,
        .height = screen_height - 20,
    };

    var gestures_count: usize = 0;
    var gesture_strings: [max_gesture_strings][32]u8 = undefined;

    var current_gesture = @enumToInt(Gesture.none);
    var previous_gesture = @enumToInt(Gesture.none);

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        { // update
            previous_gesture = current_gesture;
            current_gesture = rl.GetGestureDetected();
            touch_position = rl.GetTouchPosition(0);

            if (rl.CheckCollisionPointRec(touch_position, touch_area) and current_gesture != @enumToInt(Gesture.none)) {
                if (current_gesture != previous_gesture) {
                    switch (current_gesture) {
                        @enumToInt(Gesture.tap) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE TAP");
                        },
                        @enumToInt(Gesture.doubletap) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE DOUBLETAP");
                        },
                        @enumToInt(Gesture.hold) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE HOLD");
                        },
                        @enumToInt(Gesture.drag) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE DRAG");
                        },
                        @enumToInt(Gesture.swipe_right) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE RIGHT");
                        },
                        @enumToInt(Gesture.swipe_left) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE LEFT");
                        },
                        @enumToInt(Gesture.swipe_up) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE UP");
                        },
                        @enumToInt(Gesture.swipe_down) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE SWIPE DOWN");
                        },
                        @enumToInt(Gesture.pinch_in) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE PINCH IN");
                        },
                        @enumToInt(Gesture.pinch_out) => {
                            _ = rl.TextCopy(&gesture_strings[gestures_count], "GESTURE PINCH OUT");
                        },
                        else => {},
                    }
                    gestures_count += 1;

                    if (gestures_count >= max_gesture_strings) {
                        for (0..max_gesture_strings) |i| {
                            _ = rl.TextCopy(&gesture_strings[i], &[_]u8{0});
                        }
                        gestures_count = 0;
                    }
                }
            }
        }
        { // draw
            rl.BeginDrawing();
            defer rl.EndDrawing();

            rl.ClearBackground(rl.RAYWHITE);

            rl.DrawRectangleRec(touch_area, rl.GRAY);
            rl.DrawRectangle(225, 15, screen_width - 240, screen_height - 30, rl.RAYWHITE);

            rl.DrawText("GESTURES TEST AREA", screen_width - 270, screen_height - 40, 20, rl.Fade(rl.GRAY, 0.5));

            for (0..gestures_count) |i| {
                if (i % 2 == 0)
                    rl.DrawRectangle(10, 30 + 20 * @intCast(c_int, i), 200, 20, rl.Fade(rl.LIGHTGRAY, 0.5))
                else
                    rl.DrawRectangle(10, 30 + 20 * @intCast(c_int, i), 200, 20, rl.Fade(rl.LIGHTGRAY, 0.3));

                if (i < gestures_count - 1)
                    rl.DrawText(&gesture_strings[i], 35, 36 + 20 * @intCast(c_int, i), 10, rl.DARKGRAY)
                else
                    rl.DrawText(&gesture_strings[i], 35, 36 + 20 * @intCast(c_int, i), 10, rl.MAROON);
            }

            rl.DrawRectangleLines(10, 29, 200, screen_height - 50, rl.GRAY);
            rl.DrawText("DETECTED GESTURES", 50, 15, 10, rl.GRAY);

            if (current_gesture != @enumToInt(Gesture.none)) rl.DrawCircleV(touch_position, 30, rl.MAROON);
        }
    }
}
