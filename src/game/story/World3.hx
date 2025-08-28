package game.story;

import hxd.Key;
import game.game.MusicManager;
import game.game.BaseMainGame;

class World3 extends MappableStoryGame {
    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed);
        
        spawnMap();

        new TextBox(
"Grow through the vents
(Minimum score 950)", this, hudLayer);
        money = 20;
    }

    function spawnMap() {
        selected.x = camera.x = 39;
        selected.y = camera.y = 937;
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
        new Nutrient(186, 957, this);
        new Nutrient(200, 706, this);
        new Nutrient(289, 891, this);
        new Nutrient(255, 928, this);
        new Nutrient(225, 894, this);
        new Nutrient(221, 756, this);
        new Nutrient(340, 701, this);
        new Nutrient(359, 836, this);
        new EndPoint(402, 752, this).minScore = 950;
    }

    public function restart() {
        Main.setGame(new World3());
    }

    override function update() {
        super.update();

        if (Key.isPressed(Key.H))
            trace(mouseX, mouseY);
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

    override function onNewNode() {
        super.onNewNode();
        for (e in entities) {
            if (e is EndPoint) {
                cast (e, EndPoint).recalculate();
            }
        }
    }
}