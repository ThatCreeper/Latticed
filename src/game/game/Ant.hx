package game.game;

import h2d.Tile;
import h2d.Bitmap;

class Ant extends MGEntity {
    public var harvester:Null<NodeEntity> = null;
    public var lastX: Float;
    public var lastY: Float;

    public function new(x, y, ?g, ?l) {
        super(g, l);

        this.x = lastX = x;
        this.y = lastY = y;

        var bmp = new Bitmap(Tile.fromColor(0xFFFF00), spr);
        bmp.scaleX = 32;
        bmp.scaleY = 32;
        bmp.x = -16;
        bmp.y = -32;
    }

    override function update() {
        super.update();

        spr.alpha = harvester == null ? 1.0 : 0.5;

        x += 5 * deltaTime;

        if (harvester != null) {
            harvester.x += x - lastX;
            harvester.y += y - lastY;
            harvester.updateConnections();
        }

        lastX = x;
        lastY = y;
    }

    public function overlapsXY(x, y) {
        return M.pointRectOverlap(x, y, this.x - 16, this.y - 32, this.x + 16, this.y);
    }
}