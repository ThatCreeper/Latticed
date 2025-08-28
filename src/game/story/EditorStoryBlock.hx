package game.story;

import h3d.Vector;
import hxd.Key;

class EditorStoryBlock extends StoryBlock {
    var grabX = 0.0;
    var grabY = 0.0;

    public function new(x, y, w, h, g) {
        super(x, y, w, h, g);
    }

    override function update() {
        super.update();
        var g: EditorStoryGame = cast game;

        if (g.selectedEnt == this && (Key.isReleased(Key.MOUSE_LEFT)
                                   || Key.isReleased(Key.MOUSE_MIDDLE)
                                   || Key.isReleased(Key.MOUSE_RIGHT))) {
            g.selectedEnt = null;
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_LEFT)) {
            if (Key.isDown(Key.CTRL))
                h = M.toNearestMultipleOf(Math.max(1, game.mouseY - y), 16);
            else
                h = Math.floor(Math.max(1, game.mouseY - y));
            game.score = Math.floor(h);
            resizeTile();
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_RIGHT)) {
            if (Key.isDown(Key.CTRL))
                w = M.toNearestMultipleOf(Math.max(1, game.mouseX - x), 16);
            else
                w = Math.floor(Math.max(1, game.mouseX - x));
            game.score = Math.floor(w);
            resizeTile();
        }
        if (g.selectedEnt == this && Key.isDown(Key.MOUSE_MIDDLE)) {
            x = Math.floor(game.mouseX - grabX);
            y = Math.floor(game.mouseY - grabY);
            targetX = x;
            targetY = y;
            game.score = Math.floor(x);
            game.money = Math.floor(y);
        }
        if (g.selectedEnt != this && (Key.isPressed(Key.MOUSE_LEFT)
                                   || Key.isPressed(Key.MOUSE_MIDDLE)
                                   || Key.isPressed(Key.MOUSE_RIGHT)) && overlapsXY(game.mouseX, game.mouseY)) {
            g.selectedEnt = this;
            grabX = game.mouseX - x;
            grabY = game.mouseY - y;
        }

        bitmap.colorAdd = g.selectedEnt == this ? new Vector(0.5, 0, 0) : null;
    }

    function resizeTile() {
        bitmap.tile.setSize(w, h);
    }

    override public function serializeMapClassName() {
        return "game.story.StoryBlock";
    }
}