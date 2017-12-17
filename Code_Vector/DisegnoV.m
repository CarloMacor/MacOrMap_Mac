//
//  DisegnoV.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "DisegnoV.h"
#import "Vettoriale.h"
#import "funzioni.h"
#import "Piano.h"


@interface DisegnoV (private)

 - (Piano *)     givemePianocorrente; 
 - (Vettoriale *) dammiUltimoPoligono;

@end


@implementation DisegnoV

Piano    *_piano;
Piano    *_pianocorrente;

@synthesize  eventuale_ang;
@synthesize  eventuale_scala;
@synthesize  eventuale_offx;
@synthesize  eventuale_offy;


- (void) InitDisegno   	:(InfoObj *) _info                 {
	VersioneSoftware = 100; // prima versione
	fuso=2;
	proiezionedisegno=0;  // utm
	eventuale_xc=0;	        eventuale_yc=0;	        eventuale_ang=0;	    eventuale_scala=1.0;
	eventuale_offx=0;	    eventuale_offy=0;	
	
	eventuale_codice1=0;	eventuale_codice2=0;	eventuale_codice3=0;
	
	D_info=_info;
	ListaPiani = [[NSMutableArray alloc] init];
	b_visibiledisegno    = YES;
	b_editabiledisegno   = YES;
    b_snappabiledisegno  = YES;
	f_alfalineedisegno     = 1.0;    f_alfasuperficidisegno = 0.5;
	i_xorigine_vector = 0; 	i_yorigine_vector = 0;
	_piano = [Piano alloc]; [_piano InitPiano:self:D_info]; 	[ListaPiani addObject:_piano];
	[self setpianocorrente:0];
	nomedisegno=@"";

	numtratteggi =0;
	
    Exorigine =eventuale_offx;
    Eyorigine =eventuale_offy;
    Escala = eventuale_scala;
    Eanglerot = eventuale_ang;
	Ex_xc=0;
	Ex_yc=0;

    Centrato=NO; movedX=NO;    movedY=NO;    Roted=NO;    Scaled=NO;

 }

- (void)    FissaUndoSeNonRotScaDisegno: (NSUndoManager  *) MUndor : (double) xc : (double) yc {
	if  (( (eventuale_offx==0) & (eventuale_offy==0)  & (eventuale_ang==0) & (eventuale_scala==1) ) |
         ( (Ex_xc!=xc) | (Ex_yc!=yc)  ) ) 
	{	[[MUndor prepareWithInvocationTarget:self] EseguiUndoEventuali];	}
}


- (void)    EseguiUndoEventuali {
	
}

- (void)    impostaUndoRot             : (NSUndoManager  *) MUndor  {
    if (!Roted) { [[MUndor prepareWithInvocationTarget:self] EseguiUndoRot];	Roted=YES;   }
}

- (void)    impostaUndoSca             : (NSUndoManager  *) MUndor  {
    if (!Scaled) { [[MUndor prepareWithInvocationTarget:self] EseguiUndoSca];	Scaled=YES;   }
}

- (void)    impostaUndoOrigineX        : (NSUndoManager  *) MUndor  {
    if (!movedX) { [[MUndor prepareWithInvocationTarget:self] EseguiUndoOffX];	movedX=YES;   }
}

- (void)    impostaUndoOrigineY        : (NSUndoManager  *) MUndor  {
    if (!movedY) { [[MUndor prepareWithInvocationTarget:self] EseguiUndoOffY];	movedY=YES;   }
}



- (void)    EseguiUndoRot  {
    [self RuotaDisegnoang  :eventuale_xc : eventuale_yc : -eventuale_ang  ];    eventuale_ang=0;  Roted=NO;
}


- (void)    EseguiUndoSca  {
    [self ScalaDisegnoPar  :eventuale_xc : eventuale_yc : 1/eventuale_scala  ];    eventuale_scala=1;  Scaled=NO;
}



- (void)    EseguiUndoOffX {
    [self SpostaDisegnodxdy  :-eventuale_offx : 0  ];    eventuale_offx=0;    movedX=NO;
}

- (void) EseguiUndoOffY {
    [self SpostaDisegnodxdy  :0 : -eventuale_offy  ];    eventuale_offy=0;    movedY=NO;
}


- (void)       setnomedisegno     :(NSString *)   _nome   {
	[nomedisegno release];	    nomedisegno = _nome; [nomedisegno retain];
}

- (NSString *) nomedisegno {
	return nomedisegno;
}

- (NSString *) Solonomedisegno {
	return [nomedisegno lastPathComponent];
}

- (NSString *) SolonomedisegnoNoext {
	return [[nomedisegno lastPathComponent] stringByDeletingPathExtension];
}


- (NSString *) nomeFoglioCXF {
	NSRange myrange;
	unichar cicco;
	myrange.location=6;    myrange.length =3;
	cicco = [[nomedisegno  lastPathComponent ] characterAtIndex:6];
	if (cicco==48) { myrange.location=7;    myrange.length =2;
		cicco = [[nomedisegno  lastPathComponent ] characterAtIndex:7];
		if (cicco==48) { myrange.location=8;    myrange.length =1;}
	}
	return [[nomedisegno lastPathComponent ] substringWithRange:myrange];
}


- (void) RemoveDisegno   {
	
	Piano *locpiano;
	for (int i=ListaPiani.count-1; i>=0; i--) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano smemora];
	}
	
}

- (void) addpiano        {
	_piano = [Piano alloc];    [_piano InitPiano:self:D_info]; 	[ListaPiani addObject:_piano];
}

- (void)   faiLimiti     {
	bool todid=YES;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];        [locpiano faiLimiti];
		if ( ( [locpiano limx1] == [locpiano limx2] ) & ( [locpiano limy1] == [locpiano limy2] ) ) continue;
        if (todid) { 
			limx1=[locpiano limx1];	   limx2=[locpiano limx2]; 	   
			limy1=[locpiano limy1];	   limy2=[locpiano limy2]; 
			todid=NO;
		}
		 else
		{
			if (limx1>[locpiano limx1])   limx1=[locpiano limx1];	
			if (limy1>[locpiano limy1])   limy1=[locpiano limy1];	 
			if (limx2<[locpiano limx2])   limx2=[locpiano limx2];	 
			if (limy2<[locpiano limy2])   limy2=[locpiano limy2];	 
		}
	}
}
- (double) limx1      {return limx1; };
- (double) limy1      {return limy1; };
- (double) limx2      {return limx2; };
- (double) limy2      {return limy2; };




- (double) dimptPianoInd : (int) indice{
	Piano    *locpiano;
    locpiano = [ListaPiani objectAtIndex:indice];
	return [locpiano dimpunto]; 
}

- (void) SetdimptPianoInd : (double) valore  : (int) indice{
	Piano    *locpiano;
    locpiano = [ListaPiani objectAtIndex:indice];
	[locpiano setdimpunto:valore];
}



- (void)   updateInfoConLimiti            {
	[self    faiLimiti];
	[D_info  setLimitiDisV :limx1 : limy1 : limx2 : limy2];
}

- (void)   updateInfoConLimitiPianoCorrente  {
	[self faiLimiti];
	[D_info  setLimitiPiano :[_pianocorrente limx1] : [_pianocorrente limy1] : [_pianocorrente limx2] : [_pianocorrente limy2]];
}



- (int)    damminumpiani   {return [ListaPiani count]; }


- (float) alphaline   {return f_alfalineedisegno; }

- (float) alphasup    {return f_alfasuperficidisegno; }

- (void)  setalphaline  :(float) _value {
	f_alfalineedisegno=_value;
}

- (void)  setalphasup   :(float) _value {
	f_alfasuperficidisegno=_value;
}



- (float) alphalinepiano:(int)_indpiano {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	return [locpiano getalphaline];
}

- (float) alphasuppiano :(int)_indpiano {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	return [locpiano getalphasup];
}


- (void)  setalphalinepiano:(int)_indpiano: (float) _value{
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setalphaline :_value];
}

- (void)  setalphasuppiano :(int)_indpiano: (float) _value{
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setalphasup :_value];
}


- (float) colorepianoind_r:(int)_indpiano  {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	return [locpiano colorepiano_r];
}

- (float) colorepianoind_g:(int)_indpiano  {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	return [locpiano colorepiano_g];
}

- (float) colorepianoind_b:(int)_indpiano  {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	return [locpiano colorepiano_b];
}

- (void)  setcolorepianorgb:(int)_indpiano: (float) _r : (float) _g : (float) _b  { 
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setcolorpianorgb:_r :_g :_b];
}


- (NSString *) givemenomepianocorrente                                              { return [_pianocorrente givemenomepiano];}


// - (Vettoriale *) dammiUltimoPoligono                                                { return [_pianocorrente dammiUltimoPoligono];}

- (void)       setnomepianoind     :(NSString *)   _nome:(int)   indice{
	Piano    *locpiano;
    locpiano = [ListaPiani objectAtIndex:indice];
	[locpiano setnomepiano:_nome];
}

- (NSString *) givemecommentopianocorrente                                          { return [_piano givecommentomepiano];}

- (NSString *) givemenomepianoindice:(int)indice                                    { 
  	Piano    *locpiano;
    locpiano = [ListaPiani objectAtIndex:indice];
	return [locpiano givemenomepiano];
}


- (void) Disegna:(CGContextRef) hdc                                                 {

	if (!b_visibiledisegno) return;

			if ([D_info xorigineVista] >limx2) {		return;	}
			if ([D_info x2origineVista]<limx1) {		return;	}
			if ([D_info yorigineVista] >limy2) {		return;	}
			if ([D_info y2origineVista]<limy1) {		return;	}
	
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano Disegna:hdc : f_alfalineedisegno : f_alfasuperficidisegno];
	}
	
	
}

- (void)   DisSpostaDisegno : (CGContextRef) hdc : (double) dx : (double) dy{

	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if (![locpiano visibile]) continue;
		[locpiano DisSpostaPiano :hdc : dx : dy];
	}

        //	[self faiLimiti];
}

- (void)   DisRuotaDisegno  : (CGContextRef) hdc : (double) xc : (double) yc: (double) ang{
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano DisRuotaPiano :hdc : xc : yc : ang];
	}
}

- (void)   DisScalaDisegno  : (CGContextRef) hdc : (double) xc : (double) yc: (double) scal{
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano DisScalaPiano :hdc : xc : yc : scal];
	}
}

- (void)   Distxtvirtual    : (CGContextRef) hdc : (double) xc : (double) yc: (double) ang: (double) scal{
	[_pianocorrente Distxtvirtual    : hdc  : xc : yc : ang : scal];
}


- (void) DisegnaSplineVirtuale: (CGContextRef) hdc :(int) x1: (int) y1              {
	[_pianocorrente DisegnaSplineVirtuale: hdc:x1:y1];
}



- (void) disegnailpianino :(CGContextRef) hdc         : (NSRect) fondo              {
    _pianocorrente= [ ListaPiani objectAtIndex:indicePianocorrente];
	[_pianocorrente disegnailpianino :hdc :fondo];
}

- (void) dispallinispline:(CGContextRef) hdc                                        {
	if (![self visibile]) return ;
	[_pianocorrente dispallinispline :hdc];
}


- (void)   disVtTutti                                 : (CGContextRef) hdc          {
	if (![self visibile]) return ;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
			[locpiano disegnavtpl :hdc];
	}
}


- (bool) snapFine           : (double) x1 : (double) y1                             {
	

	bool locres=NO;
	if (!b_visibiledisegno) return locres;
	if (!b_snappabiledisegno) return locres;
	

	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		locres = [locpiano snapFine : x1 : y1];
		if (locres) break;
	}
	

	
	
	return locres;
}

- (bool) snapVicino         : (double) x1 : (double) y1                             {
	bool locres=NO;
	if (!b_visibiledisegno) return locres;
	if (!b_snappabiledisegno) return locres;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		locres = [locpiano snapVicino  : x1 : y1];
		if (locres) break;
	}
  return locres;
}

- (void) ortosegmenta       : (double) x1 : (double) y1                             {
	[_pianocorrente ortosegmenta :x1:y1];
}

- (void) seleziona_conPt: (CGContextRef) hdc :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati   {
	if (![self visibile]) return ;
	if (![self editabile]) return ;

	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        [locpiano seleziona_conPt: hdc: x1 : y1 : _LSelezionati ];
	}
}

- (void) seleziona_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati  {
	if (![self visibile]) return ;
	if (![self editabile]) return ;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        [locpiano seleziona_conPtInterno: hdc: x1 : y1 : _LSelezionati ];
	}
}


- (void)   selezionaEdif_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati {
	if (![self visibile]) return ;
		//	if (![self editabile]) return ;  o snappabile?
	NSString *estensioneFile = [[nomedisegno pathExtension] uppercaseString];
	if (![estensioneFile isEqualToString:@"CXF"])  return; 
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"] | [[locpiano givemenomepiano] isEqualToString:@"STRADA"] ) continue;
			//		if ([locpiano  pianoPlus]) 
			[locpiano seleziona_conPtInterno: hdc: x1 : y1 : _LSelezionati ];
	}
	
		// ripulire selezionati edifici se questi non hanno record corrispondente specie se terreni
}

- (void)   selezionaTerre_conPtInterno : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati {
	if (![self visibile]) return ;
		//	if (![self snappabile]) return ; o editabile?
	NSString *estensioneFile = [[nomedisegno pathExtension] uppercaseString];
	if (![estensioneFile isEqualToString:@"CXF"])  return; 
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"] | [[locpiano givemenomepiano] isEqualToString:@"STRADA"] ) continue;
		if ([locpiano pianoPlus]) {	continue; }
		[locpiano seleziona_conPtInterno: hdc: x1 : y1 : _LSelezionati ];
	}
}


- (bool) selezionaVtconPt   : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati {
	bool locres=NO;
	if (![self visibile]) return NO;
	if (![self editabile]) return NO;

	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([locpiano selezionaVtconPt: hdc: x1 : y1 : _LSelezionati ])   { locres=YES; break; }
	}
	return locres;
}

- (bool) selezionaVtspconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati {
	bool locres=NO;
	if (![self visibile]) return NO;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([locpiano selezionaVtspconPt: hdc: x1 : y1 : _LSelezionati ])   { locres=YES; break; }
	}
	return locres;
}


- (NSString *) infopianocorrente                           {
	_pianocorrente = [ ListaPiani objectAtIndex:indicePianocorrente];
	return [_pianocorrente infopiano];
}

- (NSString *) infodisegno {
	int  i_Punti, i_Pline, i_Poligoni, i_Regioni, i_SPline, i_SPoligoni, i_SRegioni;
	int  i_Cerchi, i_Testi, i_Simboli, i_Arco, i_Vt;

	i_Punti=0;      i_Pline=0;      i_Poligoni=0;  i_Regioni=0;  i_SPline=0;    
	i_SPoligoni=0;  i_SRegioni=0;   i_Cerchi=0;    i_Testi=0;    i_Simboli=0; i_Arco=0; i_Vt=0;	
	
	
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];		[locpiano qualiquantiobjpiano];
		i_Punti     = i_Punti    + [locpiano i_Punti] ;      
		i_Pline     = i_Pline    + [locpiano i_PLine] ;            
		i_Poligoni  = i_Poligoni + [locpiano i_Poligoni] ;      
		i_Regioni   = i_Regioni  + [locpiano i_Regioni] ;      
		i_SPline    = i_SPline   + [locpiano i_SPline] ;      
		i_SPoligoni = i_SPoligoni+ [locpiano i_SPoligoni] ;      
		i_SRegioni  = i_SRegioni + [locpiano i_SRegioni] ;      
		i_Cerchi    = i_Cerchi   + [locpiano i_Cerchi] ;      
		i_Testi     = i_Testi    + [locpiano i_Testi] ;      
		i_Simboli   = i_Simboli  + [locpiano i_Simboli] ;      
		i_Arco      = i_Arco     + [locpiano i_Arco] ;      
		i_Vt        = i_Vt       + [locpiano i_Vt] ;      
			//		NSLog(@"-%d ",i_Poligoni);
	}

	NSString *Str;
	Str = @"";     	
	Str = [Str stringByAppendingFormat:	 @"Pt:%d Pl:%d Pol:%d Rg:%d Ce:%d Tx:%d Si:%d Ar:%d   Vt:%d",
		    i_Punti, i_Pline, i_Poligoni, i_Regioni, i_Cerchi, i_Testi, i_Simboli , i_Arco , i_Vt ];
	return Str;
}


- (NSString *) nomepoligonopt     : (double) xc    : (double) yc {
	NSString * locres = nil;
		//
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		locres = [locpiano nomepoligonopt :xc :yc ];
		if (locres!=nil) break;
	}
	
	
	return locres;
}


- (bool) Match_conPt      : (double) x1     : (double) y1  {
	if (![self visibile]) return NO;
	if (![self editabile]) return NO;
	
	
	bool locres=NO;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([locpiano Match_conPt : x1 : y1  ]) {
			// qui metti il pianocome corrente dell'attuale disegno
			[self setpianocorrente :i];
			locres=YES; break; };
	}
	return locres;
}


- (NSMutableString *) leggirigafile: (NSString *) _fileContents: (int) _i_filepos                   {
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];
 	unichar c=0;
	while(c!=13) {  
		c=	[_fileContents characterAtIndex:_i_filepos];
		_i_filepos++;
		if (c==13)  { _i_filepos++; i_filepos=_i_filepos; return risulta ;  }
		if (c==10)  { i_filepos=_i_filepos; return risulta ;   }
		else {  [risulta appendFormat:	 @"%C", c];	
					} // togli il punto
    }	
	i_filepos=_i_filepos;
	return risulta;	
}

- (NSMutableString *) rigasenzaspazi: (NSString *) riga         {
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
 	unichar c=0;
	for (int i=0; i<[riga length]; i++) {  
		c=	[riga characterAtIndex:i];
		if (c==13)  { return risulta ;  }
		if (c==10)  { return risulta ;  }
		else { if (c!=32) 	[risulta appendFormat:	 @"%C", c];	} 
    }	
	return risulta;	
}


- (NSMutableString *) leggirigafilesenzaspazi: (NSString *) _fileContents: (int) _i_filepos         {
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];
 	unichar c=0;
	while(c!=13) {  
		c=	[_fileContents characterAtIndex:_i_filepos];
		_i_filepos++;
		if (c==13)  { _i_filepos++; i_filepos=_i_filepos; return risulta ;  }
		if (c==10)  { i_filepos=_i_filepos; return risulta ;   }
		else { if (c!=32) 	[risulta appendFormat:	 @"%C", c];	} 
    }	
	i_filepos=_i_filepos;
	return risulta;	
}

- (NSMutableArray *) ListaPiani                            {
	return ListaPiani;
}


- (NSArray  *) righetestofile : (NSString *) nomefile {
	NSFileHandle *fileHandle;
	NSMutableString *buffer;
	fileHandle = [NSFileHandle fileHandleForReadingAtPath:nomefile];
	if (fileHandle==nil) return nil;
		//	NSData *data = [fileHandle availableData];
		//     NSLog(@"Data %lu",[data length]);
	
		//	NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		//		NSLog(@"str %lu",[str length]);
	
	NSString * str = [NSString stringWithContentsOfFile:nomefile encoding:1 error:NULL];
		//	NSLog(@"Data %@",str2);
	
	
	buffer =[[NSMutableString alloc] init];
	[buffer appendString:str];
		//	[str release];
	return [buffer componentsSeparatedByString:@"\n"];
}




- (void) addLayerCorrente : (NSString *)   _nome                                    {
	Piano *locpiano;
	bool todo = YES;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
	 if ([[locpiano givemenomepiano] isEqualToString:_nome]) {	 todo = NO;	 [self setpianocorrente:i];	 break;	 }
	}
	if (todo) {
		_piano = [Piano alloc]; [_piano InitPiano:self:D_info]; [_piano setnomepiano:_nome];    [ListaPiani addObject:_piano];
		[self setpianocorrente:([ListaPiani count]-1)];
	}
}


- (void) apriDisegnoShp   : (NSString *)   _nomedisegno  : (NSMutableArray *) defsimbol {
	
	[self addLayerCorrente:[[_nomedisegno lastPathComponent  ]   stringByDeletingPathExtension]];

	[_pianocorrente shpin: _nomedisegno];
	
	
	
}



- (void) apriDisegnoDxf   : (NSString *)   _nomedisegno  : (NSMutableArray *) defsimbol {
	
	bool toglicrt = YES;
	NSLog(@"Started dxfin prerighe");
	NSLog(@"%@ dxfin prerighe",_nomedisegno);

	NSArray *Righe = [self righetestofile : _nomedisegno];
	int rigacorrente =0;
	NSLog(@"Started dxfin postrighe");

		//			NSString *fileContents;
    int tipoelemento;
    
	[self setnomedisegno :_nomedisegno];
	NSString * tt;
	NSLog(@"Started dxfin");
		//	NSError **er;
	int lunghezza; int indcolor;
	bool faseEntity = NO;
		//			fileContents = [NSString  stringWithContentsOfFile:_nomedisegno encoding:NSASCIIStringEncoding error:er];
		//      int limite=100000;
		//	lunghezza = [fileContents length];
	lunghezza = [Righe count];       

	i_filepos=0;
	NSLog(@"file lungo %d",lunghezza);
		//	while (i_filepos<lunghezza) {
	while (rigacorrente<lunghezza) {
		tt=@"";
			//		tt= [self leggirigafile:fileContents:i_filepos];
		tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;
		if ([tt isEqualToString:@"EOF"]) break;

		if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
			//		NSLog(@"%d %@",rigacorrente,tt);

		
		if ([tt isEqualToString:@"EOF"]) break;
         
			//		if (rigacorrente>limite) {	NSLog(@"%d %d",rigacorrente, lunghezza); limite = limite + 100000;   }

		if ([tt isEqualToString:@"LAYER"])  {
				//		NSLog(@"Entra %d %@ %d %d %d",rigacorrente,tt,rg.length,rg.location,[tt length]);


		 	while ((![tt isEqualToString:@"  0"]) & (![tt isEqualToString:@"   0"])) {	
				tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;
				if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
					//				tt= [self leggirigafile:fileContents:i_filepos];
		  	    if ([tt isEqualToString:@"  2"])	{ 
					tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;
					if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
					[self addLayerCorrente:tt];		
				}
				if ([tt isEqualToString:@" 62"])	{
					tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;	if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
					indcolor = [tt intValue];	rigacorrente++;			
					switch (indcolor) {
						case 1:	[self setcolorepianorgb:indicePianocorrente: 1.0 : 0.0 : 0.0];	break;
						case 2:	[self setcolorepianorgb:indicePianocorrente: 1.0 : 1.0 : 0.0];	break;
						case 3:	[self setcolorepianorgb:indicePianocorrente: 0.0 : 1.0 : 0.0];	break;
						case 4:	[self setcolorepianorgb:indicePianocorrente: 0.0 : 1.0 : 1.0];	break;
						case 5:	[self setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 : 1.0];	break;
						case 6:	[self setcolorepianorgb:indicePianocorrente: 1.0 : 0.0 : 1.0];	break;
						case 7:	[self setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 : 0.0];	break;
						case 8:	[self setcolorepianorgb:indicePianocorrente: 0.5 : 0.5 : 0.5];	break;
						case 9:	[self setcolorepianorgb:indicePianocorrente: 0.7 : 0.7 : 0.7];	break;
						default:	break;
					}
			}
			}
			// qui leggere il piano ... nome e colore.
		};

		
        if ([tt isEqualToString:@"ENTITIES"])  { faseEntity = YES;  }; //continue;
		while (faseEntity) {
			tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;
			if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];

				//			NSLog(@"- - %@",tt);
				//			if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];

			if ([tt isEqualToString:@"  0"])	{
				tt=@""; 
				tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++; if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
					//			NSLog(@"%@ %d",tt,rigacorrente);
					//				return;
			}
			

			if ([tt isEqualToString:@"ENDSEC"])	{faseEntity = NO; NSLog(@"USCITO DA ENTITA"); continue; }
            
            if ([tt isEqualToString:@"POINT"])      { tipoelemento= 1;  }
			if ([tt isEqualToString:@"INSERT"])     { tipoelemento= 4;  }
			if ([tt isEqualToString:@"LINE"])       { tipoelemento=20;  }
	
			if ([tt isEqualToString:@"VERTEX"])     { tipoelemento=101;  }
			if ([tt isEqualToString:@"POLYLINE"])   { tipoelemento= 2;  }
			if ([tt isEqualToString:@"CIRCLE"])     { tipoelemento= 5;  }
		    if ([tt isEqualToString:@"SEQEND"])     { tipoelemento= 3;  }
			if ([tt isEqualToString:@"TEXT"])       { tipoelemento= 6;  }
                //		if ([tt isEqualToString:@"ARC"])        { tipoelemento= 7;  }
			if ([tt isEqualToString:@"LWPOLYLINE"]) { tipoelemento= 1000;  } 
			if ([tt isEqualToString:@"HATCH"])      { tipoelemento= 1001;  } 

            if ([tt isEqualToString:@"  8"])	{
					//		NSLog(@"%d %@",rigacorrente,tt);

				tt=@""; 
					//				tt= [self leggirigafile:fileContents:i_filepos];
				tt= [Righe objectAtIndex:rigacorrente]; rigacorrente++;	if (toglicrt) tt = [tt substringToIndex:([tt length]-1)];
					//				NSLog(@"%d %@",rigacorrente,tt);

				[self addLayerCorrente:tt];  
				[_pianocorrente dxfinPianoK:Righe:&rigacorrente:defsimbol:tipoelemento:toglicrt];
				
				tipoelemento =0;
					//		if (tipoelemento ==1000) return;
					//                i_filepos=[_pianocorrente dxfinPiano:fileContents:i_filepos:defsimbol:tipoelemento];
                    //                continue;	 
					//			return;
            }
 
            
		}
		
	}
			NSLog(@"finito   %d",rigacorrente);
}


- (void) SalvaDisegnoDxf  : (NSString *)   _nomedisegno                                 {
	//
	NSString *Strdxf;	Strdxf = @"";       

    Strdxf = [Strdxf stringByAppendingString:@"  0\n"];
	Strdxf = [Strdxf stringByAppendingString:@"SECTION\n"];
    Strdxf = [Strdxf stringByAppendingString:@"  2\n"];
    Strdxf = [Strdxf stringByAppendingString:@"ENTITIES\n"];
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		Strdxf = [Strdxf stringByAppendingString:[locpiano salvadxf]];
	}
	
    Strdxf = [Strdxf stringByAppendingString:@"  0\n"];
	Strdxf = [Strdxf stringByAppendingString:@"ENDSEC\n"];
    Strdxf = [Strdxf stringByAppendingString:@"  0\n"];
    Strdxf = [Strdxf stringByAppendingString:@"EOF\n"];
	

	
	_nomedisegno = [_nomedisegno stringByAppendingString:@".dxf"];
	
	[Strdxf writeToFile :_nomedisegno atomically:YES encoding:NSASCIIStringEncoding error:NULL];
//	[Strdxf writeToFile :_nomedisegno atomically:YES];

}


- (NSString *) prendirigapulita : (int *) indice : (NSArray * ) Lista {
	*indice = *indice+1;
	return [[Lista objectAtIndex:(*indice)-1] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet ]];	
}

- (void) apriDisegnoCxf   : (NSString *)   _nomedisegno :(NSMutableArray *) defsimbol {

	[self setnomedisegno :_nomedisegno];
	
		//	NSString *fileContents;
	NSString *tt=nil;
	NSString *tt2=nil;
	NSString *ttnomemappa = [[_nomedisegno lastPathComponent] stringByDeletingPathExtension];
		//	NSError **er;
		//   int lunghezza;
		//	fileContents = [NSString  stringWithContentsOfFile:_nomedisegno encoding:NSASCIIStringEncoding error:er];

	NSArray *RigheFile = [self righetestofile : _nomedisegno];

		//	NSArray * RigheFile = [fileContents componentsSeparatedByString:@"\n"];
	int rigacorrente =0;
	
		//	[fileContents autorelease];
		//    lunghezza = [fileContents length];       
	i_filepos=0;
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // mappa
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // nomemappa
		//	tt= [self leggirigafile:fileContents:i_filepos];	 // scala originale
	
	rigacorrente = 3;
	while (rigacorrente<[RigheFile count]) {
			//		if (tt!=nil) { [tt release]; tt=nil;	}
		tt= [self prendirigapulita : &rigacorrente :RigheFile]; //  [RigheFile objectAtIndex:rigacorrente];	 rigacorrente++;
																//	NSLog(@"-- cxf %d %@ ", rigacorrente,tt);
		if ( ( [tt isEqualToString:@"BORDO"]) | ([tt isEqualToString:@"LINEA"]) | ([tt isEqualToString:@"TESTO"])  
			| ([tt isEqualToString:@"LINEA\\"]) | ([tt isEqualToString:@"TESTO\\"]) | ([tt isEqualToString:@"FIDUCIALE"]) | ([tt isEqualToString:@"SIMBOLO"] )  
			) {
			if ([tt isEqualToString:@"BORDO"]) {
				tt2= [self rigasenzaspazi:[RigheFile objectAtIndex:rigacorrente]]; rigacorrente++; } 	// nome piano;
			if ([tt isEqualToString:@"LINEA"])	    tt2= @"Linea";
			if ([tt isEqualToString:@"LINEA\\"])	tt2= @"LineaExt";
			if ([tt isEqualToString:@"TESTO"])	    tt2= @"Testo";
			if ([tt isEqualToString:@"TESTO\\"])	tt2= @"TestoExt";
			if ([tt isEqualToString:@"FIDUCIALE"])	tt2= @"Fiduciale";
			if ([tt isEqualToString:@"SIMBOLO"])	tt2= @"Simboli";
			[self addLayerCorrente:tt2];
			[self setalphasuppiano :indicePianocorrente: 0.4];
			[self  setcolorepianorgb:indicePianocorrente: 1.0 : 1.0 :1.0 ];	
			if ([tt2 isEqualToString:@"Y901"]) { // patch di Allumiere foglio 23
				[self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 :0.7843 ];	
				[self  setvisibilepiano :indicePianocorrente:NO];
			}
			if ([tt2 isEqualToString:ttnomemappa]) {
				[self setalphasuppiano :indicePianocorrente: 0.3];
				[self setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 :0.0 ];	
			}
            if ([tt2 isEqualToString:@"ACQUA"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0    : 1.0];	
				[self  setspessorepiano :indicePianocorrente     :0.6];
				[self setalphasuppiano :indicePianocorrente: 0.3];
				[self setalphalinepiano:indicePianocorrente: 0.5];
			}
			if ([tt2 isEqualToString:@"STRADA"]) {
				[self  setcolorepianorgb:indicePianocorrente: 1.0 : 0.5882 : 0.0];	
				[self  setspessorepiano :indicePianocorrente     :0.6];
			}
			if ([tt2 isEqualToString:@"Linea"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0    : 0.0];	
				[self setalphalinepiano:indicePianocorrente: 0.1];
				[self  setspessorepiano :indicePianocorrente     :0.6];
				[self  setvisibilepiano : indicePianocorrente     :NO];
			}
			if ([tt2 isEqualToString:@"LineaExt"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0    : 0.0];	
				[self setalphalinepiano:indicePianocorrente: 0.1];
				[self  setspessorepiano : indicePianocorrente     :0.6];
				[self  setvisibilepiano : indicePianocorrente     :NO];
			}
			
			if ([tt2 isEqualToString:@"Testo"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0    : 0.0];	
				[self setalphalinepiano:indicePianocorrente: 0.1];
				[self  setspessorepiano :indicePianocorrente     :0.6];
				[self  seteditabilepiano: indicePianocorrente     :NO];
				[self  setsnappabilepiano:indicePianocorrente     :NO];
				[self  setvisibilepiano : indicePianocorrente     :NO];
				
			}
			if ([tt2 isEqualToString:@"TestoExt"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 0.0 : 0.0    : 0.0];	
				[self setalphalinepiano:indicePianocorrente: 1.0];
				[self  setspessorepiano :indicePianocorrente     :0.6];
				[self  setvisibilepiano: indicePianocorrente     :NO];
				[self  seteditabilepiano: indicePianocorrente     :NO];
				[self  setsnappabilepiano:indicePianocorrente     :NO];
			}
			
			if ([tt2 isEqualToString:@"Fiduciale"])  {
			    [self  setcolorepianorgb:indicePianocorrente: 1.0 : 0.0    : 1.0];	
				[self setalphalinepiano:indicePianocorrente: 1.0];
				[self  setspessorepiano :indicePianocorrente     :2.0];
				[self  seteditabilepiano: indicePianocorrente     :NO];
				[self  setsnappabilepiano:indicePianocorrente     :NO];
				[self  setvisibilepiano: indicePianocorrente      :NO];
			}
			
			if ([tt2 isEqualToString:@"Simboli"])  {
			    [self setcolorepianorgb:indicePianocorrente : 0.0 : 0.0    : 0.5];	
				[self setalphalinepiano:indicePianocorrente : 1.0];
				[self setspessorepiano :indicePianocorrente : 0.6];
				[self  seteditabilepiano: indicePianocorrente     :NO];
				[self  setsnappabilepiano:indicePianocorrente     :NO];
			}
			NSRange myrange;
			myrange.location=[tt2 length]-1;    myrange.length = 1;
			if ([tt2 compare:@"+" options:NSCaseInsensitiveSearch range:myrange] ==0)    {
				[self setcolorepianorgb:indicePianocorrente: 0.0 : 0.0 : 0.0];	
				[self setalphasuppiano :indicePianocorrente: 0.8];
			}
			[_pianocorrente cxfinPiano2:RigheFile :&rigacorrente :tt :defsimbol ];		
		}
		
	}
		////////////// --------------------------------------   /////////////////////////////////
		//	[fileContents release];
	[self RiordinaPianiAlfateticamente];
	[self setpianocorrente:0];
	[self seteditabilepiano  :1 :NO];
	[self setvisibilepiano   :1 :NO];
		//	[self seteditabile :NO];
	[self    faiLimiti];
}




// elementi grafici introdotti

- (void) faipunto       : (CGContextRef) hdc: (double) x1 : (double) y1    : (NSUndoManager  *) MUndor    {
    [_pianocorrente faipunto    : hdc  : x1 : y1 :MUndor];
}

- (void) faiplinea      : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom  : (NSUndoManager  *) MUndor               {
    [_pianocorrente faiplinea   : hdc  : x1 : y1 :fasecom :MUndor ];
}

- (void) faisplinea     : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom                {
    [_pianocorrente faisplinea   : hdc  : x1 : y1 :fasecom];
}

- (void) faisimbolo     : (CGContextRef) hdc: (double) x1 : (double) y1: (int) indice :(bool) dimfissa: (NSMutableArray *) listadefinizioni : (NSUndoManager  *) MUndor {
    [_pianocorrente faisimbolo  : hdc  : x1 : y1 : indice :dimfissa : listadefinizioni :MUndor];
}

- (void) ruotasimbolo   : (CGContextRef) hdc: (double) rot {
	[_pianocorrente   ruotasimbolo :hdc : rot];
}

- (void) scalasimbolo   : (CGContextRef) hdc: (double) sca {
	[_pianocorrente scalasimbolo : hdc : sca];
}

- (void) faipoligono    : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom                {
    [_pianocorrente faipoligono : hdc  : x1 : y1 :fasecom];
}

- (void) faispoligono   : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom                {
    [_pianocorrente faispoligono : hdc  : x1 : y1 :fasecom];
}

- (void) faisregione    : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom: (int) fasereg {
    [_pianocorrente faisregione  : hdc  : x1 : y1 :fasecom:fasereg];
}

- (void) fairegione     : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom: (int) fasereg {
    [_pianocorrente fairegione : hdc  : x1 : y1 :fasecom :fasereg];
}

- (void) faitesto       : (CGContextRef) hdc:(double) x1 : (double) y1: (double) ht:  (double) ang : (NSString *) txttesto  : (NSUndoManager  *) MUndor{
	[_pianocorrente faitesto    : hdc  : x1 : y1 :ht : ang : txttesto:MUndor];
}

- (void) faitestovirtuale : (double) ht:  (double) ang : (NSString *) txttesto {
	[_pianocorrente faitestovirtuale    :ht : ang : txttesto];
}


- (bool) faiCatpoligono : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom : (DisegnoV *) disVcomp  {
	bool resulta=NO;
	resulta = [_pianocorrente faiCatpoligono : hdc  : x1 : y1 :fasecom:disVcomp];
	return resulta;
}

- (void)   BackPlineaAdded {
	[_pianocorrente BackPlineaAdded];
}


- (void) SpostaDisegnodxdy  : (double) dx    : (double) dy                                          {
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano SpostaPiano :dx :dy];
	}
    
    limx1 = limx1+ dx; limx2 = limx2 + dx;
    limy1 = limy1+ dy; limy2 = limy2 + dy;

}

- (void) RuotaDisegnodxdy   : (double) xc    : (double) yc :  (double) xc2 :  (double)  yc2         {
	Piano *locpiano;
	double angrot;	double dx,dy;
	dx = xc2-xc;	dy = yc2-yc; 
	if ((dx==0)  & (dy==0)) return;
	if (dx==0) { angrot = M_PI/2;             if (dy<0) angrot += M_PI;  } else 
	{ angrot = atan( dy / dx );    if (dx<0) angrot = M_PI+angrot; if (angrot<0) angrot += 2*M_PI;	}

	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano RuotaPiano :xc :yc: angrot];
	}
}	

- (void) RuotaDisegnoang  : (double) xc    : (double) yc :  (double) ang                            {
    eventuale_xc = xc;    eventuale_yc = yc;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano RuotaPiano :xc :yc: ang];
	}
}	



- (void) ScalaDisegno       : (double) xc    : (double) yc :  (double) xc2 :  (double)  yc2         {
	Piano *locpiano;
	double dx,dy,ddt;
	dx = xc2-xc;	dy = yc2-yc; 
	if ((dx==0)  & (dy==0)) return;
	ddt = hypot( dx, dy )/100;
	ddt = scala2verticischermo   (xc,yc,xc2,yc2,[D_info dimxVista]*[D_info scalaVista] );
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano ScalaPiano :xc :yc: ddt];
	}
}	

- (void)   ScalaDisegnoPar  : (double) xc    : (double) yc :  (double) par  {
    eventuale_xc = xc;    eventuale_yc = yc;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano ScalaPiano :xc :yc: par];
	}
}	


- (void) risistevavirtspline : (int *) x1                                                           {
//	x1=0; y1=0;
}

- (void) finitaPolilinea: (CGContextRef) hdc    : (NSUndoManager  *) MUndor                          {
	[_pianocorrente finitaPolilinea :hdc:MUndor];
}

- (void) chiudipoligono : (CGContextRef) hdc    : (NSUndoManager  *) MUndor                         {
	[_pianocorrente chiudipoligono :hdc:MUndor];
}

- (void) updateEventualeRegione : (CGContextRef) hdc    : (NSUndoManager  *) MUndor                         {
	[_pianocorrente updateEventualeRegione :hdc:MUndor];
}

- (void) faicerchio     : (CGContextRef) hdc  :(double) x1 : (double) y1: (double) x2 : (double) y2 : (NSUndoManager  *) MUndor {
    [_pianocorrente faicerchio    : hdc  : x1 : y1 : x2 : y2 : MUndor];
}

- (void) fairettangolo  : (CGContextRef) hdc  :(double) x1 : (double) y1: (double) x2 : (double) y2 : (NSUndoManager  *) MUndor {
    [_pianocorrente fairettangolo    : hdc  : x1 : y1 : x2 : y2 :MUndor];
}

- (void) cancellaultimovt                                          {
	[_pianocorrente cancellaultimovt];
}



- (void) cambianomedbase    : (NSString *)   _newtext              {
	[_newtext retain];  [nomedbaseDisegno release];	    nomedbaseDisegno = _newtext;
}

- (void) cambianomeTavola    : (NSString *)   _newtext             {
	[_newtext retain];  [nometavolaDisegno release];	nometavolaDisegno = _newtext;
}



- (void) apriDisegnoMoM : (NSString *) _nomedisegno   : (NSMutableArray *) defsimbol              {

	int lungstr;     unichar ilcar;
        //  NSLog(@"apro %@ ",_nomedisegno);
        //   NSFileHandle *fileHandle;
	unsigned long long posfile;
	NSData *_data;
	
	NSUInteger posdata;
    posdata =0;
	_data = [NSData dataWithContentsOfFile:_nomedisegno];

    limx1=0;	limy1=0;	limx2=0;	limy2=0;
	posfile=0;
		//	fileHandle = [NSFileHandle fileHandleForReadingAtPath:_nomedisegno];
	

	
	[_data getBytes:&VersioneSoftware  range:NSMakeRange (posdata, sizeof(VersioneSoftware)) ];    posdata +=sizeof(VersioneSoftware);
	[_data getBytes:&fuso              range:NSMakeRange (posdata, sizeof(fuso)) ];                posdata +=sizeof(fuso);
	[_data getBytes:&proiezionedisegno range:NSMakeRange (posdata, sizeof(proiezionedisegno)) ];   posdata +=sizeof(proiezionedisegno);
	[_data getBytes:&eventuale_xc      range:NSMakeRange (posdata, sizeof(eventuale_xc)) ];        posdata +=sizeof(eventuale_xc);
	[_data getBytes:&eventuale_yc      range:NSMakeRange (posdata, sizeof(eventuale_yc)) ];        posdata +=sizeof(eventuale_yc);
	[_data getBytes:&eventuale_ang     range:NSMakeRange (posdata, sizeof(eventuale_ang)) ];       posdata +=sizeof(eventuale_ang);
	[_data getBytes:&eventuale_scala   range:NSMakeRange (posdata, sizeof(eventuale_scala)) ];     posdata +=sizeof(eventuale_scala);
	[_data getBytes:&eventuale_offx    range:NSMakeRange (posdata, sizeof(eventuale_offx)) ];      posdata +=sizeof(eventuale_offx);
	[_data getBytes:&eventuale_offy    range:NSMakeRange (posdata, sizeof(eventuale_offy)) ];      posdata +=sizeof(eventuale_offy);
	[_data getBytes:&eventuale_codice1 range:NSMakeRange (posdata, sizeof(eventuale_codice1)) ];   posdata +=sizeof(eventuale_codice1);
	[_data getBytes:&eventuale_codice2 range:NSMakeRange (posdata, sizeof(eventuale_codice2)) ];   posdata +=sizeof(eventuale_codice2);
	[_data getBytes:&eventuale_codice3 range:NSMakeRange (posdata, sizeof(eventuale_codice3)) ];   posdata +=sizeof(eventuale_codice3);
	[_data getBytes:&b_connessodbaseDisegno range:NSMakeRange (posdata, sizeof(b_connessodbaseDisegno)) ];    posdata +=sizeof(b_connessodbaseDisegno);

	
	
	
	NSMutableString *locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self cambianomedbase : locstmut ];
	[locstmut release];
	
	locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self cambianomeTavola : locstmut ];
	[locstmut release];

	

	[_data getBytes:&limx1 range:NSMakeRange (posdata, sizeof(limx1)) ];                           posdata +=sizeof(limx1);
	[_data getBytes:&limy1 range:NSMakeRange (posdata, sizeof(limy1)) ];                           posdata +=sizeof(limy1);
	[_data getBytes:&limx2 range:NSMakeRange (posdata, sizeof(limx2)) ];                           posdata +=sizeof(limx2);
	[_data getBytes:&limy2 range:NSMakeRange (posdata, sizeof(limy2)) ];                           posdata +=sizeof(limy2);

	[_data getBytes:&f_alfalineedisegno     range:NSMakeRange (posdata, sizeof(f_alfalineedisegno)) ];       posdata +=sizeof(f_alfalineedisegno);
	[_data getBytes:&f_alfasuperficidisegno range:NSMakeRange (posdata, sizeof(f_alfasuperficidisegno)) ];   posdata +=sizeof(f_alfasuperficidisegno);
	[_data getBytes:&numtratteggi           range:NSMakeRange (posdata, sizeof(numtratteggi)) ];             posdata +=sizeof(numtratteggi);
	[_data getBytes:&numcampiture           range:NSMakeRange (posdata, sizeof(numcampiture)) ];             posdata +=sizeof(numcampiture);

	int btest;
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
	if (btest==1)  [self setvisibile:NSOnState];   else [self setvisibile:NSOffState]; 
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
	if (btest==1)  [self seteditabile:NSOnState];  else [self seteditabile:NSOffState]; 
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
    if (btest==1)  [self setsnappabile:NSOnState]; else [self setsnappabile:NSOffState];


	npiani=0;	numobj=0;
	[_data getBytes:&npiani range:NSMakeRange (posdata, sizeof(npiani)) ];                           posdata +=sizeof(npiani);
	posfile=posdata;	//	[fileHandle seekToFileOffset:   posfile];

	for (int i=0; i<npiani; i++) {

	    if (i>0)  {	_piano = [Piano alloc]; 	[_piano InitPiano:self:D_info]; 	[ListaPiani addObject:_piano];	} else 	_piano = [ListaPiani objectAtIndex:0];
		posfile=[_piano apripianoMoM:_data :posfile:defsimbol];

	}

			[self setnomedisegno :_nomedisegno];
	
    
    eventuale_ang =0;
    eventuale_scala =1.0;
    eventuale_offx =0;
    eventuale_offy =0;
    
    Exorigine =eventuale_offx;
    Eyorigine =eventuale_offy;
    Escala = eventuale_scala;
    Eanglerot = eventuale_ang;


}
	




- (void) salvaDisegnoMoM: (NSString *) _nomedisegno                {
 NSMutableData *_illodata;
	int lungstr;     unichar ilcar;
	_illodata = [NSMutableData dataWithCapacity:1000000];
	
	_nomedisegno = [_nomedisegno stringByAppendingString:@".OrMap"];
	
	[_illodata appendBytes:(const void *)&VersioneSoftware  length:sizeof(VersioneSoftware)];
	[_illodata appendBytes:(const void *)&fuso              length:sizeof(fuso)];
	[_illodata appendBytes:(const void *)&proiezionedisegno length:sizeof(proiezionedisegno)];
	[_illodata appendBytes:(const void *)&eventuale_xc      length:sizeof(eventuale_xc)];
	[_illodata appendBytes:(const void *)&eventuale_yc      length:sizeof(eventuale_yc)];
	[_illodata appendBytes:(const void *)&eventuale_ang     length:sizeof(eventuale_ang)];
	[_illodata appendBytes:(const void *)&eventuale_scala   length:sizeof(eventuale_scala)];
	[_illodata appendBytes:(const void *)&eventuale_offx    length:sizeof(eventuale_offx)];
	[_illodata appendBytes:(const void *)&eventuale_offy    length:sizeof(eventuale_offy)];
	[_illodata appendBytes:(const void *)&eventuale_codice1 length:sizeof(eventuale_codice1)];
	[_illodata appendBytes:(const void *)&eventuale_codice2 length:sizeof(eventuale_codice2)];
	[_illodata appendBytes:(const void *)&eventuale_codice3 length:sizeof(eventuale_codice3)];
	
	[_illodata appendBytes:(const void *)&b_connessodbaseDisegno length:sizeof(b_connessodbaseDisegno)];

	
	lungstr = [nomedbaseDisegno length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	for (int i=0; i<lungstr; i++) {
		ilcar = [ nomedbaseDisegno characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	
	lungstr = [nometavolaDisegno length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	for (int i=0; i<lungstr; i++) {
		ilcar = [ nometavolaDisegno characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	
	
	
	[_illodata appendBytes:(const void *)&limx1 length:sizeof(limx1)];
	[_illodata appendBytes:(const void *)&limy1 length:sizeof(limy1)];
	[_illodata appendBytes:(const void *)&limx2 length:sizeof(limx2)];
	[_illodata appendBytes:(const void *)&limy2 length:sizeof(limy2)];

	[_illodata appendBytes:(const void *)&f_alfalineedisegno     length:sizeof(f_alfalineedisegno)];
	[_illodata appendBytes:(const void *)&f_alfasuperficidisegno length:sizeof(f_alfasuperficidisegno)];
	[_illodata appendBytes:(const void *)&numtratteggi           length:sizeof(numtratteggi)];
	[_illodata appendBytes:(const void *)&numcampiture           length:sizeof(numcampiture)];

	

	int btest;
	if (b_visibiledisegno) btest=1; else btest=0;   	   [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
    if (b_editabiledisegno) btest=1; else btest=0;   	   [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	if (b_snappabiledisegno) btest=1; else btest=0;   	   [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];

	
	Piano    *locpiano;
	npiani = ListaPiani.count;
	[_illodata appendBytes:(const void *)&npiani length:sizeof(npiani)];
    for (int i=0; i<npiani; i++) {
		locpiano = [ListaPiani objectAtIndex:i];
	    [locpiano salvapianoMoM:_illodata];
    }
	
	
	[_illodata writeToFile:_nomedisegno atomically:NO];
	[self setnomedisegno :_nomedisegno];

}


- (void) setpianocorrente:(int) indice                             {
	indicePianocorrente=indice;
    _pianocorrente= [ ListaPiani objectAtIndex:indice];
}

- (Piano *) givemePianocorrente                                    {
	return _pianocorrente;
}

- (int) IndicePianocorrente                                        {
	return indicePianocorrente;
}

- (void) faidefsimboli: (NSMutableArray *) listadefsimboli         {
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        [locpiano creadefsimbolo :listadefsimboli : i];
	}
}

- (void) RiordinaPianiAlfateticamente                              {
	Piano *pia1, *pia2;
	NSString * nom1, * nom2;
	int indcandidato;
	int numpia = ListaPiani.count;
	for (int i=2; i<numpia-1; i++) {  
		pia1 = [ListaPiani objectAtIndex:i];		nom1 = [pia1 givemenomepiano]; indcandidato=i;
		for (int j=i+1; j<numpia; j++) {  
			pia2 = [ListaPiani objectAtIndex:j];	nom2 = [pia2 givemenomepiano];
			if ( [nom2 compare:nom1 options:NSNumericSearch]   == NSOrderedAscending) {
			    indcandidato=j;   nom1 = [pia2 givemenomepiano];;
			}
		}
		
			// qui scambio
       if (indcandidato>i) {
		  pia1 = [ListaPiani objectAtIndex:indcandidato]; 
		  [ListaPiani removeObjectAtIndex:indcandidato]; 
		  [ListaPiani insertObject :pia1 atIndex:i];
		   nom1 = [pia1 givemenomepiano];
	   }
	}
}



- (void)  setvisibile        :(int)   _state                       {
	if (_state==NSOnState) b_visibiledisegno=YES; else b_visibiledisegno=NO;
}
- (void)  setvisibilepiano   :(int)   _indpiano : (int)   _state   {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setvisibile :_state];
}
- (void)  seteditabile       :(int)   _state                       {
	if (_state==NSOnState) b_editabiledisegno=YES; else b_editabiledisegno=NO;
}
- (void)  seteditabilepiano  :(int)   _indpiano : (int)   _state   {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano seteditabile:_state];
}
- (void)  setsnappabile      :(int)   _state                       {
	if (_state==NSOnState) b_snappabiledisegno=YES; else b_snappabiledisegno=NO;
}
- (void)  setsnappabilepiano :(int)   _indpiano : (int)   _state   {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setsnappabile:_state];
}
- (void)  setspessorepiano   :(int)   _indpiano : (float) _spess   {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:_indpiano];
	[locpiano setspessore:_spess];	
}


- (bool)  visibile                                                 {  return b_visibiledisegno; }

- (bool)  visibilepiano       :(int)   indice                      { 	
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:indice];
	return [locpiano visibile];
}

- (bool)  editabile                                                {  return b_editabiledisegno; }
- (bool)  editabilepiano     :(int)   indice                       { 	
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:indice];
	return [locpiano editabile];
}

- (bool)  esistenomepiano    : (NSString *) nompia                 {
	bool risulta = NO;
	Piano *locpiano;
	for (int i=ListaPiani.count-1; i>0; i--) {  
		locpiano= [ListaPiani objectAtIndex:i];
		if ([[locpiano  givemenomepiano] isEqualToString:nompia] ) { risulta = YES; break; }; 
	}
	return risulta;
}

- (int)   indicePianoconNome : (NSString *) nompia                 {
	int risulta = -1;
	Piano *locpiano;
	for (int i=ListaPiani.count-1; i>=0; i--) {  
		locpiano= [ListaPiani objectAtIndex:i];
		if ([[locpiano  givemenomepiano] isEqualToString:nompia] ) { risulta = i; break; }; 
	}
	return risulta;
}



- (bool)   snappabile                                              {  return b_snappabiledisegno; }
- (bool)   snappabilepiano    :(int)   indice                      { 	
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:indice];
	return [locpiano snappabile];
}

- (float)  spessorepiano      :(int)   indice                      {
	Piano *locpiano;
	locpiano = [ ListaPiani objectAtIndex:indice];
	return [locpiano getspessore];	
}


- (void) EliminaPianiVuoti                                         {
   
	Piano *locpiano;
	for (int i=ListaPiani.count-1; i>0; i--) {  
	 locpiano= [ListaPiani objectAtIndex:i];
		if ([locpiano  givemeNumObjpiano]==0) {  NSBeep(); [ListaPiani removeObjectAtIndex:i];   }; // [locpiano elimina];
	}
    indicePianocorrente=0;
    
    
}


- (void) EliminaPianoCorrente									   {
	if (ListaPiani.count<=1) return;
	[_pianocorrente smemora];
	[ListaPiani removeObjectAtIndex:indicePianocorrente ];
	if (indicePianocorrente>=ListaPiani.count) indicePianocorrente--;
	[self setpianocorrente : indicePianocorrente];
	
	[self rifarenomipianicancelletto];
}


- (void) FondiPianiStessoNome {
	Piano *locpiano;
	Piano *locpiano2;
	Vettoriale *objvector;

	for (int i=ListaPiani.count-1; i>0; i--) {  
		locpiano= [ListaPiani objectAtIndex:i];
		for (int j=i-1; j>0; j--) {  
			locpiano2= [ListaPiani objectAtIndex:j];
			if ([[locpiano givemenomepiano] isEqualToString: [locpiano2 givemenomepiano]])	{
				
                    //			NSLog(@"%@",[locpiano givemenomepiano]);
				for (int k=[locpiano Listavector].count-1; k>0; k--) {  
					objvector= [[locpiano Listavector] objectAtIndex:k];
					[[locpiano2 Listavector] addObject:objvector];
					[[locpiano Listavector] removeObjectAtIndex:k];
				}
				
					//		[locpiano smemora];
				[ListaPiani removeObjectAtIndex:i];
				NSBeep();		
			}
		}
	}
}

- (void) FondiDis            :(DisegnoV *) disadd                  {
	
	Piano *locpiano;
	for (int i=[disadd ListaPiani].count-1 ; i>0; i--) {  
		locpiano=[[disadd  ListaPiani] objectAtIndex:i];
        [locpiano retain];
		[ListaPiani addObject:locpiano];  	
        NSLog(@"N %@",[locpiano givemenomepiano]);
        //      [[disadd  ListaPiani]  removeObjectAtIndex:i];
	}
	
        //	[self FondiPianiStessoNome];
	
}


- (void) rifarenomipianicancelletto                                {
	int indcancelleto =0;
	NSString *nompiano;
	NSString *newnompiano;

	NSRange myrange;	myrange.location=0;	myrange.length = 1;
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		nompiano = [locpiano givemenomepiano];
		if ([nompiano compare:@"#" options:NSCaseInsensitiveSearch range:myrange] ==0)		{
			newnompiano=@""; newnompiano = [newnompiano stringByAppendingFormat:	 @"# %d",indcancelleto];
			indcancelleto ++;
			[locpiano setnomepiano:newnompiano];
		}
	}
}



- (void) EliminaPianoIndice          :(int) indice                 {
	indicePianocorrente = indice;
	[self EliminaPianoCorrente];
}

- (void)  setdispallinivtpiano       :(int) indice :(bool) state   {
	_piano = [ListaPiani objectAtIndex:indice];
	[_piano setdispallinivt :state];
}

- (void)  setdispallinivtfinalipiano :(int) indice :(bool) state   {
	_piano = [ListaPiani objectAtIndex:indice];
	[_piano setdispallinivtfinali:state];
}

- (bool)  dispallinivtpiano          :(int) indice                 {
	_piano = [ListaPiani objectAtIndex:indice];
	return [	_piano dispallinivt];
}

- (bool)  dispallinivtfinalipiano    :(int) indice                 {
	_piano = [ListaPiani objectAtIndex:indice];
	return [	_piano dispallinivtfinali];
}


- (void)  settratteggiopiano         :(int) indice :(int) indtratto{
	_piano = [ListaPiani objectAtIndex:indice];
	[_piano settratteggio:indtratto];
} 

- (void)  setCampitura               :(int) indice :(int) indCamp  {
	[[ListaPiani objectAtIndex:indice] setCampitura:indCamp];
}


- (void)  CatToUtm                                                 {
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano CatToUtm];	
	}
}


- (void)  TematizzaTerreno : (Immobili *) immobili                 {
	Piano *locpiano;
	NSString * risqualita;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
	    if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
	    if ([locpiano pianoPlus]) continue;
		risqualita = [immobili QualitaTerrenoFgPart:  [self nomeFoglioCXF] :   [locpiano givemenomepiano]];
			//		NSLog(@"- %@ ",risqualita);
  	    if ([risqualita isEqualToString:@"SEMINATIVO"])		{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.8:1.0:0.0];	}
  	    if ([risqualita isEqualToString:@"SEMIN ARBOR"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.8:1.0:0.0];	}
		if ([risqualita isEqualToString:@"PASCOLO"])		{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.45:0.6:0.3];	}
		if ([risqualita isEqualToString:@"PASCOLO ARB"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.45:0.6:0.3];	}
		if ([risqualita isEqualToString:@"PASC CESPUG"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.25:0.6:0.2];	}
		if ([risqualita isEqualToString:@"PASC CESPUGLIATO"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.25:0.6:0.2];	}
		if ([risqualita isEqualToString:@"ORTO IRRIG"])		{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.0:1.0:1.0];	}

		if ([risqualita isEqualToString:@"INCOLT PROD"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.5:0.5:0.5];	}
		if ([risqualita isEqualToString:@"RELIT STRAD"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :1.0:0.5:0.0];	}

		
		if ([risqualita isEqualToString:@"BOSCO CEDUO"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.0:1.0:0.0];	}

		if ([risqualita isEqualToString:@"ULIVETO"])		{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.25:0.4:0.1];	}
  	    if ([risqualita isEqualToString:@"ENTE URBANO"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.0:0.0:0.7];	}
  	    if ([risqualita isEqualToString:@"FABB RURALE"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.0:0.5:1.0];	}

		if ([risqualita isEqualToString:@"VIGNETO"])		{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :0.45:0.0:0.3];	}

		if ([risqualita isEqualToString:@"FERROVIA SP"])	{ [locpiano setalphasup      :0.8];	[locpiano setcolorpianorgb :1.0:0.4:0.4];	}
		if ([risqualita isEqualToString:@"CAVA"])	        { [locpiano setalphasup      :1.0];	[locpiano setcolorpianorgb :1.0:1.0:0.0];	}

		if ([risqualita isEqualToString:@"CAST FRUTTO"])	{ [locpiano setalphasup      :1.0];	[locpiano setcolorpianorgb :0.0:0.5:0.5];	}
		if ([risqualita isEqualToString:@"FRUTTETO"])	    { [locpiano setalphasup      :1.0];	[locpiano setcolorpianorgb :1.0:0.0:1.0];	}

	}
	
}


- (void ) TematizzaTerrenoSuNuovoDis : (DisegnoV *) Disnuovo  : (Immobili *) immobili {
	NSString * risqualita;
	Piano *locpiano;
	Piano *pianoset;
	Vettoriale * locobjvet;
	Vettoriale * copiaobjvet;
		//	NSString * risqualita;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
/*        if ( ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) | ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) ) {
			[Disnuovo addLayerCorrente : [locpiano givemenomepiano]];
			pianoset = [[Disnuovo ListaPiani] objectAtIndex : [Disnuovo IndicePianocorrente]];
			[pianoset setalphasup      :[locpiano getalphaline]];
			[pianoset setalphaline:0.8]; [pianoset setalphasup : 0.8];
			[pianoset setcolorpianorgb :[locpiano colorepiano_r] :[locpiano colorepiano_g]:[locpiano colorepiano_b]];	
            for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
				locobjvet = [[locpiano Listavector] objectAtIndex:j ];
				copiaobjvet = [locobjvet copiaPura];
				if (copiaobjvet!=nil) {	
					[copiaobjvet Init:Disnuovo :pianoset];
					[[pianoset Listavector] addObject:copiaobjvet];	} 
			}
			continue;
		}
 */
		/*
		if ([locpiano pianoPlus]) {
			[Disnuovo addLayerCorrente : @"Fabbricati"];
			pianoset = [[Disnuovo ListaPiani] objectAtIndex : [Disnuovo IndicePianocorrente]];
			[pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :1.0:0.5:0.5];
			for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
				locobjvet = [[locpiano Listavector] objectAtIndex:j ];
				copiaobjvet = [locobjvet copiaPura];
				if (copiaobjvet!=nil) {	
					[copiaobjvet Init:Disnuovo :pianoset];
					[[pianoset Listavector] addObject:copiaobjvet];	} 
			}
			continue;
		}
*/		 
		risqualita = [immobili QualitaTerrenoFgPart:  [self nomeFoglioCXF] :   [locpiano givemenomepiano]];
		if (risqualita==nil) continue;
		if ([risqualita length]==0) continue;
		[Disnuovo addLayerCorrente : risqualita];
		pianoset = [[Disnuovo ListaPiani] objectAtIndex : [Disnuovo IndicePianocorrente]];
		for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
			locobjvet = [[locpiano Listavector] objectAtIndex:j ];
			copiaobjvet = [locobjvet copiaPura];
			if (copiaobjvet!=nil) {	
				[copiaobjvet Init:Disnuovo :pianoset];
					//			[[pianoset Listavector] addObject:copiaobjvet];
			} 
		}
		[pianoset setalphaline:0.8];
  	    if ([risqualita isEqualToString:@"SEMINATIVO"])		{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.8:1.0:0.0];	}
  	    if ([risqualita isEqualToString:@"SEMIN ARBOR"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.8:1.0:0.0];	}
		if ([risqualita isEqualToString:@"PASCOLO"])		{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.45:0.6:0.3];	}
		if ([risqualita isEqualToString:@"PASCOLO ARB"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.45:0.6:0.3];	}
		if ([risqualita isEqualToString:@"PASC CESPUG"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.25:0.6:0.2];	}
		if ([risqualita isEqualToString:@"PASC CESPUGLIATO"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.25:0.6:0.2];	}
		if ([risqualita isEqualToString:@"ORTO IRRIG"])		{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.0:1.0:1.0];	}
		if ([risqualita isEqualToString:@"INCOLT PROD"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.5:0.5:0.5];	}
		if ([risqualita isEqualToString:@"RELIT STRAD"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :1.0:0.5:0.0];	}
		if ([risqualita isEqualToString:@"BOSCO CEDUO"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.0:1.0:0.0];	}
		if ([risqualita isEqualToString:@"ULIVETO"])		{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.25:0.4:0.1];	}
  	    if ([risqualita isEqualToString:@"ENTE URBANO"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.6:0.0:0.0];	}
  	    if ([risqualita isEqualToString:@"FABB RURALE"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.0:0.5:1.0];	}
		if ([risqualita isEqualToString:@"VIGNETO"])		{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :0.45:0.0:0.3];	}
		if ([risqualita isEqualToString:@"FERROVIA SP"])	{ [pianoset setalphasup      :0.8];	[pianoset setcolorpianorgb :1.0:0.4:0.4];	}
		if ([risqualita isEqualToString:@"CAVA"])	        { [pianoset setalphasup      :1.0];	[pianoset setcolorpianorgb :1.0:1.0:0.0];	}
		if ([risqualita isEqualToString:@"CAST FRUTTO"])	{ [pianoset setalphasup      :1.0];	[pianoset setcolorpianorgb :0.0:0.5:0.5];	}
		if ([risqualita isEqualToString:@"FRUTTETO"])	    { [pianoset setalphasup      :1.0];	[pianoset setcolorpianorgb :1.0:0.0:1.0];	}
	}
}



- (void)  NoTematizzaTerreno                                       {
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
        if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
	    if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
	    if ([locpiano pianoPlus]) continue;

        [locpiano setalphasup : 0.4];
        [locpiano setcolorpianorgb: 1.0 : 1.0 :1.0 ];	

	}
	
}

- (void)  TestoAltoQU                                              {
	Piano *pianoFg;
	[self addpiano];
	pianoFg = [ListaPiani objectAtIndex:[ListaPiani count]-1];
    [pianoFg setnomepiano:@"Testi Fogli"];

	
	Piano *locpiano;
	for (int i=0; i<ListaPiani.count-1; i++) {  
		locpiano= [ListaPiani objectAtIndex:i];
		[locpiano TestoAltoQU:pianoFg];	
	}
	
}



- (void) loggadati {

/*
 for (int i=0; i<[Listasub count]; i++) {  suber = [Listasub objectAtIndex:i];
		NSLog(@"%d ; %@ ; %@ ; %@ ; %@; %@; %@; %@ ; %@; %@ ; €%1.2f",  suber.indice,[suber Foglio],[suber Particella],[suber Sub ],[suber Categoria ],[suber Classe ] 
			  ,[suber Consistenza ],[suber Via ],[suber Civico ],[suber PianoEdificio ],[suber Rendita]   );
	}
*/	
}


- (void) dealloc {
	
		//	NSBeep();
	
	[super dealloc];
}


@end
