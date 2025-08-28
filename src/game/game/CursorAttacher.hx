package game.game;

import h2d.Object;
import h2d.Bitmap;
import h2d.Tile;

class CursorAttacher extends BaseAttacher {
    public var tile: Bitmap;

    public function new(?g, ?layer) {
        super(g, layer);

        // tile = new Bitmap(Tile.fromColor(0xFF0000, 2, 2), parent);
        // tile.x = -1;
        // tile.y = -2;
        tile = new Bitmap(hxd.Res.cursorfiber.toTile(), parent);
        tile.x = -3.5;
        tile.y = 0;
        tile.scaleY = -2 / tile.tile.height;
    }

    override function postUpdate() {
        lookAt(game.selected, game.cursor);
        super.postUpdate();
    }
}