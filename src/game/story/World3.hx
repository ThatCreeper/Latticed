package game.story;

import game.game.MusicManager;
import game.game.BaseMainGame;

class World3 extends BaseMainGame {
    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed);

        selected.x = 39;
        selected.y = 937;
        camera.x = selected.x;
        camera.y = selected.y;
        new StoryBlock(0, 900, 20, 80, this);
        new StoryBlock(0, 980, 260, 20, this);
        new StoryBlock(0, 880, 180, 20, this);
        new StoryBlock(260, 760, 20, 240, this);
        new StoryBlock(160, 659, 200, 20, this);
        new StoryBlock(360, 659, 20, 163, this);
        new StoryBlock(380, 722, 80, 20, this);
        new StoryBlock(460, 722, 20, 200, this);
        new StoryBlock(280, 902, 180, 20, this);
        new StoryBlock(160, 679, 20, 201, this);
        new EndPoint(402, 752, this);

        new TextBox("Get at least XXX score", this, hudLayer);
    }

    public function restart() {
        Main.setGame(new World3());
    }

    override function isValidNodeSpot(x:Float, y:Float, sx:Float, sy:Float):Bool {
        for (e in entities) {
            if (!(e is StoryBlock))
                continue;
            var e:StoryBlock = cast e;
            if (e.rayOverlaps(sx, sy, x, y))
                return false;
        }
        return super.isValidNodeSpot(x, y, sx, sy);
    }
}