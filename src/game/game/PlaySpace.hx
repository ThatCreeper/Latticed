package game.game;

import h3d.mat.Data.TextureFlags;
import hxd.File;
import h3d.mat.Texture;
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
        // top = initBitmap(true);
        // bottom = initBitmap(true);
        // left = initBitmap(false);
        // right = initBitmap(false);
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
        
        // top.x = bottom.x = minX;
        // top.scaleX = bottom.scaleX = maxX - minX;
        // top.y = minY;
        // bottom.y = maxY;

        // left.y = right.y = minY;
        // left.scaleY = right.scaleY = maxY - minY;
        // left.x = minX;
        // right.x = maxX;
    }

    public function screenshot() {
        if (minX == maxX || minY == maxY) return;
        var target = new Texture(Math.ceil(maxX - minX + 50), Math.ceil(maxY - minY + 50), [ Target ]);
        target.clear(0x000000);

        var cam = game.s2d.camera;
        cam.x = minX - 25;
        cam.y = minY - 25;
        cam.scaleX = cam.scaleY = 1;
        cam.anchorX = cam.anchorY = 0;
        cam.rotation = 0;

        game.hudLayer.visible = false;
        game.worldlyHudLayer.visible = false;

        captureBitmapNoBitmap(game.s2d, target);
        camera.update(game.s2d, false);

        game.hudLayer.visible = true;
        game.worldlyHudLayer.visible = true;

        var pixels = target.capturePixels();

        target.dispose();
        File.saveBytes("dat-screenshot.png", pixels.toPNG());
        pixels.dispose();
    }

    // A modified version of Scene.captureBitmap
    function captureBitmapNoBitmap( s: h2d.Scene, tex : Texture ) @:privateAccess {
        var engine = Main.INST.engine;
        engine.begin();
        engine.pushTarget(tex);
        engine.setRenderZone(0, 0, tex.width, tex.height);

        var ow = s.width, oh = s.height, ova = s.viewportA, ovd = s.viewportD, ovx = s.viewportX, ovy = s.viewportY;
        s.width = tex.width;
        s.height = tex.height;
        s.viewportA = 2 / s.width;
        s.viewportD = 2 / s.height;
        s.viewportX = -1;
        s.viewportY = -1;
        s.posChanged = true;
        s.render(engine);
        engine.popTarget();

        s.width = ow;
        s.height = oh;
        s.viewportA = ova;
        s.viewportD = ovd;
        s.viewportX = ovx;
        s.viewportY = ovy;
        s.posChanged = true;
        engine.setRenderZone();
        engine.end();
    }
}