package game.game;

import h2d.Text;
import h2d.Tile;
import haxe.exceptions.NotImplementedException;
import h2d.Interactive;
import h2d.Bitmap;
import game.Entity;
import hxd.Key;
import h2d.col.Point;
import game.game.ui.CameraCoords;

// TODO: Free play mode
abstract class BaseMainGame extends Game {
    public var selected: NodeEntity;
    public var cursor: NodeCursor;
    var camCoords: CameraCoords;
    public var score = 0;
    public var money = 100;
    public var playSpace: PlaySpace;

    public var timeUntilDeath = 10.99;
    public var deathTime = 4;
    public var gameOvered = false;

    var lastMouseX = 0.0;
    var lastMouseY = 0.0;
	public var placeDelay = 0;

    var deathOverlay:Bitmap;
    var deathText:Text;

    public function new() {
        super();
        // TODO: This is just debug
        camera.scale = 2;
        camera.shakeIntensity = 1;
        money = 100000;

        // new Background(this, bgLayer);
        
        playSpace = new PlaySpace(this);

        // new Ant(100, 0, this);
        // new SpiderStrider(0, 0, this);

        selected = new NodeEntity(this);

        cursor = new NodeCursor(this, worldlyHudLayer);
        deathOverlay = new Bitmap(Tile.fromColor(0xFF0000, 1, 1), hudLayer);
        deathOverlay.setScale(10000);
        deathOverlay.alpha = 0;
        deathText = new Text(hxd.res.DefaultFont.get(), hudLayer);
        deathText.textAlign = Center;
        deathText.setScale(3);

        camCoords = new CameraCoords(0, 0, hudLayer);
        // #if !debug
        // camCoords.visible = false;
        // #end
    }

    function removeUI() {
        finishButton?.remove();
        freePlayIcon?.remove();
    }

    public var finishButton:Null<Interactive>;
    var freePlayIcon:Null<Bitmap> = null;

    function addFreePlayUI() {
        freePlayIcon = new Bitmap(hxd.Res.freeplay.toTile(), hudLayer);
        finishButton = new Interactive(90, 56, hudLayer); // FINISH BUTTON HARDCODED
        new Bitmap(hxd.Res.finish.toTile(), finishButton);
        finishButton.onClick = finish;
        camCoords.visible = false;
    }

    function finish(e:hxd.Event) {
        money = 0;
        timeUntilDeath = -1;
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
            (mouseX != lastMouseX ||
             mouseY != lastMouseY)) {
            camera.x -= mouseX - lastMouseX;
            camera.y -= mouseY - lastMouseY;
        }

        if (Key.isPressed(Key.QWERTY_EQUALS) ||
            Key.isPressed(Key.MOUSE_WHEEL_UP) ||
            Key.isPressed(61) /* firefox */) {
            camera.sscale *= 2;
        }
        if (Key.isPressed(Key.QWERTY_MINUS) ||
            Key.isPressed(Key.MOUSE_WHEEL_DOWN) ||
            Key.isPressed(173) /* firefox */) {
            camera.sscale /= 2;
        }

        if (camera.sscale < 1)
            camera.sscale = 1;

        if (!gameOvered) {
            if (money <= 0) {
                timeUntilDeath -= deltaTime;
            } else {
                timeUntilDeath = deathTime - 0.01;
            }
            if (timeUntilDeath <= 0) {
                die();
            }
        }
        deathOverlay.alpha = M.lerpC(deathOverlay.alpha,
            if (timeUntilDeath > deathTime - 0.1)
                0
            else
                0.5, deltaTime / deathTime);
        if (timeUntilDeath > deathTime - 0.1) {
            deathText.visible = false;
        } else {
            deathText.visible = true;
            deathText.text = '${Math.max(0, Math.floor(timeUntilDeath))}';
            deathText.x = scrwid / 2;
            deathText.y = (scrhei - deathText.textHeight * 3) / 2;
            deathText.alpha = deathOverlay.alpha;
        }

        // if (Key.isPressed(Key.Q))
        //     playSpace.screenshot();

        if (Key.isPressed(Key.ESCAPE) && !gameOvered && !isPaused())
            new PauseScreen(this, hudLayer);

        placeDelay--;
    }

    override function postUpdate() {
        super.postUpdate();
        updateGUI();

        lastMouseX = mouseX;
        lastMouseY = mouseY;
    }

    public function die() {
        if (gameOvered) return;
        gameOvered = true;
        cursor.remove();
        new LoseScreen(false, this, hudLayer);
        hxd.Res.latticed_lose.play();
    }

    public function win() {
        gameOvered = true;
        cursor.remove();
        new LoseScreen(true, this, hudLayer);
        hxd.Res.latticed_win.play();
    }

    function updateGUI():Void {
        // camCoords.cx.text = Std.string(Math.floor(camera.x));
        // camCoords.cy.text = Std.string(Math.floor(camera.y));
        // camCoords.e.text = Std.string(entities.length);
        // camCoords.t.text = Std.string(Math.floor(timeUntilDeath));
        camCoords.p.text = Std.string(score);
        camCoords.m.text = Std.string(money);

        finishButton?.x = scrwid - finishButton.width;
    }

    public function addScore(x:Float, y:Float, score:Int) {
        this.score += score;
        new Toast(x, y - 5, -10, '+${score}', 0x00FF00, this, this.worldlyHudLayer);
    }

    // USAGE: if (cashCheckToast(5, x, y, "Not enough money!")) return;
    public function cashCheckToast(required, x, y, text) {
        if (money < required) {
            new Toast(x, y, 3, text, 0xFF0000, this);
            hxd.Res.latticed_nomoney.play();
            return true;
        }
        money -= required;
        new Toast(x, y, 3, '-$required', 0xfdcea8, this);
        return false;
    }

    public function addMoney(x:Float, y:Float, money:Int) {
        this.money += money;
        new Toast(x, y + 5, 3, '+${money}', 0xfdcea8, this, this.worldlyHudLayer);
    }

    override function dispose() {
        super.dispose();
    }

    public function keepPlaying() {
        if (!gameOvered) return;
        money = 100000;
        timeUntilDeath = 11;
        deathTime = 1;
        gameOvered = false;
        removeIf(e->e is LoseScreen);
        cursor = new NodeCursor(this, worldlyHudLayer);
        placeDelay = 3;
        removeUI();
        addFreePlayUI();
    }
    
    public abstract function restart():Void;

    public function onNewNode() {}
    public function onFailedCrowdedNode() {}

    public function isPaused() {
        return instanceExists(e->e is PauseScreen || e is OverlayEntity);
    }

    public function isValidNodeSpot(x:Float,y:Float,sx:Float,sy:Float): Bool {
        return true;
    }
}