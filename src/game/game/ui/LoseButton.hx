package game.game.ui;

@:uiComp("lose-button")
class LoseButton extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <lose-button>
            <text public id="label"/>
        </lose-button>;
    
    @:p public var text(default, set): String;
    function set_text(t)
        return label.text = t;

    public function new(?parent) {
        super(parent);
        initComponent();

        enableInteractive = true;
        interactive.cursor = Button;
        interactive.onClick = _->{
            interactive.cursor = Default;
            onClick();
        }
        interactive.onOver = _->interactive.cursor=Button;
    }

    public dynamic function onClick() {

    }
}