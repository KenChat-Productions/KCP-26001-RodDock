/*
 * ---------------------------
 * KCP-26001-RodDock
 * ---------------------------
 * File: 
 *    dimensions.scad
 *
 * ---------------------------
 * Responsibility:
 *   Defines engineering dimensions
 *   used throughout RodDock.
 *
 * ---------------------------
 * Public Constraints:
 *   Engineering constants
 *
 * ---------------------------
 * Dependencies:
 *    None
 *
 * ---------------------------
 *Revisions:
 * 2026-06-29  Initial Creation
 *
 * ---------------------------
 * Tolerances
 * Provides sufficient clearances for assembly
 * and accommodates expected 3D printing variation.
 * Prototype values. Subject to validation.
 *
*/
ASSEMBLY_VERTICAL_CLEARANCE   =    2.00;
ASSEMBLY_HORIZONTAL_CLEARANCE =    3.00;


// STRUCTURAL CONSTANTS
MINIMUM_STRUCTURAL_WALL  = 20;
MINIMUM_STRUCTURAL_WIDTH = 30;

/*
 * ----------------------------------
 * Standard Rail Lengths
 * ----------------------------------
 * Designed for multiple length rails
 * Extra Small (4 in)
 * Small (8 in)
 * Medium (10 in)
 *  Recommended Starting Point for most installations
 * Large (12 in)
*/
RAIL_XS_LENGTH      = 101.60; //  4 in
RAIL_S_LENGTH       = 203.20; //  8 in
RAIL_M_LENGTH       = 254.00; // 10 in
RAIL_L_LENGTH       = 304.80; // 12 in

/*
 * ----------------------------------
 * Rail Profile
 * ----------------------------------
 *
*/
// Rail Envelope
// Overall rail width projection from mounting surface).
RAIL_WIDTH              =  25.00;
RAIL_HEIGHT             =  30.00;

// Rail Features
RAIL_GROOVE_WIDTH       =   8.00;
RAIL_GROOVE_HEIGHT      =  10.00;
RAIL_DT_OFFSET          =   5.00;
PRIMARY_SCREW_OFFSET    =  25.40;
RAIL_TAB_WIDTH          = (RAIL_WIDTH -
                           RAIL_GROOVE_WIDTH)/2;
RAIL_DFLT_RADIUS        =   4.00;
// Default Width for the dovetail face on the rail
RAIL_DOVETAIL_X         =   8.00;

/*
 * ----------------------------------
 * Rail Endcap Profile
// ----------------------------------
*/
// Default length of the rail endcap
RAIL_ENDCAP_DEFAULT      =  25.00;
// Rail Endcap Location
RAIL_ENDCAP_BOW          =   1;
RAIL_ENDCAP_AFT          =   2;
// Rail Endcap Type
RAIL_ENDCAP_FIXED        =   1;
RAIL_ENDCAP_ANCHOR       =   2;
// Bungee Cord offets
BUNGEE_OFFSET            =   3.00;

/* ---------------------------------------
 * RODDOCK DOVETAIL PROFILE
 * ---------------------------------------
*/

// DOVETAIL CUT 
DOVETAIL_INTERFACE_THICKNESS = 10.00;
// LAND is how much of the stock to leave behind on cut
DOVETAIL_LAND                =  1.00;
// GLUE is how far into the stock to glue securely
DOVETAIL_GLUE                =  0.50;
// Angle - the dovetail angle
DOVETAIL_ANGLE               = 60.00;


/*
 * ---------------------------------------
 * Shapes
 * ---------------------------------------
*/
DEFAULT_RECT_RADIUS     =   4.00;
RND_RECT_OFFSET         =   2.50;

/*
 * ---------------------------------------
 * Adapter
 * ---------------------------------------
*/
ADAPTER_DEFAULT_LENGTH = 30.00;

/*
 * ---------------------------------------
 * Rod Holder
 * ---------------------------------------
*/
/*
 *  Default dimensions for the rod holder
 *  Thess dimensions may need to be adjusted
 *  for various filament types
*/
RODHLDR_DEFAULT_X   = 34.00;
RODHLDR_DEFAULT_Y   = 21.00;
// Minimum Text Offset
RODHLDR_TEXT_OFFSET =  0.50;
// These measurements construct the 
// radius of the cylinder cut and
// are the basis for the width of the
// cube cut.
//
RODSLOT_RADIUS_12 =  6.00;
RODSLOT_RADIUS_13 =  6.50;
RODSLOT_RADIUS_14 =  7.00;

/*
 * ---------------------------------------
 * Rod Clip
 * ---------------------------------------
*/

// Replaceable liner thickness.
// Future enhancement
LINER_THICKNESS          = 1.00;
