//
//  Raster.h
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

#import "InfoObj.h"
#import "Polilinea.h"


@interface Raster : NSObject {
	double          scalax,	     scalay;
	double          limx1,       limy1,        limx2,         limy2;
	double          xorigine,    yorigine;
	double          dimx,	     dimy;
	double          f_anglerot;
	float           f_alpha;	
	bool            b_visibile;
	bool            b_masheracolore;
	int             i_mascheraBianco;

	double          Escalax,	    Escalay;
	double          Exorigine,     Eyorigine;
	double          Eanglerot;
	
	
	
	CGImageRef		imageref ;
	InfoObj       * info;
	NSString      * NomefileRaster;
	NSDictionary  * imgProp;
	NSString      * imgUTType;
	NSColor       * coloredelBlack;
	double          coef[8];
	int             i_filepos;
	int             i_colorefondo;
	
	bool            b_sfondobianco;
	
}

- (NSArray  *) righetestofile : (NSString *) nomefile;

- (void)       InitRaster        :(NSString *)   _nomefile: (InfoObj *) _info;
- (void)       InitRasterImgRef  :(CGImageRef)   _imgref;

- (void)       impostaUndoTutto    : (NSUndoManager  *) MUndor;
- (void)       impostaUndoOrigine  : (NSUndoManager  *) MUndor;
- (void)       impostaUndoScala    : (NSUndoManager  *) MUndor;
- (void)       impostaUndoAngolo   : (NSUndoManager  *) MUndor;

- (void)       EseguiUndoTutto;
- (void)       EseguiUndoOrigine;
- (void)       EseguiUndoScala;
- (void)       EseguiUndoAngolo;


// settaggi
- (double)     xscala;
- (double)     yscala;
- (double)     Exscala;
- (double)     limx1;
- (double)     limy1;
- (double)     limx2;
- (double)     limy2;
- (double)     xorigine;
- (double)     yorigine;
- (double)     dimx;
- (double)     dimy;
- (double)     angolo;
- (double)     Eanglerot;
- (float)      alpha;
- (bool)       visibile;
- (NSString *)     nomefile;
- (NSString *)     nomefilenoExt;
- (NSString *)     interonomefile;
- (CGImageRef)     ImgRef;
- (NSDictionary *) ImgProp;
- (NSString *)     imgUTType;
- (NSColor      *) coloredelBlack;


// azioni

- (void)       RemoveRaster;
- (void)       updateLimiti;
- (void)       updateInfoConLimiti;
- (void)       setvisibile       :(bool)  modo;
- (void)       setalpha          :(float) alpha;
- (void)       setmaskabile      :(bool)  modo:    (int) _white ;
- (void)       setcolorefondo    :(int)   _col;

- (void)       Disegna           :(CGContextRef) hdc;
- (void)       disegnarasterino  :(CGContextRef) hdc: (NSRect) fondo;

- (void)       SpostaOrigine     :(double) _dx:(double) _dy;
- (void)       ruota             :(double) _angle;
- (void)       setscalaDisraster :(double) sca_x : (double) sca_y;

- (void)       setscalaDisraster1;

- (void)       CropConPoligono   :(NSMutableArray *) _List;
- (void)       CropConRettangolo :(NSMutableArray *) _List;

- (void)       MaskConPoligono   :(NSMutableArray *) _List :(double) _xorig: (double) _yorig:(double) _scalx :(double) _scaly ;

- (void)       Calibra8pt        :(double)_x1: (double)_y1: (double)_x2: (double)_y2: (double)_x3: (double)_y3: (double)_x4: (double)_y4 
                                 :(double)_x5: (double)_y5: (double)_x6: (double)_y6: (double)_x7: (double)_y7: (double)_x8: (double)_y8  
								 : (NSLevelIndicator   *) LevelIndicatore   ;

- (void)       rotoscala         :(double)i_x1coord :(double) i_y1coord :(double)i_x2coord :(double) i_y2coord 
								 :(double)i_x3coord :(double) i_y3coord :(double)i_x4coord :(double) i_y4coord; 


- (void)       RuotaconCentro    : (double) xc : (double) yc : (double) rot;
- (void)       ScalaconCentro    : (double) xc : (double) yc : (int) modo : (double) scal;


- (void)       resetimmagine;
- (void)       FissaOrigine      : (double) xc : (double) yc ;
- (void)       setscala          : (double) xs : (double) ys ;


- (void)       BiancoTrasparente;

- (void)       SalvaInfoRaster; 


- (void)  CambiaColore : (NSColor *) colore;



- (bool)       NoBianco;

@end
