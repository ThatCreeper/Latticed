package game.story;

import hxd.Key;
import game.game.MGEntity;
import game.game.BaseMainGame;

class EditorStoryGame extends MappableStoryGame {
    public var selectedEnt: Null<MGEntity> = null;

    public function new(x, y) {
        super();

        selected.x = camera.x = x;
        selected.y = camera.y = y;

        cursor.attacher.tile.visible = false;

        Main.style.allowInspect = false; // Allow middle mouse gesture
        allowSpaceMovement = true;
    }

    override function update() {
        lockedCamera = selectedEnt != null;

        score = 0;
        money = 10000;

        super.update();

        if (selectedEnt == null && Key.isDown(Key.MOUSE_LEFT)) {
            score = Math.floor(mouseX);
            money = Math.floor(mouseY);
        }

        if (Key.isPressed(Key.B)) {
            new EditorStoryBlock(Math.floor(mouseX), Math.floor(mouseY), 16, 16, this);
        }
        if (Key.isPressed(Key.N)) {
            new EditorNutrient(Math.floor(mouseX), Math.floor(mouseY), this);
        }
        if (Key.isPressed(Key.M)) {
            new EditorMurderBlock(Math.floor(mouseX), Math.floor(mouseY), 48, 48, 1, 2, this);
        }
        if (Key.isPressed(Key.H)) {
            selected.x = mouseX;
            selected.y = mouseY;
        }
        if (Key.isPressed(Key.BACKSPACE)) {
            selectedEnt?.remove();
            selectedEnt = null;
        }
    }

    override function isPaused():Bool {
        return true; // Disables the cursor
    }

    public function restart() {
        Main.setGame(new StorySelectionGame());
    }
}