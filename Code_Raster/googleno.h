//
//  googleno.h
//  GIS2010
//
//  Created by Carlo Macor on 04/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "InfoObj.h"



@interface googleno : NSObject {
	InfoObj         *Loinfo;
	CGImageRef		imageref ;
	bool            b_visibile;
	bool            b_maivisto;
	float           f_alpha;
	bool            b_terreno;
	float           dxpan;
	float           dypan;
	float           rapscale;
	float           dimximg,dimyimg;
	int             zoomgoogle_writed;	
	int             zoomgoogle_readed;
	double          centrox_w;	
	double          centroy_w;
	double          centrox_r;  
	double          centroy_r;
}



- (void)   init               : (InfoObj *)    _info   : (bool) _terra ;
- (void)   Disegna            : (CGContextRef) hdc     ;
- (void)   setimageref        : (CGImageRef)   _imgref ; 
- (void)   setVisibile        : (bool)         _vis    ;
- (void)   setSatellite       : (bool)         _vis    ;
- (void)   setalpha           : (float)        _alpha  ;
- (void)   setZoomGoogle_w    : (int) _zom;
- (void)   setZoomGoogle_r    : (int) _zom;
- (void)   setZoomGooglePiu_w ;
- (void)   setZoomGoogleMeno_w;
- (void)   setCentro_w        : (double) xc : (double) yc;
- (void)   setCentro_r        : (double) xc : (double) yc;
- (void)   setricentro;
- (void)   justriletto;
- (void)   incpandxdy         : (float) _dx : (float) _dy;
  

- (CGImageRef) imageref     ; 
- (int)        ZoomGoogle_w ;
- (int)        ZoomGoogle_r ;
- (float)      alpha        ;
- (float)      dxpan        ;
- (float)      dypan        ;
- (float)      rapscale     ;
- (bool)       Visibile     ;
- (bool)       Satellite    ;




@end
