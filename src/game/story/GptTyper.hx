package game.story;

import h2d.Text;

class GptTyper extends Entity<World0> {
    var text: Text;
    var fullText: String;
    var index: Float;
    public var delay = 0.0;
    public var moving = true;

    public function new(start, more:String, ?g, ?l) {
        super(g, l);

        text = new Text(hxd.res.DefaultFont.get(), spr);
        scale = 2;
        text.textColor = 0xFFFFFF;
        // text.text = start;
        fullText = start + more;
        // index = start.length;
        index = 0;
    }

    override function update() {
        super.update();

        if (delay > 0) {
            delay -= deltaTime;
        } else {
            index += deltaTime * 25;
        }
        text.text = fullText.substr(0, Math.floor(Math.min(index, fullText.length)));

        var maxHei = scrhei * 2 / 3;
        if (moving && text.textHeight * 2 > maxHei) {
            y = M.lerpC(y, maxHei - text.textHeight * 2, deltaTime);
        }
    }

    public function finished() {
        return index >= fullText.length;
    }

    public function add(more:String) {
        index = Math.min(index, fullText.length);
        fullText += more;
    }

    public function addInstant(more:String) {
        fullText += more;
        index = fullText.length;
    }
    
    public function glow(part:String) {
        var lines = fullText.split("\n");
        var lastLine = lines[lines.length - 1];
        var lastLineBefore = lastLine.substr(0, lastLine.length - part.length);
        var text = new Text(hxd.res.DefaultFont.get(), spr);
        text.textColor = 0xFF0000;
        text.text = lastLineBefore;
        text.x = text.textWidth;
        text.y = this.text.textHeight - text.textHeight;
        text.text = part;
        this.text.alpha = 0.5;
    }
}