package game.game;

import game.story.StorySelectionGame;
import hxd.Key;
import game.story.World0;
import game.game.ui.PauseUI;

class PauseScreen extends MGEntity {
    var ui:PauseUI;

    var startClose = false;
    var removeFrame = false;

    public function new(?g, ?l) {
        super(g, l);

        ui = new PauseUI(game.score,spr);
        ui.continueGame = ()->remove();
        ui.screenshot = game.playSpace.screenshot;
        ui.exitToMenu = ()->GameEngine.setGame(new StorySelectionGame()); // TODO: Not a menu!
    }

    override function postUpdate() {
        x = (scrwid - ui.outerWidth) / 2;
        super.postUpdate();
    }

    override function update() {
        super.update();
        if (removeFrame)
            remove();

        if (Key.isPressed(Key.ESCAPE))
            removeFrame = true;
        //     startClose = true;
        // if (startClose && Key.isReleased(Key.ESCAPE))
    }

    override function onDispose() {
        super.onDispose();

        game.cursor.delayFrames = 1;
    }
}