package engine;

class DynamicFlagSet {
    var backing: Array<Int>;

    public function new(max) {
        if (max <= 0) throw "unsized DynamicFlagSet";

        backing = new Array();
        backing.resize(Math.ceil(max / 32));
    }

    inline function a(v: Int) {
        return Math.floor(v / 32);
    }

    inline function b(v: Int) {
        return v % 32;
    }

    public inline function has(v: Int) {
        return (backing[a(v)] & (1 << b(v))) != 0;
    }

    public inline function set(v: Int) {
        backing[a(v)] |= (1 << b(v));
    }

    public inline function unset(v: Int) {
        backing[a(v)] &= ~(1 << b(v));
    }

    public inline function setTo(v: Int, b: Bool) {
        if (b) set(v);
        else unset(v);
    }

    public function clear() {
        for (v in backing) v = 0;
    }
}