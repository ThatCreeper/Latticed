package game;

import haxe.macro.Context;
import haxe.macro.Expr.Field;
import hxd.Pad;

class PadButtons {
    public static var cross(get, never): Int;
        static function get_cross() {
            return Pad.DEFAULT_CONFIG.A;
        }
    public static var circle(get, never): Int;
        static function get_circle() {
            return Pad.DEFAULT_CONFIG.B;
        }
    public static var triangle(get, never): Int;
        static function get_triangle() {
            return Pad.DEFAULT_CONFIG.Y;
        }
    public static var square(get, never): Int;
        static function get_square() {
            return Pad.DEFAULT_CONFIG.X;
        }
    public static var l1(get, never): Int;
        static function get_l1() {
            return Pad.DEFAULT_CONFIG.LT;
        }
    public static var l2(get, never): Int;
        static function get_l2() {
            return Pad.DEFAULT_CONFIG.LB;
        }
    public static var r1(get, never): Int;
        static function get_r1() {
            return Pad.DEFAULT_CONFIG.RT;
        }
    public static var r2(get, never): Int;
        static function get_r2() {
            return Pad.DEFAULT_CONFIG.RB;
        }
    public static var l3(get, never): Int;
        static function get_l3() {
            return Pad.DEFAULT_CONFIG.analogClick;
        }
    public static var r3(get, never): Int;
        static function get_r3() {
            return Pad.DEFAULT_CONFIG.ranalogClick;
        }
    public static var laxis_x(get, never): Int;
        static function get_laxis_x() {
            return Pad.DEFAULT_CONFIG.analogX;
        }
    public static var raxis_x(get, never): Int;
        static function get_raxis_x() {
            return Pad.DEFAULT_CONFIG.ranalogX;
        }
    public static var laxis_y(get, never): Int;
        static function get_laxis_y() {
            return Pad.DEFAULT_CONFIG.analogY;
        }
    public static var raxis_y(get, never): Int;
        static function get_raxis_y() {
            return Pad.DEFAULT_CONFIG.ranalogY;
        }
    public static var up(get, never): Int;
        static function get_up() {
            return Pad.DEFAULT_CONFIG.dpadUp;
        }
    public static var down(get, never): Int;
        static function get_down() {
            return Pad.DEFAULT_CONFIG.dpadDown;
        }
    public static var left(get, never): Int;
        static function get_left() {
            return Pad.DEFAULT_CONFIG.dpadLeft;
        }
    public static var right(get, never): Int;
        static function get_right() {
            return Pad.DEFAULT_CONFIG.dpadRight;
        }
    public static var share(get, never): Int;
        static function get_share() {
            return Pad.DEFAULT_CONFIG.back; // todo: this might be wrong
        }
    public static var options(get, never): Int;
        static function get_options() {
            return Pad.DEFAULT_CONFIG.start;
        }
}