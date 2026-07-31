/*
 * --------------------------------
 * KCP-RD000-RodDock
 * --------------------------------
 * File: 
 *  adapter_profile.scad
 *
 * Responsibility:
 *  Defines the RodDock Rail Adapter Profile
 *
 * Revisions:
 *  2026-07-25  Initial Creation
 * ---------------------------------------------------
*/
include <dimensions.scad>;
include <../../KCP-Common/OpenSCAD/rounded_rect.scad>;
/*
 * ---------------------------
 * Engineering relationships
 * ---------------------------
 *
 * -------------------------
 * tang
 * -------------------------
*/
tang_height       = RAIL_GROOVE_HEIGHT -
                        ASSEMBLY_VERTICAL_CLEARANCE;
tang_width        = RAIL_GROOVE_WIDTH -
                        ASSEMBLY_HORIZONTAL_CLEARANCE;
//tang_engagement   = 6.00;
tang_engagement   = 5.00;
// -------------------------
// top jaw
// -------------------------
// Represented the adapter from the face
// to the end of the tang width
// Clearance is handed by the tang width
top_jaw_width     = RAIL_TAB_WIDTH + tang_width;
top_jaw_thickness = 3.00;

// -------------------------
// bottom jaw
// -------------------------
bottom_jaw_width     = RAIL_WIDTH -
                        ASSEMBLY_HORIZONTAL_CLEARANCE;
bottom_jaw_thickness = 4.00;

// -------------------------
// structural body
// -------------------------
// It must be tall enough to allow the tang
// to clear the top of the rail during assembly.
// width
structural_body_width = MINIMUM_STRUCTURAL_WIDTH;
// height
structural_body_height  = RAIL_HEIGHT +
                          tang_height +
                          ASSEMBLY_VERTICAL_CLEARANCE;

// -------------------------
// clamp opening
// Rough out cut
// Removes the primary clamp
// opening while leaving
// stock for the tang.
// -------------------------
clamp_opening_top = top_jaw_thickness +
                    tang_engagement;
clamp_opening_width  = top_jaw_width;
clamp_opening_bottom = bottom_jaw_thickness;    
clamp_opening_height = structural_body_height -
                        clamp_opening_top -
                        clamp_opening_bottom;


module adapter_profile()
{
    difference()
    {
        rect_outline(structural_body_width,
                     structural_body_height,
                     DEFAULT_RECT_RADIUS,
                     false);
        translate([0,bottom_jaw_thickness,0])
        clamp_opening();
    }
}
module clamp_opening()
{
    union()
    {
        // First the large rectangle
        color("green")
        square([top_jaw_width,clamp_opening_height]);
        
        // Now the tang cut
        tang_cut_width = top_jaw_width - tang_width;
        tang_cut_depth = tang_engagement;
        color("blue")    
        translate([tang_engagement,
                   clamp_opening_height,0])
        square([tang_cut_width,tang_engagement]);
    }
}
