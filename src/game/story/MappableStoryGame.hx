package game.story;

import game.game.BaseMainGame;

abstract class MappableStoryGame extends BaseMainGame {
    function generateNewString() {
        var str =
'    function spawnMap() {
        selected.x = camera.x = ${selected.x}
        selected.y = camera.y = ${selected.y}\n';
        var tab = "        ";
        for (e in entities) {
            if (!e.serializableMap())
                continue;
            var type = Type.getClassName(Type.getClass(e));
            var args = e.serializeMap();
            var self = args.length == 0 ? "this" : ", this";
            str += '${tab}new ${type}(${args}${self});\n';
        }
    }
}