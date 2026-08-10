/*
 * ---------------------------
 * KCP-26001-RodDock
 * ---------------------------
 * File: 
 *    rail_endcap_profile.scad
 *
 * -------------------------------------------------
** Responsibility:
 *   Defines the RodDock rail endcap cross sectional
 *   profile used by all rail railcaps.
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
 *  rail_endcap_profile()
 *
 * -------------------------------------------------
 *Revisions:
 * 2026-07-28  Initial Creation
 * -------------------------------------------------
*/
include <dimensions.scad>;
include <../Common/OpenSCAD/rounded_rect.scad>

/*
 * -------------------------------------------------
 * module: rail_endcap_profile
 * -------------------------------------------------
 * Description:
 *  This module defines the basic outline or "shape"
 *  used for the rail endcaps.
 *
 * Returns the 2D profile used to construct the 
 * a rail end section.
 * -------------------------------------------------
*/
module rail_endcap_profile(x, y, rounded=true)
{
    rect_outline(x, y, DEFAULT_RECT_RADIUS, rounded);
}