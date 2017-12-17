//
//  Simbolo.h
//  GIS2010
//
//  Created by Carlo Macor on 29/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"
#import "DefSimbolo.h"


@interface Simbolo : Vettoriale {
	int qualeLista;
	int indLista;
	DefSimbolo * definizione;
	double x;
	double y;
	double scalaSimb;
	double angrot;
	bool   dimfissa;
}


- (void) InitSimbolo                      :(double)x1 :(double) y1 : (int) indice : (NSMutableArray *) listadefinizioni ;

- (void) Disegna       :(CGContextRef) hdc: (InfoObj *) _info;

- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati ;
- (bool) Match_conPt      : (InfoObj *) _info   : (double) x1  : (double) y1;

- (void) ritrovadefdalista: (NSMutableArray *) listadefinizioni ;
- (void) setdefinizione   : (DefSimbolo *) ladefinizione ;

- (void) setFisso      : (bool) fisso;
- (bool) dimFissa;

- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  ;
- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;

- (void) ruotasimbolo  : (double) rot;
- (void) scalasimbolo  : (double) sca;
- (void) Sposta        : (double) dx :  (double) dy; 
- (Vettoriale *) Copia         : (double) dx :  (double) dy ;
- (void) Ruota         : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang      : (double) ang;


- (void) faiLimiti ;

- (NSString *) salvadxf;

- (void) salvavettorialeMoM  : (NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM2  : (NSData *) _data : (NSUInteger) posdata;

- (void) CatToUtm : (InfoObj *) _info;


@end
