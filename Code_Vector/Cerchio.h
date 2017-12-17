//
//  Cerchio.h
//  GIS2010
//
//  Created by Carlo Macor on 09/04/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"


@interface Cerchio : Vettoriale {
	double x;
	double y;
	double r;
}


- (void) InitCerchio           :(double)x1 :(double) y1   :(double)x2 :(double) y2;
- (void) Disegna               :(CGContextRef) hdc  : (InfoObj *) _info;
- (void) DisegnaAffineSpo      : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  ;
- (void) DisegnaAffineRot    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void) DisegnaAffineSca    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;


- (void) seleziona_conPt     : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati ;
- (bool) Match_conPt         : (InfoObj *) _info   : (double) x1  : (double) y1;

- (void) faiLimiti;

- (void) Sposta          : (double) dx :  (double) dy; 
- (Vettoriale *) Copia           : (double) dx :  (double) dy; 
- (void) Ruota           : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang        : (double) ang; 
- (void) Scala           : (double) xc :  (double) yc : (double) scal; 
- (void) Scalasc         : (double) scal; 
- (void) CopiainLista    : (NSMutableArray *) inlista;

- (void) salvavettorialeMoM    :(NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM     : (NSData *) _data: (NSUInteger) posdata;

- (NSString *) salvadxf;

- (void) CatToUtm : (InfoObj *) _info;


@end
