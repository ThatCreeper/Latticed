package game.story;

import h2d.Graphics;
import game.game.Creature;

class StoryBlock extends Creature {
    var w: Float;
    var h: Float;

    public var targetX: Float;
    public var targetY: Float;
    
    public function new(x, y, w, h, ?g, ?l) {
        super(x, y, g, l);
        this.w = w;
        this.h = h;
        this.targetX = x;
        this.targetY = y;

        var graphic = new Graphics(spr);
        graphic.beginFill(0xFF9BFA);
        graphic.drawRect(0, 0, w, h);
        graphic.endFill();
        graphic.alpha = 0.5;
    }

    override function update() {
        super.update();

        x = M.lerpC(x, targetX, deltaTime);
        y = M.lerpC(y, targetY, deltaTime);
    }

    public function getCenterX():Float {
        return x + w / 2;
    }

    public function getCenterY():Float {
        return y + h / 2;
    }

    public function overlapsXY(x:Float, y:Float):Bool {
        return x >= this.x && y >= this.y && x < this.x + w && y < this.y + h;
    }

    public function rayOverlaps(x1:Float,y1:Float,x2:Float,y2:Float) {
        for (s in 0...5) {
            if (overlapsXY(M.lerp(x1, x2, s / 4), M.lerp(y1, y2, s / 4)))
                return true;
        }
        return false;
    }
}