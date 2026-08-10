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
module rail_profile(rx, ry, cx, cy, rounded=true)
{
    gx = (rx - cx) / 2;
    gy = ry - cy;
    
    difference()
    {
        // Get the basic rail shape
        rect_outline(rx, ry,
                     DEFAULT_RECT_RADIUS,
                     rounded);
        
            // Cut the groove
        translate([gx, gy])
            square([cx,
                    cy]);
    }
}