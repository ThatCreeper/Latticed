package game.story;

import game.game.MusicManager;
import game.game.BaseMainGame;

class World4 extends BaseMainGame {
    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed);
    }

    public function restart() {
        Main.setGame(new World4());
    }
}