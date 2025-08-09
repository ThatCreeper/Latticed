package game;

import h2d.col.Point;

class Game extends TimeAware {
    public var entities: List<Entity<Dynamic>>;
    public var hudLayer: h2d.Object;
    public var worldlyHudLayer: h2d.Object;
    public var bgLayer: h2d.Object;
    public var gameLayer: h2d.Object;
    public var s2d: h2d.Scene;
    public var camera: Camera;

    public var hudCamera: h2d.Camera;

    public var scrwid(get, never): Int;
        function get_scrwid() {
            return s2d.width;
        }
    public var scrhei(get, never): Int;
        function get_scrhei() {
            return s2d.height;
        }
    
    public var mouseX(get, never): Float;
        function get_mouseX() {
            // Stupid, bad solution. But...
            @:privateAccess s2d.camera.sync(null, true);
            var pt = new Point(s2d.mouseX, 0);
            s2d.camera.screenToCamera(pt);
            return pt.x;
        }
    public var mouseY(get, never): Float;
        function get_mouseY() {
            @:privateAccess s2d.camera.sync(null, true);
            var pt = new Point(0, s2d.mouseY);
            s2d.camera.screenToCamera(pt);
            return pt.y;
        }

    public function new() {
        initLayers();
        entities = new List();
        camera = new Camera();

        hudCamera = new h2d.Camera(s2d);
        hudCamera.layerVisible = (idx) -> idx == 3;
        s2d.camera.layerVisible = (idx) -> idx != 3;
        s2d.interactiveCamera = hudCamera;
    }

    function initLayers() {
        s2d = Main.newScene();
        hudLayer = new h2d.Object();
        bgLayer = new h2d.Object();
        gameLayer = new h2d.Object();
        worldlyHudLayer = new h2d.Object();
        s2d.add(bgLayer, 0);
        s2d.add(gameLayer, 1);
        s2d.add(worldlyHudLayer, 2);
        s2d.add(hudLayer, 3);
    }
    
    public function preUpdate() {
        updateCooldowns();
        for (e in entities)
            e.preUpdate();
    }

    public function update() {
        for (e in entities)
            e.update();
    }

    public function postUpdate() {
        for (e in entities)
            e.postUpdate();
        camera.update(s2d, Main.GameSpeed > 0.1 && cd.has("shake"));
    }

    public function tick() {
        for (e in entities)
            e.tick();
    }

    public function dispose() {
        for (e in entities)
            e.dispose();
    }

    public function removeEntity(e) {
        entities.remove(e);
        e.dispose();
    }

    public function addEntity(e) {
        entities.add(e);
    }

    public function shake(s) {
        cd.setS("shake", s);
    }

    public function clear() {
        for (e in entities) e.dispose();
        entities.clear();
    }

    public function removeIf(pred:Entity<Dynamic>->Bool) {
        for (e in entities)
            if (pred(e))
                e.remove();
    }

    public function instanceExists(pred:Entity<Dynamic>->Bool) {
        for (e in entities)
            if (pred(e))
                return true;
        return false;
    }
}