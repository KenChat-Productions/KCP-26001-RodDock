//
// --------------------------------
// KCP-RD000-RodDock
// --------------------------------
// File: 
//    main.scad
// Responsibility:
//    Main OpenSCAD Entry Point
//
// Public Module(s):
//
// Dependencies:
//
//Revisions:
// 2026-06-29  Initial Creation
// --------------------------------
//

//include <rail.scad>;
//include <adapter.scad>;
//include <adapter_profile.scad>;
//include <rail_profile.scad>;
//include <accessory_blank.scad>;
//include <rod_holder_profile.scad>;
//include <rod_holder.scad>;
include <dimensions.scad>;
include <compensation.scad>;
include <../Common/OpenSCAD/dovetail.scad>

// rail(RAIL_S_LENGTH);
//linear_extrude(height = 30) adapter_profile();
//adapter();
//accessory_blank();
//linear_extrude(30)
//rod_holder_profile( RODHLDR_DEFAULT_X, RODHLDR_DEFAULT_Y, RODSLOT_RADIUS_14);
//rod_holder(30,25,radius=RODSLOT_RADIUS_14);

//dovetail(25, 8, 8, 30,25,30,60);

difference()
{
    color("gold")
    dovetail(RAIL_WIDTH,
             RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X,
             RAIL_HEIGHT,
             RAIL_WIDTH,
             RAIL_HEIGHT,
             DOVETAIL_ANGLE);

    round_dovetail(RAIL_WIDTH,
                   RAIL_HEIGHT,
                   RAIL_DOVETAIL_X,
                   DEFAULT_RECT_RADIUS);
}
module corner_cutter(radius, height)
{
    linear_extrude(height)
        difference()
        {
            square(radius, radius);
            circle(r=radius, $fn=60);
        }
}
module round_dovetail(width,height,dt_width,c_rad)
{
    // dovetail(25, 8, 8, 30,25,30,60);
    dh = round(dt_width / tan(DOVETAIL_ANGLE));
    rt_x = width-dh+DOVETAIL_LAND;
    tp_y = 7;
    tp_z = width + DOVETAIL_LAND;
    // Top Right
    color("red")
    translate([rt_x,tp_y,tp_z])
    rotate([90,0,0])
    corner_cutter(c_rad,c_rad+dh);

    // Bottom Right
    color("purple")
    translate([rt_x,-(c_rad/2),c_rad])
    rotate([270,0,0])
    corner_cutter(c_rad,c_rad+dh);
    
    // Top Left
    color("green")
    translate([c_rad,tp_y,tp_z])
    rotate([90,270,0])
    corner_cutter(c_rad,c_rad+dh);
    
    // Bottom Left
    color("blue")
    translate([c_rad,-(c_rad/2),c_rad])
    rotate([270,90,0])
    corner_cutter(c_rad,c_rad+dh);
}
/*
difference()
{
//color("gold")
//dovetail(25, 8, 8, 30,25,30,60);

color("red")
translate([4,4,26])
rotate([90,0,0])
build_cylinder_compensation(4,6);
}
*/
/*
rotate([90,0,0])intersection()
{
    circle(4,$fn=60);
    square(4,4);
}
intersection()
{
    cube([4,4,5]);
    translate([4,4,0])
        cylinder(r=4,h=5,$fn=60);
}
*/
//dovetail(25, 8, 8, 30,24,24);
//dovetail(25,8,8,30,21,27);
//linear_extrude(15) rail_profile();
//rail_endcap_profile();
