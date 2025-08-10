package game.story;

import game.game.NodeEntity;
import h2d.Graphics;
import game.game.Creature;

class Nutrient extends Creature {
    public function new(x, y, ?g, ?l) {
        super(x, y, g, l);
        var graphics = new Graphics(spr);
        graphics.beginFill(0x00FF00);
        graphics.drawCircle(0, 0, 4);
        graphics.endFill();
    }

    public function getCenterX():Float {
        return x;
    }

    public function getCenterY():Float {
        return y;
    }

    public function overlapsXY(x:Float,y:Float):Bool {
        return M.distSqr(x, y, getCenterX(), getCenterY()) < 6 * 6;
    }

    override function harvest(spawnedHarvestNode:NodeEntity) {
        super.harvest(spawnedHarvestNode);

        game.addMoney(x, y, 20);
        remove();
    }
}