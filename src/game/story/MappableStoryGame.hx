package game.story;

import sdl.Sdl;
import hxd.Key;
import game.game.BaseMainGame;

abstract class MappableStoryGame extends BaseMainGame {
    function generateNewString() {
        var str =
'function spawnMap() {
        selected.x = camera.x = ${selected.x};
        selected.y = camera.y = ${selected.y};\n';
        var tab = "        ";
        for (e in entities) {
            if (!e.serializableMap())
                continue;
            var type = e.serializeMapClassName();
            var args = e.serializeMap();
            var self = args.length == 0 ? "this" : ", this";
            var post = e.serializeMapPostfix();
            str += '${tab}new ${type}(${args}${self})${post};\n';
        }
        str += "    }";
        return str;
    }

    function loadEditor() {
        var g = new EditorStoryGame(selected.x, selected.y);
        for (e in entities) {
            e.spawnEditorClone(g);
        }
        Main.setGame(g);
    }

    override function update() {
        super.update();

        #if debug
        if (Key.isPressed(Key.S)) {
            Sdl.setClipboardText(generateNewString());
        }
        if (Key.isPressed(Key.E)) {
            loadEditor();
        }
        #end
    }

     override function isValidNodeSpot(x:Float, y:Float, sx:Float, sy:Float):Bool {
        for (e in entities) {
            if (!(e is StoryBlock))
                continue;
            var e:StoryBlock = cast e;
            if (e.rayOverlaps(sx, sy, x, y))
                return false;
        }
        return super.isValidNodeSpot(x, y, sx, sy);
    }
}