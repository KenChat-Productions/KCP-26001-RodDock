/*
 * --------------------------------
 * KCP-RD000-RodDock
 * --------------------------------
 * File: 
 *  adapter.scad
 *
 * Responsibility:
 *  Defines the RodDock Rail Adapter
 *
 * The Rail Adapter provides the standardized
 * bridge between the RodDock Rail and the
 * RodDock Accessory Interface. 
 * Design Intent:
 *
 * The Rail Adapter maintains the geometric relationship
 * between the RodDock Rail Interface and the
 * RodDock Accessory Interface.
 *
 * All adapter implementations should preserve this
 * relationship while allowing engineering optimization.
 *
 * Public Constraints:
 *  These dimensions are defined by the RodDock
 *  Rail Interface and are not adapter specific.
 *
 *  Changing them changes compatibility.
 *
 * Public Module(s):
 *  adapter()
 *
 * Dependencies:
 *  dimensions.scad
 *  hardware.scad
 *  adapater_profile.scad
 *
 * Revisions:
 *  2026-06-30  Initial Creation
 *  2026-06-30  Renamed carriage to adapter
 *              Established architectural role.
 *  2027-07-25  Converted to use adapter_profile
 * ---------------------------------------------------
*/
include <dimensions.scad>;
include <../../KCP-Common/OpenSCAD/hardware.scad>;
include <adapter_profile.scad>;
use <../../KCP-Common/OpenSCAD/dovetail.scad>;

module adapter(length=ADAPTER_DEFAULT_LENGTH,
               dovetail=true)
{
    // Build the basic stock
    difference()
    {
        adapter_stock(length);

        // "Tap & Drill" the screw hole
        screw_hole(length);

        // cut the accessory interface
        if(dovetail)
        {
            dovetail_cut(length);
        }
    };
}
module adapter_stock(length)
{
    linear_extrude(height = length)
        adapter_profile();
}
module dovetail_cut(length)
{
    // length = rail to boat
    // width  = aft to bow
    // height = deck to sky
    // width = the direction from aft to bow
    width = MINIMUM_STRUCTURAL_WIDTH;
    
    // height = the direction from deck to sky
    height  = RAIL_HEIGHT +
              tang_height +
              ASSEMBLY_VERTICAL_CLEARANCE;
    
    x = length-(DOVETAIL_INTERFACE_THICKNESS/2);
    translate([x,0,0])
    rotate([90,270,180])
    color("green")
    dovetail(width,
             RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X,
             height,
             width,
             height,
             DOVETAIL_ANGLE);
}
module screw_hole(length)
{
    x = length/2;
    y = x/2;

    rotate([90,90,0])
    translate([-x,y,0])
    color("purple")
    cylinder(
        d = M4_TAP_DIAMETER,
        h = x,
        center = true,
        $fn = 32
    );
}