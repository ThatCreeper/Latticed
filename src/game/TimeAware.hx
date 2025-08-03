package game;

import hxd.Pad;
import hxd.Timer;

class TimeAware {
    public var tmod(get, never): Float;
        function get_tmod() {
            return Main.tmod;
        }
    public var utmod(get, never): Float;
        function get_utmod() {
            return Main.utmod;
        }
    public var gameSpeed(get, set): Float;
        function get_gameSpeed() {
            return Main.GameSpeed;
        }
        function set_gameSpeed(v) {
            return Main.UserGameSpeed = v;
        }
    public var deltaTime(get, never): Float;
        function get_deltaTime() {
            return Timer.dt;
        }
    public var pad(get, never): Null<Pad>;
        function get_pad() {
            return Main.pad;
        }
    
    public var cd = new Cooldown();
    public var ucd = new Cooldown();

    function updateCooldowns() {
        cd.update(deltaTime, gameSpeed);
        ucd.update(deltaTime, 1);
    }

    function padDown(x) {
        return pad?.isDown(x) ?? false;
    }

    function padPressed(x) {
        return pad?.isPressed(x) ?? false;
    }

    function padReleased(x) {
        return pad?.isReleased(x) ?? false;
    }
}