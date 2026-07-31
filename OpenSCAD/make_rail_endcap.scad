/*
 * --------------------------------
 * KCP-RD000-RodDock
 * --------------------------------
 * File: 
 *    make_rail_endcap.scad
 * --------------------------------
 * Responsibility:
 *    Main OpenSCAD Entry Point for
 * --------------------------------
 * Public Module(s):
 *
 * --------------------------------
 * Constraints
 *  Version 1.0 only supports a rail 
 *      RodDock Rail System, a fixed
 *      width of 25mm an 
 *      height of 30mm
 *
 * --------------------------------
 * NOTES:
 *  Note: the translation numbers are hard-coded
 *  as the are arbitrarily selected to separate
 *  the models.
 *
 * --------------------------------
 *Revisions:
 * 2026-07-26   Initial Creation
 * --------------------------------
 *
*/

include <rail_endcap.scad>;

// Crreate the anchor endcaps
rail_endcap(25,
            location=RAIL_ENDCAP_BOW,
            rounded=true);
            
translate([50,0,0])
    rail_endcap(25,
                location=RAIL_ENDCAP_AFT,
                rounded=false);
                
// Create the fixed endcaps
translate([0,40,0])
rail_endcap(25,
            location=RAIL_ENDCAP_BOW,
            type=RAIL_ENDCAP_FIXED,
            rounded=true);
            
translate([50,40,0])
    rail_endcap(25,
                location=RAIL_ENDCAP_AFT,
                type=RAIL_ENDCAP_FIXED,
                rounded=false);