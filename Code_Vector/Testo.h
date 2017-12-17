//
//  Testo.h
//  GIS2010
//
//  Created by Carlo Macor on 06/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"


@interface Testo : Vettoriale {
	NSString *stringa;
	double x,y;
	int i_font;
	int i_style;
    double altezza;
    double angolo;
	int   alli;
}


- (void) InitTesto        : (double)x1 :(double) y1: (double) htxt: (double) ang;
- (void) InitTestoStr     : (double)x1 :(double) y1: (double) htxt: (double) ang: (NSString *)   _newtext;
- (void) salvavettorialeMoM               :(NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM  : (NSData *) _data : (NSUInteger) posdata ;


- (void) Disegna          : (CGContextRef) hdc: (InfoObj *) _info;
- (void) cambiastringa    : (NSString *)   _newtext;
- (void) DisegnaSelected  : (CGContextRef)  hdc    : (InfoObj *) _info;  // solo per i testi
- (void) cambiaaltezza    : (double)       newh;

- (void) faiLimiti        ;

- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  ;
- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;
- (void) DisegnaSpoRotSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  ; 

- (bool) SnapFine         : (InfoObj *)     _info  : (double)     x1      : (double) y1;
- (bool) SnapVicino       : (InfoObj *)     _info  : (double)     x1      : (double) y1;
- (void) seleziona_conPt  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;
- (bool) Match_conPt      : (InfoObj *)     _info  : (double) x1           : (double) y1;

- (void) Sposta          : (double) dx :  (double) dy; 
- (Vettoriale *) Copia           : (double) dx :  (double) dy; 
- (void) Ruota           : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang        : (double) ang; 
- (void) Scala           : (double) xc :  (double) yc : (double) scal; 
- (void) Scalasc         : (double) scal; 
- (void) CopiainLista    : (NSMutableArray *) inlista;


- (NSString *) caratteritesto;
- (double)     altezzatesto;


- (NSString *) salvadxf;

- (bool) testinternoschermo : (InfoObj *) _info  ;

- (void) CatToUtm : (InfoObj *) _info;

- (void) TestoAltoQU ;


- (Testo *) copiaPura ;


@end
