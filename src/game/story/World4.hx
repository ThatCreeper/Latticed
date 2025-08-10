package game.story;

import h2d.Bitmap;
import game.game.MusicManager;
import game.game.BaseMainGame;

class World4 extends BaseMainGame {
    public var movingWall: StoryBlock;

    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed);

        selected.x = 420;
        selected.y = 478 + 10;
        camera.x = selected.x;
        camera.y = selected.y;

        new Bitmap(hxd.Res.world4bg.toTile(), bgLayer);

        new StoryBlock(504, 444, 126, 73, this);
        new StoryBlock(630, 435, 107, 82, this);
        new StoryBlock(715, 517, 22, 37, this);
        movingWall = new StoryBlock(650, 517, 25, 37, this);

        new SliderComputer(625, 354, movingWall, 650, 480, this);
        new EndPoint(680, 520, this);

        new TextBox("Exit", this, hudLayer);

        money = 40;
    }

    public function restart() {
        Main.setGame(new World4());
    }

    override function isValidNodeSpot(x:Float, y:Float, sx:Float, sy:Float):Bool {
        if (x <= 414) return false;
        if (y >= 554) return false;
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