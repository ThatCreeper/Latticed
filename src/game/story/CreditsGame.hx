package game.story;

import hxd.Key;
import h2d.Text;

class CreditsGame extends Game {
    public function new() {
        super();

        var text = new Text(hxd.res.DefaultFont.get(), gameLayer);
        text.text =
"Hypha is a game made by creeper_host

The source code is available at
https://github.com/ThatCreeper/Latticed

Hypha uses:
The Haxe language
https://haxe.org

The Heaps game engine
https://heaps.io
MIT Licensed

Domkit
https://github.com/HeapsIO/domkit
MIT Licensed

stb_ogg_sound
https://github.com/shohei909/haxe_stb_ogg_sound

Press escape to return";
        text.textAlign = Center;
        text.y = -text.textHeight/2;

        MusicManager.set(hxd.Res.latticed_credits);
    }

    override function update() {
        super.update();

        if (Key.isDown(Key.ESCAPE))
            GameEngine.setGame(new StorySelectionGame());
    }
}