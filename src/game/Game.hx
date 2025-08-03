package game;

import h2d.col.Point;

class Game extends TimeAware {
    public var entities: List<Entity<Dynamic>>;
    public var hudLayer: h2d.Object;
    public var bgLayer: h2d.Object;
    public var gameLayer: h2d.Object;
    public var s2d: h2d.Scene;
    public var camera: Camera;

    public var scrwid(get, never): Int;
        function get_scrwid() {
            return s2d.width;
        }
    public var scrhei(get, never): Int;
        function get_scrhei() {
            return s2d.height;
        }

    public function new() {
        initLayers();
        entities = new List();
        camera = new Camera();
    }

    function initLayers() {
        s2d = Main.newScene();
        hudLayer = new h2d.Object();
        bgLayer = new h2d.Object();
        gameLayer = new h2d.Object();
        s2d.add(bgLayer, 0);
        s2d.add(gameLayer, 1);
        s2d.add(hudLayer, 2);
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
        reverseHudCamera();
    }

    public function reverseHudCamera() {
        var pos = new Point();
        @:privateAccess s2d.camera.sync(null, true);
        s2d.camera.cameraToScreen(pos);
        hudLayer.setScale(1 / s2d.camera.scaleX);
        hudLayer.x = -pos.x / s2d.camera.scaleX;
        hudLayer.y = -pos.y / s2d.camera.scaleX;
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
}