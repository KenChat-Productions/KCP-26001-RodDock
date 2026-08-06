/*
 * ------------------------------------------
 * KCP-RD000-RodDock
 * ------------------------------------------
 * File: 
 *  rod_holder.scad
 * ------------------------------------------
 * Description:
 *  This module builds the rod holder using
 *  the rod_holder profile and the RodDock
 *  URC (Universal RodDock Connector) to
 *  connect to the rail adapter.
 *
 *  Cylinder radii are determined by the
 *  rod thickess.
 *  dimensions.scad contains the 
 *  predefined constants used for RodDock
 *
 * ------------------------------------------
 * Public Module(s):
 *
 * ------------------------------------------
 * Dependencies:
 *  The following are defined in accessory_base
 *  accessory_body_length: 20
 *  accessory_body_width:  34
 *  accessory_body_height: 40
 *
 * ------------------------------------------
 * Revisions:
 *  2026-07-08   Initial Creation
 *  2026-07-29   Refactor to be stand-alone
 * ------------------------------------------
 *
*/
include <dimensions.scad>;
include <rod_holder_profile.scad>;
include <compensation.scad>;
use <../Common/OpenSCAD/dovetail.scad>;

/*
 * ------------------------------------------
 *  The dovetail (connector) dpeth is used
 *  by multiple modues, so it is defined
 *  here as a "local" constant.
 * ------------------------------------------
*/
dt_depth = RAIL_DOVETAIL_X / tan(DOVETAIL_ANGLE) +
           DOVETAIL_GLUE;

module rod_holder(x=RODHLDR_DEFAULT_X,
                  y=RODHLDR_DEFAULT_Y,
                  radius)
{
    z = RAIL_HEIGHT + DOVETAIL_INTERFACE_THICKNESS;

    translate([0,round(dt_depth)-DOVETAIL_LAND,0])
    difference()
    {
        union()
        {
            rod_holder_stock(x,y,z,radius);
            rail_connector(x, y, z);
        }
        color("yellow")
        make_label(x, y, z, radius * 2);
    }
}

/*
 * ------------------------------
 * Name: rod_holder_stock
 * ------------------------------
 * Description
 *  This module extrudes the stock
 *  from the rod_holder_profile to the
 *  requested length. 

 *    ------------------------------
 * Parameters:
 *  x = the length of the rectangle
 *  y = the width of the rectangle
 *  z = the height to be extruded
 *  radius = the radius of the clyinder
 *    ------------------------------
 *
*/
module rod_holder_stock(x,y,z,radius)
{
    linear_extrude(z)
        rod_holder_profile(x,y,radius);
    /*
     *  Close off the back curved corners
     *  Thia must happen here, otherwise
     *  it gets removed by the difference
    */
    backfill(x,y,z);
}
/*
 * ------------------------------
 * Name: backfill
 * ------------------------------
 * Description
 *  Backfill is a stock modification
 *  not a rod holder "feature".
 *  This module restores the 
 *  rounded corners on the 
 *  connector end of the rold 
 *  holder
 * ------------------------------
 * Parameters:
 *  x = the length of the rectangle
 *  y = the width of the rectangle
 *  z = the height to be extruded
 * ------------------------------
 *
*/
module backfill(x, y, z)
{
    // Try RND_RECT_OFFSET if _LAND is not good
    dy = floor(dt_depth)-DOVETAIL_LAND;
    color("purple")
    build_compensation(x, dy, z);
}
/*
 * ------------------------------
 * Name: make_label
 * ------------------------------
 * Description
 *  This module prints the 
 *  RodDock name and the diameter
 *  / width of the keyhole slot
 * ------------------------------
 * Parameters:
 *  x = the length of the rectangle
 *  y = the width of the rectangle
 *  slot_width = width of the slot
 * ------------------------------
 *
*/
module make_label(x,y,z,slot_width)
{
    // Create the size label
    label = str("  ", slot_width," mm");

    // depth and font size of the text
    txt_depth    = 0.5;
    txt_size     = 4;
    txt_z_spacer = 1;
    
    // X - bring the text to the "left" surface
    tx = x-txt_depth;
    // Y moves the text to include the connector
    str_y = -floor((dt_depth-DOVETAIL_LAND));
    
    // Z is different for each text
    str1_z = (z+txt_size)/2;
    str2_z = ((z-txt_size)/2)-txt_z_spacer;

    // RodDock Label
    color("red")
    translate([tx,str_y,str1_z])
    rotate([90,0,90])
    linear_extrude(height = txt_depth)
    text("RodDock", size = txt_size);
    
    // Size of component
    color("red")
    translate([tx,str_y,str2_z])
    rotate([90,0,90])
    linear_extrude(height = txt_depth)
    text(label, size = txt_size);
}
/*
 * ------------------------------
 * Name: rail_connector
 * ------------------------------
 * Description
 *  This module builds the 
 *  necessary dovetail to attach
 *  the rod holder to the rail
 *  adapter.
 * ------------------------------
 * Parameters:
 *  x = the length of the rectangle
 *  y = the width of the rectangle
 * ------------------------------
 *
*/
module rail_connector(x, y, z)
{
    tx = (x/2);
    ty = (y/2)+DOVETAIL_LAND;
    translate([0,-DEFAULT_RECT_RADIUS,0])
    dovetail(x,
             RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X,
             z,
             x,
             z,
             DOVETAIL_ANGLE);
}