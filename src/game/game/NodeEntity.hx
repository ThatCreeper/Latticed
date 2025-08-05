package game.game;

import h2d.Graphics;

class NodeEntity extends Entity<MainGame> {
    public var maxTimeRemaining = 60.0;
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
        // if (game.selected == this)
        //     return;
        // var q = connections.length;
        // timeRemaining -= deltaTime * ( Math.pow(Math.pow(1.05, 2 * q) - 1,
        //                                         2)
        //                              - Math.pow(1.1, q)
        //                              + 2);
        // if (timeRemaining <= 0) {
        //     remove();
        //     return;
        // }
        // spr.alpha = timeRemaining / maxTimeRemaining;
    }

    override function onDispose() {
        super.onDispose();
        
        for (attacher in connections) {
            attacher.remove();
        }
    }
}