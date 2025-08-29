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
        ui.b3.onClick = ()->setGameIfFlag(World3, "map_won_world2");
        ui.b4.onClick = ()->setGameIfFlag(World4, "map_won_world3");
        ui.b5.onClick = ()->setGameIfFlag(World5, "map_won_world4");

        ui.fp.onClick = ()->Main.setGame(new FreePlayGame());
        ui.cr.onClick = ()->Main.setGame(new CreditsGame());

        MusicManager.set(hxd.Res.latticed_menu);
    }

    // nonsense code because im lazy
    function setGameIfFlag<T>(clazz: Class<T>, flag) {
        if (PersistentGameState.check_flag(flag))
            Main.setGame(cast Type.createInstance(clazz, []));
    }

    override function update() {
        super.update();

        ui.x = (scrwid - ui.outerWidth) / 2;
        ui.y = (scrhei - ui.outerHeight) / 2;
    }
}