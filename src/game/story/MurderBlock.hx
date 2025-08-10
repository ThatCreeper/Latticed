package game.story;

import h2d.Bitmap;
import game.game.BaseMainGame;
import game.game.NodeEntity;
import game.game.MusicManager;
import h2d.Graphics;

class MurderBlock extends Entity<World5> {
    var w: Float;
    var h: Float;

    var beat: Int;
    var beats: Int;

    var visibled = false;
    var alpha = 0.0;
    
    public function new(x, y, w, h, b, B, ?g, ?l) {
        super(g, l);
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.beat = b;
        this.beats = B;

        // var graphic = new Graphics(spr);
        // graphic.beginFill(0xB90600);
        // graphic.drawRect(0, 0, w, h);
        // graphic.endFill();
        // graphic.alpha = 1;
        var graphic = new Bitmap(hxd.Res.deathtile.toTile(), spr);
    }

    override function update() {
        super.update();

        var myBeat = MusicManager.getBeat(Math.floor(120 * 2), beats) == beat;
        alpha -= deltaTime / 60 * 120 * 2;
        if (myBeat) {
            if (!visibled) {
                visibled = true;
                alpha = 1;
                doDeath();
            }
        } else {
            visibled = false;
        }
        spr.alpha = (1 - (1 - alpha) * (1 - alpha));
    }

    function doDeath() {
        for (e in game.entities) {
            if (!(e is NodeEntity))
                continue;
            var e:NodeEntity = cast e;
            if (!overlapsXY(e.x, e.y))
                continue;
            if (e == game.lastPlaced) {
                game.die();
                return;
            }
            e.remove();
            hxd.Res.latticed_nomoney.play();
        }
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