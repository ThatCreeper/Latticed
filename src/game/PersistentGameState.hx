package game;

class PersistentGameState {
    static var backing: Map<String, String> = {}

    public static function get_str(key, def: Null<String> = null) {
        return backing.get(key) ?? def;
    }

    public static function get_bool(key, def = false) {
        var dat = get_str(key);
        if (!dat)
            return def;
        return dat == "true";
    }

    public static function put_str(key, val) {
        backing[key] = val;
    }

    public static function put_bool(key, val) {
        backing[key] = val ? "true" : "false";
    }

    public static function reset() {
        backing = {};
    }

    public static function rem(key) {
        backing.remove(key);
    }

    public static function mark_flag(key) {
        put_bool(key, true);
    }
}