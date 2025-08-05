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

        x = game.s2d.mouseX + 0;
        y = Math.max(0, game.s2d.mouseY);

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

        if (dx * dx + dy * dy > 75 * 75) {
            var dist = Math.sqrt(dx * dx + dy * dy);
            dx = dx / dist * 75;
            dy = dy / dist * 75;
            x = dx + game.selected.x;
            y = dy + game.selected.y;
        }

        if (Key.isReleased(Key.MOUSE_LEFT)) {
            placeNewNode();
        }
    }

    function placeNewNode() {
        trace("Place!");

        if (game.cashCheckToast(5, x, y, "You need 5 nutrients\nto make a node!")) return;

        game.selected.frozen = false;
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

        // if (ent.connections.length > 5) {
        //     ent.remove();
            
        //     new Toast(ent.x, ent.y, "Too many connections!");

        //     return;
        // }

        game.addScore(ent.x, ent.y, M.imin(10 * ent.connections.length, 50));
        // hxd.Res.winnav.play();
    }
}