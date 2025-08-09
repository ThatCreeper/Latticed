package game.game;

class FreePlayGame extends BaseMainGame {
    public function new() {
        super();
        deathTime = 1;
        addFreePlayUI();
        hxd.Res.latticed.play(true, 0).fadeTo(0.6);
    }

    override function dispose() {
        super.dispose();
        
        hxd.Res.latticed.stop();
    }

    // override function addScore(x:Float, y:Float, score:Int) {
    //     this.score += score;
    // }

    // // USAGE: if (cashCheckToast(5, x, y, "Not enough money!")) return;
    // override function cashCheckToast(required, x, y, text) {
    //     if (money < required) {
    //         new Toast(x, y, 3, text, 0xFF0000, this);
    //         hxd.Res.latticed_nomoney.play();
    //         return true;
    //     }
    //     money -= required;
    //     return false;
    // }
    
    // override function addMoney(x:Float, y:Float, money:Int) {
    //     this.money += money;
    // }

    public function restart() {
        Main.setGame(new FreePlayGame());
    }
}