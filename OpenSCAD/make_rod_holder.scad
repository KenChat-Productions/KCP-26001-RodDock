/*
 * ---------------------------------------
 * --------------------------------
 * KCP-26001-RodDock
 * ---------------------------------------
 * File: 
 *    make_rod_holder.scad
 * ---------------------------------------
 * Responsibility:
 *    Main OpenSCAD Entry Point for
 *      RodDock Rod HolderAccessory
 *
 * ---------------------------------------
 * Public Module(s):
 *
 * ---------------------------------------
 * Dependencies:
 *
 * ---------------------------------------
 *Revisions:
 * 2026-06-29  Initial Creation
 * --------------------------------
*/

include <rod_holder.scad>;

/* Defined radii
 *  RODSLOT_RADIUS_12
 *  RODSLOT_RADIUS_13
 *  RODSLOT_RADIUS_14
*/
translate([0,-40,0])
rod_holder(radius=RODSLOT_RADIUS_12);

translate([0,0,0])
rod_holder(radius=RODSLOT_RADIUS_13);

translate([0,40,0])
rod_holder(radius=RODSLOT_RADIUS_14);
