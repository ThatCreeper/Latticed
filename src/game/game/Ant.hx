package game.game;

import h2d.Tile;
import h2d.Bitmap;

class Ant extends MGEntity {
    public var harvested = false;

    public function new(x, y, ?g, ?l) {
        super(g, l);

        this.x = x;
        this.y = y;

        var bmp = new Bitmap(Tile.fromColor(0xFFFF00), spr);
        bmp.scaleX = 32;
        bmp.scaleY = 32;
        bmp.x = -16;
        bmp.y = -32;
    }

    override function update() {
        super.update();

        spr.alpha = harvested ? 0.5 : 1.0;
    }

    public function overlapsXY(x, y) {
        return M.pointRectOverlap(x, y, this.x - 16, this.y - 32, this.x + 16, this.y);
    }
}