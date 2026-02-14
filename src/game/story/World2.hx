package game.story;

import h2d.Bitmap;
import game.game.BaseMainGame;

class World2 extends BaseMainGame {    
    public function new() {
        super();

        var bg = new Bitmap(hxd.Res.world2.toTile(), bgLayer);
        bg.x = -100;

        MusicManager.set(hxd.Res.latticed);

        selected.x = 188;
        selected.y = 145;
        cursor.placeNodeProgramatically(177, 120);
        cursor.placeNodeProgramatically(184, 94);
        camera.x = selected.x;
        camera.y = selected.y;
        new EndPoint(47, 106, this);
        new LoreComputer(291, 89, 109, 71, hxd.Res.terminal.toTile(), 4, this);

        money = 15;

        new TextBox("Reach the crack", this, hudLayer);
    }

    public function restart() {
        GameEngine.setGame(new World2());
    }

    override function isValidNodeSpot(x:Float, y:Float, sx:Float, sy:Float):Bool {
        // if (x >= 176 && x <= 191 && y >= 88 && y <= 152)
        //     return false;
        if (x >= 176 && sx < 176 && y >= 88 && y <= 152) return false;
        if (x <= 191 && sx > 191 && y >= 88 && y <= 152) return false;
        if (y <= 152 && sy > 152 && x >= 176 && x <= 191) return false;
        if (y >= 160) return false;
        return super.isValidNodeSpot(x, y, sx, sy);
    }

    override function win() {
        super.win();
        PersistentGameState.mark_flag(PersistentFlags.MapWonWorld2);
    }
}