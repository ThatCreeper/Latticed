package game.story;

import h2d.Tile;
import h2d.Bitmap;
import game.game.BaseMainGame;
import h2d.Graphics;

class StoryBlock extends Entity<BaseMainGame> {
    var w: Float;
    var h: Float;

    public var targetX: Float;
    public var targetY: Float;

    var bitmap: Bitmap;
    
    public function new(x, y, w, h, ?g, ?l) {
        super(g, l);
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.targetX = x;
        this.targetY = y;

        // var graphic = new Graphics(spr);
        // graphic.beginFill(0xFF9BFA);
        // graphic.drawRect(0, 0, w, h);
        // graphic.endFill();
        // graphic.alpha = 0.5;
        var tile = hxd.Res.storyblock.toTile();
        tile.setSize(w, h);
        bitmap = new Bitmap(tile, spr);
        bitmap.tileWrap = true;
    }

    override function update() {
        super.update();

        x = M.lerpCR(x, targetX, deltaTime);
        y = M.lerpCR(y, targetY, deltaTime);
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

    override function serializableMap():Bool {
        return true;
    }

    override function serializeMap():String {
        return '${x}, ${y}, ${w}, ${h}';
    }

    override function spawnEditorClone(game:EditorStoryGame) {
        new EditorStoryBlock(x, y, w, h, game);
    }
}