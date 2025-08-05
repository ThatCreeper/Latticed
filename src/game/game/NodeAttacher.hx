package game.game;

import h2d.Tile;
import h2d.Bitmap;

class NodeAttacher extends BaseAttacher {
    public var from: NodeEntity;
    public var to: NodeEntity;
    var tile: Bitmap;
    
    public function new(from, to, ?g, ?layer) {
        super(g, layer);
        this.from = from;
        this.to = to;

        tile = new Bitmap(Tile.fromColor(0xFF00FF, 2, 2), parent);
        tile.x = -1;
        tile.y = -2;
        
        lookAt(from, to);
    }

    override function onDispose() {
        super.onDispose();
        from.connections.remove(this);
        to.connections.remove(this);
    }
}