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
            var type = Type.getClassName(Type.getClass(e));
            var args = e.serializeMap();
            var self = args.length == 0 ? "this" : ", this";
            var post = e.serializeMapPostfix();
            str += '${tab}new ${type}(${args}${self})${post};\n';
        }
        str += "    }";
        return str;
    }

    override function update() {
        super.update();

        if (Key.isPressed(Key.S)) {
            Sdl.setClipboardText(generateNewString());
        }
    }
}