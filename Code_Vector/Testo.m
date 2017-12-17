//
//  Testo.m
//  GIS2010
//
//  Created by Carlo Macor on 06/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Testo.h"


@implementation Testo


- (void) InitTesto        :(double)x1 :(double) y1: (double) htxt: (double) ang;{
	tipo  = 6;
	stringa=@"XXXXX";
	x=x1; y=y1;
	i_font=0;
	i_style=0;
    altezza=htxt;
    angolo=ang;
	alli = 0; // allineamento Sx
}

- (void) InitTestoStr     : (double)x1 :(double) y1: (double) htxt: (double) ang: (NSString *)   _newtext {
	tipo  = 6;
  [_newtext retain];  [stringa release];	    stringa = _newtext;
	x=x1; y=y1;
	i_font=0;
	i_style=0;
    altezza=htxt;
    angolo=(ang/180)*M_PI;
	alli = 0; // allineamento Sx
}



- (void) Disegna            : (CGContextRef) hdc: (InfoObj *) _info                 {
	if (b_erased) return;
	
	double x1,y1;
    double hf;
	x1=(x-[_info xorigineVista])/[_info scalaVista];
	y1=(y-[_info yorigineVista])/[_info scalaVista];
	hf = altezza/[_info scalaVista];

	
	if (!_info.instampa) {
	if (hf<3) {	return;	}
	if (hf<6) 
	{		
		CGContextSaveGState (hdc);
		CGContextSetRGBStrokeColor (hdc, 0.1, 0.1, 0.1, 0.6);
		 CGContextMoveToPoint(hdc, x1  , y1-1);	CGContextAddLineToPoint(hdc, x1  , y1+1);
		 CGContextStrokePath(hdc);
		CGContextRestoreGState ( hdc );
		return;
	}
	}
	
	
	
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
//	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	NSColor *colore ;
	if (!_info.instampa) {
	colore = [NSColor colorWithDeviceRed:[_piano colorepiano_r] green:[_piano colorepiano_g] 
											 blue:[_piano colorepiano_b] alpha:[_piano getalphaline]*[_disegno alphaline]] ;
	} else {
		colore = [NSColor colorWithDeviceRed:0.0 green:0.0	blue:0.0 alpha:0.8] ;
	}
	
	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:fonte ,NSFontAttributeName, colore ,NSForegroundColorAttributeName, nil] ;
	
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( angolo );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	                  trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	

	[stringa drawAtPoint:pt withAttributes:attributes];


	CGContextRestoreGState ( hdc );
	
}


- (void) DisegnaSelected  : (CGContextRef)  hdc    : (InfoObj *) _info {
	if (b_erased) return;
	double x1,y1;
    double hf;
	x1=(x-[_info xorigineVista])/[_info scalaVista];
	y1=(y-[_info yorigineVista])/[_info scalaVista];
	hf = altezza/[_info scalaVista];
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
		//	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	
	
	NSColor *colore = [NSColor colorWithDeviceRed:1 green:0	 blue:0 alpha:1] ;
	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:fonte ,NSFontAttributeName, colore ,NSForegroundColorAttributeName, nil] ;
	
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( angolo );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	
	
	[stringa drawAtPoint:pt withAttributes:attributes];
	
	
	CGContextRestoreGState ( hdc );
	
}  // solo per i testi


- (void) cambiastringa    : (NSString *)   _newtext{
	[_newtext retain];  [stringa release];	    stringa = _newtext;
}

- (void) cambiaaltezza    : (double)       newh {
	altezza = newh;
}


- (void) faiLimiti {
	limx1 = x ;	limx2 = x ;	limy1 = y ;	limy2 = y ;
	double locx , locy ;
	double posx , posy ;
	locx = [stringa length]*0.8*altezza;  	           locy = 0;
	posx = locx*cos(angolo) - locy*sin(angolo);        	posy = locx*sin(angolo) + locy*cos(angolo);
    posx = x +posx;                              	    posy = y +posy;
	if (posx<limx1) limx1=posx;	if (posx>limx2) limx2=posx;
	if (posy<limy1) limy1=posy;	if (posy>limy2) limy2=posy;

	locx = [stringa length]*0.8*altezza;  	           locy = altezza;
	posx = locx*cos(angolo) - locy*sin(angolo);        	posy = locx*sin(angolo) + locy*cos(angolo);
    posx = x +posx;                              	    posy = y +posy;
	if (posx<limx1) limx1=posx;	if (posx>limx2) limx2=posx;
	if (posy<limy1) limy1=posy;	if (posy>limy2) limy2=posy;
	
	locx = 0;  	           locy = altezza;
	posx = locx*cos(angolo) - locy*sin(angolo);        	posy = locx*sin(angolo) + locy*cos(angolo);
    posx = x +posx;                              	    posy = y +posy;
	if (posx<limx1) limx1=posx;	if (posx>limx2) limx2=posx;
	if (posy<limy1) limy1=posy;	if (posy>limy2) limy2=posy;
	
}


- (void) DisegnaAffineSpo : (CGContextRef)  hdc    : (InfoObj *) _info : (double) dx : (double) dy  {
	if (b_erased) return;
	double x1,y1;
    double hf;
	x1=((x+dx)-[_info xorigineVista])/[_info scalaVista];
	y1=((y+dy)-[_info yorigineVista])/[_info scalaVista];
	hf = altezza/[_info scalaVista];
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( angolo );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	[stringa drawAtPoint:pt withAttributes:attributes];
	CGContextRestoreGState ( hdc );
}
- (void) DisegnaAffineRot : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot  {
	if (b_erased) return;
	double x1,y1;
	double hf;

	x1=x-xc;
	y1=y-yc;
	double locx,locy;
	locx = x1*cos(rot) - y1*sin(rot);        	locy = x1*sin(rot) + y1*cos(rot);
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];

	hf = altezza/[_info scalaVista];
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( angolo+rot );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	[stringa drawAtPoint:pt withAttributes:attributes];
	CGContextRestoreGState ( hdc );
}

- (void) DisegnaAffineSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) sca  {
	//
	if (b_erased) return;
	double x1,y1;
	double hf;
	x1=x-xc; 	  y1=y-yc;
	double locx,locy;
	locx = x1*sca;        	locy = y1*sca;
	x1=locx+xc;	y1=locy+yc;
	x1=(x1-[_info xorigineVista])/[_info scalaVista];
	y1=(y1-[_info yorigineVista])/[_info scalaVista];
	hf = (altezza*sca)/[_info scalaVista];
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( angolo );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	[stringa drawAtPoint:pt withAttributes:attributes];
	CGContextRestoreGState ( hdc );
}

- (void) DisegnaSpoRotSca : (CGContextRef)  hdc    : (InfoObj *) _info : (double) xc : (double) yc : (double) rot : (double) sca  {
	double x1,y1;
	x1=(xc-[_info xorigineVista])/[_info scalaVista];
	y1=(yc-[_info yorigineVista])/[_info scalaVista];
	double hf;
	hf = altezza*sca/[_info scalaVista];
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:hf];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:fonte forKey:NSFontAttributeName];
	CGContextSaveGState (hdc);
	NSPoint pt;	pt.x=x1;	pt.y=y1;
	CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( rot );
	CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -x1 ,-y1 );
	CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  x1 , y1 );
	CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trRot );
	trAll  = CGAffineTransformConcat          ( trAll , tr1 );
	CGContextConcatCTM (hdc	, trAll );
	[stringa drawAtPoint:pt withAttributes:attributes];
	CGContextRestoreGState ( hdc );
} 



- (bool) SnapFine         : (InfoObj *)     _info  : (double)     x1      : (double) y1{
	bool locres=NO;
	return locres;
}

- (bool) SnapVicino       : (InfoObj *)     _info  : (double)     x1      : (double) y1{
	bool locres=NO;
	return locres;
}

- (void) seleziona_conPt  : (CGContextRef)  hdc    : (InfoObj *) _info    : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati {
	double off  =  [ _info give_offsetmirino ];
		//	off=0;
	if (  (x1>(limx1-off)) &  (x1<(limx2+off)) &  (y1>(limy1-off)) &  (y1<(limy2+off)) ) {
		[_LSelezionati addObject:self];
	}
	
}
- (bool) Match_conPt      : (InfoObj *)     _info  : (double) x1          : (double) y1 {
	bool locres=NO;
	double off  =  [ _info give_offsetmirino ];
	off=0;
	if (  (x1>(limx1-off)) &  (x1<(limx2+off)) &  (y1>(limy1-off)) &  (y1<(limy2+off)) ) {	locres=YES;	}
	return locres;
}

- (void) Sposta          : (double) dx :  (double) dy                    {
	x +=dx;	y +=dy;	[self faiLimiti];
}

- (Vettoriale *) Copia           : (double) dx :  (double) dy                    {
	Testo *newtext;
	newtext = [Testo alloc];
	[newtext Init:_disegno : _piano];
	[newtext InitTestoStr  : x:y: altezza: angolo*180/M_PI: stringa];
	[[_piano  Listavector] addObject:newtext];
	[newtext faiLimiti];
	[self Sposta:dx:dy];

	return newtext;
}

- (void) Ruota           : (double) xc :  (double) yc : (double) ang     {
	[self Sposta:-xc :-yc];	[self Ruotaang:ang];	[self Sposta:xc :yc];
	angolo = angolo+ang;
	if (angolo<0) angolo = angolo+ M_PI*2;
	if (angolo>2*M_PI) angolo=angolo-2*M_PI;
	
}

- (void) Ruotaang        : (double) ang                                  {
	double locx,locy;
	locx = x*cos(ang) - y*sin(ang);        	locy = x*sin(ang) + y*cos(ang);
	x=locx;	y=locy;
}

- (void) Scala           : (double) xc :  (double) yc : (double) scal    {
    [self Sposta:-xc :-yc];	[self Scalasc:scal];	[self Sposta:xc :yc];
}

- (void) Scalasc         : (double) scal                                 {
	double locx,locy;
	locx = x*scal;      locy = y*scal;	       
	x=locx;	y=locy;
	altezza = altezza*scal;

}

- (void) CopiainLista    : (NSMutableArray *) inlista                    {
	Testo *newtext;
	newtext = [Testo alloc];
	[newtext Init:_disegno : _piano];
	[newtext InitTestoStr  : x:y: altezza: angolo: stringa];
	[inlista addObject:newtext];
}


- (NSString *) caratteritesto {
	return stringa;
}

- (double)     altezzatesto {
	return altezza;
}


- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;	
	for (int i=0; i<lungstr; i++) {
		ilcar = [ str characterAtIndex:i];
		[dat appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
}


- (void) salvavettorialeMoM               :(NSMutableData *) _illodata {
	[super salvavettorialeMoM:_illodata];
	[_illodata appendBytes:(const void *)&x length:sizeof(x)];
	[_illodata appendBytes:(const void *)&y length:sizeof(y)];
	[_illodata appendBytes:(const void *)&i_font  length:sizeof(i_font)];
	[_illodata appendBytes:(const void *)&i_style length:sizeof(i_style)];
	[_illodata appendBytes:(const void *)&alli    length:sizeof(alli)];
	[_illodata appendBytes:(const void *)&altezza length:sizeof(altezza)];
	[_illodata appendBytes:(const void *)&angolo  length:sizeof(angolo)];
	[self addstringaData : _illodata : stringa];
}

// NSString *stringa;



- (NSUInteger) aprivettorialeMoM  : (NSData *) _data : (NSUInteger) posdata {
    posdata	= [super aprivettorialeMoM : _data: posdata ];
	
	[_data getBytes:&x        range:NSMakeRange (posdata, sizeof(x))  ];     posdata +=sizeof(x);
	[_data getBytes:&y        range:NSMakeRange (posdata, sizeof(y))  ];     posdata +=sizeof(y);

	[_data getBytes:&i_font        range:NSMakeRange (posdata, sizeof(i_font))  ];     posdata +=sizeof(i_font);
	[_data getBytes:&i_style        range:NSMakeRange (posdata, sizeof(i_style))  ];     posdata +=sizeof(i_style);
	[_data getBytes:&alli        range:NSMakeRange (posdata, sizeof(alli))  ];     posdata +=sizeof(alli);

	[_data getBytes:&altezza        range:NSMakeRange (posdata, sizeof(altezza))  ];     posdata +=sizeof(altezza);
	[_data getBytes:&angolo        range:NSMakeRange (posdata, sizeof(angolo))  ];     posdata +=sizeof(angolo);

	int lungstr;            unichar ilcar;

	NSMutableString *locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self cambiastringa : locstmut ];	    [locstmut release];
	
	
 return posdata;

}


- (NSString *) salvadxf                        {
	NSString *risulta=@"";
	risulta = [risulta stringByAppendingString:@"  0\n"];
	risulta = [risulta stringByAppendingString:@"TEXT\n"];
	risulta = [risulta stringByAppendingString:@"  8\n"];
	risulta = [risulta stringByAppendingString:[_piano givemenomepiano]];	risulta = [risulta stringByAppendingString:@"\n"];
	
//	writeln(FDXF,'  7');   ttFont:=dammifonteTesto(loctesto,locpiano); 	writeln(FDXF,ttFont);	
	
	risulta = [risulta stringByAppendingString:@" 10\n"];
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,x];  risulta = [risulta stringByAppendingString:@"\n"];
	risulta = [risulta stringByAppendingString:@" 20\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,y];  risulta = [risulta stringByAppendingString:@"\n"];

	risulta = [risulta stringByAppendingString:@" 40\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,altezza];  risulta = [risulta stringByAppendingString:@"\n"];

	risulta = [risulta stringByAppendingString:@"  1\n"];     
	risulta = [risulta stringByAppendingString:stringa];  risulta = [risulta stringByAppendingString:@"\n"];

	risulta = [risulta stringByAppendingString:@" 50\n"];     
	risulta = [risulta stringByAppendingFormat:@"%1.2f" ,angolo];  risulta = [risulta stringByAppendingString:@"\n"];
	
	return risulta;	
}


- (bool) testinternoschermo : (InfoObj *) _info  {
	bool locres=YES;
	if (x<[_info xorigineVista]  )  return NO;
	if (x>[_info x2origineVista] ) return NO;
	if (y<[_info yorigineVista]  )  return NO;
	if (y>[_info y2origineVista] ) return NO;
	return locres;
}

- (void) CatToUtm  : (InfoObj *) _info{
	[_info catastotoutm : &x : &y];
}

- (void) TestoAltoQU  {
	
	if ([stringa length]<9) return;
	NSRange myrange;
	unichar cicco;
	myrange.location=6;    myrange.length =3;
	cicco = [stringa characterAtIndex:6];
	if (cicco==48) { myrange.location=7;    myrange.length =2;
		cicco = [stringa characterAtIndex:7];
		if (cicco==48) { myrange.location=8;    myrange.length =1;}
	}
	
    NSString * momst = [stringa substringWithRange:myrange];
    [stringa release];
	stringa = momst;
	
	altezza = 200;
}

- (Testo *) copiaPura {
	Testo * copT;
	copT = [Testo alloc];
	[copT Init  : _disegno  : _piano];
	[copT InitTestoStr : x : y : altezza : angolo : stringa];
	[copT faiLimiti];
	return copT;
}


@end
