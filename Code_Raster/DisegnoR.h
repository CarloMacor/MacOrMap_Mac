//
//  DisegnoR.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

#import "Raster.h"
// #import "InfoObj.h"
// #import "Polilinea.h"

  


@interface DisegnoR : NSObject {
		//	Raster         *MyRaster;
	InfoObj         *infoObj_Raster;
	NSMutableArray *ListaImgRaster;
	bool            b_visibileraster;
	bool            b_maskabile;
	int             i_mascheraBianco;
	float           f_alpha;
	double          limx1,  limx2,  limy1,  limy2;
	int             indiceSubRastercorrente;
}


- (void)    InitDisegnoR                :(NSString *)  _nomefile : (InfoObj *) _info;
- (void)    InitDisegnoRPost            : (InfoObj *) _info;

- (void)    impostaUndoCorrenteTutto    : (NSUndoManager  *) MUndor;
- (void)    impostaUndoCorrenteOrigine  : (NSUndoManager  *) MUndor;
- (void)    impostaUndoCorrenteScala    : (NSUndoManager  *) MUndor;
- (void)    impostaUndoCorrenteAngolo   : (NSUndoManager  *) MUndor;
- (void)    FissaUndoSeNonRotScaSubcorrente: (NSUndoManager  *) MUndor;

- (void)    impostaUndoTuttiOrigine     : (NSUndoManager  *) MUndor;

- (int)     IndiceSepresenteSubRaster     : (NSString *) nomefile;


- (int)     numimg;
- (float)   alpha;
- (float)   alphaindice                 :(int)   _ind ;
- (double)  angoloindice                :(int)   _ind ;
- (double)  scalaindice                 :(int)   _ind ;

- (double)  xorigineIndice             :(int)   _ind ;
- (double)  yorigineIndice             :(int)   _ind ;

- (double)  limitex1;
- (double)  limitey1;
- (double)  limitex2;
- (double)  limitey2;
- (bool)    isvisibleRaster ;
- (bool)    visibleRasterIndice         :(int) indice ;
- (bool)    isMaskableRaster ;
- (int)     isMaskabianca ;
- (int)     getdimx_indrast             :(int) indice ;
- (int)     getdimy_indrast             :(int) indice ;
- (CGImageRef)     dammiImgRef;
- (NSString *)     damminomefile        :(int) indice;
- (NSString *)     interonomefile       :(int) indice;
- (NSString *)     damminomefileNoExt   :(int) indice;
- (CGImageRef)     imgRefIndice         :(int) indice;
- (NSDictionary *) imgPropIndice        :(int) indice;
- (NSString *)     imgUTTypeIndice      :(int) indice;

- (NSMutableArray *) Listaimgraster;

- (int)     indiceSubRastercorrente;
- (void)    setindiceSubRasterCorrente     :(int) indice;

- (void)  RemoveDisegnoR;
- (void)  RemoveDisegnoRindice        :(int) indice;
- (void)  updateLimiti;
- (void)  updateInfoConLimiti;
- (void)  updateInfoConLimitiSubraster;
- (void)  InitRasterImgRef            :(CGImageRef)   _imgref;
- (void)  addDisegnoR                 :(NSString *)   _nomefile;
- (void)  setalpha                    :(float) _alpha;
- (void)  setalphaindice              :(int)   _ind      : (float) _alpha;
- (void)  setvisibile                 :(int)   _state;
- (void)  setmaskabile                :(int)   _state: (int) _white;
- (void)  setvisibileindice           :(int) indice :(bool)   stat;
- (void)  BiancoTrasparente;
- (void)  SpostaOrigine               :(double) _dx   :(double) _dy  : (bool) tutti: (int) indice;
- (void)  setscalaDisraster           :(double) sca_x :(double) sca_y: (bool) tutti: (int) indice;
- (void)  setscalaraster1             :(bool) tutti   :(int)indice;
          
- (void)  setangolorot                :(double) _angle;
- (void)  setangolorotindice          :(double) _angle Indice:(int) indice;

- (void)  Disegna                     :(CGContextRef) hdc;
- (void)  disegnarasterino            :(CGContextRef) hdc : (NSRect) fondo;

- (void)  CropConPoligono             :(NSMutableArray *) _List: (bool) tutti: (int) indice;
- (void)  CropConRettangolo           :(NSMutableArray *) _List: (bool) tutti: (int) indice;

- (void)  MaskConPoligono             :(NSMutableArray *) _List: (bool) tutti: (int) indice;

- (void)  rotoscala                   :(double)i_x1coord :(double) i_y1coord :(double)i_x2coord :(double) i_y2coord 
									  :(double)i_x3coord :(double) i_y3coord :(double)i_x4coord :(double) i_y4coord: (bool) tutti: (int) indice; 

- (void)  Calibra8pt                  : (double)_x1: (double)_y1: (double)_x2: (double)_y2: (double)_x3: (double)_y3: (double)_x4: (double)_y4 
                                      : (double)_x5: (double)_y5: (double)_x6: (double)_y6: (double)_x7: (double)_y7: (double)_x8: (double)_y8
                                      : (bool) tutti: (int) indice : (NSLevelIndicator   *) LevelIndicatore; 

- (void)  RuotaconCentro              : (double) xc : (double) yc : (double) rot  : (int) indice  ;
- (void)  ScalaconCentro              : (double) xc : (double) yc : (int) modo : (double) scal : (int) indice  ;


- (void)  resetimmagine               :(int)_ind ;
- (void)  FissaOrigine                :(int)_ind : (double) xc : (double) yc ;
- (void)  setscalaindice              :(int)_ind : (double) xs : (double) ys ;




- (void)  SalvaInfoRaster;
- (void)  SalvaInfoRasterUno          : (int) indice;

- (void)  CambiaColore : (NSColor *) colore;



@end
