package game.game.ui;

class PauseUI extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <pause-u-i>
            <text class="header" text={"Pause"}/>
            <lose-button id="scrnsht" text={"Save a picture"}/>
            <lose-button id="exit" text={"Exit to menu"}/>
            <lose-button id="cont" text={"Continue"}/>
        </pause-u-i>;

    public function new(score:Float, ?parent) {
        super(parent);
        initComponent();

        GameEngine.style.addObject(this);
        scrnsht.onClick = ()->screenshot();
        exit.onClick = ()->exitToMenu();
        cont.onClick = ()->continueGame();
    }

    public dynamic function screenshot() {}
    public dynamic function exitToMenu() {}
    public dynamic function continueGame() {}
}