package game.story;

import game.game.MusicManager;
import game.game.FreePlayGame;
import hxd.Key;
import h2d.Text;

class StorySelectionGame extends Game {
    public function new() {
        super();

        var text = new Text(hxd.res.DefaultFont.get(), gameLayer);
        text.setScale(2);
        text.textAlign = Center;
        text.text =
"No menu yet!
Press 1 for FreePlay
2 for World0
3 for World1";
        text.y = -text.textHeight;

        MusicManager.set(hxd.Res.latticed_tempmenu);
    }

    override function update() {
        super.update();

        if (Key.isPressed(Key.NUMBER_1))
            Main.setGame(new FreePlayGame());
        if (Key.isPressed(Key.NUMBER_2))
            Main.setGame(new World0());
        if (Key.isPressed(Key.NUMBER_3))
            Main.setGame(new World1());
        if (Key.isPressed(Key.NUMBER_4))
            Main.setGame(new World2());
    }
}