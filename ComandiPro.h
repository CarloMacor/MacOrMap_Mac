//
//  ComandiPro.h
//  MacOrMap
//
//  Created by Carlo Macor on 25/02/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"
#import "InfoObj.h"

@interface ComandiPro : NSObject {
	IBOutlet InfoObj                *  info;
	IBOutlet Varbase                *  varbase;
}

- (void) initComandiPro  ; 

- (void)     Match_conPt                  ;
- (void)     CancellaVerticeSelezionato   ;
- (void)     SpostaVerticeSelezionato     : (double) newx: (double) newy;
- (void)     InserisciVerticeSelezionato  : (double) newx: (double) newy; 
- (void)     EditVerticeSelezionato       : (double) newx: (double) newy;

- (void)     seleziona_conPt              ;
- (void)     selezInfo_conPt              ;
- (void)     selezInfo_conPtInterno       ;
- (void)     selezEdif_conPtInterno       : (CGContextRef) hdc     ;
- (void)     selezTerra_conPtInterno      : (CGContextRef) hdc     ;
- (void)     SpostaSelezionati            ;
- (void)     CopiaSelezionati             ;
- (void)     RuotaSelezionati             ;
- (void)     ScalaSelezionati             ;
- (bool)     selezionaVtconPt             ;
- (bool)     selezionaVtspconPt           ;

- (void)     deseleziona                  ;

- (Polilinea *)     Esecuzione2Poligoni  :(Polilinea *) P1 : (Polilinea *) P2 : (bool) costruisciImg;
- (void)     Intersezione2Poligoni        ; 


@end
