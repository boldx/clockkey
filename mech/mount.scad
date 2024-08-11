$fn=128;

ph = 10; // notch height
eh = 10; // notch width 
di = 33; // inner dia
thh = 90.5; // inner height
ah = 7.5; // motor axle height
ad = 3.2; // axle dia
ac = 0.5; //axle cut
wt = 1; // wall thickness
totalh = ph + ah + thh;
do = di + 2*wt;

difference() {
    translate([0, 0, thh]) difference() {
        translate([0,0, -thh]) color("#FF00FF") rotate([0, 0, 0]) cylinder(totalh, d=do);
        translate([0, do/2, ah]) rotate([90, 0, 0]) linear_extrude(height=do) polygon([[do/2, 0], [do/2, ph], [eh/2, ph]]);
        translate([0, do/2, ah]) rotate([90, 0, 0]) linear_extrude(height=do) polygon([[-do/2, 0], [-do/2, ph], [-eh/2, ph]]);
        translate([-eh / 2,-do / 2, ah]) cube([eh, do, eh]);
        difference() {
            cylinder(ah, d=ad);
            translate([ad/2  - ac, -ad, 0]) cube([ac, ad * 2, ah]);
        }
    }
    translate([0,0,0]) color("blue") rotate([0, 0, 0]) cylinder(thh, d=di);
}