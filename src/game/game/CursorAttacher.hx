package game.game;

import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;

class CursorAttacher extends BaseAttacher {
    var tile: Bitmap;

    public function new(?g, ?layer) {
        super(g);

        tile = new Bitmap(Tile.fromColor(0xFF0000, 2, 2), parent);
        tile.x = -1;
        tile.y = -2;
    }

    override function postUpdate() {
        lookAt(game.selected, game.cursor);
        super.postUpdate();
    }
}