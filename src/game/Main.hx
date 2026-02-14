package game;

import engine.GameEngine;

class Main {
    static function main() {
        new GameEngine(() -> new game.story.World0());
    }
}