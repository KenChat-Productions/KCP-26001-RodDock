/*
 * --------------------------------
 * KCP-RD000-RodDock
 * --------------------------------
 * File: compensation.scad
 *
 * Responsibility:
 *  Defines the RodDock Dovetail edges used by the
 *  Adapter and Accessory implementations.
 *
 * Public Constraints:
 *
 * The RodDock Dovetail Interface is defined in
 * dimensions.scad.
 *
 * Changing those dimensions changes compatibility
 * between adapters and accessories.
*/

/*
 * build a cube for the requester
*/
module build_compensation(width, depth, height)
{
    cube([width, depth, height]);
}