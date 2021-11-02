$fn=128;

ph = 10; // notch height
eh = 10; // notch width 
hd = 32.5; // inner dia
thh = 5; // inner height
ah = 7.5; // motor axle height
ad = 3; // axle dia
wt = 1; // wall thickness
totalh = ph + ah + thh;

difference() {
    translate([0, 0, thh]) difference() {
        translate([0,0, -thh]) color("#FF00FF") rotate([0, 0, 0]) cylinder(totalh, d=hd);
        translate([0, hd/2, ah]) rotate([90, 0, 0]) linear_extrude(height=hd) polygon([[hd/2, 0], [hd/2, ph], [eh/2, ph]]);
        translate([0, hd/2, ah]) rotate([90, 0, 0]) linear_extrude(height=hd) polygon([[-hd/2, 0], [-hd/2, ph], [-eh/2, ph]]);
        translate([-eh / 2,-hd / 2, ah]) cube([eh, hd, eh]);
        difference() {
            cylinder(ah, d=ad);
            translate([ad/2  - 0.5, -ad, 0]) cube([0.5, ad * 2, ah]);
        }
    }
    translate([0,0,0]) color("blue") rotate([0, 0, 0]) cylinder(thh, d=hd-wt*2);
}