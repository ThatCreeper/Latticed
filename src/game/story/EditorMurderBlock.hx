package game.story;

import h2d.Text;
import h3d.Vector;
import hxd.Key;

class EditorMurderBlock extends MurderBlock {
    var text_b: Text;
    var text_B: Text;
    var grabX = 0.0;
    var grabY = 0.0;

    public function new(x, y, w, h, b, B, g) {
        super(x, y, w, h, b, B, g);

        text_b = new Text(hxd.res.DefaultFont.get(), spr);
        text_B = new Text(hxd.res.DefaultFont.get(), spr);
        text_b.text = Std.string(beat);
        text_B.text = Std.string(beats);
        text_B.x = 48 - 12;
        text_B.y = 48 - 18;
        text_b.x = 12;
        text_b.y = 8;
    }

    override function update() {
        super.update();
        var g: EditorStoryGame = cast game;

        if (g.selectedEnt == this && (Key.isReleased(Key.MOUSE_MIDDLE)
                                   || Key.isReleased(Key.MOUSE_RIGHT))) {
            g.selectedEnt = null;
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_RIGHT)) {
            if (game.mouseX < grabX + x - 5) {
                beat--;
                grabX = game.mouseX - x;
            }
            else if (game.mouseX > grabX + x + 5) {
                beat++;
                grabX = game.mouseX - x;
            }
            if (game.mouseY < grabY + y - 5) {
                beats--;
                grabY = game.mouseY - y;
            }
            else if (game.mouseY > grabY + y + 5) {
                beats++;
                grabY = game.mouseY - y;
            }
            text_b.text = Std.string(beat);
            text_B.text = Std.string(beats);
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_MIDDLE)) {
            x = Math.floor(game.mouseX - grabX);
            y = Math.floor(game.mouseY - grabY);
            game.score = Math.floor(x);
            game.money = Math.floor(y);
        }
        if (g.selectedEnt != this && (Key.isPressed(Key.MOUSE_MIDDLE)
                                   || Key.isPressed(Key.MOUSE_RIGHT)) && overlapsXY(game.mouseX, game.mouseY)) {
            g.selectedEnt = this;
            grabX = game.mouseX - x;
            grabY = game.mouseY - y;
        }

        graphic.colorAdd = g.selectedEnt == this ? new Vector(0.5, 0, 0) : null;
        spr.alpha = Math.max(0.5, spr.alpha);
    }

    override public function serializeMapClassName() {
        return "game.story.MurderBlock";
    }
}