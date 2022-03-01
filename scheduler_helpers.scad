// Event Options
SDR_P = 2.918;
SDR_I = 5.452;
LD_P = 24.344;
LD_I = 158.491;
IDCT = 3.54;
CC = 52;

// Core Options
Core_IDCT = -70;
Core_3 = Core_IDCT+10;
Core_2 = Core_3+10;
Core_1 = Core_2+10;

// Usage: Place the start time of the event type at the specified time
// and draws a box that marks the duration of the event on a specified core.
//
// starts_at(0, SDR_I, Core_1, "blue");
//      - start time is 0
//      - event is SDR_I
//      - core is Core_1
//      - shade is blue
//          - Default shade is grey
module starts_at(start_time, event, core,  shade = "grey"){
    translate([start_time, core, 0])
        color(shade)
            cube([event, 10, 10]);
}


// Usage: Places the end of the scheduled event at the specified time.
// Other than that, identical to starts_at
module ends_at(end_time, event, core, shade = "grey"){
    translate([end_time - event, core, 0])
        color(shade)
            cube([event, 10, 10]);
}

// Usage: Makes a big red arrow to show what time the variable represents
// marker(i1_sdr_done)

module marker(time){
    color("red"){
        rotate([90, 0, 0]){
            translate([time, 0, 10])
                cylinder(h = 10, d1 = 10, d2 = 0);
            translate([time, 0, 80])
                cylinder(h = 10, d1 = 0, d2 = 10);
            translate([time, 0, 50])
                cylinder(h = 80, d = 1, center = true);
        }
    }
}

// Usage: Visually mark when DMA occurs
// dma_marker(i1_idct_done) -> Default arrow width is 2.5
// dma_marker(i1_idct_done, arrow_width) -> Can adjust arrow width via input

module dma_marker(time, size = 2.5){
    color("black"){
        rotate([90, 0, 0]){
            translate([time, 0, 25])
                cylinder(h = 5, d1 = size, d2 = 0);
            translate([time, 0, 70])
                cylinder(h = 5, d1 = 0, d2 = size);
            translate([time, 0, 50])
                cylinder(h = 50, d = 0.5, center = true);
        }
    }
}

// Marks the location of the cores text on the left
translate([-30, Core_IDCT, 0])
    text("IDCT", size=6, valign="bottom");
translate([-30, Core_3, 0])
    text("Core 3", size=6, valign="bottom");
translate([-30, Core_2, 0])
    text("Core 2", size=6, valign="bottom");
translate([-30, Core_1, 0])
    text("Core 1", size=6, valign="bottom");