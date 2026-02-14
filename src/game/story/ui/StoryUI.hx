package game.story.ui;

@:uiComp("story-button")
class StoryButton extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <story-button>
            <text public id="number"/>
            <text public id="label"/>
        </story-button>;
    
    @:p public var text(default, set): String;
    function set_text(t)
        return label.text = t;
    @:p public var num(default, set): String;
    function set_num(t)
        return number.text = t;

    public function new(?parent) {
        super(parent);
        initComponent();

        enableInteractive = true;
        interactive.cursor = Button;
        interactive.onClick = _->{
            interactive.cursor = Default;
            onClick();
        }
        interactive.onOver = _->{
            interactive.cursor=Button;
            dom.hover = true;
        }
        interactive.onOut = _->{
            dom.hover = false;
        }
    }

    public dynamic function onClick() {

    }
}

class StoryUI implements h2d.domkit.Object extends h2d.Flow {
    static var SRC =
        <story-u-i>
            <bitmap src="logo.png"/>
            <flow>
                <story-button public id="b0" num={"0"} text={"Intro"}/>
                <story-button public id="b1" num={"1"} text={"Tutorial"}/>
            </flow>
            <flow>
                <story-button public id="b2" num={"2"} text={"Start"}/>
                <story-button public id="b3" num={"3"} text={"Vent"}/>
                <story-button public id="b4" num={"4"} text={"Hack"}/>
                <story-button public id="b5" num={"5"} text={"Dodge"}/>
            </flow>
            <flow>
                <story-button public id="fp" num={""} text={"Free\nPlay"}/>
                <story-button public id="cr" num={""} text={"Credits"}/>
            </flow>
        </story-u-i>;
    
    public function new(?parent) {
        super(parent);
        initComponent();

        GameEngine.style.addObject(this);
    }
}