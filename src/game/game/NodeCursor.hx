package game.game;

import hxd.Key;
import h2d.Graphics;

class NodeCursor extends Entity<MainGame> {
    var attacher: CursorAttacher;

    public function new(g, ?layer) {
        super(g, layer);
        var graphic = new Graphics();
        graphic.beginFill(0x0000FF);
        graphic.drawRoundedRect(-3, -3, 6, 6, 1);
        graphic.endFill();
        spr.addChild(graphic);
        
        attacher = new CursorAttacher(g, g.worldlyHudLayer);
    }

    override function update() {
        super.update();

        x = game.s2d.mouseX;
        y = game.s2d.mouseY;

        var dx = x - game.selected.x;
        var dy = y - game.selected.y;

        var numCloseNodes = 1;

        for (node in game.entities) {
            if (!(node is NodeEntity))
                continue;
            if (node == game.selected)
                continue;
            var node: NodeEntity = cast(node);
            var dx1 = x - node.x;
            var dy1 = y - node.y;
            var hypot = M.hypotSqr(dx1, dy1);
            if (hypot <= 75 * 75)
                numCloseNodes++;
            if (hypot * 2 < M.hypotSqr(dx, dy)) {
                game.selected = node;
                dx = dx1;
                dy = dy1;
            }
        }

        // attacher.spr.visible = numCloseNodes <= 5;

        var overlappingAnt:Ant = null;
        for (ant in game.entities) {
            if (!(ant is Ant))
                continue;
            var ant:Ant = cast ant;
            if (ant.harvester == null && ant.overlapsXY(x, y)) {
                overlappingAnt = ant;
                break;
            }
        }

        if (overlappingAnt == null) {
            if (dx * dx + dy * dy > 75 * 75) {
                var dist = Math.sqrt(dx * dx + dy * dy);
                dx = dx / dist * 75;
                dy = dy / dist * 75;
                x = dx + game.selected.x;
                y = dy + game.selected.y;
            }
            y = Math.max(0, y);
        }

        if (Key.isReleased(Key.MOUSE_LEFT)) {
            if (overlappingAnt != null) {
                harvestAnt(overlappingAnt);
            } else {
                placeNewNode(numCloseNodes);
            }
        }
    }

    function harvestAnt(ant:Ant) {
        // TODO: Check to make sure that it's actually within range=75.
        // TODO: Make the range not a magic number plastered everywhere.
        game.addScore(x, y, 50);
        game.addMoney(x, y, 25);
        ant.harvester = placeNewNodeImpl();
    }

    function placeNewNode(connections) {
        trace("Place!");

        if (connections > 5) {
            new Toast(x, y, 3, "Too many connections!", 0xFF0000);

            return;
        }

        if (game.cashCheckToast(5, x, y + 5, "You need 5 nutrients\nto make a node!")) return;

        var ent = placeNewNodeImpl();

        game.addScore(x, y, M.imin(10 * ent.connections.length, 50));
        // hxd.Res.winnav.play();
    }
    
    function placeNewNodeImpl():NodeEntity {
        var ent = new NodeEntity();
        ent.x = x;
        ent.y = y;
        camera.sx = ent.x;
        camera.sy = ent.y;
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