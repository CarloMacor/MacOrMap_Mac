	//
	//  Piano.h
	//  GIS2010
	//
	//  Created by Carlo Macor on 01/03/10.
	//  Copyright 2010 Carlo Macor. All rights reserved.
	//

#import <Cocoa/Cocoa.h>
#import "DisegnoV.h"


@interface Piano : NSObject {
	DisegnoV       *_disegno;
	InfoObj        * info;
	NSMutableArray *Listavector;
	NSString       *nomepiano;
	NSString       *commentopiano;
	NSString       *nomedbase;
	NSString       *nometavola;
	
	double          limx1, limx2, limy1,limy2;
    bool            b_visibilepiano;
	bool            b_editabile;
    bool            b_snappabile;
	float           f_alfalineepiano;
    float           f_alfasuperficipiano;
	int             i_filepos;
    float           f_rosso,f_verde,f_blu;
	float           f_spessoreline;

	int             i_colore;
	int             i_tratteggio;
	int             i_campitura;
	
	int             indsimbolo;
	double          scalatratto;

	
    double          dimpunto;
	
	double          scalaminvista;
	double          scalamaxvista;

    bool            b_connessodbase;
	
    bool            b_dispallinivt;
    bool            b_dispallinivtfinali;

	int             i_Punti;
	int             i_Pline;
	int             i_Poligoni;
	int             i_Regioni;
	int             i_SPline;
	int             i_SPoligoni;
	int             i_SRegioni;
	int             i_Cerchi;
	int             i_Testi;
	int             i_Simboli;
	int             i_Arco;
	int             i_Vt;

	float          offxroma;   // correzioni 
	float          offyroma;

}


- (void) InitPiano  : (DisegnoV *) _dis: (InfoObj *) _info;
- (void) Disegna:(CGContextRef) hdc:  (float) _alfal : (float) alfas;
- (void) DisegnaSplineVirtuale: (CGContextRef) hdc :(int) x1: (int) y1;

- (void) disegnavtpl       : (CGContextRef) hdc ;
- (void) disegnavtfinalipl : (CGContextRef) hdc ; 

- (void) disegnailpianino  : (CGContextRef) hdc  : (NSRect) fondo;
- (void) dispallinispline  : (CGContextRef) hdc;

- (void) mettitratteggio  : (CGContextRef) hdc : (int) tipotratt;

- (bool) snapFine         : (double) x1 : (double) y1;
- (bool) snapVicino       : (double) x1 : (double) y1;
- (void) ortosegmenta     : (double) x1 : (double) y1;


- (void) seleziona_conPt  : (CGContextRef) hdc  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati ;
- (void) seleziona_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;

- (bool) Match_conPt      : (double) x1 : (double) y1;
- (bool) selezionaVtconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;
- (bool) selezionaVtspconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;


- (NSString *)  givemenomepiano;
- (NSString *)  nomepianoNoPlus;
- (NSString *)  givecommentomepiano;
- (int)         givemeNumObjpiano;
- (int)         NumObjpianoNotErased;
- (int)         givemeNumPtpiano;
- (NSMutableArray *) Listavector;
- (NSString *) nomepoligonopt     : (double) xc    : (double) yc;



- (void)  setnomepiano    :(NSString *) nome;
- (void)  setcommentopiano:(NSString *) nome;
- (void)  setvisibile    :(int)   _state;
- (bool)  visibile;
- (void)  seteditabile   :(int)   _state;
- (bool)  editabile;
- (void)  setsnappabile  :(int)   _state;
- (bool)  snappabile;

- (void)  SpostaPiano    : (double) dx    : (double) dy;
- (void)  RuotaPiano     : (double) xc    : (double) yc: (double) angrot;
- (void)  ScalaPiano     : (double) xc    : (double) yc: (double) scal;

- (void)  DisSpostaPiano : (CGContextRef) hdc : (double) dx : (double) dy;
- (void)  DisRuotaPiano  : (CGContextRef) hdc : (double) xc : (double) yc : (double) ang  ;
- (void)  DisScalaPiano  : (CGContextRef) hdc : (double) xc : (double) yc : (double) scal ;
- (void)  Distxtvirtual    : (CGContextRef) hdc : (double) xc : (double) yc: (double) ang: (double) scal;

- (NSString *) infopiano;
- (void)  qualiquantiobjpiano;
- (int)   i_Punti;
- (int)   i_PLine;
- (int)   i_Poligoni;
- (int)   i_Regioni;
- (int)   i_SPline;
- (int)   i_SPoligoni;
- (int)   i_SRegioni;
- (int)   i_Cerchi;
- (int)   i_Testi;
- (int)   i_Simboli;
- (int)   i_Arco;
- (int)   i_Vt;



- (void)  setdispallinivt       :(bool) state;
- (void)  setdispallinivtfinali :(bool) state;
- (bool)  dispallinivt;
- (bool)  dispallinivtfinali;


- (float) getalphaline     ;
- (float) getalphasup      ;
- (float) getspessore      ;
- (void)  setalphaline     :(float) _value;
- (void)  setalphasup      :(float) _value;
- (void)  setspessore      :(float) _value;

- (void)  setdimpunto       : (double) dim;

- (void)  settacolorepiano :(CGContextRef) hdc : (float) _alfal : (float) alfas ;

- (float) colorepiano_r  ;
- (float) colorepiano_g  ;
- (float) colorepiano_b  ;

- (double) dimpunto;

- (void)  setcolorpianorgb :(float) _r :(float) _g :(float) _b;
- (void)  faicolorepianoint:(int) _value;



	// elementi grafici in disegno
- (void) faipunto      : (CGContextRef) hdc: (double) x1 : (double) y1             : (NSUndoManager  *) Undor ;
- (void) faiplinea     : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase: (NSUndoManager  *) Undor ;
- (void) faisplinea    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase;
- (void) faipoligono   : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase;
- (void) faispoligono  : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase;
- (void) faisregione   : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase: (int) fasereg;
- (void) faisimbolo    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) indice :(bool) dimfissa : (NSMutableArray *) listadefinizioni: (NSUndoManager  *) Undor;
- (void) ruotasimbolo  : (CGContextRef) hdc: (double) rot;
- (void) scalasimbolo  : (CGContextRef) hdc: (double) sca;
- (void) faitesto      : (CGContextRef) hdc: (double) x1 : (double) y1: (double) ht: (double) ang : (NSString *) txttesto : (NSUndoManager  *) Undor;
- (void) releasetestoincostruzione;
- (void) faitestovirtuale : (double) ht:  (double) ang : (NSString *) txttesto;


- (void) fairegione    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase: (int) fasereg;
- (void) finitaPolilinea  : (CGContextRef) hdc  : (NSUndoManager  *) MUndor;
- (void) chiudipoligono: (CGContextRef) hdc: (NSUndoManager  *) MUndor;
- (void) updateEventualeRegione: (CGContextRef) hdc    : (NSUndoManager  *) MUndor;

- (void) faicerchio    : (CGContextRef) hdc: (double) x1 : (double) y1 : (double) x2 : (double) y2: (NSUndoManager  *) MUndor;
- (void) fairettangolo : (CGContextRef) hdc: (double) x1 : (double) y1 : (double) x2 : (double) y2: (NSUndoManager  *) MUndor;

- (bool) faiCatpoligono : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom : (DisegnoV *) disVcomp;

- (void) BackPlineaAdded;
- (void) cancellaultimovt;


- (void)   faiLimiti;
- (double) limx1;
- (double) limy1;
- (double) limx2;
- (double) limy2;


- (void) salvapianoMoM    :(NSMutableData *) _illodata;
- (unsigned long long) apripianoMoM     : (NSData *) _data  : (unsigned long long) posfile : (NSMutableArray *) defsimbol;
- (void) cambianomedbase    : (NSString *)   _newtext;
- (void) cambianomeTavola   : (NSString *)   _newtext;

- (int)  dxfinPiano  :(NSString *) _fileContents: (int) _i_filepos  : (NSMutableArray *) defsimbol : (int) tipoelem; 
- (void) dxfinPianoK :(NSArray  *) Righe        : (int *) rigacorrente   : (NSMutableArray *) defsimbol    : (int) tipoelem :(bool) toglictr;

- (void) dxfinobjexecute;
- (void) svuotabooldxf;

- (void) shpin              : (NSString *)   _nomedisegno;

- (NSString *) prendirigapulita : (int *) indice : (NSArray * ) Lista ;



- (int)  cxfinPiano2:(NSArray *) listarighe :(int *) indriga :(NSString *)_tt:(NSMutableArray *)defsimbol ;		


- (void) creadefsimbolo : (NSMutableArray *) listadefsimboli : (int) indice;



- (NSMutableString *) leggirigafile: (NSString *) _fileContents: (int) _i_filepos;
- (NSMutableString *) leggirigafilesenzaspazi: (NSString *) _fileContents: (int) _i_filepos;

- (NSString *) salvadxf;

- (void) settratteggio : (int) indtratto;

- (void) setCampitura  : (int) indcamp;

- (void) coloreCatastoCivitavecchia;

- (void) svuota;

- (void) smemora;

- (void) CatToUtm;

- (void) TestoAltoQU : (Piano *) toLayer;

- (bool) pianoPlus;

- (double) SupPoligoni;

@end
