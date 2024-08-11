$fn=64;
use <circle-tangents.scad>



function sq(x) = pow(x,2);

r2 = 45;  // flaps radius
x2 = 45;  // flaps distance

r1 = 55;  // top dent
y1 = sqrt(sq(r1 + r2) - sq(x2));

q = r1 / (r1 + r2);

r3 = r2 * 0.6; // flaps hole

hd = 35;  // handle diameter
eh = 10;  // extrude height

hw = sqrt(sq(hd) - sq(eh));

r5 = 10;  // radius of the lower rounding
x5 = (hw / 2) + r5;
y5 = - (r2 + r5) * 1.05;  // begining handle

c0 = [-x2, 0];
c1 = [-x5, y5];
c2 = [x2, 0];
c3 = [x5, y5];

sc = GetSimCentre(c0, r2, c1, r5, s=1); 
t0 = GetTangent(c0, r2, sc, s=1);
t2 = GetTangent(c1, r5, sc, s=1);

d = -c1.x - r5;
echo("handle width", d * 2);
ph = 10; // handle rectangular protusion height

hh = t0.y - y5 + ph;
x = hd / 2 - eh /2;

linear_extrude(height=eh) {
    difference() {
        union() {
            difference() {
                union() {
                    translate([x2, 0]) circle(r2);
                    translate([-x2, 0]) circle(r2);
                    translate([-q * x2, 0]) square([q * x2 * 2, q * y1]);
                }
                translate([0, y1]) circle(r1);
                translate([x2, 0]) circle(r3);
                translate([-x2, 0]) circle(r3);
            }
            polygon ([[0, 0], t0, t2, [-t2.x, t2.y], [-t0.x, t0.y]]);
            translate([0, y5]) square([-t2.x, -y5 + t2.y]);
            translate([t2[0], y5]) square([-t2.y, -y5 + t2.y]);
        }
        translate(c3) circle(r5);
        translate(c1) circle(r5);
    }
    translate([-d, c1.y - r5]) square([d * 2, 10]);
}

echo(y5, hh, ph, eh, hd, d);


difference() {
    translate([0, y5 + (hh - ph), eh / 2]) color("red") rotate([90, 0, 0]) cylinder(hh, d=hd);
    translate([-hd / 2, y5 - ph, eh]) cube([hd, hh, x]);
    translate([-hd / 2, y5 - ph, -x]) cube([hd, hh, x]);
}

/*
translate([0, y5 - ph, eh/2]) rotate([0, 90, 90]) difference() {
    translate([0,0,0]) color("red") rotate([0, 0, 0]) cylinder(eh, d=hd);
    //translate([-hd / 2, y5 - ph, eh]) cube([hd, hh, x]);
    translate([0, hd/2, 0]) rotate([90, 0, 0]) linear_extrude(height=hd) polygon([[hd/2, 0], [hd/2, ph], [eh/2, ph]]);
    translate([0, hd/2, 0]) rotate([90, 0, 0]) linear_extrude(height=hd) polygon([[-hd/2, 0], [-hd/2, ph], [-eh/2, ph]]);
}
*/
//translate([0, y5 + (hh - ph), eh / 2]) color("red") rotate([90, 0, 0]) cylinder(hh, d=hd);




