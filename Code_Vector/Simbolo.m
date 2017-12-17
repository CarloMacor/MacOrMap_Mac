//
//  Simbolo.m
//  GIS2010
//
//  Created by Carlo Macor on 29/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Simbolo.h"


@implementation Simbolo

- (void) InitSimbolo          : (double)x1 : (double) y1 : (int) indice : (NSMutableArray *) listadefinizioni     {
	qualeLista =0;
	b_erased=NO;	b_selected=NO;
	tipo  = 10;  	x = x1;  	y = y1;  
	if (listadefinizioni != nil) definizione = [listadefinizioni objectAtIndex:indice]; // [definizione retain];
	indLista    = indice;
	scalaSimb   = 1;
	angrot      = 0;
	dimfissa    = NO;
}



- (void) Disegna            : (CGContextRef) hdc: (InfoObj *) _info                 {
	if (b_erased) return;
	if (definizione==nil) return;
	double dx = limx2-limx1;
	double dy = limy2-limy1;
	dx = dx/[_info scalaVista];
	dy = dy/[_info scalaVista];
    if (((dx<4) & (dy<4)) & (!dimfissa))  return;
	
	Vettoriale *objvector;
	for (int i=0; i<[definizione  Listavector].count; i++) {  
		objvector= [[definizione  Listavector] objectAtIndex:i];
		if (dimfissa) 
			[objvector DisegnaSpoRotSca : hdc    : _info : x : y: angrot : 6*[_info scalaVista]]  ;
			else
	    [objvector DisegnaSpoRotSca : hdc    : _info : x : y: angrot : scalaSimb]  ;
	}
	
}


- (void) seleziona_conPt  : (CGContextRef) hdc  : (InfoObj *) _info  :(double) x1 : (double) y1: (NSMutableArray *) _LSelezionati {
	double off  =  [ _info give_offsetmirino ];
	if (  (x1>(limx1-off)) &  (x1<(limx2+off)) &  (y1>(limy1-off)) &  (y1<(limy2+off)) ) {
		[_LSelezionati addObject:self];
	}
	
	
}

- (bool) Match_conPt      : (InfoObj *) _info   : (double) x1 : (double) y1         {
	bool locres=NO;
	double off  =  [ _info give_offsetmirino ];
	off=0;
	if (  (x1>(limx1-off)) &  (x1<(limx2+off)) &  (y1>(limy1-off)) &  (y1<(limy2+off)) ) {	locres=YES;	}
	return locres;
}

- (void) ritrovadefdalista: (NSMutableArray *) listadefinizioni                     {
	definizione = [listadefinizioni objectAtIndex:indLista];
}




- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy                                 {
	if (b_erased) return;
	if (definizione==nil) return;
	Vettoriale *objvector;
	for (int i=0; i<[definizione  Listavector].count; i++) {  
		objvector= [[definizione  Listavector] objectAtIndex:i];
	    [objvector DisegnaSpoRotSca : hdc    : _info : x+dx : y+dy: angrot : scalaSimb]  ;
	}
}

- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot                  {
	if (b_erased) return;
	if (definizione==nil) return;
	double x1,y1;	    x1=x-xc;	                           y1=y-yc;
	double locx,locy;	locx = x1*cos(rot) - y1*sin(rot);      locy = x1*sin(rot) + y1*cos(rot);
	locx = locx+xc;     locy = locy+yc;
	Vettoriale *objvector;
	for (int i=0; i<[definizione  Listavector].count; i++) {  
		objvector= [[definizione  Listavector] objectAtIndex:i];
	    [objvector DisegnaSpoRotSca : hdc    : _info : locx : locy: angrot+rot : scalaSimb]  ;
	}
}

- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca                  {
	if (b_erased) return;
	if (definizione==nil) return;
	Vettoriale *objvector;
	for (int i=0; i<[definizione  Listavector].count; i++) {  
		objvector= [[definizione  Listavector] objectAtIndex:i];
	    [objvector DisegnaSpoRotSca : hdc    : _info : x +(xc-x)*(1-sca) : y+(yc-y)*(1-sca): angrot : scalaSimb*sca]  ;
	}
}




- (void) faiLimiti                                                          {
	limx1 = x ;	limx2 = x ;	limy1 = y ;	limy2 = y ;
	double loclimx, loclimy;
	Vettoriale *objvector;
	for (int i=0; i<[definizione  Listavector].count; i++) {  
		objvector= [[definizione  Listavector] objectAtIndex:i];
		loclimx =[objvector limx1];		loclimy =[objvector limy1];
        loclimx += x;		loclimy += y;
        if (limx1>loclimx) limx1=loclimx;        if (limy1>loclimy) limy1=loclimy;
		loclimx =[objvector limx2];		loclimy =[objvector limy2];
        loclimx += x;		loclimy += y;
        if (limx2<loclimx) limx2=loclimx;        if (limy2<loclimy) limy2=loclimy;
	}
}


- (void) Sposta           : (double) dx :  (double) dy                      {
	x +=dx;	y +=dy;	[self faiLimiti];
}

- (Vettoriale *) Copia            : (double) dx :  (double) dy                      {
	Simbolo *newsy;
	newsy = [Simbolo alloc];
	[newsy Init:_disegno : _piano];
	[newsy InitSimbolo:x :y :indLista :nil];
	
	[newsy setdefinizione :definizione];
	[[_piano  Listavector] addObject:newsy];
	[newsy faiLimiti];
	[self Sposta:dx:dy];

	return newsy;
}

- (void) setdefinizione   : (DefSimbolo *) ladefinizione                    {
	definizione = ladefinizione;
}

- (void) setFisso         : (bool) fisso {
	dimfissa = fisso;
}

- (bool) dimFissa {
	return dimfissa;
}


- (void) Ruota            : (double) xc :  (double) yc : (double) ang       {
	[self Sposta:-xc :-yc];	[self Ruotaang:ang];	[self Sposta:xc :yc];
}

- (void) Ruotaang         : (double) ang                                    {
	double locx,locy;
	locx = x*cos(ang) - y*sin(ang);        	locy = x*sin(ang) + y*cos(ang);
	x=locx;	y=locy;
	[self ruotasimbolo : (angrot+ang)];
} 


- (void) Scala           : (double) xc :  (double) yc : (double) scal       {
	[self Sposta:-xc :-yc];	[self Scalasc:scal];	[self Sposta:xc :yc];
	[self scalasimbolo : scalaSimb*scal];
} 

- (void) Scalasc         : (double) scal                                    {
	double locx,locy;
	locx = x*scal;      locy = y*scal;	       
	x=locx;	y=locy;
} 



- (void) ruotasimbolo     : (double) rot                                            {
	angrot = rot;
	if (angrot<0) angrot = angrot+ M_PI*2;
	if (angrot>2*M_PI) angrot=angrot-2*M_PI;

}

- (void) scalasimbolo     : (double) sca                                            {
	scalaSimb = sca;
}

- (NSString *) salvadxf                                                             {
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


- (void)               salvavettorialeMoM   : (NSMutableData *) _illodata                                {
	[super salvavettorialeMoM : _illodata];
	[_illodata appendBytes:(const void *)&qualeLista length:sizeof(qualeLista)];
	[_illodata appendBytes:(const void *)&indLista length:sizeof(indLista)];
	[_illodata appendBytes:(const void *)&x length:sizeof(x)];
	[_illodata appendBytes:(const void *)&y length:sizeof(y)];
	[_illodata appendBytes:(const void *)&scalaSimb length:sizeof(scalaSimb)];
	[_illodata appendBytes:(const void *)&angrot length:sizeof(angrot)];
	[_illodata appendBytes:(const void *)&dimfissa length:sizeof(dimfissa)];
}


- (NSUInteger) aprivettorialeMoM2     : (NSData *) _data: (NSUInteger) posdata {
	posdata = [super aprivettorialeMoM :_data: posdata ];
	[_data getBytes:&qualeLista        range:NSMakeRange (posdata, sizeof(qualeLista))  ];     posdata +=sizeof(qualeLista);
	[_data getBytes:&indLista          range:NSMakeRange (posdata, sizeof(indLista))  ];       posdata +=sizeof(indLista);
	[_data getBytes:&x                 range:NSMakeRange (posdata, sizeof(x))  ];              posdata +=sizeof(x);
	[_data getBytes:&y                 range:NSMakeRange (posdata, sizeof(y))  ];              posdata +=sizeof(y);
	[_data getBytes:&scalaSimb         range:NSMakeRange (posdata, sizeof(scalaSimb))  ];      posdata +=sizeof(scalaSimb);
	[_data getBytes:&angrot            range:NSMakeRange (posdata, sizeof(angrot))  ];         posdata +=sizeof(angrot);
	[_data getBytes:&dimfissa         range:NSMakeRange (posdata, sizeof(dimfissa))  ];        posdata +=sizeof(dimfissa);
	[self faiLimiti];
 return posdata;
}


- (void) CatToUtm         : (InfoObj *) _info                                      {
	[_info catastotoutm : &x : &y];
}

@end
