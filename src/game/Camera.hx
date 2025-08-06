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

    public var shakeIntensity = 2.0;

    public function new() {
        
    }

    public function update(s: h2d.Scene, shaking: Bool) {
        rx = M.lerpC(rx, sx, 0.2 * tmod);
        ry = M.lerpC(ry, sy, 0.2 * tmod);
        rscale = M.lerpC(rscale, sscale, 0.2 * tmod);
        
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
            c.x += (Math.random() - 0.5) * 2 * shakeIntensity / scale;
            c.y += (Math.random() - 0.5) * 2 * shakeIntensity / scale;
        }
    }

    // TODO: Camera -> World, vice versa.
}