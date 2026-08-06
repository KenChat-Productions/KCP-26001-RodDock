/*
 * ------------------------------------------
 * KCP-RD000-RodDock
 * ------------------------------------------
 * File: 
 *  rod_holder_profile.scad
 * ------------------------------------------
 * Description:
 *  This module builds rod holder profile
 *  it creates a rounded rectangle then
 *  carves out a key hole for the rod.
 *  
 *  It is extruded to the proper length by
 *  the calling module.
 *
 * ------------------------------------------
 * Public Module(s):
 *
 * ------------------------------------------
 * Parameters:
 *  x = lenght of the base rectangle
 *  y = the width of the base rectangle
 *  radius = the radius of the keyhole circle
 *  rounded controls the use of rounded vs
 *  square rectangle.
 *
 * ------------------------------------------
 * Revisions:
 *  2026-07-28   Initial Creation
 * ------------------------------------------
 *
*/include <dimensions.scad>;
include <..\Common\OpenSCAD\rounded_rect.scad>;

module rod_holder_profile(x, y, radius, rounded=true)
{
    d = radius * 2;
    difference()
    {
        // base rectangle to build on.
        rect_outline(x, y, DEFAULT_RECT_RADIUS, rounded);   
        
        // keyhole to cut out.
        translate([x/2,10.5,0])
        union()
        {
            color("green")
            circle(radius);
            translate([-radius,-RND_RECT_OFFSET,0])
            color("blue")
            rect_outline(d,y,DEFAULT_RECT_RADIUS,rounded);
        }
    }
}