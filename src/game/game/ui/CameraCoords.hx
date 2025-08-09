package game.game.ui;

import hxd.Key;

class CameraCoords extends h2d.Flow implements h2d.domkit.Object {
    static var SRC =
        <camera-coords>
            // <flow class="infobox">
            //     <text public id="cx" text={'$camX'}/>
            //     <text public id="cy" text={'$camY'}/>
            // </flow>
            // <flow class="infobox">
            //     <text public id="e" text={'0'}/>
            //     <text public id="t" text={'10'}/>
            // </flow>
            <flow class="infobox">
                <text public id="p" text={'0'}/>
                <text public id="m" text={'100'}/>
            </flow>
        </camera-coords>;

    public function new(camX: Float, camY: Float, ?parent) {
        super(parent);
        initComponent();

        Main.style.addObject(this);
    }
}