package game;

class Camera extends TimeAware {
    public var x(get, set): Float;
        function get_x() {
            return rx;
        }
        function set_x(v) {
            return rx = sx = v;
        }
    public var y(get, set): Float;
        function get_y() {
            return ry;
        }
        function set_y(v) {
            return ry = sy = v;
        }
    public var sx = 0.0;
    public var sy = 0.0;
    public var scale(get, set): Float;
        function get_scale() {
            return rscale;
        }
        function set_scale(v) {
            return rscale = sscale = v;
        }
    public var sscale = 1.0;
    public var centered = true;
    var rx: Float = 0;
    var ry: Float = 0;
    var rscale = 1.0;

    public function new() {
        
    }

    public function update(s: h2d.Scene, shaking: Bool) {
        rx = M.lerp(rx, sx, 0.2 * tmod);
        ry = M.lerp(ry, sy, 0.2 * tmod);
        rscale = M.lerp(rscale, sscale, 0.2 * tmod);
        
        var c = s.camera;
        if (centered) {
            c.anchorX = 0.5;
            c.anchorY = 0.5;
        } else {
            c.anchorX = 0;
            c.anchorY = 0;
        }
        c.scaleX = rscale;
        c.scaleY = rscale;
        c.x = rx;
        c.y = ry;

        if (shaking) {
            c.x += (Math.random() - 0.5) * 2 * 2 / scale;
            c.y += (Math.random() - 0.5) * 2 * 2 / scale;
        }
    }

    public function screenToWorldX(screen) {
        var scrWid = Main.INST.game.s2d.width;
        var centerRelScreen = screen - scrWid / 2.0;
        var centerRelZoomed = centerRelScreen / rscale;
        var centerMoved = centerRelZoomed + rx;
        var world = centerMoved + (scrWid / 2.0) / rscale;
        return world;
    }

    // TODO: Function assumes centered = true. Also it probably doesn't work.
    public function screenToWorldY(screen) {
        var scrHei = Main.INST.game.s2d.height;
        var centerRelScreen = screen - scrHei / 2.0;
        var centerRelZoomed = centerRelScreen / rscale;
        var centerMoved = centerRelZoomed + ry;
        var world = centerMoved + (scrHei / 2.0) / rscale;
        return world;
    }
}