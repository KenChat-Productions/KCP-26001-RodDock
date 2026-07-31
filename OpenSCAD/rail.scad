/*
 * ---------------------------------------
 * KCP-RD000-RodDock
 * ---------------------------------------
 * File:
 *    rail.scad
 *
 * ---------------------------------------
 * Responsibility:
 *    Defines the RodDock rail geometry.
 *
 * ---------------------------------------
 * Public Modules:
 *    rail(length)
 *
 * ---------------------------------------
 * Dependencies:
 *    dimensions.scad
 *
 * ---------------------------------------
 * Revisions:
 * 2026-06-29  Initial Creation
 * ----------------------------
 *
 * ---------------------------------------
 * NOTE:
 *  The rail was originally modeled in
 *  this orientation.
 *  Coordinate names reflect the existing
 &  implementation.
 *  Consider reorienting the rail during a 
 *  future refactoring if it provides
 *  sufficient benefit.
 * ---------------------------------------
 *
*/
include <../../KCP-Common/OpenSCAD/hardware.scad>;
include <rail_profile.scad>;
include <connectors.scad>;
use <../../KCP-Common/OpenSCAD/dovetail.scad>;
use <compensation.scad>;


/*
 * --------------------------------------
 * module: rail
 * --------------------------------------
 * Description:
 *  This module puts together a rail
 *  with joinable ends.
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 *
*/
module rail(length,rounded=true)
{
    /*
     * This rotation is for the .stl file
     * used on a bambu labs printer
    */
    y = (length == RAIL_L_LENGTH) ? 47 : 
        (length == RAIL_M_LENGTH) ? 50 : 0;
    rotate([90,0,y])
    difference()
    {
        union()
        {
            difference()
            {
                rail_stock(RAIL_WIDTH,
                           RAIL_HEIGHT,
                           RAIL_GROOVE_WIDTH,
                           RAIL_GROOVE_HEIGHT,
                           length,
                           rounded);
                mounting_holes(length);
                aft_joint(length);
            }
            bow_joint(length);
        }
        cut_bow_groove(length);
    }
}
/*
 * --------------------------------------
 * module: rail_stock
 * --------------------------------------
 * Description:
 *  This module extrudes a rail profile
 *  to the the requested length.
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 * --------------------------------------
 *
*/
module rail_stock(rx, ry, cx, cy, length, rounded)
{
    rotate([0,90,0])
    linear_extrude(height = length)
        rail_profile(rx, ry, cx, cy, rounded);
}
// --------------------------------------
// module: mounting hole
// --------------------------------------
// Description:
//  This module creates the appropriate
//  mounting holes in the correct places
//  depending on the rail length.
//
// Parameters:
//  length = Extruded length of the rail.
//
// --------------------------------------
// Constraints
//  Mounting hole centerline is located 
//  at the rail center height.
//
//  The selected position provides 
//  adequate material above and below the
//  hole while maintaining clearance from
//  the adapter groove.
//
//  he mounting feature is intended for
//  standard countersunk mounting screws
//  whose head geometry remains entirely
//  below the adapter groove.
//
//  The proper number of holes must be
//  used to securely mount the rail and
//  support it without compromising
//  its strength.
//
//  Intial testing proved that a span of
//  8 inches or less only needed 2 holes.
// --------------------------------------
//
module mounting_holes(length)
{
    left = PRIMARY_SCREW_OFFSET; // 1 inch
    right = length - PRIMARY_SCREW_OFFSET;
    center = length / 2;
    
    // Aft hole
    color("red")
    drill_hole(left,M4_WOODSCREW_DIAMETER,true);
    if (length ==  RAIL_L_LENGTH)
    {        
        // Middle hole
        color("blue");
        drill_hole(center,M4_WOODSCREW_DIAMETER,true);
    }
    // Bow hole
    color("green")
    drill_hole(right,M4_WOODSCREW_DIAMETER,true);
}
/*
 * ---------------------------------------
 * drill hole
 * ---------------------------------------
 * Description
 *  "Drills" a hole of a specific size
 *  at a specified location and applies
 *  a countersink hole, if requested.
 * ---------------------------------------
 * Parameters
 *  location    - "x" coordinate on the stock
 *  diameter    - the "size" of the hole
 *  countersink - whether to provide a
 *      countersink
 * ---------------------------------------
 * ---------------------------------------
 *
*/
module drill_hole(location,
                  diameter,
                  countersink = false)
{
    // current assumption is a 4mm wood  screw
    x = location;
    y = RAIL_HEIGHT / 2;
    z = RAIL_WIDTH;
    // drill the hole (and countersink?)
    translate([x,y,-z])
    cylinder(
        d=diameter,
        h=z,
        $fn = 50
    );
    if (countersink)
    {
        translate([x,y,-M4_WOOD_HEAD_HEIGHT])
        cylinder(
            h = M4_WOOD_HEAD_HEIGHT,
            d1 = diameter,
            d2 = M4_WOOD_HEAD_DIAMETER +
                    COUNTERSINK_TOLERANCE,
            $fn = 50
        );
    }
}

/*
 * -----------------------------------------------
 * module: cut_bow_grove
 * -----------------------------------------------
 * Description
 *  Cut the rail groove in the bow joint that was 
 *  added (union) to the bow end of the rail.
 * -----------------------------------------------
 * Paraeters:
 *  length - the rail length
 * -----------------------------------------------
 *
*/
module cut_bow_groove(length)
{
    // Because of orientation:
    // x = aft-to-bow
    // y = deck-to-sky
    // z = rail-to-boat
    //adj = 0.5;
    x = length-RAIL_DOVETAIL_X;
    y = RAIL_HEIGHT - RAIL_GROOVE_HEIGHT;    
    z = ((RAIL_WIDTH - RAIL_GROOVE_WIDTH) / 2);
    z_pos = ((RAIL_WIDTH - RAIL_GROOVE_WIDTH) / 2)*2;

    color("orange")
    translate([x,y,-z_pos+DOVETAIL_GLUE])
    build_compensation(RAIL_DOVETAIL_X +
                       RAIL_GROOVE_HEIGHT,
                       RAIL_GROOVE_HEIGHT,
                       z-DOVETAIL_GLUE);
}

