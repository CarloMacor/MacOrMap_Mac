//
//  Vettoriale.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
// #import "InfoObj.h"
#import "Piano.h"
#import "DisegnoV.h"
#import "Vertice.h"
#import "BeccoVett.h"


@interface Vettoriale : NSObject {
    int      tipo;    // 1 punto  2 plinea  3 poligono 4 regione 5 cerchio
				      // 6 testo  7 Splinea 8 Splineachiusa 9 SplineaRegione
	                  // 10 simbolo ,11 Arco
	
	double   limx1, limx2, limy1,limy2;
	int      indicedbase;
	int      indicedbase2;
	
	bool     b_erased;
	bool     b_selected;
	Piano    *_piano;
	DisegnoV *_disegno;
}

- (void) Init             : (DisegnoV *)    _dis   : (Piano   *) _pian;
- (void) Disegna          : (CGContextRef)  hdc    : (InfoObj *) _info;
- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  ;
- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;
- (void) DisegnaSpoRotSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  ; 

- (void) dispallinispline : (CGContextRef)  hdc    : (InfoObj *) _info ;
- (void) DisegnaSelected  : (CGContextRef)  hdc    : (InfoObj *) _info;  // solo per i testi


- (void) DisegnaVtTutti   : (CGContextRef)  hdc    : (InfoObj *) _info;
- (void) DisegnaVtFinali  : (CGContextRef)  hdc    : (InfoObj *) _info;


- (bool) SnapFine         : (InfoObj *)     _info  : (double)     x1      : (double) y1;
- (bool) SnapVicino       : (InfoObj *)     _info  : (double)     x1      : (double) y1;
- (int)  SnapCat          : (InfoObj *)     _info  : (double)     x1      : (double) y1;
- (void) seleziona_conPt  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;
- (void) seleziona_conPtInterno  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;
- (bool) Match_conPt      : (InfoObj *)     _info  : (double) x1          : (double) y1;
- (bool) selezionaVtconPt : (CGContextRef) hdc     : (InfoObj *) _info    : (double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;
- (void) SpostaVerticeSelezionato    :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy ;
- (void) InserisciVerticeSelezionato :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy ;
- (void) CancellaVerticeSelezionato  :(NSMutableArray *) _LSelezionati ;
- (void) EditVerticeSelezionato      :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy ;
- (bool) ptInterno      : (double) x1: (double) y1;
- (Vertice *) verticeN  : (int) ind;

- (bool)   addCatVertici  : (double) x1: (double) y1 : (Vettoriale *) objvect;


- (void) faiLimiti;
- (bool) testinternoschermo : (InfoObj *) _info  ;

- (double) limx1;
- (double) limy1;
- (double) limx2;
- (double) limy2;

- (void) Sposta          : (double) dx :  (double) dy; 
- (Vettoriale *) Copia           : (double) dx :  (double) dy ; 

- (void) Ruota           : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang        : (double) ang; 
- (void) Scala           : (double) xc :  (double) yc : (double) scal; 
- (void) Scalasc         : (double) scal; 

- (void) CopiainLista    : (NSMutableArray *) inlista;

- (void) cancella;
- (void) Decancella;
- (bool) cancellato;
- (int)  dimmitipo;
- (NSString *)  dimmitipostr;
- (double)      lunghezza   ;
- (double)      superficie  ;
- (NSString *)  lunghezzastr;

- (NSString *)  pianostr;
- (NSString *)  disegnostr;
- (NSString *)  nvtstr;
- (NSString *)  supstr;

- (void) chiudiSeChiusa ;
- (void) Cambia1PoligonoaRegione;


- (void) salvavettorialeMoM     :(NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM    : (NSData *) _data  : (NSUInteger) posdata ;

- (bool)   isspline;
- (int)    numvt;

- (void)   CatToUtm : (InfoObj *) _info;

- (void)   TestoAltoQU;


- (NSString *) salvadxf;

- (void)   svuota;

- (Piano    *) piano;
- (DisegnoV *) disegno;

- (Vettoriale *) copiaPura;

- (Vettoriale *) copiaPuraNoaDisegno;



- (NSString *) caratteritesto;

- (double)     altezzatesto;



@end
