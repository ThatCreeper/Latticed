package game.game;

import game.Entity;
import hxd.Key;
import h2d.col.Point;
import game.game.ui.CameraCoords;

// TODO: Free play mode
class MainGame extends Game {
    public var selected: NodeEntity;
    public var cursor: NodeCursor;
    var camCoords: CameraCoords;
    public var score = 0;
    public var money = 100;
    public var playSpace: PlaySpace;

    var lastMouseX = 0.0;
    var lastMouseY = 0.0;

    public function new() {
        super();
        // TODO: This is just debug
        camera.scale = 2;
        camera.shakeIntensity = 1;

        new Background(this, bgLayer);
        
        playSpace = new PlaySpace(this);

        new Ant(100, 0, this);
        new SpiderStrider(0, 0, this);

        selected = new NodeEntity(this);

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

        if (Key.isDown(Key.MOUSE_RIGHT) &&
            (s2d.mouseX != lastMouseX ||
             s2d.mouseY != lastMouseY)) {
            camera.x -= s2d.mouseX - lastMouseX;
            camera.y -= s2d.mouseY - lastMouseY;
        }

        if (Key.isPressed(Key.QWERTY_EQUALS) ||
            Key.isPressed(Key.MOUSE_WHEEL_UP)) {
            camera.sscale *= 2;
        }
        if (Key.isPressed(Key.QWERTY_MINUS) ||
            Key.isPressed(Key.MOUSE_WHEEL_DOWN)) {
            camera.sscale /= 2;
        }

        if (camera.sscale < 1)
            camera.sscale = 1;
    }

    override function postUpdate() {
        super.postUpdate();
        updateGUI();

        lastMouseX = s2d.mouseX;
        lastMouseY = s2d.mouseY;
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
        new Toast(x, y - 5, -10, '+${score}', 0x00FF00, this, this.worldlyHudLayer);
    }

    // USAGE: if (cashCheckToast(5, x, y, "Not enough money!")) return;
    public function cashCheckToast(required, x, y, text) {
        if (money < required) {
            new Toast(x, y, 3, text, 0xFF0000, this);
            return true;
        }
        money -= required;
        new Toast(x, y, 3, '-$$$required', 0xFF0000, this);
        return false;
    }

    public function addMoney(x:Float, y:Float, money:Int) {
        this.money += money;
        new Toast(x, y + 5, 3, '+${money}', 0x00FF00, this, this.worldlyHudLayer);
    }
}