include <dimensions.scad>;

// --------------------------------------
// module: aft_joint
// --------------------------------------
// Description:
//  This module creates the aft 
//  mounting points to join rail to rail
//  or rail to an aft end cap
// --------------------------------------
// Parameters:
//  length = Extruded length of the rail.
// --------------------------------------
// NOTES
//  The Aft end of the rail is a male dovetail/
// --------------------------------------
//  The "head" of the join is set down from
//  the top to make a smooth, continuous
//  connection when the rails are joined.
// --------------------------------------
//  For reference:
//  length = rail to boat
//  width  = aft to bow
//  height = deck to sky
// --------------------------------------
//
module aft_joint(length,rounded=false)
{
    dt_adj = round(RAIL_DOVETAIL_X /
                tan(DOVETAIL_ANGLE));
    height = round(RAIL_HEIGHT - dt_adj) +
                ASSEMBLY_HORIZONTAL_CLEARANCE;
    width  = RAIL_WIDTH-DOVETAIL_LAND;
        
    translate([dt_adj,0,0])
    rotate([0,90,90])
    dovetail(RAIL_WIDTH,
             RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X,
             RAIL_HEIGHT,
             width,
             height,
             DOVETAIL_ANGLE,
             crn_round=rounded);

    // Check to see if we need to cut away
    // any material
    aft_compensation(height,width,dt_adj);
}
/*
 * --------------------------------------
 * module: aft_compensation
 * --------------------------------------
 * Description:
 *  This module creates a compensation
 *  block of a given size (x, y, z) 
 *  to remove any overhanging stock.
 * --------------------------------------
 * Parameters:
 *  height = how tall is the compensation.
 *  width  = how wide is the compensation.
 *  dt_adj = What "x" (length adjustment
*       is needed.
 * --------------------------------------
*/
module aft_compensation(height,width,dt_adj)
{
    h = RAIL_HEIGHT - height;
    if(height != RAIL_HEIGHT)
    {
        // Top Ledge
        color("purple")
        translate([0,height,-RAIL_WIDTH])
        build_block_compensation(dt_adj,
                           h,
                           RAIL_WIDTH);
    }
    if(width != RAIL_WIDTH)
    {
        // boat side
        color("purple")
        translate([0,0,-h/2])        
        build_block_compensation(dt_adj,
                           RAIL_HEIGHT,
                           h/2);

        // rail side
        color("purple")
        translate([0,0,-(width+h/2)])        
        build_block_compensation(dt_adj,
                           RAIL_HEIGHT,
                           h/2);
    }
}
/*
 * --------------------------------------
 * module: bow_joint
 * --------------------------------------
 * Description:
 *  This module creates the aft 
 *  mounting points to join rail to rail
 *  or rail to an aft end cap
 * --------------------------------------
 * Parameters:
 *  length = Extruded length of the rail.
 * --------------------------------------
 * NOTES
 *  The Bow end of the rail is a female dovetail/
 * --------------------------------------
 *  For reference:
 *  length = rail to boat
 *  width  = aft to bow
 *  height = deck to sky
 * --------------------------------------
 *
*/
module bow_joint(length,rounded=false)
{
    //echo("bow_joint - length: ", length);
    dt_adj = round(RAIL_DOVETAIL_X /
                   tan(DOVETAIL_ANGLE));    
    x = length+(dt_adj-DOVETAIL_LAND);
/*
    module dovetail(bx,
                bh,
                sx,
                sh,
                width,
                height,
                dt_angle)
*/

    translate([x+DOVETAIL_GLUE,0,0])
    rotate([0,90,90])
    dovetail(RAIL_WIDTH,
             RAIL_DOVETAIL_X,
             RAIL_DOVETAIL_X,
             RAIL_HEIGHT,
             RAIL_WIDTH,
             RAIL_HEIGHT,
             DOVETAIL_ANGLE,
             DEFAULT_RECT_RADIUS,
			 DOVETAIL_LAND,
			 rounded);
}
