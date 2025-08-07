package game.game.ui;

import h2d.Text;
import h2d.Interactive;

@:uiComp("lose-button")
class LoseButton extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <lose-button>
            <text public id="label" text={btext}/>
        </lose-button>;
    
    public function new(btext:String,?parent) {
        super(parent);
        initComponent();

        enableInteractive = true;
        interactive.onClick = _->onClick;
    }

    public dynamic function onClick() {

    }
}

class LoseUI extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <lose-u-i>
            <text class="header" text={"You lost!"}/>
            <html-text class="score" text={'Ending score: <font color="#00FF00">$score</font>'}/>
            <lose-button btext={"Continue playing..."} public id="contbtn"/>
        </lose-u-i>;

    public function new(score:Float, ?parent) {
        super(parent);
        initComponent();

        Main.style.addObject(this);
    }
}