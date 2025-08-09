package game.story;

import game.game.BaseMainGame;

class World1 extends BaseMainGame {
    public function new() {
        super();
    }

    public function restart() {
        Main.setGame(new World1());
    }
}