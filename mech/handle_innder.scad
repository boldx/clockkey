//$fn = 256;

height = 90.5;
outer_d = 32;

magnet_h = 5.5;
magnet_d = 18.5;

battery_h = 42;
battery_d = 18.5;

splitter_disc_h = 2;

battery_contact_spacer = 3.5;
battery_contact_slot_dim = [13.6, outer_d, 0.9];
battery_contact_cutout_dim = [8, outer_d, 1.1];

fet_h = 5;
fet_d = magnet_d;

motor_dim = [12.5, 10.5, 25.5];
motor_shaft_d = 4;

charger_dim = [17.5, 3.5, 26];
charger_conn_dim = [8.2, 4.5, 8.7];

button_dims = [6.5, 4, 3.5];

wire_duct_d = 5;


difference() {
    // body
    //cylinder(h=60, d=outer_d);
    cylinder(h=height, d=outer_d);
    
    translate([2, 0, 0]) union() {
        // magnet
        translate([0, 0, splitter_disc_h]) cylinder(h=magnet_h, d=magnet_d);
        // magnet top cut-out
        translate([-magnet_d / 2, 0, splitter_disc_h]) cube([magnet_d, outer_d / 2, magnet_h]);
        
        // battery
        battery_bottom_z = splitter_disc_h + magnet_h + battery_contact_spacer;
        battery_top_z = battery_bottom_z + battery_h;
        translate([0, 0, battery_bottom_z]) cylinder(h=battery_h, d=battery_d);
        // battery top cut-out
        translate([-battery_d / 2, 0, battery_bottom_z]) cube([battery_d, outer_d / 2, battery_h]);
        
        // battery contact holder bottom
        translate([-battery_contact_slot_dim.x / 2, -battery_d / 2, battery_bottom_z - (battery_contact_slot_dim.z + battery_contact_cutout_dim.z)])
            cube(battery_contact_slot_dim);
        translate([-battery_contact_cutout_dim.x / 2, -battery_d / 2, battery_bottom_z - battery_contact_cutout_dim.z])
            cube(battery_contact_cutout_dim);
        // battery contact holder top
        translate([-battery_contact_cutout_dim.x / 2, -battery_d / 2, battery_top_z])
            cube(battery_contact_cutout_dim);
        translate([-battery_contact_slot_dim.x / 2, -battery_d / 2, battery_top_z + battery_contact_cutout_dim.z])
            cube(battery_contact_slot_dim);
        
        // wire duct axial
        axial_wire_duct_bottom_z = splitter_disc_h / 2;
        axial_wire_duct_length = axial_wire_duct_bottom_z + battery_top_z + battery_contact_spacer + splitter_disc_h + fet_h;
        translate([0, -battery_d / 2 , axial_wire_duct_bottom_z])
            cylinder(h=axial_wire_duct_length, d=wire_duct_d);
        
        // wire duct below magnet
        translate([-wire_duct_d / 2, -battery_d / 2, splitter_disc_h / 2])
            cube([wire_duct_d, outer_d / 2 + 2, splitter_disc_h / 2]);
        // wire duct to charger
        translate([0, 0, charger_dim.z]) difference() {
            cylinder(h=wire_duct_d, d=battery_d + wire_duct_d);
            translate([0, -(battery_d + wire_duct_d)/2 , 0])
                cube([battery_d + wire_duct_d, battery_d + wire_duct_d, wire_duct_d]);
        }
        
        // fet
        fet_bottom_z = battery_top_z + battery_contact_spacer;
        translate([0, 0, fet_bottom_z]) cylinder(h=fet_h, d=fet_d);
        // fet top cut-out
        translate([-fet_d / 2, 0, fet_bottom_z]) cube([fet_d, outer_d / 2, fet_h]);
    }
    
    // motor
    translate([-motor_dim.x / 2, -motor_dim.y / 2, height - splitter_disc_h - motor_dim.z])
        cube([motor_dim.x, motor_dim.y, motor_dim.z]);
    // motor top cut-out
    translate([-motor_dim.x / 2, 0, height - splitter_disc_h - motor_dim.z])
        cube([motor_dim.x, outer_d / 2, motor_dim.z]);
    
    // motor shaft cut-out
    translate([0, 0, height - splitter_disc_h]) cylinder(h=splitter_disc_h, d=motor_shaft_d);
    translate([-motor_shaft_d / 2, 0, height - splitter_disc_h]) cube([motor_shaft_d, outer_d / 2, splitter_disc_h]);
    
    // motor - fet wire duct
    translate([0, 0, height - splitter_disc_h - motor_dim.z -wire_duct_d]) cylinder(h=wire_duct_d, d=wire_duct_d);
    
    // charger
    translate([-battery_d / 2 + 1, -battery_d / 2, splitter_disc_h / 2]) rotate([0, 0, 90]) union() {
        cube([charger_dim.x * 2.5, charger_dim.y, charger_dim.z]);
        charger_conn_x_off = charger_dim.x / 2 - charger_conn_dim.x / 2;
        translate([charger_conn_x_off, 0, 0])
            cube([charger_conn_dim.x * 2.5, charger_conn_dim.y, charger_conn_dim.z]);
        // bottom cut-out
        translate([charger_dim.x / 2 - charger_conn_dim.x / 2, 0, -1])
            cube([charger_conn_dim.x, charger_conn_dim.y, charger_conn_dim.z]);
    }
    
    //button
    translate([-button_dims.x / 2, outer_d / 2 - button_dims.y - 2, 0]) cube([button_dims.x, button_dims.y, button_dims.z]);
}
