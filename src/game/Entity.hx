package game;

import h2d.Object;

class Entity<T: Game = Game> extends TimeAware {
    public var game: T;
    public var spr: Object;
    public var x: Float = 0;
    public var y: Float = 0;
    public var scale: Float = 1;
    public var rotation: Float = 0;
    public var pixelRounding = true;

    public var camera(get, never): Camera;
        function get_camera() {
            return game.camera;
        }

    public var scrwid(get, never): Int;
        function get_scrwid() {
            return game.scrwid;
        }
    public var scrhei(get, never): Int;
        function get_scrhei() {
            return game.scrhei;
        }
    
    var attached: List<Entity<T>>;
    var disposed = false;
    
    public function new(?g: T, ?layer) {
        if (g == null)
            g = cast (Main.INST.game);
        game = g;
        game.addEntity(cast this);

        spr = new Object(layer ?? game.gameLayer);

        attached = new List();
    }

    public function preUpdate() {
        updateCooldowns();
    }

    public function update() {

    }

    public function postUpdate() {
        if (pixelRounding) {
            spr.x = Math.floor(x);
            spr.y = Math.floor(y);
        } else {
            spr.x = x;
            spr.y = y;
        }
        spr.scaleX = scale;
        spr.scaleY = scale;
        spr.rotation = rotation;

        if (cd.has("shake")) {
            spr.x += (Math.random() - 0.5) * 2 * 2 / scale;
            spr.y += (Math.random() - 0.5) * 2 * 2 / scale;
        }
    }

    public function tick() {

    }

    public function remove() {
        game.removeEntity(cast this);
    }

    public function dispose() {
        if (disposed)
            return;
        disposed = true;
        for (e in attached)
            e.remove();
        spr.remove();
        onDispose();
    }

    public function onDispose() {

    }

    public function shake(s) {
        cd.setS("shake", s);
    }

    public function attach(e) {
        attached.add(e);
    }
}