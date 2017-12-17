//
//  Punto.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Punto.h"


@implementation Punto


- (void) InitPunto          : (double)x1 : (double) y1                                {
	b_erased=NO;	b_selected=NO;
	tipo  = 1;  	x = x1;  	y = y1;  
	[self faiLimiti];
}


- (void) salvavettorialeMoM    : (NSMutableData *) _illodata            {
	[super salvavettorialeMoM : _illodata];
	[_illodata appendBytes:(const void *)&x length:sizeof(x)];
	[_illodata appendBytes:(const void *)&y length:sizeof(y)];
}

- (NSUInteger) aprivettorialeMoM     : (NSData *) _data : (NSUInteger ) posdata           {
	posdata = [super aprivettorialeMoM :_data: posdata ];
	[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
	[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);
	[self faiLimiti];
	return posdata;
}


- (void) Disegna            : (CGContextRef) hdc: (InfoObj *) _info                 {
	if (b_erased) return;
	double x1,y1;
	int dimcroce = [_piano dimpunto];
    if (dimcroce<=1) {
     CGRect rect ;
     rect.origin.x = (x-[_info xorigineVista])/[_info scalaVista];
     rect.origin.y = (y-[_info yorigineVista])/[_info scalaVista];
     rect.size.height=1;
     rect.size.width=1;
            //     CGContextFillRect (hdc, rect );	// se piccolo metter comunque un punto
     CGContextStrokeRect (hdc,rect );

     return;
    }
    
    
	x1=(x-[_info xorigineVista])/[_info scalaVista];
	y1=(y-[_info yorigineVista])/[_info scalaVista];
	CGContextMoveToPoint(hdc, x1-dimcroce, y1);	CGContextAddLineToPoint(hdc, x1+dimcroce, y1);
	CGContextMoveToPoint(hdc, x1  , y1-dimcroce);	CGContextAddLineToPoint(hdc, x1  , y1+dimcroce);
	CGContextStrokePath(hdc);
}

- (void) DisegnaAffineSpo    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  {
	if (b_erased) return;
	double x1,y1;
	x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextMoveToPoint(hdc, x1-3, y1);	CGContextAddLineToPoint(hdc, x1+3, y1);
	CGContextMoveToPoint(hdc, x1  , y1-3);	CGContextAddLineToPoint(hdc, x1  , y1+3);
	CGContextStrokePath(hdc);
}

- (void) DisegnaAffineRot    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  {
	if (b_erased) return;
	double x1,y1;
	x1=x-xc;
	y1=y-yc;
	double locx,locy;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextMoveToPoint(hdc, x1-3, y1);	CGContextAddLineToPoint(hdc, x1+3, y1);
	CGContextMoveToPoint(hdc, x1  , y1-3);	CGContextAddLineToPoint(hdc, x1  , y1+3);
	CGContextStrokePath(hdc);
}



- (void) DisegnaAffineSca    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  {
	if (b_erased) return;
	double x1,y1;
	x1=x-xc; 	  y1=y-yc;
	double locx,locy;
	locx = x1*sca;        	locy = y1*sca;
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextMoveToPoint(hdc, x1-3, y1);	CGContextAddLineToPoint(hdc, x1+3, y1);
	CGContextMoveToPoint(hdc, x1  , y1-3);	CGContextAddLineToPoint(hdc, x1  , y1+3);
	CGContextStrokePath(hdc);
}


- (bool) SnapFine      : (InfoObj *) _info:  (double) x1: (double) y1                 {
	bool locres=NO;
	double off  =  [ _info give_offsetmirino ];
	double dx   =  (x1-x); 	double dy   =  (y1-y); 
	if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
	if ((dx<off) & (dy<off)) {	[_info setxysnap : x : y];  locres=YES; }
	return locres;
}

- (bool) SnapVicino    : (InfoObj *) _info:  (double) x1: (double) y1       {
	bool locres=NO;
	double off  =  [ _info give_offsetmirino ];
	double dx   =  (x1-x); 	double dy   =  (y1-y); 
	if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
	if ((dx<off) & (dy<off)) {	[_info setxysnap : x : y];  locres=YES; }
	return locres;
}

- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati {
	double off  =  [ _info give_offsetmirino ];
	double dx   =  (x1-x); 	double dy   =  (y1-y); 
	if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
	if ((dx<off) & (dy<off)) { 	[_LSelezionati addObject:self];   }
}

- (bool) Match_conPt      : (InfoObj *) _info : (double) x1 : (double) y1   {
	bool locres=NO;
	double off  =  [ _info give_offsetmirino ];
	double dx   =  (x1-x); 	double dy   =  (y1-y); 
	if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
	if ((dx<off) & (dy<off)) { locres=YES;   }
	return locres;
}

- (void) faiLimiti                                                          {
	limx1 = x-1 ;	limx2 = x+1 ;	limy1 = y-1 ;	limy2 = y+1 ;
}

- (double) x                                                                {
	return x;
}

- (double) y                                                                {
	return y;
}


- (void) Sposta          : (double) dx :  (double) dy                       {
	x +=dx;	y +=dy;	[self faiLimiti];
}

- (Vettoriale *) Copia           : (double) dx :  (double) dy                       {
	Punto *newpt;
	newpt = [Punto alloc];
	[newpt Init:_disegno : _piano];
	[newpt InitPunto:x:y];
	[[_piano  Listavector] addObject:newpt];
	[newpt faiLimiti];
	[self Sposta:dx:dy];

	return newpt;
}

- (Vettoriale *) copiaPura {
	Punto *newpt;
	newpt = [Punto alloc];
	[newpt Init:_disegno : _piano];
	[newpt InitPunto:x:y];
	[newpt faiLimiti];
	return newpt;	
}



- (void) Ruota           : (double) xc :  (double) yc : (double) ang        {
	[self Sposta:-xc :-yc];	[self Ruotaang:ang];	[self Sposta:xc :yc];
}

- (void) Ruotaang        : (double) ang                                     {
	double locx,locy;
	locx = x*cos(ang) - y*sin(ang);        	locy = x*sin(ang) + y*cos(ang);
	x=locx;	y=locy;
}

- (void) Scala           : (double) xc :  (double) yc : (double) scal       {
    [self Sposta:-xc :-yc];	[self Scalasc:scal];	[self Sposta:xc :yc];
}

- (void) Scalasc         : (double) scal                                    {
	double locx,locy;
	locx = x*scal;      locy = y*scal;	       
	x=locx;	y=locy;
}

- (NSString *) salvadxf                                                     {
	NSString *risulta=@"";
	risulta = [risulta stringByAppendingString:@"  0\n"];
	risulta = [risulta stringByAppendingString:@"POINT\n"];
	risulta = [risulta stringByAppendingString:@"  8\n"];
	risulta = [risulta stringByAppendingString:[_piano givemenomepiano]];	risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 10\n"];
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,x];  risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 20\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,y];  risulta = [risulta stringByAppendingString:@"\n"];
	return risulta;	
}

- (void) CatToUtm  : (InfoObj *) _info{
			[_info catastotoutm : &x : &y];
}



@end
