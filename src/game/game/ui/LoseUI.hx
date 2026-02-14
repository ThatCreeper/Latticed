package game.game.ui;

import h2d.Text;
import h2d.Interactive;

class LoseUI extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <lose-u-i>
            <text class="header" text={won ? "Victory!" : "You lost!"}/>
            <html-text class="score" text={'Ending score: <font color="#00FF00">$score</font>'}/>
            <lose-button id="scrnsht" text={"Save a picture"}/>
            <lose-button id="exit" text={"Exit to menu"}/>
            <lose-button id="restartbtn" text={"Start anew"}/>
            <lose-button id="btn" text={"Keep playing..."}/>
        </lose-u-i>;

    public function new(won:Bool, score:Float, ?parent) {
        super(parent);
        initComponent();

        GameEngine.style.addObject(this);
        exit.onClick = ()->exitToMenu();
        btn.onClick = ()->keepPlaying();
        scrnsht.onClick = ()->screenshot();
        restartbtn.onClick = ()->restart();
    }

    public dynamic function keepPlaying() {}
    public dynamic function screenshot() {}
    public dynamic function exitToMenu() {}
    public dynamic function restart() {}
}