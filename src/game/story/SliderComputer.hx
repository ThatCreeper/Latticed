package game.story;

import game.game.NodeEntity;
import h2d.Bitmap;
import game.game.Creature;

class SliderComputer extends Creature {
    var bitmap:Bitmap;
    var slider:StoryBlock;
    var sliderTargetX:Float;
    var sliderTargetY:Float;

    public function new(x, y, slider, tx, ty, ?g, ?l) {
        super(x, y, g, l);

        bitmap = new Bitmap(hxd.Res.computer.toTile(), spr);
        this.slider = slider;
        sliderTargetX = tx;
        sliderTargetY = ty;
    }

    public function getCenterX():Float {
        return x + bitmap.tile.width / 2;
    }

    public function getCenterY():Float {
        return y + bitmap.tile.height / 2;
    }

    public function overlapsXY(x:Float, y:Float):Bool {
        return x >= this.x && y >= this.y && x < this.x + bitmap.tile.width && y < this.y + bitmap.tile.height;
    }

    override function harvest(spawnedHarvestNode:NodeEntity) {
        super.harvest(spawnedHarvestNode);

        this.slider.targetX = sliderTargetX;
        this.slider.targetY = sliderTargetY;
    }
}