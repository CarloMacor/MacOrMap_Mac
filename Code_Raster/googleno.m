//
//  googleno.m
//  GIS2010
//
//  Created by Carlo Macor on 04/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//


#import "googleno.h"


@implementation googleno


- (void)   init            : (InfoObj *)    _info   : (bool) _terra	{
	Loinfo = _info;
	b_visibile     = NO;
	b_maivisto     = YES;
	b_terreno      = _terra;	
	b_maivisto     = YES;
	f_alpha        = 1.0;
}
 
- (void)   Disegna         : (CGContextRef) hdc						{
	if (!b_visibile) return;
	if (b_maivisto)  return;


		//    NSLog(@"G:  %d", [self ZoomGoogle_r]);
	if ([self ZoomGoogle_r]<=3) 	return;
	if ([self ZoomGoogle_r]>18) 	return;

	
	CGContextSetAlpha (hdc,f_alpha );
	
	CGRect destarect;
	destarect.origin.x=0;	destarect.origin.y=0;
	destarect.size.width  = [Loinfo dimxVista];
	destarect.size.height = [Loinfo dimyVista];
	
	long  scalagoog;	float dx,dy,complrapscale;
	dx = [Loinfo dimxVista];	dy = [Loinfo dimyVista];    scalagoog     = (exp2(20-[self ZoomGoogle_r]));
	
	rapscale      = (float)(scalagoog / [Loinfo scalaVista_g]);
    complrapscale = (float)(1-rapscale)/2;
	
	CGRect sRect;
	sRect.origin.x= 0.0;  // dxpan, dypan
	sRect.origin.y= 0.0;
	sRect.size.width  = (float)[Loinfo dimxVista];
	sRect.size.height = (float)[Loinfo dimyVista];
	
//  da sapere il centro della vista e quello del googleno per capire se spostare origine dest rect	
//	Loinfo  double  d_scalaVista;	double  d_xorigineVista;   double   d_yorigineVista;
// dq qui conosco le coord centro
	
	
	if (rapscale<1.0) {
		destarect.origin.x=(float)[Loinfo dimxVista]*((1-rapscale)/2);	
		destarect.origin.y=(float)[Loinfo dimyVista]*((1-rapscale)/2);
		destarect.size.width=[Loinfo dimxVista]*rapscale;
		destarect.size.height=[Loinfo dimyVista]*rapscale;
	}
	
	if (rapscale>=1.0) {
		destarect.origin.x=(float)[Loinfo dimxVista]*((1-rapscale)/2);	
		destarect.origin.y=(float)[Loinfo dimyVista]*((1-rapscale)/2);
		destarect.size.width=[Loinfo dimxVista]*rapscale;
		destarect.size.height=[Loinfo dimyVista]*rapscale;
	}
	
	
	double offxcen, offycen;
	offxcen = ((centrox_r-centrox_w)/[Loinfo scalaVista]);
	offycen = ((centroy_r-centroy_w)/[Loinfo scalaVista]);
//	if (zoomgoogle_writed!=zoomgoogle_readed) NSBeep();   ma questa e' la ex scalavista!!!
// andrebbe bene se la scala e' 1 tra scalaVista e quella del googleno
	destarect.origin.x=destarect.origin.x + offxcen;  
	destarect.origin.y=destarect.origin.y + offycen;
	
	
	
	if ([self ZoomGoogle_r]>18) 	return;
	
	if ([self ZoomGoogle_r]>20) {
		destarect.origin.x=0;	
		destarect.origin.y=0;
		destarect.size.width=[Loinfo dimxVista];
		destarect.size.height=[Loinfo dimyVista];
		sRect.origin.x=[Loinfo dimxVista]/4;	
		sRect.origin.y=[Loinfo dimyVista]/4;
		sRect.size.width=[Loinfo dimxVista]/2;
		sRect.size.height=[Loinfo dimyVista]/2;
	}
	
//	CGImageRef locimg = CGImageCreateWithImageInRect ( imageref, sRect );
	CGContextSetAlpha (hdc,f_alpha );
//	CGContextDrawImage  (hdc,destarect,locimg);   qui la differenza!!
// comunque fare il CIImage e inserire la rotazione. 
// precedente modo di vedre il googleno	
//	CGContextDrawImage  (hdc,destarect,imageref);
	
	// calcolo angolo di rotazione googleno
	double ddy    = ([Loinfo N_2google]-[Loinfo N_1google]);
	double ddx    = ([Loinfo E_2google]-[Loinfo E_1google]);
	double angdd  = atan2(ddy,ddx)*180/M_PI;
	float  angolo = (angdd*M_PI/180)*1.5;
	// calcolo angolo di rotazione googleno   Fine
	//	NSLog(@"ang %2.4f ",angolo);
	//	NSLog(@"Pre %2.4f %2.4f %2.4f %2.4f ",[Loinfo N_2google],[Loinfo N_1google],[Loinfo E_2google],[Loinfo E_1google]);
		//			if (angolo<0) NSBeep();
	
	CIImage       * Iimage;
	Iimage = [[CIImage alloc]initWithCGImage:imageref];
	CIContext* ciContext = [CIContext contextWithCGContext:hdc options:nil];
	float f_anglerot = -angolo;
	CGAffineTransform trRot = CGAffineTransformMakeRotation ( f_anglerot );

		//	CGAffineTransform trRot = CGAffineTransformMakeRotation ( 0 );
	
	float ofrx,ofry;
	ofrx = destarect.size.width/2; 	       ofry = destarect.size.height/2;
	ofrx = sRect.size.width/2;     	       ofry = sRect.size.height/2;
	
	CGAffineTransform tr0 = CGAffineTransformMakeTranslation ( -ofrx ,-ofry );
	CGAffineTransform tr1 = CGAffineTransformMakeTranslation (  ofrx , ofry );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0      , trRot );
	                  trAll  = CGAffineTransformConcat          ( trAll    , tr1 );
	CIImage       * Iimage2;
	Iimage2 = [Iimage imageByApplyingTransform: trAll ];
	[ciContext drawImage:Iimage2 inRect:destarect fromRect:sRect];
		//	Iimage2 =nil;
	
	
		// il riporto delle informazionoi cpyright googleMaps
	
	CGRect RR;
	RR.origin.x    =  0;	        RR.size.width  = [Loinfo dimxVista];
	RR.size.height = 9;        RR.origin.y = ([Loinfo dimyVista]-RR.size.height)-3;
	CGImageRef imma = CGImageCreateWithImageInRect (imageref, RR );
	RR.origin.y = 0;
	CGContextClearRect ( hdc, RR );
	CGContextSetAlpha (hdc,1.0);
	CGContextDrawImage  (hdc,RR,imma);  
	CGImageRelease (imma);
	
	CGContextSetLineWidth      (hdc, 1.0);
	CGContextSetRGBStrokeColor (hdc, 0.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, 0, 9);
	CGContextAddLineToPoint(hdc,[Loinfo dimxVista], 9);
	CGContextStrokePath(hdc);
	
	RR.origin.x    =  0;       RR.size.width =64;
	RR.size.height = 22;        RR.origin.y = ([Loinfo dimyVista]-RR.size.height)-3;
	imma = CGImageCreateWithImageInRect (imageref, RR );
	RR.origin.y    =  0;
	CGContextDrawImage  (hdc,RR,imma);  
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, 0, 22);
	CGContextAddLineToPoint(hdc,64, 22);
	CGContextAddLineToPoint(hdc,64, 9);

	CGContextStrokePath(hdc);

		// il riporto delle informazionoi cpyright googleMaps

	
}



- (void)   setimageref     : (CGImageRef)   _imgref					{
	if (imageref!=nil) {CGImageRelease (imageref);	imageref=nil;	}
	imageref  = CGImageCreateCopy ( _imgref  );
	dxpan=0;  dypan=0;
	dimximg   = CGImageGetWidth (_imgref);
	dimyimg   = CGImageGetHeight(_imgref);
}

- (void)   setVisibile     : (bool)         _vis					{
	b_visibile = _vis;
	if (!_vis) { b_maivisto =YES;	}
	
}

- (void)   setSatellite    : (bool)         _vis					{
	b_terreno = _vis;
}

- (void)   setalpha        : (float)        _alpha					{
	f_alpha = _alpha;
}

- (void)   incpandxdy      : (float) _dx : (float) _dy				{
	dxpan = dxpan+_dx;	dypan = dypan+_dy;
}

- (void)   setZoomGoogle_w:(int)_zom								{ zoomgoogle_writed=_zom;   }

- (void)   setZoomGoogle_r:(int)_zom								{ zoomgoogle_readed=_zom;   }

- (void)   setZoomGooglePiu_w										{ zoomgoogle_writed++;      }

- (void)   setZoomGoogleMeno_w										{ zoomgoogle_writed--;      }

- (void)   setCentro_w     :(double) xc  : (double) yc				{
	centrox_w=xc;		centroy_w=yc;
}

- (void)   setCentro_r     :(double) xc  : (double) yc				{
	centrox_r=xc;  centroy_r=yc;
}

- (void)   setricentro												{
	centrox_r=centrox_w;  centroy_r=centroy_w;
} 

- (void)   justriletto												{
	if (!b_visibile) return;
	b_maivisto =NO;
	centrox_r=centrox_w;  centroy_r=centroy_w;
}

- (CGImageRef)  imageref											{
	return imageref;
}

- (bool)   Satellite												{
	return b_terreno;
}

- (int)    ZoomGoogle_w												{ return zoomgoogle_writed; }

- (int)    ZoomGoogle_r												{ return zoomgoogle_readed; }

- (float)  alpha													{
	return f_alpha;
}

- (float)  dxpan													{ return dxpan; }

- (float)  dypan													{ return dypan; }

- (float)  rapscale													{ return rapscale; }

- (bool)   Visibile													{
	return b_visibile;
}



@end
