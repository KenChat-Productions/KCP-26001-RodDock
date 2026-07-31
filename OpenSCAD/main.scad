//
// --------------------------------
// KCP-RD000-RodDock
// --------------------------------
// File: 
//    main.scad
// Responsibility:
//    Main OpenSCAD Entry Point
//
// Public Module(s):
//
// Dependencies:
//
//Revisions:
// 2026-06-29  Initial Creation
// --------------------------------
//

//include <rail.scad>;
//include <adapter.scad>;
//include <adapter_profile.scad>;
//include <rail_profile.scad>;
include <accessory_blank.scad>;
//include <rod_holder_profile.scad>;
//include <rod_holder.scad>;
//include <dovetail_connector.scad>

// rail(RAIL_S_LENGTH);
//linear_extrude(height = 30) adapter_profile();
//adapter();
accessory_blank();
//linear_extrude(30)
//rod_holder_profile( RODHLDR_DEFAULT_X, RODHLDR_DEFAULT_Y, RODSLOT_RADIUS_14);
//rod_holder(30,25,radius=RODSLOT_RADIUS_14);
//dovetail(25, 8, 8, 30,24,24);
//dovetail(25,8,8,30,21,27);
//linear_extrude(15) rail_profile();
//rail_endcap_profile();
