/*
 * ---------------------------------------
 * KCP-26001-RodDock
 * ---------------------------------------
 * File:
 *    rail_endcap.scad
 *
 * ---------------------------------------
 * Responsibility:
 *    Defines the RodDock rail
 *  endcap geometry.
 *
 * ---------------------------------------
 * Public Modules:
 *    rail_endcap(length)
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

include <../Common/OpenSCAD/hardware.scad>;
include <rail_endcap_profile.scad>;
include <connectors.scad>;
use <../Common/OpenSCAD/dovetail.scad>;
use <compensation.scad>;

/*
 * --------------------------------------
 * module: rail_endcap
 * --------------------------------------
 * Description:
 *  This module calls the appropriate
 *  rail endcap based on the provided
 *  length, location, and type
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 *  location = bow or aft
 *  type = fixed or hook
 * --------------------------------------
 *
*/
module rail_endcap(length,
                   location=RAIL_ENDCAP_BOW,
                   type=RAIL_ENDCAP_ANCHOR,
                   rounded)
{
    difference()
    {
        
        if(location == RAIL_ENDCAP_BOW)
        {
            rail_endcap_bow(RAIL_WIDTH,
                            RAIL_HEIGHT,
                            length,rounded);
        }
        else
        {
            rail_endcap_aft(RAIL_WIDTH,
                            RAIL_HEIGHT,
                            length,rounded);
        }
        // IF POSSIBLE DO "TYPE WORK" HERE
        if(type == RAIL_ENDCAP_FIXED)
        {
            cut_fixed_cap(length);
        }
        else
        {
            x = length - 
                (BUNGEE_OFFSET +
                round(RAIL_DOVETAIL_X /
                   tan(DOVETAIL_ANGLE)));
            anchor_x = location == RAIL_ENDCAP_AFT ?
                       -x : -BUNGEE_OFFSET;
            translate([anchor_x,0,0])
                cut_anchor_cap(length);
        }
    }
}
/*
 * --------------------------------------
 * module: rail_endcap_stock
 * --------------------------------------
 * Description:
 *  This module extrudes a rail rendcap profile
 *  to the the requested length.
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail endcap.
 * --------------------------------------
 *
*/
module rail_endcap_stock(x,y,
                         length=RAIL_ENDCAP_DEFAULT,
                         rounded)
{
    rotate([0,90,0])
    linear_extrude(height = length)
        rail_endcap_profile(x,y,rounded);
}
/*
 * --------------------------------------
 * module: rail_endcap_bow
 * --------------------------------------
 * Description:
 *  This module assembles a bow mounted
 *  endcap base.
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 *
*/
module rail_endcap_bow(x,y,length,rounded)
{
    difference()
    {
        rail_endcap_stock(x,y,length,rounded);
        aft_joint(length);
    }
}

/*
 * --------------------------------------
 * module: rail_endcap_aft
 * --------------------------------------
 * Description:
 *  This module assembles a aft mounted
 *  endcap base.
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 *
*/
module rail_endcap_aft(x, y, length,rounded)
{
    union()
    {
        rail_endcap_stock(x,y,length,rounded);
        bow_joint(length,rounded);
    }
}
/*
 * -----------------------------------------------
 * module: cut_anchor_cap
 * -----------------------------------------------
 * Description
 *  Cut a cleat-like grrove into the block
 *  to allow the 1/8" cord to be attached.
 * -----------------------------------------------
 * Paraeters:
 *  length - the rail length
 * -----------------------------------------------
 *
*/
module cut_anchor_cap(length)
{
    by = round(RAIL_HEIGHT/3);
    tx = length - 
        BUNGEE_GROOVE_WIDTH;
    ty = RAIL_HEIGHT - by;
    tz = RAIL_WIDTH;
    translate([tx,0,-tz])
    color("purple")
    build_block_compensation(BUNGEE_GROOVE_WIDTH,
                       by,
                       RAIL_WIDTH);

    translate([tx,ty,-tz])
    color("purple")
    build_block_compensation(BUNGEE_GROOVE_WIDTH,
                       by,
                       RAIL_WIDTH);
    
    translate([tx,by,-BUNGEE_GROOVE_WIDTH])
    color("orange")
    build_block_compensation(BUNGEE_GROOVE_WIDTH,
                       by,
                       BUNGEE_GROOVE_WIDTH);

    translate([tx,by,-RAIL_WIDTH])
    color("blue")
    build_block_compensation(BUNGEE_GROOVE_WIDTH,
                       by,
                       BUNGEE_GROOVE_WIDTH);
}
/*
 * -----------------------------------------------
 * module: cut_fixed_cap
 * -----------------------------------------------
 * Description
 *  Cut a hole into the block to allow the 
 *  1/8" cord to be attached.
 * -----------------------------------------------
 * Paraeters:
 *  length - the rail length
 * -----------------------------------------------
 *
*/
module cut_fixed_cap(length)
{
    x = length/2;
    y = RAIL_HEIGHT / 2;
    z = RAIL_WIDTH;

    translate([x,y,-z])
    color("purple")
    cylinder(
        d=BUNGEE_HOLE_DIAMETER,
        h=z,
        $fn = 50
    );
}

