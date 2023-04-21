const lib = @import("lib.zig");

pub const KeyboardKey = enum(i32) {
    /// Key: NULL, used for no key pressed
    none = 0,
    // Alphanumeric keys
    /// Key: '
    apostrophe = 39,
    /// Key: ,
    comma = 44,
    /// Key: -
    minus = 45,
    /// Key: .
    period = 46,
    /// Key: /
    slash = 47,
    /// Key: 0
    zero = 48,
    /// Key: 1
    one = 49,
    /// Key: 2
    two = 50,
    /// Key: 3
    three = 51,
    /// Key: 4
    four = 52,
    /// Key: 5
    five = 53,
    /// Key: 6
    six = 54,
    /// Key: 7
    seven = 55,
    /// Key: 8
    eight = 56,
    /// Key: 9
    nine = 57,
    /// Key: ;
    semicolon = 59,
    /// Key: =
    equal = 61,
    /// Key: A | a
    a = 65,
    /// Key: B | b
    b = 66,
    /// Key: C | c
    c = 67,
    /// Key: D | d
    d = 68,
    /// Key: E | e
    e = 69,
    /// Key: F | f
    f = 70,
    /// Key: G | g
    g = 71,
    /// Key: H | h
    h = 72,
    /// Key: I | i
    i = 73,
    /// Key: J | j
    j = 74,
    /// Key: K | k
    k = 75,
    /// Key: L | l
    l = 76,
    /// Key: M | m
    m = 77,
    /// Key: N | n
    n = 78,
    /// Key: O | o
    o = 79,
    /// Key: P | p
    p = 80,
    /// Key: Q | q
    q = 81,
    /// Key: R | r
    r = 82,
    /// Key: S | s
    s = 83,
    /// Key: T | t
    t = 84,
    /// Key: U | u
    u = 85,
    /// Key: V | v
    v = 86,
    /// Key: W | w
    w = 87,
    /// Key: X | x
    x = 88,
    /// Key: Y | y
    y = 89,
    /// Key: Z | z
    z = 90,
    /// Key: [
    left_bracket = 91,
    /// Key: '\'
    backslash = 92,
    /// Key: ]
    right_bracket = 93,
    /// Key: `
    grave = 96,
    // Function keys
    /// Key: Space
    space = 32,
    /// Key: Esc
    escape = 256,
    /// Key: Enter
    enter = 257,
    /// Key: Tab
    tab = 258,
    /// Key: Backspace
    backspace = 259,
    /// Key: Ins
    insert = 260,
    /// Key: Del
    delete = 261,
    /// Key: Cursor right
    right = 262,
    /// Key: Cursor left
    left = 263,
    /// Key: Cursor down
    down = 264,
    /// Key: Cursor up
    up = 265,
    /// Key: Page up
    page_up = 266,
    /// Key: Page down
    page_down = 267,
    /// Key: Home
    home = 268,
    /// Key: End
    end = 269,
    /// Key: Caps lock
    caps_lock = 280,
    /// Key: Scroll down
    scroll_lock = 281,
    /// Key: Num lock
    num_lock = 282,
    /// Key: Print screen
    print_screen = 283,
    /// Key: Pause
    pause = 284,
    /// Key: F1
    f1 = 290,
    /// Key: F2
    f2 = 291,
    /// Key: F3
    f3 = 292,
    /// Key: F4
    f4 = 293,
    /// Key: F5
    f5 = 294,
    /// Key: F6
    f6 = 295,
    /// Key: F7
    f7 = 296,
    /// Key: F8
    f8 = 297,
    /// Key: F9
    f9 = 298,
    /// Key: F10
    f10 = 299,
    /// Key: F11
    f11 = 300,
    /// Key: F12
    f12 = 301,
    /// Key: Shift left
    left_shift = 340,
    /// Key: Control left
    left_control = 341,
    /// Key: Alt left
    left_alt = 342,
    /// Key: Super left
    left_super = 343,
    /// Key: Shift right
    right_shift = 344,
    /// Key: Control right
    right_control = 345,
    /// Key: Alt right
    right_alt = 346,
    /// Key: Super right
    right_super = 347,
    /// Key: KB menu
    kb_menu = 348,
    // Keypad keys
    /// Key: Keypad 0
    kp_0 = 320,
    /// Key: Keypad 1
    kp_1 = 321,
    /// Key: Keypad 2
    kp_2 = 322,
    /// Key: Keypad 3
    kp_3 = 323,
    /// Key: Keypad 4
    kp_4 = 324,
    /// Key: Keypad 5
    kp_5 = 325,
    /// Key: Keypad 6
    kp_6 = 326,
    /// Key: Keypad 7
    kp_7 = 327,
    /// Key: Keypad 8
    kp_8 = 328,
    /// Key: Keypad 9
    kp_9 = 329,
    /// Key: Keypad .
    kp_decimal = 330,
    /// Key: Keypad /
    kp_divide = 331,
    /// Key: Keypad *
    kp_multiply = 332,
    /// Key: Keypad -
    kp_subtract = 333,
    /// Key: Keypad +
    kp_add = 334,
    /// Key: Keypad Enter
    kp_enter = 335,
    /// Key: Keypad =
    kp_equal = 336,
    // // Android key buttons
    // /// Key: Android back button
    // back = 4,
    // /// Key: Android menu button
    // menu = 82,
    // /// Key: Android volume up button
    // volume_up = 24,
    // /// Key: Android volume down button
    // volume_down = 25,
};

pub fn isKeyDown(key: KeyboardKey) bool {
    return lib.c.raylib.core.IsKeyDown(@enumToInt(key));
}
