package game.game;

import h2d.Tile;
import h2d.Bitmap;

class SpiderStrider extends Creature {
    public var harvesterTargetTime = 5.0;
    public var harvesterAmount = 15;
    public var harvesterScore = 10;
    public var maxDistance = 500;
    var harvesterTime = 0.0;

    public function new(x, y, ?g, ?l) {
        super(x, y, g, l);

        var bmp = new Bitmap(Tile.fromColor(0x2FD750), spr);
        bmp.scaleX = 32;
        bmp.scaleY = 32;
        bmp.x = -16;
        bmp.y = -32;
    }

    override function midUpdate() {
        super.midUpdate();
        
        x -= 5 * deltaTime;
        // TODO: Use max distance
    }

    override function postUpdateHarvesters() {
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

    public function getCenterX():Float {
        return x;
    }

    public function getCenterY():Float {
        return y - 16;
    }
}