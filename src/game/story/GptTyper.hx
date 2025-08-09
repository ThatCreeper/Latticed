package game.story;

import h2d.Text;

class GptTyper extends Entity<World0> {
    var text: Text;
    var fullText: String;
    var index: Float;
    public var delay = 0.0;
    public var moving = false;
    public var fullScrollText = "";
    public var finalScrollLineStart: Null<String> = null;
    public var finalScrollLineWord: Null<String> = null;
    var scrollTime = 0.0;
    public var scrollDur = 1.0;
    public var fading = false;
    public var targetCameraZoom = 0.0;
    var startCameraZoom = 0.0;
    var overlay: Text;

    public function new(start, more:String, ?g, ?l) {
        super(g, l);

        text = new Text(hxd.res.DefaultFont.get(), spr);
        scale = 2;
        text.textColor = 0xFFFFFF;
        // text.text = start;
        fullText = start + more;
        // index = start.length;
        index = 0;
        startCameraZoom = camera.scale;
    }

    override function update() {
        super.update();

        if (delay > 0) {
            delay -= deltaTime;
        } else {
            index += deltaTime * 25;
        }
        
        if (moving) {
            scrollTime += deltaTime;
            text.text = fullScrollText;
            var finalTargetY = (scrhei / 2) - text.textHeight * 2;
            text.text = finalScrollLineStart;
            finalTargetY -= text.textHeight;
            y = M.smoothStep(0, finalTargetY, scrollTime / scrollDur);
        }
        if (moving && finalScrollLineStart != null) {
            text.text = finalScrollLineStart;
            var A = text.textWidth * 2;
            text.text = finalScrollLineWord;
            var B = text.textWidth * 2;
            var C = scrwid / 2;
            var finalTargetX = C - A - (B / 2);
            x = M.smootherStep(0, finalTargetX, scrollTime / scrollDur);
        }
        if (moving && targetCameraZoom != 0) {
            camera.scale = M.smootherStep(startCameraZoom, targetCameraZoom, scrollTime / scrollDur);
        }

        if (fading) {
            text.alpha -= deltaTime / 5.0;
            overlay.alpha -= deltaTime / 3.0;
        }

        text.text = fullText.substr(0, Math.floor(Math.min(index, fullText.length)));
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
        overlay = new Text(hxd.res.DefaultFont.get(), spr);
        overlay.textColor = 0xFFFFFF;
        overlay.text = lastLineBefore;
        overlay.x = overlay.textWidth;
        overlay.y = this.text.textHeight - overlay.textHeight;
        overlay.text = part;
        overlay.alpha = 3;
    }
}