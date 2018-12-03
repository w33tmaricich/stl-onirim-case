// box constants
BOX_SQUARE = 150;

// card holder dimensions.
CARD_WIDTH = 105;
CARD_HEIGHT = 95.40;
CARD_DEPTH_LOW = 43;
CARD_DEPTH_HIGH= 69;
CARD_LID_WIDTH = 15;
CARD_LID_THICKNESS = 5;
CARD_TRANSLATION = [0,-15,0];

// incubus holder dimensions.
INCUBUS_WIDTH = 30.35;
INCUBUS_HEIGHT = 18;
INCUBUS_DEPTH = 20;
INCUBUS_TRANSLATION = [0,55,0];

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
        translate(CARD_TRANSLATION) linear_extrude(height=CARD_DEPTH_HIGH, center=false) square([CARD_WIDTH, CARD_HEIGHT], true);
        translate(INCUBUS_TRANSLATION) linear_extrude(height=CARD_DEPTH_HIGH, center=false) square([INCUBUS_WIDTH, INCUBUS_HEIGHT], true);
    }
}

//cross();

module card_cube(x=CARD_WIDTH, y=CARD_HEIGHT, z=CARD_DEPTH_HIGH, padding=8) {
    linear_extrude(height=z, center=false) difference() {
        square([x+padding, y+padding], true);
    }
}

module incubus_walls() {
    card_cube(x=INCUBUS_WIDTH, y=INCUBUS_HEIGHT, z=INCUBUS_DEPTH,padding=8);
}

module incubus_holder() {
    translate(INCUBUS_TRANSLATION) difference() {
        incubus_walls();
        card_cube(x=INCUBUS_WIDTH, y=INCUBUS_HEIGHT, z=INCUBUS_DEPTH*2,padding=0);
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
    
    translate(CARD_TRANSLATION) difference() {
        card_walls();
        linear_extrude(height=CARD_DEPTH_HIGH, center=false) square([CARD_WIDTH, CARD_HEIGHT], true);
    }
}

module onirim_case() {
    union() {
        holy_cross();
        incubus_holder();
        card_holder();
    }
}
//cross();
//holy_cross();
//card_holder();

//onirim_case();