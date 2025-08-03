package game;

import h2d.Tile;
import h2d.domkit.Style;

class Hud {
    var style: Style;

    public function new(?parent) {
        style = new Style();
        //style.load(hxd.Res.style);
        style.allowInspect = true;
    }

    public function dispose() {
        
    }
}