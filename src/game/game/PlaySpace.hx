package game.game;

class PlaySpace extends MGEntity {
    var minX = 0.0;
    var maxX = 0.0;
    var minY = 0.0;
    var maxY = 0.0;

    public function new(g, ?l) {
        super(g, l);
    }

    public function register(x, y) {
        var score = 0.0;
        if (x < minX) {
            score += minX - x;
            minX = x;
        } else if (x > maxX) {
            score += x - maxX;
            maxX = x;
        }
        if (y < minY) {
            score += minY - y;
            minY = y;
        } else if (y > maxY) {
            score += y - minY;
            maxY = y;
        }
        if (score == 0) return;
        game.addScore(x, y - 20, Math.ceil(score));
    }
}