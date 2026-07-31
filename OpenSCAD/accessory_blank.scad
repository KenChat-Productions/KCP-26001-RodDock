/*
 * --------------------------------
 * KCP-RD000-RodDock
 * --------------------------------
 * File: 
 *  accessory_lank.scad
 *
 * Responsibility:
 *  Defines the RodDock Rail Blank Accessory
 *
 * The Rail Accessory provides the standardized
 * bridge between the RodDock Accesory and the
 * RodDock Adapter Interface. 
 *
 * Design Intent:
 *
 * The Rail Accessory maintains the
 * geometric relationship
 * between the RodDock Accessory Interface and the
 * RodDock Adapter Interface.
 *
 * All accessory implementations should preserve this
 * relationship while allowing engineering optimization.
 *
 * Public Constraints:
 *  These dimensions are defined by the RodDock
 *  Rail Interface and Adapter
 *  and are not acessory specific.
 *
 *  Changing them changes compatibility.
 *
 * Public Module(s):
 *  accessory()
 *
 * Dependencies:
 *  dimensions.scad
 *  hardware.scad
 *  dovetail_connector
 *
 * Revisions:
 *  2026-07-06  Initial Creation
 *  2026-07-08  renamed to accessory_base
 *              since it only produces the
 *              accessory base, not the finished 
 *              component.
 *  2026-07-29  Renamed to accessory_blank to 
 *              reflect its usage
*/

include <dimensions.scad>;
include <../../KCP-Common/OpenSCAD/hardware.scad>;
include <accessory_blank_profile.scad>;
use <../../KCP-Common/OpenSCAD/dovetail.scad>;

// -------------------------
// structural body
// -------------------------
// length = the direction from the rail to the boat
//accessory_body_length  = MINIMUM_accessory_WALL +
//                           DOVETAIL_INTERFACE_THICKNESS;
                            
// width = the direction from aft to bow
//accessory_body_width = MINIMUM_accessory_WIDTH;
    
// Height = the direction from deck to sky
//accessory_body_height  = RAIL_HEIGHT +
//                          tang_height +
//                          ASSEMBLY_VERTICAL_CLEARANCE;


// length = the direction from the rail to the boat
// This value should not be changed, it is the 
// "accessory base thickness"
accessory_body_length  = MINIMUM_STRUCTURAL_WALL;

// width = the direction from aft to bow
// This has to be the adapter width plus the land.
accessory_body_width = MINIMUM_STRUCTURAL_WIDTH +
                       ASSEMBLY_HORIZONTAL_CLEARANCE +
                       DOVETAIL_LAND;
    
// Height = the direction from deck to sky
// This can change based on the need.
accessory_body_height  = RAIL_HEIGHT +
                         ASSEMBLY_VERTICAL_CLEARANCE +
                         RAIL_DOVETAIL_X;


module accessory_blank()
{
    union()
    {
        accessory_stock();
        // Add the "accessory base to rail" interface
        dovetail_cut();
    }

}

module accessory_stock()
{
    // length = rail to boat
    // width  = aft to bow
    // height = deck to sky
    linear_extrude(height=accessory_body_height)
    accessory_blank_profile(accessory_body_length,
                accessory_body_width, rounded = false);

}

module dovetail_cut()
{
    /*
    length = rail to boat
    width  = aft to bow
    height = deck to sky
    */
    cut_adj = accessory_body_width -
              DOVETAIL_INTERFACE_THICKNESS;
    translate([cut_adj,0,0])
    rotate([0,0,90])
    dovetail(accessory_body_width,RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X, accessory_body_height,
             accessory_body_width,
             accessory_body_height);
}