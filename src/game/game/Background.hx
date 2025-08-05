package game.game;

import h2d.Tile;
import h2d.Bitmap;

class Background extends MGEntity {
    public function new(g, l) {
        super(g, l);
        var bmp = new Bitmap(Tile.fromColor(0x0000AA), spr);
        bmp.x = - 50000;
        bmp.y = -100000;
        bmp.scaleX = bmp.scaleY = 100000;
    }
}