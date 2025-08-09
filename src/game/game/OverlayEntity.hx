package game.game;

import hxd.Key;
import h2d.Bitmap;

class OverlayEntity extends MGEntity {
    var removeFrame = false;
    
    public function new(i, s, ?g) {
        super(g, (g ?? Main.INST.game).hudLayer);

        var bm = new Bitmap(i, spr);
        scale = s;
    }

    override function update() {
        super.update();

        if (removeFrame)
            remove();

        if (Key.isPressed(Key.ESCAPE))
            removeFrame = true;
    }
}