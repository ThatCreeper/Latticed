package game.game;

import game.story.StorySelectionGame;
import game.story.World0;
import game.game.ui.LoseUI;

class LoseScreen extends MGEntity {
    var ui:LoseUI;

    public function new(?g, ?l) {
        super(g, l);

        ui = new LoseUI(game.score,spr);
        ui.keepPlaying = game.keepPlaying;
        ui.screenshot = game.playSpace.screenshot;
        ui.restart = game.restart;
        ui.exitToMenu = ()->Main.setGame(new StorySelectionGame()); // TODO: Real menu
    }

    override function postUpdate() {
        x = (scrwid - ui.outerWidth) / 2;
        super.postUpdate();
    }
}