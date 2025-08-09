package game.game;

import h2d.Bitmap;
import hxd.snd.effect.Pitch;
import hxd.Key;
import h2d.Graphics;

class NodeCursor extends MGEntity {
    var attacher: CursorAttacher;

    public function new(g, ?layer) {
        super(g, layer);
        // var graphic = new Graphics();
        // graphic.beginFill(0x0000FF);
        // graphic.drawRoundedRect(-3, -3, 6, 6, 1);
        // graphic.endFill();
        // spr.addChild(graphic);
        var bitmap = new Bitmap(hxd.Res.node.toTile(), spr);
        bitmap.x = bitmap.y = -4;
        
        attacher = new CursorAttacher(g, g.worldlyHudLayer);
        attach(attacher);
    }

    override function update() {
        super.update();

        x = game.mouseX;
        y = game.mouseY;

        var dx = x - game.selected.x;
        var dy = y - game.selected.y;

        // TODO: ONLY DO THIS IF (a) SELECTED.DISPOSED OR (b) MOUSE HAS MOVED
        for (node in game.entities) {
            if (!(node is NodeEntity))
                continue;
            if (node == game.selected)
                continue;
            var node: NodeEntity = cast(node);
            var dx1 = x - node.x;
            var dy1 = y - node.y;
            var hypot = M.hypotSqr(dx1, dy1);
            if (game.selected.disposed || hypot * 2 < M.hypotSqr(dx, dy)) {
                game.selected = node;
                dx = dx1;
                dy = dy1;
            }
        }

        // attacher.spr.visible = numCloseNodes <= 5;

        if (dx * dx + dy * dy > 75 * 75) {
            var dist = Math.sqrt(dx * dx + dy * dy);
            dx = dx / dist * 75;
            dy = dy / dist * 75;
            x = dx + game.selected.x;
            y = dy + game.selected.y;
        }

        var overlappingCreature:Creature = null;
        for (ant in game.entities) {
            if (!(ant is Creature))
                continue;
            var ant:Creature = cast ant;
            if (ant.harvester == null && ant.overlapsXY(x, y)) {
                overlappingCreature = ant;
                break;
            }
        }

        // TODO: this is wrong but not fully wrong
        // if (overlappingCreature == null) {
        //     y = Math.max(0, y);
        // }

        if (Key.isReleased(Key.MOUSE_LEFT) &&
            game.placeDelay < 0) {
            if (overlappingCreature != null) {
                harvestCreature(overlappingCreature);
            } else {
                placeNewNode();
            }
        }
    }

    function harvestCreature(creature:Creature) {
        // TODO: Check to make sure that it's actually within range=75.
        // TODO: Make the range not a magic number plastered everywhere.
        creature.harvest(placeNewNodeImpl());
        game.onNewNode();
    }

    function placeNewNode() {
        trace("Place!");

        var connections = 0;
        for (node in game.entities) {
            if (!(node is NodeEntity))
                continue;
            if (M.distSqr(x, y, node.x, node.y) < 75 * 75)
                connections++;
        }

        if (connections > 5) {
            connectionsToast();
            return;
        }

        if (game.cashCheckToast(5, x, y + 5, "You need 5 nutrients\nto make a node!")) return;

        if (game.s2d.mouseX < scrwid / 3 ||
            game.s2d.mouseX > (scrwid * 2) / 3 ||
            game.s2d.mouseY < scrhei / 3 ||
            game.s2d.mouseY > (scrhei * 2) / 3) {
            camera.sx = x;
            camera.sy = y;
        }
        var ent = placeNewNodeImpl();

        game.addScore(x, y, M.imin(10 * ent.connections.length, 50));
        game.playSpace.register(x, y);
        hxd.Res.latticed_place.play();
        game.onNewNode();
    }

    function connectionsToast() {
        new Toast(x, y, 3, "Too many connections!", 0xFF0000);
        hxd.Res.latticed_nomoney.play();
    }
    
    function placeNewNodeImpl():NodeEntity {
        var ent = new NodeEntity();
        ent.x = x;
        ent.y = y;
        game.selected = ent;

        for (node in game.entities) {
            if (!(node is NodeEntity))
                continue;
            var node:NodeEntity = cast(node);
            if (node == ent)
                continue;
            if (M.distSqr(node.x, node.y, ent.x, ent.y) > 76 * 76) // floating point bug prevention
                continue;
            var attacher = new NodeAttacher(node, ent);
            node.connections.add(attacher);
            ent.connections.add(attacher);
        }

        return ent;
    }
}