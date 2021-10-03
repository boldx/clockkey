$fn = 32;

height = 90.5;
outer_d = 32;

magnet_h = 5.5;
magnet_d = 18.5;

battery_h = 35;
battery_d = 18.5;

splitter_disc_h = 2;

battery_contact_spacer = 3;
battery_contact_w = 5;
battery_contact_h = 5;
battery_contact_d = 5;

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
        
        // battery contact bottom 
        translate([-battery_contact_w / 2, -battery_contact_h / 2, splitter_disc_h + magnet_h + splitter_disc_h]) cube([battery_contact_w, battery_contact_h, battery_contact_spacer]);
        // battery
        translate([0, 0, splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer]) cylinder(h=battery_h, d=battery_d);
        // battery top cut-out
        translate([-battery_d / 2, 0, splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer]) cube([battery_d, outer_d / 2, battery_h + battery_contact_spacer]);
        // battery contact top
        translate([-battery_contact_w / 2, -battery_contact_h / 2, splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer + battery_h]) cube([battery_contact_w, battery_contact_h, battery_contact_spacer]);
        
        // wire duct
        translate([0, -battery_d / 2 , splitter_disc_h / 2]) cylinder(h=splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer + battery_h + battery_contact_spacer + splitter_disc_h + magnet_h + splitter_disc_h - 0.5, d=wire_duct_d);
        translate([-wire_duct_d / 2, -battery_d / 2, splitter_disc_h / 2]) cube([wire_duct_d, outer_d / 2 + 2, splitter_disc_h / 2]);
        translate([0, 0, charger_dim.z]) difference() {
            cylinder(h=wire_duct_d, d=battery_d + wire_duct_d);
            translate([0, -(battery_d + wire_duct_d)/2 , 0]) cube([battery_d + wire_duct_d, battery_d + wire_duct_d, wire_duct_d]);
        }
        
        // fet
        translate([0, 0, splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer + battery_h + splitter_disc_h + magnet_h]) cylinder(h=magnet_h, d=magnet_d);
        // fet top cut-out
        translate([-magnet_d / 2, 0, splitter_disc_h + magnet_h + splitter_disc_h + battery_contact_spacer + battery_h + splitter_disc_h + magnet_h]) cube([magnet_d, outer_d / 2, magnet_h]);
    }
    
    // motor
    translate([-motor_dim.x / 2, -motor_dim.y / 2, height - splitter_disc_h - motor_dim.z]) cube([motor_dim.x, motor_dim.y, motor_dim.z]);
    // motor top cut-out
    translate([-motor_dim.x / 2, 0, height - splitter_disc_h - motor_dim.z]) cube([motor_dim.x, outer_d / 2, motor_dim.z]);
    
    // motor shaft cut-out
    translate([0, 0, height - splitter_disc_h]) cylinder(h=splitter_disc_h, d=motor_shaft_d);
    translate([-motor_shaft_d / 2, 0, height - splitter_disc_h]) cube([motor_shaft_d, outer_d / 2, splitter_disc_h]);
    
    // motor - fet wire duct
    translate([0, 0, height - splitter_disc_h - motor_dim.z -wire_duct_d]) cylinder(h=wire_duct_d, d=wire_duct_d);
    
    // charger
    translate([-battery_d / 2 + 1, -battery_d / 2, splitter_disc_h / 2]) rotate([0, 0, 90]) union() {
        cube([charger_dim.x * 2.5, charger_dim.y, charger_dim.z]);
        translate([charger_dim.x / 2 - charger_conn_dim.x / 2, 0, 0]) cube([charger_conn_dim.x * 2.5, charger_conn_dim.y, charger_conn_dim.z]);
        // bottom cut-out
        translate([charger_dim.x / 2 - charger_conn_dim.x / 2, 0, -1]) cube([charger_conn_dim.x, charger_conn_dim.y, charger_conn_dim.z]);
        // wire duct
        //translate([20, 0, charger_dim.z]) cylinder(h=wire_duct_d, d=battery_d);
        //translate([0, 1, charger_dim.z]) cube([charger_dim.x * 2.5, charger_dim.y - 1, 3]);
        //translate([charger_dim.x - 3, -2, charger_dim.z + 2]) cube([5, 5, 3]);
    }
    
    //button
    translate([-button_dims.x / 2, outer_d / 2 - button_dims.y - 2, 0]) cube([button_dims.x, button_dims.y, button_dims.z]);
}





