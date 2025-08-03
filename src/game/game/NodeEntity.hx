package game.game;

import h2d.Graphics;

class NodeEntity extends Entity<MainGame> {
    public function new(?g, ?layer) {
        super(g, layer);
        var graphic = new Graphics();
        graphic.beginFill(0xFFFFFF);
        graphic.drawRoundedRect(-16, -16, 32, 32, 4);
        graphic.endFill();
        spr.addChild(graphic);
    }
}