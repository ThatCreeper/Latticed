package game.story;

import game.game.MusicManager;
import hxd.snd.Channel;
import hxd.Key;
import h2d.Object;
import game.game.BaseMainGame;

class World1 extends BaseMainGame {
    var phase = 0;
    var textBox: TextBox;

    public function new() {
        super();

        gameLayer.alpha = 0;
        worldlyHudLayer.alpha = 0;
        hudLayer.alpha = 0;

        deathTime = 4;

        textBox = new TextBox(
"Use left click to
extend a hypha", this, hudLayer);

        // music = hxd.Res.latticed.play(true, 0);
        // music.fadeTo(0.6);
        MusicManager.set(hxd.Res.latticed);

        money = 100;
        
        camCoords.visible = false;
    }

    override function update() {
        super.update();
        fadeLayer(gameLayer, 3);
        fadeLayer(worldlyHudLayer, 4);
        fadeLayer(hudLayer, 5);

        if (phase == 1 &&
            (Key.isReleased(Key.LEFT) ||
             Key.isReleased(Key.RIGHT) ||
             Key.isReleased(Key.UP) ||
             Key.isReleased(Key.DOWN))) {
            phase = 2;
            textBox.setText("Use =/- to zoom");
        }
        if (phase == 2 &&
            (Key.isReleased(Key.QWERTY_MINUS) ||
             Key.isReleased(Key.QWERTY_EQUALS) ||
             Key.isReleased(61) ||
             Key.isReleased(173))) {
            phase = 3;
            textBox.setText(
"You can also use
right click and the
scroll wheel to
manipulate the camera");
        }
        if (phase == 3 &&
            (Key.isReleased(Key.MOUSE_RIGHT))) {
            phase = 4;
            textBox.setText(
"When growing, you have
a limited number of nutrients.
If you run out, you lose");
            money = 20;
            camCoords.visible = true;
        }
        if (phase == 8 &&
            hudLayer.alpha <= 0) {
            Main.setGame(new StorySelectionGame());
        }
    }

    function fadeLayer(layer:Object, time:Float) {
        if (phase == 8) {
            layer.alpha -= deltaTime / time;
        } else {
            if (layer.alpha < 1) {
                layer.alpha += deltaTime / time;
                if (layer.alpha > 1)
                    layer.alpha = 1;
            }
        }
    }

    public function restart() {
        Main.setGame(new World1());
    }

    override function die() {
        if (phase == 4) {
            phase = 5;
            textBox.setText(
"Nearby nodes
(the end of a hypha)
will connect to each other
within a distance");
            money = 100;
        } else {
            super.die();
        }
    }

    override function onNewNode() {
        super.onNewNode();

        if (phase == 0) {
            phase = 1;
            textBox.setText(
"Use the arrow
keys to pan");
        }

        if (money <= 0 && phase != 4) {
            money = 100;
        }

        if (phase == 5 &&
            selected.connections.length > 1) {
            phase = 6;
            textBox.setText(
"If a node is surrounded
by too many other nodes,
however, it will become
crowded and unable to form");
        }

        if (phase == 7) phase = 8;
    }

    override function onFailedCrowdedNode() {
        super.onFailedCrowdedNode();

        if (phase == 6) {
            phase = 7;
            textBox.setText(
"Use escape to open
the pause screen and
exit to the menu");
            // MusicManager.fadeOut(4);
        }
    }

    override function dispose() {
        super.dispose();
    }
}