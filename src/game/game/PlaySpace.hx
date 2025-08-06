package game.game;

import h2d.Tile;
import h2d.Bitmap;

class PlaySpace extends MGEntity {
    var minX = 0.0;
    var maxX = 0.0;
    var minY = 0.0;
    var maxY = 0.0;
    
    var top:Bitmap;
    var left:Bitmap;
    var bottom:Bitmap;
    var right:Bitmap;

    public function new(g, ?l) {
        super(g, l);
        top = initBitmap(true);
        bottom = initBitmap(true);
        left = initBitmap(false);
        right = initBitmap(false);
    }

    function initBitmap(horizontal) {
        var bitmap = new Bitmap(Tile.fromColor(0xA0A0A0), spr);
        if (horizontal) {
            spr.scaleX = 0;
        } else {
            spr.scaleY = 0;
        }
        return bitmap;
    }

    public function register(x, y) {
        var score = 0.0;
        if (x < minX) {
            score += minX - x;
            minX = x;
        } else if (x > maxX) {
            score += x - maxX;
            maxX = x;
        }
        if (y < minY) {
            score += minY - y;
            minY = y;
        } else if (y > maxY) {
            score += y - minY;
            maxY = y;
        }
        if (score == 0) return;
        score /= 20; // random number i picked
        game.addScore(x, y - 20, Math.ceil(score));
        
        top.x = bottom.x = minX;
        top.scaleX = bottom.scaleX = maxX - minX;
        top.y = minY;
        bottom.y = maxY;

        left.y = right.y = minY;
        left.scaleY = right.scaleY = maxY - minY;
        left.x = minX;
        right.x = maxX;
    }
}