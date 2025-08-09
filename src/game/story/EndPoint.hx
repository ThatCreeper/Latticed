package game.story;

import game.game.NodeEntity;
import h2d.Bitmap;
import game.game.BaseMainGame;
import game.game.Creature;

class EndPoint extends Creature {
    var bitmap:Bitmap;

    public function new(x, y, ?g, ?l) {
        super(x, y, g, l);

        bitmap = new Bitmap(hxd.Res.checkpoint.toTile(), spr);
        // bitmap.x = -bitmap.tile.width;
        // bitmap.y = -bitmap.tile.height;
    }

    public function getCenterX():Float {
        return x + bitmap.tile.width / 2;
    }

    public function getCenterY():Float {
        return y + bitmap.tile.height / 2;
    }

    public function overlapsXY(x:Float, y:Float):Bool {
        return M.distSqr(x, y, getCenterX(), getCenterY()) < 9 * 9;
    }

    override function harvest(spawnedHarvestNode:NodeEntity) {
        super.harvest(spawnedHarvestNode);
        
        bitmap.tile = hxd.Res.checkpoint_captured.toTile();
        game.win();
    }
}