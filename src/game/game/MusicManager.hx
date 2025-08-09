package game.game;

import hxd.res.Sound;
import hxd.snd.Channel;

class MusicManager {
    static var current: Null<Channel> = null;

    public static function set(sound: Sound) {
        if (current == null) _set(sound);
        if (current.sound == sound) return;
        _set(sound);
    }

    static function _set(sound: Sound) {
        fadeOut(1);
        current = sound.play(true, 0);
        current.fadeTo(0.6);
    }

    public static function fadeOut(dur: Float) {
        if (current == null) return;
        var cChannel = current;
        cChannel.fadeTo(0, dur, ()->cChannel.stop());
        current = null;
    }
}