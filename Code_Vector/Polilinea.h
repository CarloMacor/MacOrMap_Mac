//
//  Polilinea.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vettoriale.h"
#import "Vertice.h"



@interface Polilinea : Vettoriale {
	NSPoint         locpos;
	NSMutableArray *Spezzata;
	NSMutableArray *VertControlList;
	NSMutableArray *BacksInfo;

	bool    b_chiusa;
	bool    b_regione;
	Vertice *lastVtUp;
	bool    b_scurva;
	
	
	
}


- (void)   InitPolilinea  :(bool) chiusa;

- (void)   UpdatePolyInSpline;
- (void)   setregione:(bool) _bol;

- (void)   Disegna  :(CGContextRef)  hdc: (InfoObj *) _info;
- (void)   DisegnaSp:(CGContextRef)  hdc: (InfoObj *) _info;
- (void)   DisegnaSplineVirtuale: (CGContextRef) hdc : (int) x1: (int) y1: (InfoObj *) _info;

- (void)   DisegnaAffineSpo     : (CGContextRef) hdc : (InfoObj *) _info : (double) dx : (double) dy ;
- (void)   DisegnaAffineRot     : (CGContextRef) hdc : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  ;
- (void)   DisegnaAffineSca     : (CGContextRef) hdc : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  ;
- (void)   DisegnaSpoRotSca     : (CGContextRef) hdc : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  ; 

- (void)   dispallinispline     : (CGContextRef) hdc : (InfoObj *) _info ;
- (void)   DisegnaVtTutti       : (CGContextRef) hdc : (InfoObj *) _info ;
- (void)   DisegnaVtFinali      : (CGContextRef) hdc : (InfoObj *) _info ;


- (bool)   SnapFine      : (InfoObj *) _info:  (double) x1: (double) y1;
- (bool)   SnapVicino    : (InfoObj *) _info:  (double) x1: (double) y1;
- (int)    SnapCat       : (InfoObj *) _info:  (double) x1: (double) y1;
- (void)   ortosegmenta  : (InfoObj *) _info:  (double) x1: (double) y1;

- (void)   seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati ;
- (void)   seleziona_conPtInterno  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;

- (bool)   Match_conPt      : (InfoObj *) _info   : (double) x1  : (double) y1;
- (bool)   selezionaVtconPt : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;
- (void)   SpostaVerticeSelezionato    :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy ;
- (void)   InserisciVerticeSelezionato :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy; 
- (void)   CancellaVerticeSelezionato  :(NSMutableArray *) _LSelezionati ;
- (void)   EditVerticeSelezionato      :(NSMutableArray *) _LSelezionati : (double) newx    : (double) newy ;

- (void)   cancellaultimovt;                                                                         

- (void)   addvertex      : (double) x1: (double) y1: (int) flag;
- (void)   addvertexnoUpdate  : (double) x1: (double) y1: (int) flag;

- (void)   addcontroll    : (double) x1: (double) y1;

- (void)   addvertexUp    : (double) x1: (double) y1;
- (bool)   addCatVertici  : (InfoObj *) _info : (double) x1: (double) y1 : (Vettoriale *) objvect;

- (void)   chiudi;
- (int)    numvt;
- (int)    givemenumctrvt;

- (void)   polyinpoligono;

- (NSString *)  dimmitipostr;
- (double)      lunghezza   ;
- (double)      superficie  ;
- (double)      superficieconsegno;

- (NSString *)  lunghezzastr;
- (NSString *)  nvtstr;
- (NSString *)  supstr;


- (bool)   chiusa;
- (bool)   isspline;
- (bool)   isregione;
- (double) dammixPuntoInd :(int) ind;
- (double) dammiyPuntoInd :(int) ind;
- (bool)   ptInterno      : (double) x1: (double) y1;
- (bool)   ptBordo1mm     : (double) x1: (double) y1;
- (bool)   ptBordo        : (double) x1: (double) y1;


- (Vertice *) verticeN    : (int) ind;

- (void)   faiLimiti;
- (NSRect) dammilimiti;

- (NSMutableArray *) Spezzata;
- (NSMutableArray *) VertControlList;

- (void) Sposta          : (double) dx :  (double) dy; 
- (Vettoriale *) Copia           : (double) dx :  (double) dy ; 
- (void) Ruota           : (double) xc :  (double) yc : (double) ang; 
- (void) Ruotaang        : (double) ang; 
- (void) Scala           : (double) xc :  (double) yc : (double) scal; 
- (void) Scalasc         : (double) scal; 
- (void) CopiainLista    : (NSMutableArray *) inlista;

- (Polilinea *)  copiaPura;

- (Polilinea *)  copiaPuraNoaDisegno;

- (Polilinea *)  copiaPuraPrimoPoligono;


- (void) ImpostaBack     : (int) azb : (int) indb : (double) xer : (double) yer ;

- (void) EseguiBack      ;


- (void) svuota;

- (void) salvavettorialeMoM    :(NSMutableData *) _illodata;
- (NSUInteger) aprivettorialeMoM     : (NSData *) _data : (NSUInteger) posdata ;

- (NSString *) salvadxf;

- (void) CatToUtm : (InfoObj *) _info;

- (void) togliVtDoppi ;

- (void) addvertexUpHereToStart ;
- (void) updateRegione;
- (void) rigiraspezzata : (int) indp1 : (int) indp2;
- (void) rigiraspezzataTotale;

- (void) partedavtindice :(int) starter;

- (void) Srigiraspezzata : (int) indp1 : (int) indp2; 
- (void) chiudiconVtSeAperta;
- (void) chiudiSeChiusa ;
- (void) chiudiconVtDown; 
- (void) Cambia1PoligonoaRegione;

- (bool) OrtoInternoNoInfo :  (double) x1 :(double) y1:(double) x2 :(double) y2:(double) xpt :(double) ypt;
- (void) addvicini : (Polilinea *) polext ;


@end
