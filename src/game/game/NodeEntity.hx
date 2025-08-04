package game.game;

import h2d.Graphics;

class NodeEntity extends Entity<MainGame> {
    public var maxTimeRemaining = 15.0;
    public var timeRemaining = 0.0;
    public var frozen = false;
    public var connections = new List<NodeAttacher>();
    
    public function new(?g, ?layer) {
        super(g, layer);
        var graphic = new Graphics();
        graphic.beginFill(0xFFFFFF);
        graphic.drawRoundedRect(-4, -4, 8, 8, 1);
        graphic.endFill();
        spr.addChild(graphic);

        timeRemaining = maxTimeRemaining;
    }

    override function update() {
        super.update();
        if (frozen)
            return;
        timeRemaining -= deltaTime * Math.pow(0.9, connections.length);
        if (timeRemaining <= 0) {
            remove();
            for (attacher in connections) {
                attacher.remove();
            }
            return;
        }
        spr.alpha = timeRemaining / maxTimeRemaining;
    }
}