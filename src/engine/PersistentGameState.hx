package engine;

class PersistentGameState {
    static var flags = new DynamicFlagSet(cast(PersistentFlags.MaxValue));
    
    public static function reset() {
        flags.clear();
    }

    public static function mark_flag(flag: PersistentFlags) {
        flags.set(cast(flag));
    }

    public static function check_flag(flag: PersistentFlags) {
        return flags.has(cast(flag));
    }
}