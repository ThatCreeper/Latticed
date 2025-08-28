package game.story;

import hxd.Key;
import h3d.Vector;

class EditorEndPoint extends EndPoint {
    var grabX = 0.0;
    var grabY = 0.0;

    public function new(x, y, m, g) {
        super(x, y, g);
        minScore = m;
    }
    
    override function update() {
        super.update();
        var g: EditorStoryGame = cast game;

        if (g.selectedEnt == this && (Key.isReleased(Key.MOUSE_MIDDLE))) {
            g.selectedEnt = null;
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_MIDDLE)) {
            x = Math.floor(game.mouseX - grabX);
            y = Math.floor(game.mouseY - grabY);
            game.score = Math.floor(x);
            game.money = Math.floor(y);
        }
        if (g.selectedEnt != this && (Key.isPressed(Key.MOUSE_MIDDLE)) && overlapsXY(game.mouseX, game.mouseY)) {
            g.selectedEnt = this;
            grabX = game.mouseX - x;
            grabY = game.mouseY - y;
        }

        bitmap.colorAdd = g.selectedEnt == this ? new Vector(0.5, 0, 0) : null;
    }

    override public function serializeMapClassName() {
        return "game.story.EndPoint";
    }
}