package game.game;

import hxd.Key;
import h2d.col.Point;
import game.game.ui.CameraCoords;

class MainGame extends Game {
    var camCoords: CameraCoords;

    public function new() {
        super();
        camera.scale = 3;
        addEntity(new NodeEntity(this));
        
        camCoords = new CameraCoords(0, 0, hudLayer);
    }

    override function update() {
        super.update();

        if (Key.isDown(Key.LEFT))
            camera.sx -= 1 * tmod;
        if (Key.isDown(Key.RIGHT))
            camera.sx += 1 * tmod;
        if (Key.isDown(Key.UP))
            camera.sy -= 1 * tmod;
        if (Key.isDown(Key.DOWN))
            camera.sy += 1 * tmod;
    }

    override function postUpdate() {
        super.postUpdate();
        camCoords.cx.text = Std.string(Math.floor(camera.x));
        camCoords.cy.text = Std.string(Math.floor(camera.y));
    }
}