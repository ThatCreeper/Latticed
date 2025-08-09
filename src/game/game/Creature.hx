package game.game;

abstract class Creature extends MGEntity {
    public var harvester:Null<NodeEntity> = null;
    public var lastX: Float;
    public var lastY: Float;
    public var startX: Float;
    public var startY: Float;

    public function new(x, y, ?g, ?l) {
        super(g, l);

        this.x = lastX = startX = x;
        this.y = lastY = startY = y;
    }

    override function update() {
        super.update();

        if (game.gameOvered) return;
        
        // spr.alpha = harvester == null ? 1.0 : 0.5;

        midUpdate();

        if (harvester != null) {
            updateHarvesters();
        }

        lastX = x;
        lastY = y;
    }

    function midUpdate() {}

    function updateHarvesters():Void {
        // TODO: If Y mod is never added, simplify to += 5 * delta or whatever
        harvester.x += x - lastX;
        harvester.y += y - lastY;

        for (connection in harvester.connections) {
            if (connection.lengthSqr() > 400 * 400) {
                connection.remove();
                continue;
            }
            connection.updateLookAt();
        }

        if (harvester.connections.length == 0) {
            remove();
            return;
        }

        postUpdateHarvesters();
    }

    public function harvest(spawnedHarvestNode:NodeEntity) {
        // game.addScore(x, y, 50);
        // game.addMoney(x, y, 25);
        harvester = spawnedHarvestNode;
    }

    function postUpdateHarvesters() {}
    public abstract function getCenterX():Float;
    public abstract function getCenterY():Float;
    public abstract function overlapsXY(x:Float,y:Float):Bool;
}