package engine;

import hxd.Pad;
import hxd.Timer;

class TimeAware {
    public var tmod(get, never): Float;
        function get_tmod() {
            return GameEngine.tmod;
        }
    public var utmod(get, never): Float;
        function get_utmod() {
            return GameEngine.utmod;
        }
    public var gameSpeed(get, set): Float;
        function get_gameSpeed() {
            return GameEngine.GameSpeed;
        }
        function set_gameSpeed(v) {
            return GameEngine.UserGameSpeed = v;
        }
    public var deltaTime(get, never): Float;
        function get_deltaTime() {
            return Timer.dt;
        }
    public var pad(get, never): Null<Pad>;
        function get_pad() {
            return GameEngine.pad;
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