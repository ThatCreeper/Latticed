package game.story;

import game.game.MusicManager;
import game.game.BaseMainGame;

class World5 extends BaseMainGame {
    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed_rhythm);
    }

    public function restart() {
        Main.setGame(new World5());
    }
}