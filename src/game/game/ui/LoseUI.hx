package game.game.ui;

class LoseUI extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <lose-u-i>
            <text class="header" text={"You lost!"}/>
            <html-text class="score" text={'Ending score: <font color="#00FF00">$score</font>'}/>
        </lose-u-i>;

    public function new(score:Float, ?parent) {
        super(parent);
        initComponent();

        Main.style.addObject(this);
    }
}