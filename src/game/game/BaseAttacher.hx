package game.game;

import h2d.Object;

class BaseAttacher extends MGEntity {
    var parent: Object;

    public function new(?g, ?layer) {
        super(g, layer);

        parent = new Object(spr);
    }

    function lookAt(from: Entity<BaseMainGame>, to: Entity<BaseMainGame>) {
        x = from.x;
        y = from.y;
        var dx = to.x - x;
        var dy = to.y - y;
        var dist = M.hypot(dx, dy);
        parent.scaleY = dist / 2;
        parent.rotation = Math.atan2(dy, dx) + Math.PI / 2;
    }
}