package game.game;

import h2d.Tile;
import h2d.Bitmap;

class AntAttacher extends BaseAttacher {
    public var from: NodeEntity;
    public var to: Ant;

    public function new(from, to, ?g, ?l) {
        super(g, l);

        this.from = from;
        this.to = to;

        var tile = new Bitmap(Tile.fromColor(0xFF00FF, 2, 2), parent);
        tile.x = -1;
        tile.y = -2;

        lookAt(from, to);
    }

    override function update() {
        super.update();
        lookAt(from, to);
    }

    override function onDispose() {
        super.onDispose();
        
        from.connections.remove(this);
        to.harvested = false;
    }
}