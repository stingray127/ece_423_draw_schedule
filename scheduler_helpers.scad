// Event Options
SDR_P = 2.918;
SDR_I = 5.452;

LD_Y_P = 13.654;
LD_Cr_P = 5.345;
LD_Cb_P = 5.345;
LD_All_P = LD_Y_P + LD_Cr_P + LD_Cb_P;

LD_Y_I = 69.548;
LD_Cr_I = 45.336;
LD_Cb_I = 43.607;
LD_All_I = LD_Y_I + LD_Cr_I + LD_Cb_I;

IDCT = 3.54;
CC = 52;
// Are these correct?
// CC_Y = 52/3;
// CC_Cr = 52/3;
// CC_Cb = 52/3;

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
//      - label is "SDR"
//          - Default label is empty
//      - fontsize is 5
//          - Default fontsize is 5
module starts_at(start_time, event, core, shade = "grey", label = "", fontsize = 5){
    translate([start_time, core, -10])
        color(shade)
            cube([event, 10, 10]);
    translate([start_time, core + 5 - fontsize/2, 0])
        color("black")
            text(text = label, size = fontsize);
}

// Usage: Places the end of the scheduled event at the specified time.
// Other than that, identical to starts_at
module ends_at(end_time, event, core, shade = "grey", label = "", fontsize = 5){
    translate([end_time - event, core, -10])
        color(shade)
            cube([event, 10, 10]);
    translate([end_time - event, core + 5 - fontsize/2, 0])
        color("black")
            text(text = label, size = fontsize);
}

$fn = 64;
// arrows = [top_arrow_width, bottom_arrow_width, arrow_height]
module basic_marker(time, shade = "grey", height = 50, arrows = [2.5, 2.5, 5], label = "", fontsize = 4){
    cores_center = Core_2;
    color(shade){
        translate([time, cores_center, 0])
            rotate([90, 0, 0])
                cylinder(h = height, d = min(fontsize/8, 1), center = true);
        translate([time, cores_center + (height/2 - arrows[2]/2), 0])
            rotate([90, 0, 0])
                cylinder(h = arrows[2], d1 = arrows[0], d2 = 0, center = true);
        translate([time, cores_center - (height/2 - arrows[2]/2), 0])
            rotate([90, 0, 0])
                cylinder(h = arrows[2], d1 = 0, d2 = arrows[1], center = true);
        marker_label(label = label, fontsize = fontsize, position = [time, cores_center + height/2, 0]);
    }
}

module marker_label(label, fontsize, position){
    translate(position){
        rotate([0, 0, 45])
            text(text=label, size=fontsize);
    }
}

// Markers based on basic_marker

module whereami(time){
    basic_marker(time, "red", 80, [5, 5, 10]);
}

module dma_marker(time){
    basic_marker(time, "black", 50, [2.5, 2.5, 5]);
}

module label_time(time, label = "", fontsize = 4){
    basic_marker(time, "grey", 60, [2.5, 0, 5], label, fontsize);
}

// Marks the location of the cores text on the left
color("black"){
    translate([-30, Core_IDCT+2.5, 0])
        text("IDCT", size=5);
    translate([-30, Core_3+2.5, 0])
        text("Core 3", size=5);
    translate([-30, Core_2+2.5, 0])
        text("Core 2", size=5);
    translate([-30, Core_1+2.5, 0])
        text("Core 1", size=5);
}