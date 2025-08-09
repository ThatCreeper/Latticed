package game.story;

import game.game.OverlayEntity;
import game.game.NodeEntity;
import h2d.Tile;
import game.game.Creature;

class LoreComputer extends Creature {
    var w: Float;
    var h: Float;
    var i: Tile;
    var s: Float;
    
    public function new(x, y, w, h, i, s, ?g, ?l) {
        super(x, y, g, l);
        this.w = w;
        this.h = h;
        this.i = i;
        this.s = s;
    }

    public function getCenterX():Float {
        return x;
    }

    public function getCenterY():Float {
        return y;
    }

    public function overlapsXY(x:Float, y:Float):Bool {
        return x >= this.x && y >= this.y && x < this.x + w && y < this.y + h;
    }

    override function harvest(spawnedHarvestNode:NodeEntity) {
        super.harvest(spawnedHarvestNode);

        game.money += 5;
        new OverlayEntity(i, s);
    }
}