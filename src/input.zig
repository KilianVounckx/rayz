const std = @import("std");

const lib = @import("lib.zig");
const Vector2 = lib.Vector2;

/// Keyboard keys (US keyboard layout)
pub const KeyboardKey = enum(u16) {
    /// Key: NULL, used for no key pressed
    null = lib.c.KEY_NULL,
    // Alphanumeric keys
    /// Key: '
    apostrophe = lib.c.KEY_APOSTROPHE,
    /// Key: ,
    comma = lib.c.KEY_COMMA,
    /// Key: -
    minus = lib.c.KEY_MINUS,
    /// Key: .
    period = lib.c.KEY_PERIOD,
    /// Key: /
    slash = lib.c.KEY_SLASH,
    /// Key: 0
    zero = lib.c.KEY_ZERO,
    /// Key: 1
    one = lib.c.KEY_ONE,
    /// Key: 2
    two = lib.c.KEY_TWO,
    /// Key: 3
    three = lib.c.KEY_THREE,
    /// Key: 4
    four = lib.c.KEY_FOUR,
    /// Key: 5
    five = lib.c.KEY_FIVE,
    /// Key: 6
    six = lib.c.KEY_SIX,
    /// Key: 7
    seven = lib.c.KEY_SEVEN,
    /// Key: 8
    eight = lib.c.KEY_EIGHT,
    /// Key: 9
    nine = lib.c.KEY_NINE,
    /// Key: ;
    semicolon = lib.c.KEY_SEMICOLON,
    /// Key: =
    equal = lib.c.KEY_EQUAL,
    /// Key: A | a
    a = lib.c.KEY_A,
    /// Key: B | b
    b = lib.c.KEY_B,
    /// Key: C | c
    c = lib.c.KEY_C,
    /// Key: D | d
    d = lib.c.KEY_D,
    /// Key: E | e
    e = lib.c.KEY_E,
    /// Key: F | f
    f = lib.c.KEY_F,
    /// Key: G | g
    g = lib.c.KEY_G,
    /// Key: H | h
    h = lib.c.KEY_H,
    /// Key: I | i
    i = lib.c.KEY_I,
    /// Key: J | j
    j = lib.c.KEY_J,
    /// Key: K | k
    k = lib.c.KEY_K,
    /// Key: L | l
    l = lib.c.KEY_L,
    /// Key: M | m
    m = lib.c.KEY_M,
    /// Key: N | n
    n = lib.c.KEY_N,
    /// Key: O | o
    o = lib.c.KEY_O,
    /// Key: P | p
    p = lib.c.KEY_P,
    /// Key: Q | q
    q = lib.c.KEY_Q,
    /// Key: R | r
    r = lib.c.KEY_R,
    /// Key: S | s
    s = lib.c.KEY_S,
    /// Key: T | t
    t = lib.c.KEY_T,
    /// Key: U | u
    u = lib.c.KEY_U,
    /// Key: V | v
    v = lib.c.KEY_V,
    /// Key: W | w
    w = lib.c.KEY_W,
    /// Key: X | x
    x = lib.c.KEY_X,
    /// Key: Y | y
    y = lib.c.KEY_Y,
    /// Key: Z | z
    z = lib.c.KEY_Z,
    /// Key: [
    left_bracket = lib.c.KEY_LEFT_BRACKET,
    /// Key: '\'
    backslash = lib.c.KEY_BACKSLASH,
    /// Key: ]
    right_bracket = lib.c.KEY_RIGHT_BRACKET,
    /// Key: `
    grave = lib.c.KEY_GRAVE,
    // Function keys
    /// Key: Space
    space = lib.c.KEY_SPACE,
    /// Key: Esc
    escape = lib.c.KEY_ESCAPE,
    /// Key: Enter
    enter = lib.c.KEY_ENTER,
    /// Key: Tab
    tab = lib.c.KEY_TAB,
    /// Key: Backspace
    backspace = lib.c.KEY_BACKSPACE,
    /// Key: Ins
    insert = lib.c.KEY_INSERT,
    /// Key: Del
    delete = lib.c.KEY_DELETE,
    /// Key: Cursor right
    right = lib.c.KEY_RIGHT,
    /// Key: Cursor left
    left = lib.c.KEY_LEFT,
    /// Key: Cursor down
    down = lib.c.KEY_DOWN,
    /// Key: Cursor up
    up = lib.c.KEY_UP,
    /// Key: Page up
    page_up = lib.c.KEY_PAGE_UP,
    /// Key: Page down
    page_down = lib.c.KEY_PAGE_DOWN,
    /// Key: Home
    home = lib.c.KEY_HOME,
    /// Key: End
    end = lib.c.KEY_END,
    /// Key: Caps lock
    caps_lock = lib.c.KEY_CAPS_LOCK,
    /// Key: Scroll down
    scroll_lock = lib.c.KEY_SCROLL_LOCK,
    /// Key: Num lock
    num_lock = lib.c.KEY_NUM_LOCK,
    /// Key: Print screen
    print_screen = lib.c.KEY_PRINT_SCREEN,
    /// Key: Pause
    pause = lib.c.KEY_PAUSE,
    /// Key: F1
    f1 = lib.c.KEY_F1,
    /// Key: F2
    f2 = lib.c.KEY_F2,
    /// Key: F3
    f3 = lib.c.KEY_F3,
    /// Key: F4
    f4 = lib.c.KEY_F4,
    /// Key: F5
    f5 = lib.c.KEY_F5,
    /// Key: F6
    f6 = lib.c.KEY_F6,
    /// Key: F7
    f7 = lib.c.KEY_F7,
    /// Key: F8
    f8 = lib.c.KEY_F8,
    /// Key: F9
    f9 = lib.c.KEY_F9,
    /// Key: F10
    f10 = lib.c.KEY_F10,
    /// Key: F11
    f11 = lib.c.KEY_F11,
    /// Key: F12
    f12 = lib.c.KEY_F12,
    /// Key: Shift left
    left_shift = lib.c.KEY_LEFT_SHIFT,
    /// Key: Control left
    left_control = lib.c.KEY_LEFT_CONTROL,
    /// Key: Alt left
    left_alt = lib.c.KEY_LEFT_ALT,
    /// Key: Super left
    left_super = lib.c.KEY_LEFT_SUPER,
    /// Key: Shift right
    right_shift = lib.c.KEY_RIGHT_SHIFT,
    /// Key: Control right
    right_control = lib.c.KEY_RIGHT_CONTROL,
    /// Key: Alt right
    right_alt = lib.c.KEY_RIGHT_ALT,
    /// Key: Super right
    right_super = lib.c.KEY_RIGHT_SUPER,
    /// Key: KB menu
    kb_menu = lib.c.KEY_KB_MENU,
    // Keypad keys
    /// Key: Keypad 0
    kp_0 = lib.c.KEY_KP_0,
    /// Key: Keypad 1
    kp_1 = lib.c.KEY_KP_1,
    /// Key: Keypad 2
    kp_2 = lib.c.KEY_KP_2,
    /// Key: Keypad 3
    kp_3 = lib.c.KEY_KP_3,
    /// Key: Keypad 4
    kp_4 = lib.c.KEY_KP_4,
    /// Key: Keypad 5
    kp_5 = lib.c.KEY_KP_5,
    /// Key: Keypad 6
    kp_6 = lib.c.KEY_KP_6,
    /// Key: Keypad 7
    kp_7 = lib.c.KEY_KP_7,
    /// Key: Keypad 8
    kp_8 = lib.c.KEY_KP_8,
    /// Key: Keypad 9
    kp_9 = lib.c.KEY_KP_9,
    /// Key: Keypad .
    kp_decimal = lib.c.KEY_KP_DECIMAL,
    /// Key: Keypad /
    kp_divide = lib.c.KEY_KP_DIVIDE,
    /// Key: Keypad *
    kp_multiply = lib.c.KEY_KP_MULTIPLY,
    /// Key: Keypad -
    kp_subtract = lib.c.KEY_KP_SUBTRACT,
    /// Key: Keypad +
    kp_add = lib.c.KEY_KP_ADD,
    /// Key: Keypad Enter
    kp_enter = lib.c.KEY_KP_ENTER,
    /// Key: Keypad =
    kp_equal = lib.c.KEY_KP_EQUAL,

    _,

    // Android key buttons
    /// Key: Android back button
    pub const back = @intToEnum(KeyboardKey, lib.c.KEY_BACK);
    /// Key: Android menu button
    pub const menu = @intToEnum(KeyboardKey, lib.c.KEY_MENU);
    /// Key: Android volume up button
    pub const volume_up = @intToEnum(KeyboardKey, lib.c.KEY_VOLUME_UP);
    /// Key: Android volume down button
    pub const volume_down = @intToEnum(KeyboardKey, lib.c.KEY_VOLUMN_DOWN);
};

// Set a custom key to exit program (default is ESC)
pub fn setExitKey(key: KeyboardKey) void {
    lib.c.SetExitKey(@enumToInt(key));
}

/// Check if a key is being pressed
pub fn isKeyDown(key: KeyboardKey) bool {
    return lib.c.IsKeyDown(@enumToInt(key));
}

/// Check if a key has been pressed once
pub fn isKeyPressed(key: KeyboardKey) bool {
    return lib.c.IsKeyPressed(@enumToInt(key));
}

/// Check if a key has been released once
pub fn isKeyReleased(key: KeyboardKey) bool {
    return lib.c.IsKeyReleased(@enumToInt(key));
}

/// Check if a key is NOT being pressed
pub fn isKeyUp(key: KeyboardKey) bool {
    return lib.c.IsKeyUp(@enumToInt(key));
}

/// Mouse buttons
pub const MouseButton = enum(i32) {
    /// Mouse button left
    left = lib.c.MOUSE_BUTTON_LEFT,
    /// Mouse button right
    right = lib.c.MOUSE_BUTTON_RIGHT,
    /// Mouse button middle (pressed wheel)
    middle = lib.c.MOUSE_BUTTON_MIDDLE,
    /// Mouse button side (advanced mouse device)
    side = lib.c.MOUSE_BUTTON_SIDE,
    /// Mouse button extra (advanced mouse device)
    extra = lib.c.MOUSE_BUTTON_EXTRA,
    /// Mouse button forward (advanced mouse device)
    forward = lib.c.MOUSE_BUTTON_FORWARD,
    /// Mouse button back (advanced mouse device)
    back = lib.c.MOUSE_BUTTON_BACK,
};

/// Get mouse position XY
pub fn getMousePosition() Vector2 {
    return Vector2.fromCStruct(lib.c.GetMousePosition());
}

/// Check if a mouse button has been pressed once
pub fn isMouseButtonPressed(button: MouseButton) bool {
    return lib.c.IsMouseButtonPressed(@enumToInt(button));
}

/// Check if a mouse button is being pressed
pub fn isMouseButtonDown(button: MouseButton) bool {
    return lib.c.IsMouseButtonDown(@enumToInt(button));
}

/// Get mouse wheel movement for X or Y, whichever is larger
pub fn getMouseWheelMove() f32 {
    return lib.c.GetMouseWheelMove();
}

/// Get mouse delta between frames
pub fn getMouseDelta() Vector2 {
    return Vector2.fromCStruct(lib.c.GetMouseDelta());
}

/// Gesture bit flags
pub const GestureFlags = blk: {
    var fields: []const std.builtin.Type.StructField = &[_]std.builtin.Type.StructField{};
    const default_field = false;
    for (std.meta.fields(Gesture)[1..]) |field| { // Ignore none
        fields = fields ++ &[_]std.builtin.Type.StructField{.{
            .name = field.name,
            .type = bool,
            .default_value = &default_field,
            .is_comptime = false,
            .alignment = 0,
        }};
    }

    const Pad = @Type(.{ .Int = .{
        .signedness = .unsigned,
        .bits = @typeInfo(@typeInfo(Gesture).Enum.tag_type).Int.bits - (std.meta.fields(Gesture).len - 1),
    } });
    const default_pad = 0;

    fields = fields ++ &[_]std.builtin.Type.StructField{.{
        .name = "_",
        .type = Pad,
        .default_value = &default_pad,
        .is_comptime = false,
        .alignment = 0,
    }};

    break :blk @Type(.{ .Struct = .{
        .layout = .Packed,
        .backing_integer = @typeInfo(Gesture).Enum.tag_type,
        .fields = fields,
        .decls = &.{},
        .is_tuple = false,
    } });
};

/// Gesture
pub const Gesture = enum(u16) {
    /// No gesture
    none = lib.c.GESTURE_NONE,
    /// Tap gesture
    tap = lib.c.GESTURE_TAP,
    /// Double tap gesture
    doubletap = lib.c.GESTURE_DOUBLETAP,
    /// Hold gesture
    hold = lib.c.GESTURE_HOLD,
    /// Drag gesture
    drag = lib.c.GESTURE_DRAG,
    /// Swipe right gesture
    swipe_right = lib.c.GESTURE_SWIPE_RIGHT,
    /// Swipe left gesture
    swipe_left = lib.c.GESTURE_SWIPE_LEFT,
    /// Swipe up gesture
    swipe_up = lib.c.GESTURE_SWIPE_UP,
    /// Swipe down gesture
    swipe_down = lib.c.GESTURE_SWIPE_DOWN,
    /// Pinch in gesture
    pinch_in = lib.c.GESTURE_PINCH_IN,
    /// Pinch out gesture
    pinch_out = lib.c.GESTURE_PINCH_OUT,
};

/// Enable a set of gestures using flags
pub fn setGesturesEnabled(flags: GestureFlags) void {
    lib.c.SetGesturesEnabled(@bitCast(u16, flags));
}

/// Get latest detected gesture
pub fn getGestureDetected() Gesture {
    return @intToEnum(Gesture, @intCast(u16, lib.c.GetGestureDetected()));
}

/// Get touch position XY for a touch point index (relative to screen size)
pub fn getTouchPosition(index: i32) Vector2 {
    return Vector2.fromCStruct(lib.c.GetTouchPosition(index));
}
