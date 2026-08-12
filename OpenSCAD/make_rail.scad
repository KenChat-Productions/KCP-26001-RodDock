/*
 * --------------------------------
 * KCP-26001-RodDock
 * --------------------------------
 * File: 
 *    make_rail.scad
 * Responsibility:
 *    Main OpenSCAD Entry Point for
 * Public Module(s):
 *
 * Constraints
 *  Version 1.0 only supports a rail 
 *      RodDock Rail System, a fixed
 *      width of 25mm an 
 *      height of 30mm
 *
 * Dependencies:
 *
 *Revisions:
 * 2026-06-29   Initial Creation
 * 2026-07-11   Rotate the final block
 *              to position it for printing
 * --------------------------------
*/

include <rail.scad>;

/*
    --------------------
    Valid Rail Lengths
    --------------------
    RAIL_XS_LENGTH
    RAIL_S_LENGTH
    RAIL_M_LENGTH
    RAIL_L_LENGTH
*/
rail(RAIL_XS_LENGTH);

translate([120,0,0])
rail(RAIL_S_LENGTH);

translate([0,50,0])
rail(RAIL_M_LENGTH);

translate([0,-50,0])
rail(RAIL_L_LENGTH);