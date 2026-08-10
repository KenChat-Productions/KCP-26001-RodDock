/*
 * ------------------------------------------
 * KCP-26001-RodDock
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
*/
include <dimensions.scad>;
include <..\Common\OpenSCAD\rounded_rect.scad>;
include <..\Common\OpenSCAD\corner_cutter.scad>;

/*
 * ==========================================
 *               MODULES
 * ==========================================
*/
/*
 * ==========================================
 *               MODULES
 * ==========================================
*/
/*
 * ------------------------------------------
 * module: rod_holder_profile
 * ------------------------------------------
 * Description
 *  This module is a "director". Depending on
 *  the input parameters, it will return a
 *  block or rounded version of the profile.
 *
 * ------------------------------------------
 * Parameters
 *  x = the width of the holder
 *  y = the length of the holder
 *  radius = the radius of the rod socket
 *           and the width of the rod "chute"
 *  crn_radius = the radius of the rounded
 *               corners
 *  rounded = (boolean) determines whether
 *              to return a block or rounded
 *              profile
 * ------------------------------------------
 *
*/
module rod_holder_profile(x, y, radius,
                          crn_radius = 
                                 DEFAULT_RECT_RADIUS,
                          rounded=true)
{
    if (rounded)
    {
        round_profile(x, y, radius, crn_radius);
    }
    else
    {
        square_profile(x,y,radius,crn_radius);
    }
}
/*
 * ------------------------------------------
 * module: square_profile
 * ------------------------------------------
 * Description
 *  This module creats the block version offset
 *  the profile.
 *
 * ------------------------------------------
 * Parameters
 *  x = the width of the holder
 *  y = the length of the holder
 *  radius = the radius of the rod socket
 *           and the width of the rod "chute"
 *  crn_radius = the radius of the rounded
 *               corners
 * ------------------------------------------
 *
*/
module square_profile(x, y,slot_radius,crn_radius)
{
    d = slot_radius * 2;
    difference()
    {
        // base rectangle to build on.
        rect_outline(x, y, crn_radius);   
        
        // keyhole to cut out.
        translate([x/2,y/2,0])
        union()
        {
            color("green")
            circle(slot_radius);
            translate([-slot_radius,-RND_RECT_OFFSET,0])
            color("green")
            rect_outline(d,y,crn_radius,false);
        }
    }
}
/*
 * ------------------------------------------
 * module: round_profile
 * ------------------------------------------
 * Description
 *  This module creats the rounded version offset
 *  the profile.
 *
 * ------------------------------------------
 * Parameters
 *  x = the width of the holder
 *  y = the length of the holder
 *  radius = the radius of the rod socket
 *           and the width of the rod "chute"
 *  crn_radius = the radius of the rounded
 *               corners
 * ------------------------------------------
 *
*/
module round_profile(x, y, radius, crn_radius)
{
    //  tx
    //  12 = radius + 1
    //  13 = radius
    //  14 = radius - 1
    x_adj = (radius == RODSLOT_RADIUS_12) ? 1 :
            (radius == RODSLOT_RADIUS_13) ? 0 :
            (radius == RODSLOT_RADIUS_14) ? -1 :
             0;
    d = radius * 2;
    tx = radius + x_adj;
    tx2 = y + radius;
    ty = 0;
    
    difference()
    {
        // base rectangle to build on.
        rect_outline(x, y,
                     crn_radius, true);   

        translate([tx,x/2, ty])
        corner_cutter(crn_radius);

        translate([tx2,x/2,ty])
        rotate([0,0,90])
        corner_cutter(crn_radius);

        // keyhole to cut out.
        translate([x/2,y/2,0])
        union()
        {
            color("green")
            circle(radius);
            translate([-radius,-RND_RECT_OFFSET,0])
            color("blue")
            rect_outline(d,y,crn_radius,true);
        }
    }
}