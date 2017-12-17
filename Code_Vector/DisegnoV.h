//
//  DisegnoV.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "InfoObj.h"
#import "Immobili.h"


@interface DisegnoV : NSObject {
	
	int      VersioneSoftware; //    100 = prima versione

	int      fuso;
	int      proiezionedisegno;
	double   eventuale_xc;
	double   eventuale_yc;
	double   eventuale_ang;
	double   eventuale_scala;
	double   eventuale_offx;
	double   eventuale_offy;
	int      eventuale_codice1;
	int      eventuale_codice2;
	int      eventuale_codice3;

    double          Escala;
	double          Exorigine,     Eyorigine;
	double          Eanglerot;
	double          Ex_xc;
	double          Ex_yc;
    
    bool            Centrato;
    bool            Roted;
    bool            Scaled;
    bool            movedX;
    bool            movedY;
    

    
	NSString       *nomedbaseDisegno;
	NSString       *nometavolaDisegno;
    bool            b_connessodbaseDisegno;
	
	
	NSMutableArray *ListaPiani;
    int             indicePianocorrente;
	
	int       i_xorigine_vector;
	int       i_yorigine_vector;

	bool      b_visibiledisegno;
	bool      b_editabiledisegno;
    bool      b_snappabiledisegno;

    float     f_alfalineedisegno;
    float     f_alfasuperficidisegno;
	int       numpiani;
	NSString *nomedisegno;
	int       i_filepos;
    int       faseapertura;
	
	double    limx1, limx2, limy1,limy2;

	int       i_buttavuote;
	int       npiani;
	int       numobj;
	
	
	int       numtratteggi;
	int       numcampiture;

	InfoObj   *D_info;
	

}



- (void)   InitDisegno      : (InfoObj *) _info;

- (void)    FissaUndoSeNonRotScaDisegno: (NSUndoManager  *) MUndor : (double) xc : (double) yc;
- (void)    EseguiUndoEventuali;

- (void)    impostaUndoRot             : (NSUndoManager  *) MUndor ; 
- (void)    impostaUndoSca             : (NSUndoManager  *) MUndor ; 
- (void)    impostaUndoOrigineX        : (NSUndoManager  *) MUndor ;
- (void)    impostaUndoOrigineY        : (NSUndoManager  *) MUndor ;

- (void)    EseguiUndoRot  ;
- (void)    EseguiUndoSca  ;

- (void)    EseguiUndoOffX ;
- (void)    EseguiUndoOffY ;

- (NSString *) prendirigapulita : (int *) indice : (NSArray * ) Lista;

- (void)   RemoveDisegno;

- (void)   addpiano;

- (void)   Disegna          : (CGContextRef) hdc;

- (void)   DisSpostaDisegno : (CGContextRef) hdc : (double) dx : (double) dy;
- (void)   DisRuotaDisegno  : (CGContextRef) hdc : (double) xc : (double) yc: (double) ang;
- (void)   DisScalaDisegno  : (CGContextRef) hdc : (double) xc : (double) yc: (double) scal;

- (void)   Distxtvirtual    : (CGContextRef) hdc : (double) xc : (double) yc: (double) ang: (double) scal;

- (void)   DisegnaSplineVirtuale: (CGContextRef) hdc :(int) x1: (int) y1;


- (void)   disegnailpianino : (CGContextRef) hdc : (NSRect) fondo;
- (void)   dispallinispline : (CGContextRef) hdc;
- (void)   disVtTutti       : (CGContextRef) hdc;

- (void)   salvaDisegnoMoM  : (NSString *)   _nomedisegno;
- (void)   apriDisegnoMoM   : (NSString *)   _nomedisegno : (NSMutableArray *) defsimbol;
- (void)   apriDisegnoDxf   : (NSString *)   _nomedisegno : (NSMutableArray *) defsimbol;

- (void)   SalvaDisegnoDxf  : (NSString *)   _nomedisegno;

- (void)   apriDisegnoShp   : (NSString *)   _nomedisegno  : (NSMutableArray *) defsimbol;

- (void)   apriDisegnoCxf   : (NSString *)   _nomedisegno : (NSMutableArray *) defsimbol ;


- (void) cambianomedbase    : (NSString *)   _newtext;
- (void) cambianomeTavola   : (NSString *)   _newtext;

// edit vettoriale
- (bool)   snapFine         : (double) x1    : (double) y1;
- (bool)   snapVicino       : (double) x1    : (double) y1;
- (void)   ortosegmenta     : (double) x1    : (double) y1;
- (void)   seleziona_conPt  : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;
- (void)   seleziona_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;
- (void)   selezionaEdif_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;
- (void)   selezionaTerre_conPtInterno : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati ;

- (bool)   Match_conPt      : (double) x1     : (double) y1;

- (bool)   selezionaVtconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;
- (bool)   selezionaVtspconPt: (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati;

// aggiungi elementi vettoriali
- (void)   faipunto         : (CGContextRef) hdc: (double) x1 : (double) y1  : (NSUndoManager  *) MUndor;
- (void)   faiplinea        : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom: (NSUndoManager  *) MUndor ;
- (void)   faisplinea       : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom;
- (void)   faipoligono      : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom;
- (void)   faispoligono     : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom;
- (void)   faisimbolo       : (CGContextRef) hdc: (double) x1 : (double) y1: (int) indice :(bool) dimfissa : (NSMutableArray *) listadefinizioni: (NSUndoManager  *) MUndor;
- (void)   ruotasimbolo     : (CGContextRef) hdc: (double) rot;
- (void)   scalasimbolo     : (CGContextRef) hdc: (double) sca;
- (void)   fairegione       : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom: (int) fasereg;
- (void)   faisregione      : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom: (int) fasereg;
- (void)   faitesto         : (CGContextRef) hdc: (double) x1 : (double) y1:(double) ht:  (double) ang : (NSString *) txttesto : (NSUndoManager  *) MUndor;
- (void)   faitestovirtuale : (double) ht:  (double) ang : (NSString *) txttesto;

- (bool)   faiCatpoligono   : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom : (DisegnoV *) disVcomp;
- (void)   BackPlineaAdded;

- (void)   risistevavirtspline : (int *) x1 ;
- (void)   finitaPolilinea  : (CGContextRef) hdc  : (NSUndoManager  *) MUndor;
- (void)   chiudipoligono   : (CGContextRef) hdc  : (NSUndoManager  *) MUndor;
- (void)   faicerchio       : (CGContextRef) hdc  : (double) x1 : (double) y1: (double) x2 : (double) y2: (NSUndoManager  *) MUndor;
- (void)   fairettangolo    : (CGContextRef) hdc  : (double) x1 : (double) y1: (double) x2 : (double) y2: (NSUndoManager  *) MUndor;
- (void)   updateEventualeRegione : (CGContextRef) hdc    : (NSUndoManager  *) MUndor;


- (void)   cancellaultimovt ;

- (void)   SpostaDisegnodxdy: (double) dx    : (double) dy;
- (void)   RuotaDisegnodxdy : (double) xc    : (double) yc :  (double) xc2 :  (double)  yc2;	
- (void)   RuotaDisegnoang  : (double) xc    : (double) yc :  (double) ang;	
- (void)   ScalaDisegno     : (double) xc    : (double) yc :  (double) xc2 :  (double)  yc2;	
- (void)   ScalaDisegnoPar  : (double) xc    : (double) yc :  (double) par ;	



- (void)   faiLimiti;
- (double) limx1;
- (double) limy1;
- (double) limx2;
- (double) limy2;




- (double) dimptPianoInd    : (int) indice;
- (void)   SetdimptPianoInd : (double) valore :  (int) indice;


- (void)   updateInfoConLimiti;
- (void)   updateInfoConLimitiPianoCorrente;

- (int)    damminumpiani;

- (void)   setpianocorrente :(int) indice;
- (int)    IndicePianocorrente; 

- (void)   setvisibile        :(int)   _state;
- (void)   setvisibilepiano   :(int) _indpiano : (int)   _state;
- (bool)   visibile;
- (bool)   visibilepiano      :(int)   indice;

- (void)   seteditabile       :(int)   _state;
- (void)   seteditabilepiano  :(int)   _indpiano : (int)   _state;
- (bool)   editabile;
- (bool)   editabilepiano     :(int)   indice;


- (void)   setsnappabile      :(int)   _state;
- (void)   setsnappabilepiano :(int) _indpiano : (int)   _state;
- (void)   setspessorepiano   :(int) _indpiano : (float) _spess;

- (bool)   snappabile;
- (bool)   snappabilepiano    :(int)   indice;
- (float)  spessorepiano      :(int)   indice;

- (void)       setnomedisegno     :(NSString *)   _nome;
- (NSString *) nomedisegno;
- (NSString *) nomeFoglioCXF;
- (NSString *) Solonomedisegno;
- (NSString *) SolonomedisegnoNoext;

- (void)       setnomepianoind     :(NSString *)   _nome:(int)   indice;


- (void)   addLayerCorrente:(NSString *)   _nome;


- (float)  alphaline;
- (float)  alphasup;
- (void)   setalphaline     :(float) _value;
- (void)   setalphasup      :(float) _value;

- (float)  alphalinepiano   :(int)_indpiano;
- (float)  alphasuppiano    :(int)_indpiano;
- (void)   setalphalinepiano:(int)_indpiano: (float) _value;
- (void)   setalphasuppiano :(int)_indpiano: (float) _value;
- (void)   setcolorepianorgb:(int)_indpiano: (float) _r : (float) _g : (float) _b;

	// - (void)   impostalimiti;
- (void)   rifarenomipianicancelletto;

- (float) colorepianoind_r:(int)_indpiano  ;
- (float) colorepianoind_g:(int)_indpiano  ;
- (float) colorepianoind_b:(int)_indpiano  ;

- (NSString *) givemenomepianocorrente;
- (NSString *) givemecommentopianocorrente;
- (NSString *) givemenomepianoindice:(int)indice;

- (NSString *) infopianocorrente;
- (NSString *) infodisegno;


- (NSString *) nomepoligonopt     : (double) xc    : (double) yc;

- (NSMutableString *) leggirigafile: (NSString *) _fileContents: (int) _i_filepos;
- (NSMutableString *) leggirigafilesenzaspazi: (NSString *) _fileContents: (int) _i_filepos;

- (NSMutableArray *) ListaPiani;

- (void) faidefsimboli: (NSMutableArray *) listadefsimboli;

- (void) RiordinaPianiAlfateticamente;


// edit topologico

- (void) EliminaPianiVuoti ;

- (void) EliminaPianoCorrente;

- (void) FondiDis                    :(DisegnoV *) disadd;
- (void) FondiPianiStessoNome ;

- (void) EliminaPianoIndice:(int) indice;

- (void)  setdispallinivtpiano       :(int) indice :(bool) state;
- (void)  setdispallinivtfinalipiano :(int) indice :(bool) state;
- (bool)  dispallinivtpiano          :(int) indice ;
- (bool)  dispallinivtfinalipiano    :(int) indice ;

- (void)  settratteggiopiano         :(int) indice  :(int) indtratto; 

- (void)  setCampitura               :(int) indice  :(int) indCamp; 


- (void)  CatToUtm;

- (bool)  esistenomepiano : (NSString *) nompia;

- (int)   indicePianoconNome : (NSString *) nompia;

- (void)  TematizzaTerreno : (Immobili *) immobili;

- (void ) TematizzaTerrenoSuNuovoDis : (DisegnoV *) Disnuovo  : (Immobili *) immobili;




- (void)  NoTematizzaTerreno ;

- (void) TestoAltoQU;

- (void) loggadati;

@property(nonatomic) double eventuale_ang; 	
@property(nonatomic) double eventuale_scala; 	
@property(nonatomic) double eventuale_offx;
@property(nonatomic) double eventuale_offy;



@end
