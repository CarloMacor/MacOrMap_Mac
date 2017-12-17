//
//  Cerchio.m
//  GIS2010
//
//  Created by Carlo Macor on 09/04/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Cerchio.h"


@implementation Cerchio


- (void)   InitCerchio: (double)x1 :(double) y1: (double)x2 :(double) y2              {
	b_erased=NO;	b_selected=NO;
	tipo  = 5;  	x = x1;  	y = y1;  	
	r = hypot((x2-x1), (y2-y1));
	[self faiLimiti];
}

- (void)   Disegna:(CGContextRef) hdc: (InfoObj *) _info                              {
	
	if (b_erased) return;
	double x1,y1,rag;
	x1=(x-[_info xorigineVista])/[_info scalaVista];
	y1=(y-[_info yorigineVista])/[_info scalaVista];
	rag = r /[_info scalaVista];
	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextStrokePath(hdc);
	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextFillPath(hdc);
	
	
	tipo  = 5; 
}

- (void)   DisegnaAffineSpo    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  {
	
	double x1,y1,rag;
	x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	rag = r /[_info scalaVista];
	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextStrokePath(hdc);
//	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
//	CGContextFillPath(hdc);
	
	
}

- (void) DisegnaAffineRot    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  {
	double x1,y1,rag;
	x1=x-xc;	y1=y-yc;
	double locx,locy;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	rag = r /[_info scalaVista];
	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextStrokePath(hdc);
}



- (void) DisegnaAffineSca    : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  {
	double x1,y1,rag;
	x1=x-xc; 	  y1=y-yc;
	double locx,locy;
	locx = x1*sca;        	locy = y1*sca;
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	rag = (r*sca) /[_info scalaVista];
	CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextSetLineWidth(hdc, 0.6 );
	CGContextStrokePath(hdc);
}




- (double) distsemplice : (double) x1 :(double) y1:(double) x2 :(double) y2           {
	return hypot( (x2-x1), (y2-y1) );
}

- (void)   seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati {
	double dd;  
	double off  =  [ _info give_offsetmirino ];
	dd = [self distsemplice : x: y: x1 : y1 ] - r ;
	if (dd<0) dd=-dd;
    if (dd<off)  { [_LSelezionati addObject:self];	}
}

- (bool) Match_conPt        : (InfoObj *) _info   : (double) x1  : (double) y1{
	bool locres=NO;
	double dd;  
	double off  =  [ _info give_offsetmirino ];
	dd = [self distsemplice : x: y: x1 : y1 ] - r ;
	if (dd<0) dd=-dd;
    if (dd<off)  { locres =YES; }
	return locres;
}


- (void)   faiLimiti                                                                  {
	limx1 = x-r ;	limx2 = x+r ;	limy1 = y-r ;	limy2 = y+r ;
}

- (void) Sposta          : (double) dx :  (double) dy                 {
	x +=dx;	y +=dy;	[self faiLimiti];
}

- (Vettoriale *) Copia           : (double) dx :  (double) dy                 {
	Cerchio *newcer;
	newcer = [Cerchio alloc];
	[newcer InitCerchio:x :y :(x+r) :y];
	[[_piano  Listavector] addObject:newcer];
	[newcer faiLimiti];
	[self Sposta:dx :dy];
	return newcer;
}

- (void) Ruota           : (double) xc :  (double) yc : (double) ang  {
	[self Sposta:-xc :-yc];	[self Ruotaang:ang];	[self Sposta:xc :yc];
}

- (void) Ruotaang        : (double) ang                               {
	double locx,locy;
	locx = x*cos(ang) - y*sin(ang);        	locy = x*sin(ang) + y*cos(ang);
	x=locx;	y=locy;
}

- (void) Scala           : (double) xc :  (double) yc : (double) scal {
    [self Sposta:-xc :-yc];	[self Scalasc:scal];	[self Sposta:xc :yc];
}

- (void) Scalasc         : (double) scal                              {
	double locx,locy;
	locx = x*scal;      locy = y*scal;	       
	x=locx;	y=locy;
	r = r*scal;
}

- (void) CopiainLista    : (NSMutableArray *) inlista                 {
	Cerchio *newcer;
	newcer = [Cerchio alloc];
	[newcer InitCerchio:x :y :(x+r) :y];
	[inlista addObject:newcer];
	[newcer faiLimiti];
}


- (void) salvavettorialeMoM    :(NSMutableData *) _illodata           {
	[super salvavettorialeMoM:_illodata];
		//	[_illodata appendBytes:(const void *)&tipo length:sizeof(tipo)];
	[_illodata appendBytes:(const void *)&x length:sizeof(x)];
	[_illodata appendBytes:(const void *)&y length:sizeof(y)];
	[_illodata appendBytes:(const void *)&r length:sizeof(r)];
}

- (NSUInteger) aprivettorialeMoM     : (NSData *) _data: (NSUInteger) posdata          {
    posdata = [super aprivettorialeMoM :_data: posdata ];
	
	[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
	[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);
	[_data getBytes:&r        range:NSMakeRange (posdata, sizeof(r))  ];     posdata +=sizeof(r);
  	[self faiLimiti];

 return posdata;

}


- (NSString *) salvadxf                        {
	NSString *risulta=@"";
	risulta = [risulta stringByAppendingString:@"  0\n"];
	risulta = [risulta stringByAppendingString:@"CIRCLE\n"];
	risulta = [risulta stringByAppendingString:@"  8\n"];
	risulta = [risulta stringByAppendingString:[_piano givemenomepiano]];	risulta = [risulta stringByAppendingString:@"\n"];
	
	risulta = [risulta stringByAppendingString:@" 10\n"];
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,x];  risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 20\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,y];  risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 40\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,r];  risulta = [risulta stringByAppendingString:@"\n"];

	return risulta;	
}

- (void) CatToUtm  : (InfoObj *) _info{
	[_info catastotoutm : &x : &y];
}



@end
