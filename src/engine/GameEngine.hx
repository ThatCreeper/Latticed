package engine;

import hxd.Key;
import h2d.domkit.Style;
import hxd.Cursor;
import hxd.Pad;
import h2d.Scene;

class GameEngine extends hxd.App {
    public static var FPS: Float = 60;
    public static var GameSpeed: Float = 1;
    public static var UserGameSpeed: Float = 1;
    public static var TickRate = 60;
    public static var tmod(get, never): Float;
        static function get_tmod(): Float {
            return utmod * GameSpeed;
        }
    public static var utmod(get, never): Float;
        static function get_utmod(): Float {
            return 60 / FPS;
        }
    public static var pad: Null<Pad> = null;
    public static var style: Style = null;

    public static var INST: GameEngine;

    public var ucd: Cooldown;
    public var game: Game;

    var timeSinceTick = 0.0;
    var newGameThisFrame = false;

    var gameInitFunc: () -> Game;

    public function new(gameFunc: () -> Game) {
        gameInitFunc = gameFunc;
        super();
    }

    override function init() {
        INST = this;
        #if (hl && debug)
        hxd.Res.initLocal();
        #else
        hxd.Res.initEmbed();
        #end
        #if debug
        hxd.res.Resource.LIVE_UPDATE = true;
        #end

        hxd.snd.Manager.get();

        style = new h2d.domkit.Style();
        style.load(hxd.Res.styles);
        #if debug
        style.allowInspect = true;
        #end

        Pad.wait(p -> {
            pad = p;
            pad.onDisconnect = () -> pad = null;
        });

        ucd = new Cooldown();
        
        setGame(gameInitFunc());
        newGameThisFrame = false;
    }

    public static function newScene(): Scene {
        var s = new Scene();
        GameEngine.INST.setScene2D(s);
        return s;
    }

    public static function setGame(game) {
        INST.game?.dispose();
        INST.game = game;
        INST.newGameThisFrame = true;
    }

    public function freezeFrame() {
        ucd.setF('frozen', 4);
    }

    override function update(dt:Float) {
        FPS = 1.0 / dt;
        ucd.update(dt, 1);

        GameSpeed = ucd.has('frozen') ? 0.1 : UserGameSpeed;

        do {
            newGameThisFrame = false;
            game.preUpdate();
            game.update();

            timeSinceTick += dt * GameSpeed;
            while (timeSinceTick >= 1 / TickRate) {
                timeSinceTick -= 1 / TickRate;
                game.tick();
            }

            game.postUpdate();
            style.sync(dt);
            if (newGameThisFrame)
                hxd.Timer.update(); // Prevent keyboard input loops. Might mess up some other stuff
        } while(newGameThisFrame);
    }

    override function dispose() {
        game.dispose();
        super.dispose();
    }
}