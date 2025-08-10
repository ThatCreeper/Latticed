package game.story;

import game.story.ui.StoryUI;
import game.game.MusicManager;
import game.game.FreePlayGame;
import hxd.Key;
import h2d.Text;

class StorySelectionGame extends Game {
    var ui:StoryUI;

    public function new() {
        super();

        ui = new StoryUI(hudLayer);
        ui.b0.onClick = ()->Main.setGame(new World0());
        ui.b1.onClick = ()->Main.setGame(new World1());
        ui.b2.onClick = ()->Main.setGame(new World2());
        ui.b3.onClick = ()->Main.setGame(new World3());
        ui.b4.onClick = ()->Main.setGame(new World4());
        ui.b5.onClick = ()->Main.setGame(new World5());

        ui.fp.onClick = ()->Main.setGame(new FreePlayGame());
        ui.cr.onClick = ()->Main.setGame(new CreditsGame());

        MusicManager.set(hxd.Res.latticed_menu);
    }

    override function update() {
        super.update();

        ui.x = (scrwid - ui.outerWidth) / 2;
        ui.y = (scrhei - ui.outerHeight) / 2;
    }
}