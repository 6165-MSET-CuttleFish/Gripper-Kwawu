// The Kwawu 2.0 prosthetic Arm - Socket Version
// By Jacqun Buchanan

// Modified by Eric Woo-Shem for Gripper hand
// Using Gripper design by Skip Meetze and Jon Schull & Modifications by James Quilty (Thai_Reach)

// Parameteric 3-d printable prosthetic arm
//
// This design is licensed under the Creative Commons - Attribution - Share Alike license.

// The ISO thread code is by Trevor Moseley

// Preview Each Part
part = "Cuff"; // [Cuff:Cuff, Arm1:Arm1, Arm2:Arm2, WristBolt:WristBolt,  ElbowBolt:ElbowBolt, GripperHand: GripperHand, ThumbMoldOuter:ThumbMoldOuter, ThumbMoldInner:ThumbMoldInner, ThumbReg:ThumbReg, All:All *WIP*]    

// Choose Left or Right Hand
LeftRight = "Left"; // [Left,Right]
// Wrist to elbow crease (mm)
ArmLength = 282; //[141: 564]
// Circumference of Forearm just below elbow crease (mm)
ForearmCircumference = 271; //[135: 542]
// Circumference of Bicep (mm)
BicepCircumference = 294; //[147: 588]
// Additional Hand Scale (percentage)
AdditionalHandScale = 100; //[50: 150]
// Padding Thickness -inside forearm and cuff (mm)
PaddingThickness = 2; //[0: 10]
// How many pieces to divide the arm into  HIDDEN
// ArmPieces = 2; //[1, 2]
// ISO metric bolt holding cuff and arm together (mm)
ElbowBoltDiameter = 8; //[4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
// Extra added diameter for elbow bolt
ElbowBoltExtraDiameter = 0.15;

WristBoltDiameter = 25; // [20, 25, 30]

VentingHoles = "None"; // [None,VentingHoles1,VentingHoles2,VentingHoles3]

// - Across all four knuckles (mm)
//HandWidth = 93; //[50:186]

/* [Hidden] */

ArmPieces = 2;

// This is an amount added to the pencil cover length. 
// When this is zero the pencil cover is as tight as possible.
// Make it larger to fit around larger/thicker pencils
PencilCoverAddedLength = 4.0;

PI =  3.141592653589793238;
HandVersion = "V2.2";
ArmScale = ArmLength/282;

ForearmCircumferenceWPadding = ((ForearmCircumference/PI) + 2*PaddingThickness)*PI;
ArmCircumferenceScale = ForearmCircumferenceWPadding/271;
BicepCircumferenceWPadding = ((BicepCircumference/PI) + 2*PaddingThickness)*PI;
CuffScale = BicepCircumferenceWPadding/294;
//HandScale = HandWidth/93;
HandScale = ArmCircumferenceScale * (AdditionalHandScale/100) * 1.1544; // 1.1544 multiplier for large hand

// Metric thumb screw diameter
ThumbScrewDia = HandScale > 0.86 ? 4 : 3;

$fn=30;

print_part();


module print_part( ) {
    
    if(part == "ElbowBolt" || part == "All") {
        translate([400, 400, 0])
        // ( dia,hi, headhi, headDiameter, hexDiameter)
        translate([-30, 0, 0])
        make_bolt(ElbowBoltDiameter + ElbowBoltExtraDiameter, ArmCircumferenceScale * 6 + CuffScale * 10, ElbowBoltDiameter/2, ElbowBoltDiameter *3);
        if (part == "All") {
            translate([400, 400, 0])
            translate([30, 0, 0])
            make_bolt(ElbowBoltDiameter + ElbowBoltExtraDiameter, ArmCircumferenceScale * 6 + CuffScale * 10, ElbowBoltDiameter/2, ElbowBoltDiameter *3);
            translate([400, 400, 0])
            translate([0, 30, 0])
            make_bolt(ElbowBoltDiameter + ElbowBoltExtraDiameter, ArmCircumferenceScale * 6 + CuffScale * 10, ElbowBoltDiameter/2, ElbowBoltDiameter *3);
            translate([400, 400, 0])
            translate([0, -30, 0])
            make_bolt(ElbowBoltDiameter + ElbowBoltExtraDiameter, ArmCircumferenceScale * 6 + CuffScale * 10, ElbowBoltDiameter/2, ElbowBoltDiameter *3);
        }
        
    }

    if(part == "WristBolt" || part == "All") {
        translate([-400, 400, 0])
        // rotate for better print orientation
        rotate([0,90,0]) 
        MakeWristBolt();
    }
    
    if (part == "Cuff" || part == "All") {
        translate([-400, -400, 0])
        translate([-150, -230, 0])
        if (LeftRight == "Left") {
            mirror([0,1,0]) MakeCuff();
        } else {
            MakeCuff();
        }
    }
    
    if (part == "Arm1" || part == "All") {
        translate([400, -400, 0])
        translate([0, -10, 0])
        // rotate for better print orientation
        rotate([0,180,0]) 
        if (LeftRight == "Left") {
            mirror([1,0,0]) MakeArm(1);
        } else {
            MakeArm(1);
        }
    } 
    
    if (part == "Arm2" || part == "All") {
        translate([800, 400, 0])
        // rotate for better print orientation
        rotate([0,180,0]) 
        if(ArmPieces == 2)
        {
            if (LeftRight == "Left") {
                mirror([1,0,0]) MakeArm(2);
            } else {
                MakeArm(2);
            }
        }
    } 
    
    if (part == "GripperHand" || part == "All") {
        translate([400, 800, 0])
        translate([30, 0, 0])
        if (LeftRight == "Left") {
            mirror([1,0,0])     MakeGripper();
        } else {
            MakeGripper();
        }
    } 
    if (part == "ThumbMoldOuter" || part == "All") {
        translate([800, 800, 0])
        translate([120, -100,0])
        if (LeftRight == "Left") {
            mirror([1,0,0])     MakeThumbMoldOuter();
        } else {
            MakeThumbMoldOuter();
        }
    } 
    if (part == "ThumbMoldInner" || part == "All") {
        translate([-800, 400, 0])
        translate([200, -200, 0])
        if (LeftRight == "Left") {
            mirror([1,0,0])     MakeThumbMoldInner();
        } else {
            MakeThumbMoldInner();
        }
    } 
    if (part == "ThumbReg" || part == "All") {
        translate([-800, -800, 0])
        if (LeftRight == "Left") {
            mirror([1,0,0])     MakeThumbReg();
        } else {
            MakeThumbReg();
        }
    }
    
    
    
}

module MakeCuff() {
    
    difference() {
        Cuff();
        
        //Cut a holes for elbow bolts
        translate([CuffScale  * 58.65, CuffScale  * -157, 0 ]) cylinder(d=ElbowBoltDiameter + 1, h = CuffScale  * 150, center=true, $fn=30);
        translate([CuffScale  * 58.65, CuffScale  * -303.63, 0 ]) cylinder(d=ElbowBoltDiameter + 1, h = CuffScale  * 150, center=true, $fn=30);

    }
    
   
}

module MakeWristBolt() {
    // Compensate .6 mm tolerance per 5 mm change in thread diameter
    // this is because with smaller bolt, we need larger tolerance
    diam = WristBoltDiameter == 25 ? 25 : WristBoltDiameter == 20 ? 19.6 : WristBoltDiameter == 30 ? 29.4 : 25;
    hi = 16 * HandScale + 20 * ArmScale;
    
    difference() {
        
        union() {
            // basic cyliner of bolt
            thread_out_centre(diam,hi);
            
            // round the ends to not wear the thread
            translate([0, 0, 2 ]) rotate_extrude(convexity = 10) translate([diam/4, 0, 0]) circle(r = diam/5.5, $fn = 100);
            translate([0, 0, hi-2 ]) rotate_extrude(convexity = 10) translate([diam/4, 0, 0]) circle(r = diam/5.5, $fn = 100);
            
            difference(){
                
                //make threads
                
                translate([0, 0, -5 ]) thread_out(diam,hi+10);
               
                //Cut threads evenly at bolt ends
                translate([0, 0, -5 ]) cylinder(d = diam + 10, h = 10, center=true, $fn=30);
                translate([0, 0, hi+5 ]) cylinder(d = diam + 10, h = 10, center=true, $fn=30);
                
            }
        }
      
        //Cut flat top and bottom to make printable
        translate([9*diam /10, 0, hi/2 -5]) cube([ diam + 1, diam + 1, hi+15], center= true);
        //translate([-9*WristBoltDia /10, 0, hi/2 -5]) cube([ WristBoltDia + 1, WristBoltDia + 1, hi+15], center= true);
        
        //Cut a hole down middle for string
        translate([0, 0, hi/2 +5 ]) cylinder(d = diam/5.5, h = hi +15, center=true, $fn=30);
        
    }
    
}

module MakeArm(PieceNumber) {
    
    difference(){
        
        if(ArmPieces == 1) {
            Arm();
        } else {
            if(PieceNumber == 1)
                Arm1();
            else
                Arm2();
        }
        
        if(PieceNumber == 1) {
            // cut large hole for wrist bolt 
            // the -0.05 on bolt diamter is to make sure threads attach to walls
            translate([2.513 * ArmCircumferenceScale, 14.753 * ArmCircumferenceScale, -(21.5* ArmScale) + (26* ArmScale)/2 ]) 
            cylinder(d = WristBoltDiameter - 0.05, h = 27.00 * ArmScale + 50 * ArmScale, center=true, $fn=30);
            
            // cut small hole for wrist bolt 
            translate([2.513 * ArmCircumferenceScale, 14.753 * ArmCircumferenceScale, -(21.5* ArmScale) + (30* ArmScale)/2 ]) cylinder(d = WristBoltDiameter, h = 40.00 * ArmScale + 60 * ArmScale, center=true, $fn=30);
        }
        
        if(PieceNumber == 2 || ArmPieces == 1) {
             // Make hole for Elbow threads
            translate([ArmCircumferenceScale * 10.423, 0, ArmScale * -294.89]) rotate([90,0,10]) cylinder(d=ElbowBoltDiameter, h=ArmCircumferenceScale * 200,center=true, $fn=20);
        }
        
        if(VentingHoles == "VentingHoles1")
        {
            if(ArmPieces == 1)
            {
                VentingHoles11();
                VentingHoles12();
                
            } else {
                if(PieceNumber == 1) 
                    VentingHoles11();
                else
                    VentingHoles12();
            }
                          
        }
              
        if(VentingHoles == "VentingHoles2")
        {
            if(ArmPieces == 1)
            {
                VentingHoles21();
                VentingHoles22();
                
            } else {
                if(PieceNumber == 1) 
                    VentingHoles21();
                else
                    VentingHoles22();
            }
        }
              
         if(VentingHoles == "VentingHoles3")
         {
            if(ArmPieces == 1)
            {
                VentingHoles31();
                VentingHoles32();
                
            } else {
                if(PieceNumber == 1) 
                    VentingHoles31();
                else
                    VentingHoles32();
            }
         }
    }
   
    if(PieceNumber == 1) {
        difference(){
            
            //Add inner threads for wrist bolt holder
            translate([2.513 * ArmCircumferenceScale, 14.753 * ArmCircumferenceScale, -(20 * ArmScale + 40 * ArmScale) +(-3* ArmScale) ])   
            thread_in(WristBoltDiameter, 23 * ArmScale + 40 * ArmScale);
          
            // truncate threads length to wrist end
            translate([2.513 * ArmCircumferenceScale - 100, 14.753 * ArmCircumferenceScale - 100, -(21.5* ArmScale)-0.5]) 
            cube(200);
            
            // truncate threads inside arm
            translate([2.513 * ArmCircumferenceScale - 100, 14.753 * ArmCircumferenceScale - 100, -200-(46.5* ArmScale)-0.5]) 
            cube(200);
            
        }
    }
    

        
    if(PieceNumber == 2 || ArmPieces == 1) {
       difference() {
       
            //Add inner threads for elbow bolt holder
            translate([ArmCircumferenceScale * 10.423, 0, ArmScale * -294.89]) rotate([90,0,10]) translate([0, 0, -ArmCircumferenceScale * (60+ 20)]) thread_in(ElbowBoltDiameter, ArmCircumferenceScale * 120);
                    
            translate([ArmCircumferenceScale * 10.423, 0, ArmScale * -294.89]) rotate([90,0,10]) translate([0, 0, -ArmCircumferenceScale * (43 - 29)]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmCircumferenceScale * 86,center=true, $fn=20);
               
            translate([ArmCircumferenceScale * 10.423, 0, ArmScale * -294.89]) rotate([90,0,10]) translate([0, 0, -ArmCircumferenceScale * (20 - 65)]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmCircumferenceScale * 20,center=true, $fn=20);
               
            translate([ArmCircumferenceScale * 10.423, 0, ArmScale * -294.89]) rotate([90,0,10]) translate([0, 0, -ArmCircumferenceScale * (20 + 52.8)]) cylinder(d=ElbowBoltDiameter + 0.5, h=ArmCircumferenceScale * 20,center=true, $fn=20);
       }
    }    
}

module MakeGripper() {  
    BoltAlign = (WristBoltDiameter == 25 ? 
    (LeftRight == "Left" ? 165 : 270)
    : (LeftRight == "Left" ? 165-185 : 270+75));

    difference(){
        union(){
            // Load hand model
            Gripper();
            
            // Fill in original bolt mount
            translate([27.6* HandScale, -3.5 * HandScale, 0])
            cylinder(h = 18 * HandScale, d = 25 * HandScale, $fn = 30);
            translate([23* HandScale, -2 * HandScale, 0])
            cylinder(h = 30 * HandScale, d = 25 * HandScale, $fn = 30);
            
            // Fill in Letter
            translate([9* HandScale, -4 * HandScale, 0])
            cylinder(h = 4 * HandScale, d = 10 * HandScale, $fn = 30);
            
            // Fix screw hole for thumb
            rotate([0,90,0])
            translate([-32 * HandScale, -15.5 * HandScale, 9.35 * HandScale])
            {
                difference() {
                    cylinder(h = 50 * HandScale, d = 5 * HandScale, $fn = 30);
                    cylinder(h = 50 * HandScale, d = (ThumbScrewDia-0.45), $fn = 30);
                }
            }
        }
        
        rotate([0,90,0]) {
            // Hole for screw head
            translate([-32 * HandScale, -15.5 * HandScale, 58 * HandScale])
            cylinder(h = 6 * HandScale, d = 8.5 * HandScale, $fn = 30);
            
            // Fix hole for thumb
            translate([-32 * HandScale, -15.5 * HandScale, 38.44 * HandScale])
            cylinder(h = 14.49 * HandScale, d = 6 * HandScale, $fn = 30);
        }
          
        // cut large hole for wrist bolt
        translate([(28.7209 + 0.69/1.1544)* HandScale, (-5.9592 + 1.77/1.1544 + .54/1.1544)* HandScale, 0])
        {
            cylinder(d = WristBoltDiameter - 0.05, h = 30 * HandScale, center=true, $fn=30);
            
            // cut small hole for wrist bolt
            cylinder(d = WristBoltDiameter - 4, h = 27 * HandScale, center=true, $fn=30);
        }
    }
    
    difference(){
        // Add inner threads for wrist bolt holder
        translate([(28.7209 + 0.69/1.1544)* HandScale, (-5.9592 + 1.77/1.1544 + .54/1.1544)* HandScale, 0])
        rotate([0, 0, BoltAlign])
        thread_in(WristBoltDiameter, 18 * HandScale);
    }
}
module MakeThumbMoldOuter() {
    ThumbOuter();
}
module MakeThumbMoldInner() {
    ThumbInner();
}
module MakeThumbReg() {
    ThumbReg();
}
//module MakeThumb() {
//    Thumb();
//    
//    translate([61.5 * HandScale, 122.22 * HandScale, 14.12 * HandScale])
//    rotate([90,90,0])
//    cylinder(h = 15.763 * HandScale, d = 1 * HandScale, $fn = 30);
////    
////        Thumb();
////        translate([61 * HandScale, 108.46 * HandScale, 14 * HandScale])
////        rotate([90,90,0])
////        {
////            difference() {
////                union() {
////                    cylinder(h = 2 * HandScale, d = 28 * HandScale, $fn = 30);
////                    translate([0, 0, -13.765 * HandScale])
////                    cylinder(h = 15.763 * HandScale, d = 6 * HandScale, $fn = 30);
////                }
////                translate([0, 0, -13.765 * HandScale])
////                cylinder(h = 20 * HandScale, d = 4.6 * HandScale, $fn = 30);
////            }
////        }
//    
//}


//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);


module make_bolt(dia,hi, headhi, headDiameter)
// make an ISO bolt 
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
//rotate for better print orientation
rotate([-90,0,0]) 
    difference() {
        union()
        {   
            difference() {
            cylinder(d = headDiameter, h = headhi, $fn=30);
            
                // Make head rounded
                difference() {
                    
                    pad = 0.1; // Padding to maintain manifold
                    r = 1; // radius of fillet
                    cr = headDiameter/2;
                        
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r+pad, -pad, 0]) square(r+pad,r+pad);
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r, r, 0]) circle(r=r,$fn=30);
                    }
       
            }
            translate([0,0,headhi-0.1]) thread_out_centre(dia,hi+0.1);
            translate([0,0,headhi-0.1]) thread_out(dia,hi+0.1);
        }
        
        // make the hex hole
        translate([0,0,-1]) rotate([0,0,45]) cylinder(d = dia - 2 ,h = dia, $fn=4);
     
        //flatten one side to make it printable
        translate([-hi, dia/2 - dia/12, -1]) cube(hi *2);   
        
        //flatten other side to make threads not wavy on top
        translate([-hi,- (hi *2) - (dia/2 - dia/14), headhi + 0.1]) cube(hi *2);   
    }
    
         
}

module thread_out(dia,hi,thr=$fn)
// make an outside ISO thread (as used on a bolt)
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_out_pitch(dia,hi,p,thr);
}

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
    //JB: I add this mirror because the model will be mirrored at the end if it is a left
    if (LeftRight == "Left")
        mirror([0,1,0]) thread_in_pitch(dia,hi,p,thr); 
    else
        thread_in_pitch(dia,hi,p,thr); 
        
}

module thread_out_pitch(dia,hi,p,thr=$fn)
// make an outside thread (as used on a bolt) with supplied pitch
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of full turns
	n=r/(p/thr);			// number of segments for remainder
	// do full turns
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_out_turn(dia,p,thr);
	// do remainder
	for(sg=[0:n])
		th_out_pt(Rmin-0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_out_centre(dia,hi)
{
	p = get_coarse_pitch(dia);
	thread_out_centre_pitch(dia,hi,p);
}

module thread_out_centre_pitch(dia,hi,p)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin

	cylinder(r = Rmin, h = hi);
}

module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(d = dia,h = hi);
		translate([0,0,-1]) cylinder(d = dia - thk*2, h = hi + 1);
	}
}

//--low level bolt modules-----------------------------------------------------------

module th_out_turn(dia,p,thr=$fn)
// make a single turn of an outside thread
//  dia=diameter, 6=M6 etc
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_out_pt(Rmin-0.1,p,s,sg,thr,h,p/thr);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// make a part of an outside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = (sg % thr) * s ;			// angle to start of seg
	ae = as + s  - (s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   | \  2,5
 	//   | / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[cos(as)*rt,sin(as)*rt,z],								// 0
			[cos(as)*rt,sin(as)*rt,z+(3/4*p)],						// 1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/8*p)],		// 2
			[cos(ae)*rt,sin(ae)*rt,z+sh],							// 3
			[cos(ae)*rt,sin(ae)*rt,z+(3/4*p)+sh],					// 4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh+(3/8*p)]],	// 5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module Arm1() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_Arm1.stl", convexity=3); }

module Arm2() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_Arm2.stl", convexity=3); }

module VentingHoles11() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles11.stl", convexity=3); }

module VentingHoles12() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles12.stl", convexity=3); }

module VentingHoles21() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles21.stl", convexity=3); }

module VentingHoles22() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles22.stl", convexity=3); }

module VentingHoles31() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles31.stl", convexity=3); }

module VentingHoles32() {scale([ArmCircumferenceScale,ArmCircumferenceScale,ArmScale]) import("o_VentHoles32.stl", convexity=3); }

module Cuff() {scale([CuffScale,CuffScale,CuffScale]) import("o_Cuff.stl", convexity=3); }

module Gripper() {
    rotate([0, 90, 0]) 
    translate([-65 * HandScale, 0, 0])
    scale([HandScale, HandScale, HandScale]) 
    import("o_Gripper.stl", convexity=3);
}
module ThumbOuter() { 
    scale([HandScale / 1.1544, HandScale / 1.1544, HandScale / 1.1544]) 
    import("o_ThumbOuter.stl", convexity=3);
}
module ThumbInner() { 
    scale([HandScale / 1.1544, HandScale / 1.1544, HandScale / 1.1544]) 
    import("o_ThumbInner.stl", convexity=3);
}
module ThumbReg() { 
    scale([HandScale / 1.1544, HandScale / 1.1544, HandScale / 1.1544]) 
    import("o_ThumbReg.stl", convexity=3);
}
