package game.story;

import h2d.Tile;
import h2d.Graphics;
import h2d.Text;
import h2d.Bitmap;
import game.game.BaseMainGame;

class TextBox extends Entity<BaseMainGame> {
    var cornerA: Bitmap; // tl
    var cornerB: Bitmap; // tr
    var cornerC: Bitmap; // bl
    var cornerD: Bitmap; // br
    var lineA: Bitmap;   // t
    var lineB: Bitmap;   // r
    var lineC: Bitmap;   // b
    var lineD: Bitmap;   // l
    var bg: Bitmap;
    var text: Text;
    
    // Centered, down.
    public function new(txt, ?g, ?l) {
        super(g, l);

        bg = new Bitmap(Tile.fromColor(0x000000), spr);
        bg.alpha = 0.5;

        text = new Text(hxd.res.DefaultFont.get(), spr);
        text.textColor = 0xFFFFFF;
        text.text = txt;
        text.setScale(2);
        text.y = 12;
        // text.x = -text.textWidth;
        text.textAlign = Center;

        cornerA = addCorner(false, false);
        cornerB = addCorner(true,  false);
        cornerC = addCorner(false, true);
        cornerD = addCorner(true,  true);

        lineA = addLine(false, false);
        lineB = addLine(true,  true);
        lineC = addLine(false, true);
        lineD = addLine(true,  false);

        updateBg();
    }

    function addCorner(x, y) {
        var bm = new Bitmap(hxd.Res.node.toTile(), spr);
        updateCorner(bm, x, y);
        return bm;
    }

    function updateCorner(bm:Bitmap, x, y) {
        bm.x = if (x)
            text.textWidth + 12 - 4;
        else
            -text.textWidth - 12 - 4;
        bm.y = if (y)
            text.textHeight * 2 + 24 - 4
        else
            -4;
    }

    function addLine(vertical, mod) {
        var bm = new Bitmap(hxd.Res.fiber.toTile(), spr);
        updateLine(bm, vertical, mod);
        return bm;
    }

    function updateLine(bm:Bitmap, vertical, mod) {
        bm.rotation = vertical ? 0 : -(Math.PI/2);
        bm.x = if (vertical && mod)
            text.textWidth + 12;
        else
            -text.textWidth - 12;
        bm.y = if (!vertical && mod)
            text.textHeight * 2 + 24
        else
            0;
        bm.scaleY = 1 / bm.tile.height;
        bm.scaleY *= if (vertical)
            text.textHeight * 2 + 24
        else
            text.textWidth * 2 + 24;

        if (vertical)
            bm.x -= 2.5;
        else
            bm.y += 2.5;
    }

    function updateBg() {
        bg.scaleX = text.textWidth * 2 + 24;
        bg.scaleY = text.textHeight * 2 + 24;
        bg.x = -text.textWidth - 12;
        bg.y = 0;
    }

    override function update() {
        super.update();

        x = scrwid / 2;
        y = 24;
    }

    public function setText(txt) {
        text.text = txt;
        updateCorner(cornerA, false, false);
        updateCorner(cornerB, true,  false);
        updateCorner(cornerC, false, true);
        updateCorner(cornerD, true,  true);

        updateLine(lineA, false, false);
        updateLine(lineB, true,  true);
        updateLine(lineC, false, true);
        updateLine(lineD, true,  false);
        updateBg();

        hxd.Res.latticed_dialog.play();
    }
}