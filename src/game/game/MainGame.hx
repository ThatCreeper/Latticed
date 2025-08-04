package game.game;

import hxd.Key;
import h2d.col.Point;
import game.game.ui.CameraCoords;

class MainGame extends Game {
    public var selected: NodeEntity;
    public var cursor: NodeCursor;
    var camCoords: CameraCoords;

    public function new() {
        super();
        camera.scale = 3;

        selected = new NodeEntity(this);
        selected.frozen = true;

        new CursorAttacher(this, worldlyHudLayer);
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
    }

    override function postUpdate() {
        super.postUpdate();
        camCoords.cx.text = Std.string(Math.floor(camera.x));
        camCoords.cy.text = Std.string(Math.floor(camera.y));
        camCoords.e.text = Std.string(entities.length);
        camCoords.t.text = Std.string(selected.timeRemaining);
    }
}