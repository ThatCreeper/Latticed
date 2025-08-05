package game.game;

import h2d.Text;

class Toast extends MGEntity {
    public var vy: Float;

    public function new(x, y, vy, text, color, ?g, ?l) {
        super(g, l ?? (g ?? Main.INST.game).worldlyHudLayer);

        var txt = new Text(hxd.res.DefaultFont.get(), spr);
        txt.textColor = color;
        txt.dropShadow = {
            dx: 0,
            dy: 1,
            alpha: 1,
            color: 0x000000
        };
        txt.text = text;
        txt.x = -txt.textWidth / 2;
        txt.y = -txt.textHeight / 2;

        pixelRounding = false;
        this.x = Math.floor(x);
        this.y = Math.floor(y);
        this.vy = vy;
    }

    override function update() {
        super.update();
        
        var mod = deltaTime / 1.0;
        y += mod * vy;
        scale = 3.0 / camera.scale;
        spr.alpha -= mod;
        if (spr.alpha <= 0) {
            remove();
        }
    }
}