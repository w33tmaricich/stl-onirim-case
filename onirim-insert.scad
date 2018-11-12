// box constants
BOX_SQUARE = 150;

// card holder dimensions.
CARD_WIDTH = 105;
CARD_HEIGHT = 95.40;
CARD_DEPTH_LOW = 43;
CARD_DEPTH_HIGH= 69;
CARD_LID_WIDTH = 15;
CARD_LID_THICKNESS = 5;

// incubus holder dimensions.
INCUBUS_WIDTH = 30.35;
INCUBUS_HEIGHT = 18;

module box_bar() {
    box_bar_size = 10;
    cube([BOX_SQUARE, box_bar_size, box_bar_size], true);
} 

module cross() {
    translate([0,0,5]) union() {
        box_bar();
        rotate([0,0,90]) box_bar();
    }
}

module holy_cross() {
    difference() {
        cross();
        linear_extrude(height=CARD_DEPTH_HIGH, center=false) square([CARD_WIDTH, CARD_HEIGHT], true);
    }
}

//cross();

module card_cube(x=CARD_WIDTH, y=CARD_HEIGHT, z=CARD_DEPTH_HIGH, padding=8) {
    linear_extrude(height=z, center=false) difference() {
        square([x+padding, y+padding], true);
    }
}

module card_walls() {
    // lay out the cutouts
    difference() {
        card_cube();
        union() {
            translate([0,0,CARD_DEPTH_LOW]) card_cube(x=CARD_WIDTH+10, y=CARD_HEIGHT-(2*CARD_LID_WIDTH), z=100, padding=0);
        translate([0,0,CARD_DEPTH_LOW]) card_cube(x=CARD_WIDTH-(2*CARD_LID_WIDTH), y=CARD_HEIGHT+10, z=100, padding=0);
        }
    }
    
}
module card_holder() {
    
    difference() {
        card_walls();
        linear_extrude(height=CARD_DEPTH_HIGH, center=false) square([CARD_WIDTH, CARD_HEIGHT], true);
    }
}

module onirim_case() {
    union() {
        holy_cross();
        card_holder();
    }
}
//cross();
//holy_cross();
//card_holder();

onirim_case();