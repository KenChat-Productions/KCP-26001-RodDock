/*
 * ---------------------------
 * KCP-26001-RodDock
 * ---------------------------
 * File: 
 *    rail_profile.scad
 *
 * -------------------------------------------------
** Responsibility:
 *   Defines the RodDock rail cross sectional
 *   profile used by all rail lengths.
 *
 * -------------------------------------------------
 * Design Constraints:
 *   V. 1 limits the rail to a fixed width and
 *      height. This constraint is defined in
 *      dimensions.scad
 *
 * -------------------------------------------------
 * Public Constraints:
 *   None
 * 
 * -------------------------------------------------
 * Public Module(s):
 *  rail_profile()
 *  rail_endcap_profile()
 *  rail_outline()
 *
 * -------------------------------------------------
 * Dependencies:
 *    dimensions.scad
 *
 * -------------------------------------------------
 *Revisions:
 * 2026-06-29  Initial Creation
 * 2026-07-26   Add "generic" outline to be used by
 *              anything that needs to relate to the
 *              rail.
 * -------------------------------------------------
*/
include <dimensions.scad>;
include <../Common/OpenSCAD/rounded_rect.scad>
include <..\Common\OpenSCAD\corner_cutter.scad>;

/*
 * -------------------------------------------------
 * module: rail_profile
 * -------------------------------------------------
 * Description:
 *  This module defines the basic outline or "shape"
 *  used for the rail. 
 *
 * Returns the 2D profile used to construct the 
 * a rail section.
 * -------------------------------------------------
*/
module rail_profile(rx, ry, cx, cy,
                    base_radius,
                    rail_radius)
{
    gx = (rx - cx) / 2;
    gy = ry - cy;
    
    difference()
    {
        // Get the basic rail shape
        rect_outline(rx, ry,
                     base_radius,
                     false);
        
        // Cut the groove
        translate([gx, gy])
            square([cx,
                    cy]);
        
        // Round the top corner
        tx = rail_radius;
        ty1 = ry - rail_radius;
        translate([tx,ty1,0])
        rotate([0,0,90])
        color("red")
        corner_cutter(rail_radius);
        
        // Round the bottom corner
        ty2 = rail_radius;
        translate([tx,ty2,0])
        rotate([0,0,180])
        corner_cutter(rail_radius);
    }
}