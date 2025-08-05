package game.game;

import game.Entity;
import hxd.Key;
import h2d.col.Point;
import game.game.ui.CameraCoords;

class MainGame extends Game {
    public var selected: NodeEntity;
    public var cursor: NodeCursor;
    var camCoords: CameraCoords;
    public var score = 0;
    public var money = 100;

    public function new() {
        super();
        camera.scale = 2;
        camera.shakeIntensity = 1;

        new Background(this, bgLayer);

        new Ant(100, 0, this);

        selected = new NodeEntity(this);
        selected.frozen = true;

        cursor = new NodeCursor(this, worldlyHudLayer);

        camCoords = new CameraCoords(0, 0, hudLayer);
    }

    override function update() {
        super.update();

        if (Key.isDown(Key.LEFT))
            camera.sx -= 3 * tmod;
        if (Key.isDown(Key.RIGHT))
            camera.sx += 3 * tmod;
        if (Key.isDown(Key.UP))
            camera.sy -= 3 * tmod;
        if (Key.isDown(Key.DOWN))
            camera.sy += 3 * tmod;

        if (Key.isPressed(Key.QWERTY_EQUALS))
            camera.sscale *= 2;
        if (Key.isPressed(Key.QWERTY_MINUS))
            camera.sscale /= 2;

        if (camera.sscale < 1)
            camera.sscale = 1;
    }

    override function postUpdate() {
        super.postUpdate();
        updateGUI();
    }

    function updateGUI():Void {
        camCoords.cx.text = Std.string(Math.floor(camera.x));
        camCoords.cy.text = Std.string(Math.floor(camera.y));
        camCoords.e.text = Std.string(entities.length);
        camCoords.t.text = Std.string(selected.timeRemaining);
        camCoords.p.text = Std.string(score);
        camCoords.m.text = Std.string(money);
    }

    public function addScore(x:Float, y:Float, score:Int) {
        this.score += score;
        new Toast(x, y, '+${score}', this, this.worldlyHudLayer);
    }

    // USAGE: if (cashCheck(5)) return;
    public function cashCheck(required) {
        if (money < required) return true;
        money -= required;
        return false;
    }

    // USAGE: if (cashCheckToast(5, x, y, "Not enough money!")) return;
    public function cashCheckToast(required, x, y, text) {
        if (money < required) {
            new Toast(x, y, text, this);
            return true;
        }
        money -= required;
        return false;
    }
}