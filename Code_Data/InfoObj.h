//
//  InfoObj.h
//  GIS2010
//
//  Created by Carlo Macor on 03/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
	// #import "Varbase.h"

@interface InfoObj : NSObject {
    PDFView       *  Info_mypdf;
		//	Varbase       * varbase;

	// Limiti
	double  d_limx1DisR;	double  d_limy1DisR;	double  d_limx2DisR;	double  d_limy2DisR;  // limiti del disegno RASTER corrente
	double  d_limx1Ras;	    double  d_limy1Ras;	    double  d_limx2Ras;	    double  d_limy2Ras;   // limiti del singolo Raster corrente
	double  d_limx1DisV;	double  d_limy1DisV;	double  d_limx2DisV;	double  d_limy2DisV;  // limiti del disegno VETTORIALE corrente
	double  d_limx1Piano;	double  d_limy1Piano;	double  d_limx2Piano;   double  d_limy2Piano; // limiti del singolo PIANO corrente
	double  d_limx1Tutto;	double  d_limx2Tutto;	double  d_limy1Tutto;	double  d_limy2Tutto; // limiti del tutto.
		
    // vista schermo
	double  d_scalaVista;	    
	double  d_xorigineVista;    double   d_yorigineVista;
	double  d_dimxView;  	    double   d_dimyView;
	double  d_x2origineVista;   double   d_y2origineVista;

	int        dimMirino; 

		//	long    i_dimxViewvettorino;	long    i_dimyViewvettorino;
	
    bool    b_rasterautosave;
	
	double scalaDisGoogleno;
	
	double  xsnap;          double   ysnap;
	int     dimmirino;      double   offsetmirino;
	int     i_xlastspline;	int      i_ylastspline;
	
	
	
	float   lat_centrogoogle_w;	float   lon_centrogoogle_w;	
	float   lat_centrogoogle_r;	float   lon_centrogoogle_r;
	int     google_maxscala;	
	
		//	int     google_fuso;
	double  N_centrogoogle;	    double  E_centrogoogle;
	float   f_scalaVista_g;
	
	double  N_1google;	    double  E_1google;
	double  N_2google;	    double  E_2google;

	
	bool    VedoVerticiTuttoDisegno;
	
	
	double  offxroma;   // correzioni 
	double  offyroma;
	
	double  offxGoogleMaps;   // correzioni legate al comune specie se montano
	double  offyGoogleMaps;

	
	int     numVtCorAdded;
	double offsetCxfX, offsetCxfY;

	bool instampa;
}

@property(nonatomic) bool	instampa;
@property(nonatomic) double	scalaDisGoogleno;



- (void) initInfo;

	// - (void) updatemodoopenvet;
- (void) setoffxGoogleMaps : (double) ofx ;

- (void) setoffyGoogleMaps : (double) ofy ;

- (void) setoffcxfx     : (double) valx  ;
- (void) setoffcxfy     : (double) valy  ;

- (void)   setpdf   : (PDFView *) _pdf;

- (PDFView *)   pdf;

// ritorno dei limiti

// limiti del disegno RASTER corrente
-(double)  limx1DisR;	
-(double)  limy1DisR;	
-(double)  limx2DisR;	
-(double)  limy2DisR;  
  
// limiti del singolo Raster corrente
-(double)  limx1Ras;	    
-(double)  limy1Ras;	    
-(double)  limx2Ras;	    
-(double)  limy2Ras;   

// limiti del disegno VETTORIALE corrente
-(double)  limx1DisV;	
-(double)  limy1DisV;	
-(double)  limx2DisV;	
-(double)  limy2DisV;  

// limiti del singolo PIANO corrente
-(double)  limx1Piano;	
-(double)  limy1Piano;	
-(double)  limx2Piano;   
-(double)  limy2Piano; 

// limiti del tutto
-(double)  limx1Tutto;	
-(double)  limx2Tutto;	
-(double)  limy1Tutto;	
-(double)  limy2Tutto; 

// vista
-(double)  scalaVista    ;
-(double)  xorigineVista ;
-(double)  yorigineVista ;
-(double)  x2origineVista;
-(double)  y2origineVista;
-(double)  dimxVista     ;
-(double)  dimyVista     ;


// snap
-(double)  xsnap ;
-(double)  ysnap ;
-(double)  give_offsetmirino ;                      

// spline utility
- (int)    i_xlastspline;
- (int)    i_ylastspline;

// GoogleMap

-(int)     google_maxscala;
-(float)   lat_centrogoogle_w;
-(float)   lon_centrogoogle_w;
-(float)   lat_centrogoogle_r;
-(float)   lon_centrogoogle_r;
-(double)  N_centrogoogle;
-(double)  E_centrogoogle;
-(float)   scalaVista_g;

- (bool)   rasterautosave                      ;
- (void)   setrasterautosave: (bool) Stato     ;


// settaggio dei limiti;
- (void)   setLimitiTutto: (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2;
- (void)   setLimitiDisR : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2;
- (void)   setLimitiRas  : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2;
- (void)   setLimitiDisV : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2;
- (void)   setLimitiPiano: (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2;

// attuazzione degli zoom
- (void)   setZoomAll;
- (void)   setZoomC      : (double) newx: (double) newy ;
- (void)   setZoomAllRaster;
- (void)   setZoomLocRaster;
- (void)   setZoomAllVector;
- (void)   setZoomPianoVector;

// settaggio Vista
- (void)   set_scalaVista  : (double) value;
- (void)   set_scalaVista2 : (double) value1: (double) value2;

- (void)   set_origineVista: (double) _vx     : (double) _vy;
- (void)   set_origineVistax: (double) _vx ;
- (void)   set_origineVistay: (double) _vy ;

- (void)   set_dimVista    : (double)  _vx    : (double)  _vy;

- (void)   riaggiornax2y2;

- (NSString *)  fusoStr;


// set snap
- (void)   setxysnap       : (double) xsn     : (double) ysn;
- (void)   set_dimMirino   : (int)    dimMir;
- (void)   update_offsetmirino;

// spline uyility
- (void)   set_xylastspline : (int) _x : (int) _y;

// set GoogleMap

- (void)   setgoogle_maxscala:(int) _valmax;
- (void)   setlat_centrogoogle_w:(float) _vallat;
- (void)   setlon_centrogoogle_w:(float) _vallon;
- (void)   setlat_centrogoogle_r:(float) _vallat;
- (void)   setlon_centrogoogle_r:(float) _vallon;
- (void)   setN_centrogoogle:(double) _val;
- (void)   setE_centrogoogle:(double) _val;
- (void)   calcola;


- (double)  N_1google;	    
- (double)  E_1google;
- (double)  N_2google;	    
- (double)  E_2google;
 

- (double)  offxroma;  
- (double)  offyroma;

- (void) traformacord : (double*) xcord : (double*) ycord : (int) Proiezione;



- (void) utmtocatasto  : (double*) xcord : (double*) ycord ;
- (void) utmtolatlon   : (double*) xcord : (double*) ycord ;
- (void) utmtoGBoaga   : (double*) xcord : (double*) ycord ;
- (void) utmtoutm50    : (double*) xcord : (double*) ycord ;
- (void) utmtolatlon50 : (double*) xcord : (double*) ycord ;


- (void) catastotoutm  : (double*) xcord : (double*) ycord ;
- (void) latlonToUtm   : (double*) xcord : (double*) ycord ;
- (void) GBoagaToUtm   : (double*) xcord : (double*) ycord ;
- (void) latlon50ToUtm : (double*) xcord : (double*) ycord ;
- (void) utm50toutm    : (double*) xcord : (double*) ycord ;




- (bool) VedoVerticiTuttoDisegno;
- (void) setVedoVerticiTuttoDisegno : (bool) modo;
- (void) switchsetVedoVerticiTuttoDisegno;

- (NSString *) ingradi      : (double) valore;
- (NSString *) invirgcoord  : (double) valore;

- (int)      GradidaCord   : (double) valore;
- (int)      MinutidaCord  : (double) valore;
- (double)   SecondidaCord : (double) valore;
- (NSString *) SecondiStrdaCord : (double) valore;


	// la impostazione di campiture
- (void) settapattern :(CGContextRef) hdc : (int) indiceCamp : (float) rcol :  (float) gcol : (float) bcol : (float) alpa;



@property(nonatomic) int	numVtCorAdded;
@property(nonatomic) double	offsetCxfX;
@property(nonatomic) double	offsetCxfY;


@end
