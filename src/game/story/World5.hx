package game.story;

import game.game.NodeEntity;
import game.game.MusicManager;
import game.game.BaseMainGame;

class World5 extends MappableStoryGame {
    public var lastPlaced: NodeEntity;

    public function new() {
        super();

        MusicManager.set(hxd.Res.latticed_rhythm);

        spawnMap();
        lastPlaced = selected;

        money = 50;

        new TextBox(
"Reach the bottom
(Click close to the edge
to scroll the camera)", this, hudLayer);
    }

    function spawnMap() {
        selected.x = camera.x = 365;
        selected.y = camera.y = 87;
        new MurderBlock(390, 64, 48, 48, 1, 8, this);
        new MurderBlock(438, 64, 48, 48, 2, 8, this);
        new MurderBlock(486, 64, 48, 48, 3, 8, this);
        new MurderBlock(486, 132, 48, 48, 5, 8, this);
        new MurderBlock(438, 132, 48, 48, 6, 8, this);
        new MurderBlock(390, 132, 48, 48, 7, 8, this);
        new MurderBlock(342, 200, 48, 48, 1, 4, this);
        new MurderBlock(390, 200, 48, 48, 3, 4, this);
        new MurderBlock(438, 200, 48, 48, 1, 4, this);
        new MurderBlock(486, 200, 48, 48, 3, 4, this);
        new MurderBlock(534, 200, 48, 48, 1, 4, this);
        new MurderBlock(342, 248, 48, 48, 3, 4, this);
        new MurderBlock(390, 248, 48, 48, 1, 4, this);
        new MurderBlock(438, 248, 48, 48, 3, 4, this);
        new MurderBlock(486, 248, 48, 48, 1, 2, this);
        new MurderBlock(534, 248, 48, 48, 2, 2, this);
        new MurderBlock(342, 296, 48, 48, 1, 4, this);
        new MurderBlock(390, 296, 48, 48, 2, 2, this);
        new MurderBlock(438, 296, 48, 48, 3, 4, this);
        new MurderBlock(486, 296, 48, 48, 2, 2, this);
        new MurderBlock(534, 296, 48, 48, 1, 4, this);
        new MurderBlock(390, 392, 48, 48, 1, 4, this);
        new MurderBlock(438, 392, 48, 48, 2, 4, this);
        new MurderBlock(486, 392, 48, 48, 3, 4, this);
        new MurderBlock(486, 440, 48, 48, 4, 4, this);
        new MurderBlock(486, 488, 48, 48, 1, 4, this);
        new MurderBlock(438, 488, 48, 48, 2, 4, this);
        new MurderBlock(390, 488, 48, 48, 3, 4, this);
        new MurderBlock(390, 440, 48, 48, 4, 4, this);
        new MurderBlock(486, 536, 48, 48, 2, 4, this);
        new MurderBlock(534, 536, 48, 48, 3, 4, this);
        new MurderBlock(582, 536, 48, 48, 4, 4, this);
        new MurderBlock(582, 488, 48, 48, 1, 4, this);
        new MurderBlock(582, 440, 48, 48, 2, 4, this);
        new MurderBlock(534, 440, 48, 48, 3, 4, this);
        new MurderBlock(630, 632, 48, 48, 1, 8, this);
        new MurderBlock(630, 728, 48, 48, 3, 8, this);
        new MurderBlock(630, 824, 48, 48, 5, 8, this);
        new MurderBlock(630, 920, 48, 48, 7, 8, this);
        new StoryBlock(322, 44, 260, 20, this);
        new StoryBlock(342, 112, 192, 20, this);
        new StoryBlock(322, 64, 20, 68, this);
        new StoryBlock(582, 44, 20, 396, this);
        new StoryBlock(390, 180, 192, 20, this);
        new StoryBlock(322, 132, 20, 280, this);
        new StoryBlock(342, 392, 48, 20, this);
        new StoryBlock(370, 412, 20, 124, this);
        new StoryBlock(370, 536, 116, 20, this);
        new StoryBlock(466, 556, 20, 28, this);
        new StoryBlock(466, 584, 164, 20, this);
        new StoryBlock(610, 604, 20, 432, this);
        new StoryBlock(630, 1016, 68,  20, this);
        new StoryBlock(678, 516, 20, 500, this);
        new StoryBlock(650, 516, 28, 20, this);
        new StoryBlock(630, 440, 20, 96, this);
        new StoryBlock(602, 420, 48, 20, this);
        new StoryBlock(534, 392, 48, 48, this);
        new StoryBlock(438, 440, 48, 48, this);
        new StoryBlock(534, 488, 48, 48, this);
        new Nutrient(555, 94, this);
        new Nutrient(567, 112, this);
        new Nutrient(552, 145, this);
        new Nutrient(364, 155, this);
        new Nutrient(382, 366, this);
        new Nutrient(462, 380, this);
        new Nutrient(503, 424, this);
        new Nutrient(431, 516, this);
        new Nutrient(601, 468, this);
        new Nutrient(566, 563, this);
        new Nutrient(655, 559, this);
        new Nutrient(655, 704, this);
        new Nutrient(654, 800, this);
        new Nutrient(656, 893, this);
        new EndPoint(638, 976, this);
    }

    public function restart() {
        Main.setGame(new World5());
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
        lastPlaced = selected;
    }
}