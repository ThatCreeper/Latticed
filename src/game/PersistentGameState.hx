package game;

class PersistentGameState {
    static var backing: Map<String, String> = new Map<String, String>();

    public static function get_str(key, def: Null<String> = null) {
        return backing.get(key) ?? def;
    }

    public static function get_bool(key, def = false) {
        var dat = get_str(key);
        if (dat == null)
            return def;
        return dat == "true";
    }

    public static function put_str(key, val) {
        backing[key] = val;
    }

    public static function put_bool(key, val) {
        put_str(key, val ? "true" : "false");
    }

    public static function reset() {
        backing.clear();
    }

    public static function rem(key) {
        backing.remove(key);
    }

    public static function mark_flag(key) {
        put_bool(key, true);
    }

    public static function check_flag(key) {
        return get_bool(key);
    }
}