package game.game;

import h2d.Tile;
import h2d.Bitmap;

class Ant extends MGEntity {
    public var harvester:Null<NodeEntity> = null;
    public var lastX: Float;
    public var lastY: Float;
    public var harvesterTargetTime = 5.0;
    public var harvesterAmount = 15;
    public var harvesterScore = 10;
    var harvesterTime = 0.0;

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
            updateHarvesters();
        }

        lastX = x;
        lastY = y;
    }

    function updateHarvesters():Void {
        harvester.x += x - lastX;
        harvester.y += y - lastY;

        for (connection in harvester.connections) {
            if (connection.lengthSqr() > 400 * 400) {
                connection.remove();
                continue;
            }
            connection.updateLookAt();
        }

        if (harvester.connections.length == 0) {
            remove();
            return;
        }

        harvesterTime += deltaTime;
        if (harvesterTime > harvesterTargetTime) {
            harvesterTime -= harvesterTargetTime;
            game.addScore(x, y - 16, harvesterScore);
            game.addMoney(x, y - 16, harvesterAmount);
        }
    }

    public function overlapsXY(x, y) {
        return M.pointRectOverlap(x, y, this.x - 16, this.y - 32, this.x + 16, this.y);
    }

    override function onDispose() {
        super.onDispose();
        harvester?.remove();
    }
}