//
//  Arco.h
//  GIS2010
//
//  Created by Carlo Macor on 05/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"


@interface Arco : Vettoriale {
	double x;
	double y;
	double r;
    double ang1;
    double ang2;
}

- (void)   InitArco: (double)x1 :(double) y1: (double)r1 :(double) a1  :(double) a2 ;


- (void)   Disegna:(CGContextRef) hdc: (InfoObj *) _info;


- (bool) testinternoschermo : (InfoObj *) _info  ;

- (void) salvavettorialeMoM    :(NSMutableData *) _illodata;

- (NSUInteger) aprivettorialeMoM     : (NSData *) _data : (NSUInteger) posdata;




- (void) Sposta          : (double) dx :  (double) dy; 

- (void) faiLimiti                                                          ;

- (void) CatToUtm : (InfoObj *) _info;

@end
