/*
 * --------------------------------
 * KCP-26001-RodDock
 * --------------------------------
 * File: 
 *  accessory_base_profile.scad
 *
 * Responsibility:
 *  Defines the RodDock Accessory Base Profile
 *
 * Revisions:
 *  2026-07-28  Initial Creation
 * ---------------------------------------------------
*/
include <..\Common\OpenSCAD/rounded_rect.scad>;

module accessory_blank_profile(x, y, rounded=true)
{
    rect_outline(x,y,DEFAULT_RECT_RADIUS,rounded);
}