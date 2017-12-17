//
//  Punto.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"


@interface Punto : Vettoriale {
	double x;
	double y;
	double z;
}

- (void) InitPunto     :(double)x1 :(double) y1;
- (void) salvavettorialeMoM  :(NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM   : (NSData *) _data : (NSUInteger) posdata ;

- (void) Disegna             : (CGContextRef) hdc: (InfoObj *) _info;
- (void) DisegnaAffineSpo    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  ;
- (void) DisegnaAffineRot    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void) DisegnaAffineSca    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;



- (bool) SnapFine      : (InfoObj *) _info:  (double) x1: (double) y1;
- (bool) SnapVicino    : (InfoObj *) _info:  (double) x1: (double) y1;

// no al snap vicino

- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati ;
- (bool) Match_conPt      : (InfoObj *) _info   : (double) x1  : (double) y1;


- (void) faiLimiti ;

- (double) x;
- (double) y;


- (void) Sposta          : (double) dx :  (double) dy; 
- (Vettoriale *)  Copia           : (double) dx :  (double) dy ; 
- (Vettoriale *)  copiaPura;


- (void) Ruota           : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang        : (double) ang; 
- (void) Scala           : (double) xc :  (double) yc : (double) scal; 
- (void) Scalasc         : (double) scal; 

- (NSString *) salvadxf;

- (void) CatToUtm : (InfoObj *) _info;


@end
