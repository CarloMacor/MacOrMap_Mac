//
//  Vertice.h
//  GIS2010
//
//  Created by Carlo Macor on 02/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InfoObj.h"


@interface Vertice : NSObject {
	double     x;
	double     y;
	double     z;
	bool      up;
}

- (void)    InitVertice   :(double)x1 :(double) y1;
- (void)    InitVerticeUp :(double)x1 :(double) y1;
- (double)  xpos;
- (double)  ypos;
- (double)  zpos;
- (bool)    givemeifup;
- (void)    setVtUp;
- (void)    setVtDown;

- (void)    moveto  :(CGContextRef) hdc : (InfoObj *) _info;
- (void)    lineto  :(CGContextRef) hdc : (InfoObj *) _info;
- (void)    tangento:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) t;

- (void)    movetoSpo  :(CGContextRef) hdc : (InfoObj *) _info :(double) dx : (double) dy;
- (void)    linetoSpo  :(CGContextRef) hdc : (InfoObj *) _info :(double) dx : (double) dy;
- (void)    movetoRot  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot;
- (void)    linetoRot  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot;
- (void)    movetoSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) sca;
- (void)    linetoSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) sca;
- (void)    movetoSpoRotSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot: (double) sca;
- (void)    linetoSpoRotSca  :(CGContextRef) hdc : (InfoObj *) _info :(double) xc : (double) yc: (double) rot: (double) sca;

- (void)    discroce         :(CGContextRef) hdc : (InfoObj *) _info;
- (void)    discrocespline   :(CGContextRef) hdc : (InfoObj *) _info : (Vertice *) V;
- (void)    dispallino       :(CGContextRef) hdc : (InfoObj *) _info;
- (void)    dispallinofinale :(CGContextRef) hdc : (InfoObj *) _info;


- (void)    CopiaconVt:(Vertice *) _vt;

- (void)    splineto:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2;
- (void)    splinetoSpo:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) dx : (double) dy;
- (void)    splinetoRot:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) rot ;
- (void)    splinetoSca:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) sca ;
- (void)    splinetoSpoRotSca:(CGContextRef) hdc : (InfoObj *) _info :(Vertice *) p1 :(Vertice *) t1 :(Vertice *) t2:(double) xc : (double) yc : (double) rot : (double) sca;



- (void) Sposta          : (double) dx :  (double) dy; 
- (void) Ruotaang        : (double) ang; 
- (void) Scalasc         : (double) scal; 
- (void) CatToUtm : (InfoObj *) _info;


@end
