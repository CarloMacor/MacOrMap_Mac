//
//  Piano.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Piano.h"
#import "Vettoriale.h"
#import "Punto.h"
#import "Polilinea.h"
#import "Cerchio.h"
#import "Simbolo.h"
#import "Testo.h"
#import "Arco.h"




@interface Piano (public)  // private

 - (Polilinea *) dammiUltimoPoligono;

@end


@implementation Piano

   Polilinea      *Polyincostruzione;
   Testo          *Testoincostruzione;
   Simbolo        *simboloincostruzione;

	// Roma
	//		float          offxroma= -(2020000.0); // + 5.0 ORA RIMOSSO
	//	float          offyroma=         0.0;  // prima - 8 messo adesso in calocla 



// civitavecchia catasto
// float          offxroma=  289450+9;   // correzioni + 9 e + 11 in funzioni.m
// float          offyroma= 4646172+11;

	// vuoto
	// float          offxroma=  0;
	// float          offyroma=  0;

// civitavecchia fotogrammetrico
//float          offxroma= -(1500000-4110);
//float          offyroma= +1258;

NSString *dxf_01;
NSString *dxf_02;

double   dxf_10, dxf_20, dxf_30;
double   dxf_11, dxf_21, dxf_31;
double   dxf_40, dxf_41, dxf_42;
double   dxf_50, dxf_51, dxf_70;
int      dxf_73;

bool     b_dxf_10, b_dxf_20, b_dxf_30;
int      tipoelemento;


- (void) InitPiano   : (DisegnoV *) _dis : (InfoObj *) _info                        {
	Listavector = [[NSMutableArray alloc] init];
	nomepiano = [[NSString alloc] initWithString:@""];
	NSString *str =@"#";             str = [str stringByAppendingFormat:	 @"%d", [_dis damminumpiani ]];
	[self setnomepiano  :str];
	b_visibilepiano=YES;
	b_editabile    =YES;
    b_snappabile   =YES;
	f_alfalineepiano           =  1.0;
    f_alfasuperficipiano       =  1.0;
	
    f_rosso=0.2;	f_verde=0.2;	f_blu  =0.2;
    f_spessoreline =0.8;
	
	dimpunto  = 2.0;
	
	
	scalaminvista=0.0;
	scalamaxvista=10000;

	nomedbase  = @"";
	nometavola = @"";
    b_connessodbase=NO;
	
	b_dispallinivt       = NO;
    b_dispallinivtfinali = NO;

	i_tratteggio=0;
	i_campitura=0;

	_disegno = _dis;
    info = _info;
	[self svuotabooldxf];

	offxroma = [info offxroma]; 
	offyroma = [info offyroma];



}


- (void) setnomepiano:(NSString *)nome        {  [nome retain];  [nomepiano release];	    nomepiano = nome; }

- (void) setcommentopiano:(NSString *) nome   {  [nome retain];  [commentopiano release];	commentopiano = nome; }

- (NSString *) givemenomepiano                { return nomepiano;}

- (NSString *)  nomepianoNoPlus   {
    NSString * risulta ;
    
    if ([self pianoPlus]) {
        NSRange myrange;
        myrange.location=0;    myrange.length = [nomepiano length]-1;
        risulta = [nomepiano substringWithRange:myrange];
    } else {
         return nomepiano;
    }
    return risulta;
}




- (NSString *) givecommentomepiano            { return commentopiano;}

- (int)        givemeNumObjpiano              { 
	int numobj;
	numobj = [Listavector count];
	return numobj;
}

- (int)        NumObjpianoNotErased           {
	int resulta=0;
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if (![objvector cancellato]) resulta ++;
	}
	return resulta;
}

- (int)        givemeNumPtpiano               {
	int result;
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if ([objvector dimmitipo]==1) result++;
	}
	
	return result;
}

- (NSString *) infopiano                      {
    NSString *Str;
	[self qualiquantiobjpiano];
	Str = @"";     	
	Str = [Str stringByAppendingFormat:	 @"Pt:%d Pl:%d Pol:%d Rg:%d Ce:%d Tx:%d Si:%d Ar:%d   Vt:%d",
	  [self i_Punti],[self i_PLine],[self i_Poligoni],[self i_Regioni],[self i_Cerchi],[self i_Testi],[self i_Simboli] ,[self i_Arco] ,[self i_Vt] ];
	return Str;
}


- (void)  qualiquantiobjpiano                 {
	i_Punti=0;      i_Pline=0;      i_Poligoni=0;  i_Regioni=0;  i_SPline=0;    
	i_SPoligoni=0;  i_SRegioni=0;   i_Cerchi=0;    i_Testi=0;    i_Simboli=0; i_Arco=0; i_Vt=0;
	Vettoriale *objvector;
	Polilinea *Pollo;
	for (int i=0; i<Listavector.count; i++) { 
		objvector= [Listavector objectAtIndex:i];
	
		switch ([objvector dimmitipo]) {
			case 1:    i_Punti ++;	    break;
			case 2: case 3:case 4:case 7:case 8:case 9:
				Pollo = [Listavector objectAtIndex:i];
				i_Vt = i_Vt+[Pollo numvt];
				if ([Pollo isspline])	{if ([Pollo	isregione]) i_SRegioni++; else {	 if ([Pollo	chiusa]) i_SPoligoni++; else i_SPline++; } 	}
				else {				if ([Pollo	isregione]) i_Regioni++; else {	if ([Pollo	chiusa]) i_Poligoni++; else i_Pline++; }			}
				                        break;
			case 5:    i_Cerchi ++;	    break;
			case 6:    i_Testi ++;	    break;
			case 10:   i_Simboli ++;	break;
			case 11:   i_Arco ++;	    break;
			default:			        break;
		}
	}
}


- (int)   i_Punti     {	return i_Punti;     }
- (int)   i_PLine     {	return i_Pline;     }
- (int)   i_Poligoni  {	return i_Poligoni;  }
- (int)   i_Regioni   {	return i_Regioni;   }
- (int)   i_SPline    {	return i_SPline;    }
- (int)   i_SPoligoni {	return i_SPoligoni; }
- (int)   i_SRegioni  {	return i_SRegioni;  }
- (int)   i_Cerchi    {	return i_Cerchi;    }
- (int)   i_Testi     {	return i_Testi;     }
- (int)   i_Simboli   {	return i_Simboli;   }
- (int)   i_Arco      {	return i_Arco;      }
- (int)   i_Vt        {	return i_Vt;        }


- (void)  setdispallinivt         :(bool) state {
	b_dispallinivt = state;
}

- (void)  setdispallinivtfinali   :(bool) state {
	b_dispallinivtfinali = state;
}

- (bool)  dispallinivt                          {
	return b_dispallinivt;	
}

- (bool)  dispallinivtfinali                    {
	return b_dispallinivtfinali;
}


- (void) mettitratteggio  : (CGContextRef) hdc : (int) tipotratt {

	if (tipotratt==1)  {	const CGFloat mypar[2] = {2,2 };    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==2)  {	const CGFloat mypar[2] = {1,10};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==3)  {	const CGFloat mypar[2] = {1,15};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==4)  {	const CGFloat mypar[2] = {1,20};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==5)  {	const CGFloat mypar[2] = {1,30};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	

	if (tipotratt==6)  {	const CGFloat mypar[2] = {5 ,1};    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==7)  {	const CGFloat mypar[2] = {10,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==8)  {	const CGFloat mypar[2] = {15,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==9)  {	const CGFloat mypar[2] = {20,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==10) {	const CGFloat mypar[2] = {30,1};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	
	if (tipotratt==11) {	const CGFloat mypar[2] = {5,5};	    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==12) {	const CGFloat mypar[2] = {5,10};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==13) {	const CGFloat mypar[2] = {5,15};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==14) {	const CGFloat mypar[2] = {5,20};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==15) {	const CGFloat mypar[2] = {5,30};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	
	if (tipotratt==16) {	const CGFloat mypar[2] = {5 ,5};    CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==17) {	const CGFloat mypar[2] = {10,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==18) {	const CGFloat mypar[2] = {15,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==19) {	const CGFloat mypar[2] = {20,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	if (tipotratt==20) {	const CGFloat mypar[2] = {30,5};	CGContextSetLineDash ( hdc , 0, mypar, 2 );	}	
	
	
}


- (NSMutableArray *) Listavector                {
	return Listavector;
}

- (Polilinea *) dammiUltimoPoligono             { 
	Polilinea      *_locpoly;
	if (Polyincostruzione!=nil) {
		if ([Polyincostruzione chiusa])  _locpoly=Polyincostruzione;
	} 
	return _locpoly;
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
		else {  [risulta appendFormat:	 @"%C", c];		} // togli il punto
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
		else {	if (c!=32) [risulta appendFormat:	 @"%C", c];	} // togli lo spazio
    }	
	return risulta;	
}

- (NSString *) salvadxf                                                                      {
	NSString *risulta=@"";
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		risulta = [risulta stringByAppendingString:[objvector salvadxf]];
	}
	return risulta;	
}

- (NSString *) nomepoligonopt     : (double) xc    : (double) yc{
	NSString * locres = nil;
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector ptInterno : xc: yc] ) {
			locres = [self givemenomepiano]; break;
		}
	}
	return locres;
}
















- (void) faipunto      : (CGContextRef) hdc: (double) x1 : (double) y1   : (NSUndoManager  *) Undor   {
	Punto *locpunto;
	locpunto = [Punto alloc];	[locpunto Init:_disegno : self];	[locpunto InitPunto:x1:y1];
	[Listavector addObject:locpunto];
	[_disegno faiLimiti];
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	CGContextSetLineWidth(hdc, [self getspessore ] );
	[locpunto Disegna:hdc :info];
	
	[[Undor prepareWithInvocationTarget:locpunto] cancella];
}

- (void) faiplinea     : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase  : (NSUndoManager  *) Undor               {

	if (fase==0) {  
		Polyincostruzione = nil;
		Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO]; } 
	if (fase==1) {	[Listavector addObject:Polyincostruzione]; };

	[ Polyincostruzione addvertex:x1:y1:0 ];
	[_disegno faiLimiti];

	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[Polyincostruzione Disegna:hdc :info];
	
		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];

}

- (void) faisplinea    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase                {
	if (fase==0) { 
		Polyincostruzione = nil;
		Polyincostruzione = [Polilinea alloc]; 	
		[Polyincostruzione Init:_disegno : self];  
		[Polyincostruzione InitPolilinea:NO];
		[Polyincostruzione UpdatePolyInSpline];
	} 
	if (fase==2) {	[Listavector addObject:Polyincostruzione]; };
		int disp =fase % 2 ;
		if (disp==1) {	[ Polyincostruzione addcontroll:x1:y1 ];} 
		        else {  [ Polyincostruzione addvertex:x1:y1:0 ]; 
					[info set_xylastspline:(x1-[info xorigineVista])/[info scalaVista] 
											:(y1-[info yorigineVista])/[info scalaVista] ]; }
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[Polyincostruzione Disegna:hdc :info];
		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];

}

- (void) faisimbolo    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) indice :(bool) dimfissa: (NSMutableArray *) listadefinizioni : (NSUndoManager  *) Undor{
	simboloincostruzione = nil;
	simboloincostruzione = [Simbolo alloc];
	[simboloincostruzione Init:_disegno : self];
	[simboloincostruzione InitSimbolo:x1:y1:indice : listadefinizioni ];
	[simboloincostruzione setFisso:dimfissa ];

	[[Undor prepareWithInvocationTarget:simboloincostruzione] cancella];

	[Listavector addObject:simboloincostruzione];
	[self settacolorepiano :hdc:1.0:1.0];
	[_disegno faiLimiti];
	[simboloincostruzione Disegna:hdc :info];
	
}

- (void) ruotasimbolo  : (CGContextRef) hdc: (double) rot {
	[simboloincostruzione ruotasimbolo : rot];
	[simboloincostruzione Disegna:hdc :info];
}

- (void) scalasimbolo  : (CGContextRef) hdc: (double) sca {
	[simboloincostruzione scalasimbolo:sca];
    [simboloincostruzione Disegna:hdc :info];
}

- (void) faipoligono   : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase                {
	if (fase==0) {  Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self]; [Polyincostruzione InitPolilinea:YES]; } 
	if (fase==1) {	[Listavector addObject:Polyincostruzione]; };
	if (fase==0) [ Polyincostruzione addvertexUp:x1:y1 ]; else	[ Polyincostruzione addvertex:x1:y1:0 ];
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[Polyincostruzione Disegna:hdc :info];
	
		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];

 }

- (void) faispoligono  : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase                {
	if (fase==0) {  Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self]; [Polyincostruzione InitPolilinea:YES]; 
		[Polyincostruzione UpdatePolyInSpline];
    } 
	if (fase==2) {	[Listavector addObject:Polyincostruzione]; };
	int disp =fase % 2 ;
	if (disp==1) {	[ Polyincostruzione addcontroll:x1:y1 ];} 
	else {  [ Polyincostruzione addvertex:x1:y1:0 ]; 
		[info set_xylastspline:(x1-[info xorigineVista])/[info scalaVista] 
								:(y1-[info yorigineVista])/[info scalaVista] ]; }
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[Polyincostruzione Disegna:hdc :info];
		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];

}

- (void) faisregione   : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase: (int) fasereg {
	if (fase==0) {  Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self]; [Polyincostruzione InitPolilinea:YES];
 		           [Polyincostruzione setregione:YES];
	           	   [Polyincostruzione UpdatePolyInSpline];	
		[info set_xylastspline:(x1-[info xorigineVista])/[info scalaVista] 
		  					  :(y1-[info yorigineVista])/[info scalaVista] ];
	
	} 
	if (fase==2) {	[Listavector addObject:Polyincostruzione]; };
	if (fase==0) {  [ Polyincostruzione addvertexUp:x1:y1];
	}	else	
	{	
		int disp =fase % 2 ;
		if (fasereg==1) {	[ Polyincostruzione addvertexUp:x1:y1 ];  
		
			[info set_xylastspline:(x1-[info xorigineVista])/[info scalaVista] :(y1-[info yorigineVista])/[info scalaVista] ];  
		
		} //	[ Polyincostruzione addcontroll:x1:y1 ];
		       else
		  { if (disp==1) 	[ Polyincostruzione addcontroll:x1:y1 ];  else
		    { [ Polyincostruzione addvertex:x1:y1:0 ];  
			  [info set_xylastspline:(x1-[info xorigineVista])/[info scalaVista] :(y1-[info yorigineVista])/[info scalaVista] ];  
			}
		  }
	};

	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[Polyincostruzione Disegna:hdc :info];
		//	[[Undor prepareWithInvocationTarget:Polyincostruzione] cancellaultimovt];

}

- (void) faitesto      : (CGContextRef) hdc: (double) x1: (double) y1: (double) ht: (double) ang  : (NSString *) txttesto : (NSUndoManager  *) Undor{
	Testo *loctesto;
	loctesto = [Testo alloc];
	[loctesto Init:_disegno : self];
	[loctesto InitTesto:x1:y1:ht:ang];
	[loctesto cambiastringa:txttesto];
	[Listavector addObject:loctesto];
	[self settacolorepiano :hdc:1.0:1.0];
	[_disegno faiLimiti];
	[loctesto Disegna:hdc :info];
	[[Undor prepareWithInvocationTarget:loctesto] cancella];

		//	Testoincostruzione =loctesto;
}

- (void) faitestovirtuale : (double) ht:  (double) ang : (NSString *) txttesto                     {
	[self releasetestoincostruzione];
	Testoincostruzione = [Testo alloc];
	[Testoincostruzione Init:_disegno : self];
	[Testoincostruzione InitTesto:0:0:ht:ang];
	[Testoincostruzione cambiastringa:txttesto];
}


- (void) releasetestoincostruzione                                                                 {
	[Testoincostruzione release];
}



- (void) fairegione    : (CGContextRef) hdc: (double) x1 : (double) y1 : (int) fase: (int) fasereg {
	if (fase==0) {  Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self]; [Polyincostruzione InitPolilinea:YES]; 
		[Polyincostruzione setregione:YES];	} 
	if (fase==1) {	[Listavector addObject:Polyincostruzione]; };
	if (fase==0)     [ Polyincostruzione addvertexUp:x1:y1]; else	
	                 {	if (fasereg==1)  [ Polyincostruzione addvertexUp:x1:y1 ]; else [ Polyincostruzione addvertex:x1:y1:0 ]; }
	fasereg=0;
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];
	[Polyincostruzione Disegna:hdc :info];
}


- (void) finitaPolilinea: (CGContextRef) hdc    : (NSUndoManager  *) MUndor                          {
    if (Polyincostruzione ==nil) return;
	[[MUndor prepareWithInvocationTarget:Polyincostruzione] cancella];
}


- (void) chiudipoligono: (CGContextRef) hdc    : (NSUndoManager  *) MUndor                          {
    if (Polyincostruzione ==nil) return;
    [Polyincostruzione chiudi];
	[self settacolorepiano     :hdc :1.0    :1.0];
	[Polyincostruzione Disegna :hdc :info      ];
	[[MUndor prepareWithInvocationTarget:Polyincostruzione] cancella];
}
        
- (void) updateEventualeRegione: (CGContextRef) hdc    : (NSUndoManager  *) MUndor                          {
    if (Polyincostruzione ==nil) return;
    [Polyincostruzione updateRegione];
}


- (void) faicerchio    : (CGContextRef) hdc: (double) x1 : (double) y1 : (double) x2 : (double)y2 : (NSUndoManager  *) MUndor {
	Cerchio *loccerchio;
	loccerchio = [Cerchio alloc];	[loccerchio Init:_disegno : self];
	[loccerchio InitCerchio:x1:y1:x2:y2];
	[Listavector addObject:loccerchio];
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[loccerchio Disegna:hdc :info];
	[[MUndor prepareWithInvocationTarget:loccerchio] cancella];

}

- (void) fairettangolo : (CGContextRef) hdc: (double) x1 : (double) y1 : (double) x2 : (double)y2 : (NSUndoManager  *) MUndor {
    Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES]; 
	[Listavector addObject:Polyincostruzione]; 
	[Polyincostruzione addvertexUp:x1:y1]; 
	[Polyincostruzione addvertex:x2:y1:0];
	[Polyincostruzione addvertex:x2:y2:0];
	[Polyincostruzione addvertex:x1:y2:0];
	[Polyincostruzione addvertex:x1:y1:0];
	CGContextSetLineWidth(hdc, [self getspessore ]  );
	[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
	[_disegno faiLimiti];

	[Polyincostruzione Disegna:hdc :info];
	[[MUndor prepareWithInvocationTarget:Polyincostruzione] cancella];

}


- (bool) faiCatpoligono : (CGContextRef) hdc: (double) x1 : (double) y1: (int) fasecom : (DisegnoV *) disVcomp  {
	bool resulta=NO;
	bool dainserire=NO;
	Piano      *locpiano;
	Vettoriale *objvector;
	
	if ([Polyincostruzione numvt]==1) { dainserire=YES; }

	if (fasecom==0) {  Polyincostruzione = [Polilinea alloc]; 	
		[Polyincostruzione Init:_disegno : self]; 
		[Polyincostruzione InitPolilinea:YES]; 
		[Polyincostruzione addvertexUp:x1:y1];
		[info setxysnap : x1 : y1 ];
		resulta=YES; 	} 

	
	if (fasecom>0) { // qui la vera aggiungi vertici di altre polilinee
		for (int i=0; i<[disVcomp ListaPiani].count; i++) {  
			locpiano= [[disVcomp ListaPiani] objectAtIndex:i];
			for (int j=0; j<[locpiano Listavector].count; j++) {  
							objvector= [[locpiano Listavector] objectAtIndex:j];
				resulta = [Polyincostruzione addCatVertici:info:x1:y1:objvector ];
			  if (resulta) break;
			}			
		 if (resulta) break;
		}

			//	 resulta=YES;
	} 
	if (resulta) {
		if (dainserire) {	[Listavector addObject:Polyincostruzione]; 	};
		CGContextSetLineWidth(hdc, [self getspessore ]  );
		[self settacolorepiano :hdc :[_disegno alphaline] : [_disegno alphasup] ];
		[_disegno faiLimiti];
		[Polyincostruzione Disegna:hdc :info];
	}
	return resulta;
}

- (void)   BackPlineaAdded                                                                             {
		//	NSLog(@"n back %d",info.numVtCorAdded);
	
	for (int i=0; i<info.numVtCorAdded; i++) {  
		[self cancellaultimovt];
	}
	info.numVtCorAdded=0;
}


- (void) cancellaultimovt                                                                              {
	if (Polyincostruzione==nil) return;
	if ([Polyincostruzione numvt]<1) return;
	[Polyincostruzione cancellaultimovt];
	[info setxysnap : [Polyincostruzione dammixPuntoInd :([Polyincostruzione numvt]-1) ] : [Polyincostruzione dammiyPuntoInd :([Polyincostruzione numvt]-1) ] ];
	
}




- (void) salvapianoMoM    : (NSMutableData *) _illodata                                                {
		//	int numobj = [self givemeNumObjpiano];
			int numobj = [self NumObjpianoNotErased];
	
    int btest;
	if (b_visibilepiano) btest=1; else btest=0;   	   [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	if (b_editabile) btest=1; else btest=0;   	       [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	if (b_snappabile) btest=1; else btest=0;   	       [_illodata appendBytes:(const void *)&btest length:sizeof(btest)];
	[_illodata appendBytes:(const void *)&f_alfalineepiano     length:sizeof(f_alfalineepiano)];
	[_illodata appendBytes:(const void *)&f_alfasuperficipiano length:sizeof(f_alfasuperficipiano)];
	[_illodata appendBytes:(const void *)&f_spessoreline       length:sizeof(f_spessoreline)];

	[_illodata appendBytes:(const void *)&i_tratteggio         length:sizeof(i_tratteggio)];
	[_illodata appendBytes:(const void *)&i_campitura          length:sizeof(i_campitura)];
	[_illodata appendBytes:(const void *)&indsimbolo           length:sizeof(indsimbolo)];
	[_illodata appendBytes:(const void *)&scalatratto          length:sizeof(scalatratto)];

	
	
	
	[_illodata appendBytes:(const void *)&f_rosso              length:sizeof(f_rosso)];
	[_illodata appendBytes:(const void *)&f_verde              length:sizeof(f_verde)];
	[_illodata appendBytes:(const void *)&f_blu                length:sizeof(f_blu)];

	[_illodata appendBytes:(const void *)&scalaminvista        length:sizeof(scalaminvista)];
	[_illodata appendBytes:(const void *)&scalamaxvista        length:sizeof(scalamaxvista)];

	[_illodata appendBytes:(const void *)&dimpunto             length:sizeof(dimpunto)];
	
	int lungstr = [nomepiano length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;	
	for (int i=0; i<lungstr; i++) {
		ilcar = [ nomepiano characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	
	 lungstr = [commentopiano length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	for (int i=0; i<lungstr; i++) {
		ilcar = [ commentopiano characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	
	[_illodata appendBytes:(const void *)&b_connessodbase        length:sizeof(b_connessodbase)];
	lungstr = [nomedbase length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	for (int i=0; i<lungstr; i++) {
		ilcar = [ nomedbase characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	lungstr = [nometavola length];
	[_illodata appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	for (int i=0; i<lungstr; i++) {
		ilcar = [ nometavola characterAtIndex:i];
		[_illodata appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
	

	
	
	[_illodata appendBytes:(const void *)&numobj length:sizeof(numobj)];

	Vettoriale *objvector;
	int tipo;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		tipo = [objvector dimmitipo];
		[objvector salvavettorialeMoM:_illodata]; 
	}
	objvector=nil;
	
}

- (unsigned long long) apripianoMoM     : (NSData *) _data    : (unsigned long long) posfile  : (NSMutableArray *) defsimbol {
	NSUInteger posdata=posfile;

		//	NSLog(@"Passa %d",posdata);
		//	NSLog(@"Passa %d",posfile);

	
	int      tipo;    // 1 punto  2 plinea  3 poligono 4 regione 5 testo
	int btest;
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
	if (btest==1)  [self setvisibile:NSOnState];   else [self setvisibile:NSOffState]; 
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
	if (btest==1)  [self seteditabile:NSOnState];  else [self seteditabile:NSOffState]; 
	[_data getBytes:&btest range:NSMakeRange (posdata, sizeof(btest)) ];                           posdata +=sizeof(btest);
    if (btest==1)  [self setsnappabile:NSOnState]; else [self setsnappabile:NSOffState];
	
	[_data getBytes:&f_alfalineepiano       range:NSMakeRange (posdata, sizeof(f_alfalineepiano)) ];         posdata +=sizeof(f_alfalineepiano);
	[_data getBytes:&f_alfasuperficipiano   range:NSMakeRange (posdata, sizeof(f_alfasuperficipiano)) ];     posdata +=sizeof(f_alfasuperficipiano);
	[_data getBytes:&f_spessoreline         range:NSMakeRange (posdata, sizeof(f_spessoreline)) ];           posdata +=sizeof(f_spessoreline);
	[_data getBytes:&i_tratteggio           range:NSMakeRange (posdata, sizeof(i_tratteggio)) ];             posdata +=sizeof(i_tratteggio);
	[_data getBytes:&i_campitura            range:NSMakeRange (posdata, sizeof(i_campitura)) ];              posdata +=sizeof(i_campitura);
	[_data getBytes:&indsimbolo             range:NSMakeRange (posdata, sizeof(indsimbolo)) ];               posdata +=sizeof(indsimbolo);
	[_data getBytes:&scalatratto            range:NSMakeRange (posdata, sizeof(scalatratto)) ];              posdata +=sizeof(scalatratto);
	[_data getBytes:&f_rosso                range:NSMakeRange (posdata, sizeof(f_rosso)) ];                  posdata +=sizeof(f_rosso);
	[_data getBytes:&f_verde                range:NSMakeRange (posdata, sizeof(f_verde)) ];                  posdata +=sizeof(f_verde);
	[_data getBytes:&f_blu                  range:NSMakeRange (posdata, sizeof(f_blu)) ];                    posdata +=sizeof(f_blu);
	[_data getBytes:&scalaminvista          range:NSMakeRange (posdata, sizeof(scalaminvista)) ];            posdata +=sizeof(scalaminvista);
	[_data getBytes:&scalamaxvista          range:NSMakeRange (posdata, sizeof(scalamaxvista)) ];            posdata +=sizeof(scalamaxvista);
	[_data getBytes:&dimpunto               range:NSMakeRange (posdata, sizeof(dimpunto)) ];                 posdata +=sizeof(dimpunto);

	int lungstr;            unichar ilcar;
	
	NSMutableString *locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self setnomepiano : locstmut ];	    [locstmut release];

	locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self setcommentopiano : locstmut ];	[locstmut release];

	[_data getBytes:&b_connessodbase        range:NSMakeRange (posdata, sizeof(b_connessodbase)) ];          posdata +=sizeof(b_connessodbase);

	locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar           range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self cambianomedbase : locstmut ];	[locstmut release];
	

	locstmut = [[NSMutableString alloc] initWithCapacity:40];
	[_data getBytes:&lungstr           range:NSMakeRange (posdata, sizeof(lungstr)) ];             posdata +=sizeof(lungstr);
  	for (int i=0; i<lungstr; i++) {	
		[_data getBytes:&ilcar         range:NSMakeRange (posdata, sizeof(ilcar)) ];             posdata +=sizeof(ilcar);
		[locstmut appendFormat:	 @"%C",ilcar];	}
	[self cambianomeTavola : locstmut ];	[locstmut release];
	
	int numobj ;
	[_data getBytes:&numobj             range:NSMakeRange (posdata, sizeof(numobj)) ];             posdata +=sizeof(numobj);
		//	NSLog(@"Nome %@",nomepiano);
		//	NSLog(@"numo , %d ",numobj);
	 for (int j=0; j<numobj; j++) {
		 [_data getBytes:&tipo           range:NSMakeRange (posdata, sizeof(tipo)) ];             posdata +=sizeof(tipo);
             //		 		 NSLog(@"Tipo , %d ",tipo);
		 if (tipo==1) { Punto *locpunto; locpunto = [Punto alloc]; 
			           [locpunto Init:_disegno : self];  [locpunto InitPunto:0 :0];     [Listavector addObject:locpunto]; 
			 posdata = [locpunto aprivettorialeMoM     :_data:posdata ];   
		 }	
	
		 if (tipo==2) { Polilinea *locplinea; locplinea = [Polilinea alloc];  
			           [locplinea Init:_disegno : self]; [locplinea InitPolilinea:NO];  [Listavector addObject:locplinea]; 
			 posdata = [locplinea aprivettorialeMoM     :_data:posdata ];  
		 }	
		 
		 if (tipo==3) {
			 Polyincostruzione = [Polilinea alloc];  
			 [Polyincostruzione Init:_disegno : self]; [Polyincostruzione InitPolilinea:YES]; [Listavector addObject:Polyincostruzione]; 
			 posdata = [Polyincostruzione aprivettorialeMoM     :_data:posdata ];  
		 }	

		 if (tipo==5) { Cerchio *loccerchio; loccerchio = [Cerchio alloc]; 
			           [loccerchio Init:_disegno :self]; [loccerchio InitCerchio:0 :0 :1 :0];  [Listavector addObject:loccerchio]; 
			 posdata = [loccerchio aprivettorialeMoM     :_data:posdata];   }	
		 

         if (tipo==6) { Testo *loctesto; loctesto = [Testo alloc]; [loctesto Init :_disegno : self];
			           [loctesto InitTesto        :0 :0: 0:0];	 [Listavector addObject:loctesto]; 
			 posdata=[loctesto aprivettorialeMoM     :_data:posdata];   }	
	 
		 if (tipo==11) { Arco *locarco;      locarco = [Arco alloc]; 
			            [locarco Init :_disegno : self];  [locarco InitArco:0 :0 :0 :0 :0]; [Listavector addObject:locarco]; 
				 	posdata=	[locarco aprivettorialeMoM     :_data:posdata];   
			}	

		 if (tipo==10) { Simbolo *locSimbolo; locSimbolo = [Simbolo alloc]; 
						[locSimbolo Init:_disegno : self]; [locSimbolo InitSimbolo:0 :0 :0 :nil]; [Listavector addObject:locSimbolo]; 
			 posdata= [locSimbolo aprivettorialeMoM     :_data:posdata];  			  [locSimbolo ritrovadefdalista:defsimbol];	 }	
	
	 }
	
	return posdata;
}


- (void) cambianomedbase    : (NSString *)   _newtext                                                  {
	[_newtext retain];  [nomedbase release];	    nomedbase = _newtext;
}

- (void) cambianomeTavola   : (NSString *)   _newtext                                                  {
	[_newtext retain];  [nometavola release];	    nometavola = _newtext;
}

- (void) shpin              : (NSString *)   _nomedisegno                                              {
	double x1lim,y1lim,x2lim,y2lim;
	int Tiposhp;
	int laposizione0;
	int laposizione;

	NSData * _data;
	NSUInteger posdata;
	NSUInteger posparti;

	posdata=0;	
	posparti=0;	
	
	_data = [NSData dataWithContentsOfFile:_nomedisegno];
	posdata=32;	

	[_data getBytes:&Tiposhp range:NSMakeRange (posdata, sizeof(Tiposhp)) ];    posdata +=sizeof(Tiposhp);
	[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
	[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
	[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
	[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);

		//	NSLog(@"Shape type:%d",Tiposhp);
	posdata=108;	

	
	
	int recnum ;
	int Numparts,NumPoints ;
	int parts ;
	int parts1,parts2 ;

	Punto *locpunto;
	
	
	switch (Tiposhp) {
		case 1 : // Punti
			while ([_data length]>=(posdata+1)) {
				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum)) ];     posdata +=sizeof(recnum);
				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
				locpunto = [Punto alloc];	[locpunto Init:_disegno : self];	
			    [locpunto InitPunto: x1lim : y1lim];		[Listavector addObject:locpunto];	
				posdata +=8;
			}
			break; // caso 1 Punti
		case 3 : // Polilinee
			while ([_data length]>=(posdata+1)) {
				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum)) ];     posdata +=sizeof(recnum);
				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
				[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
				[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);
				[_data getBytes:&Numparts    range:NSMakeRange (posdata, sizeof(Numparts)) ];      posdata +=sizeof(Numparts);
				[_data getBytes:&NumPoints   range:NSMakeRange (posdata, sizeof(NumPoints)) ];     posdata +=sizeof(NumPoints);

				if  (Numparts==1) {
					Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO]; 
					[Listavector addObject:Polyincostruzione]; 
					[_data getBytes:&parts    range:NSMakeRange (posdata, sizeof(parts)) ];      posdata +=sizeof(parts);
					for (int i=0; i<NumPoints; i++) {  
						[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
						[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
						[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
					}
				}  else {
					
					Polyincostruzione = [Polilinea alloc]; [Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO];
					[Listavector addObject:Polyincostruzione]; 
					posparti=posdata;
					for (int kpa=0; kpa<(Numparts-1); kpa++) {  
						posdata = posparti+kpa*4;
						[_data getBytes:&parts1    range:NSMakeRange (posdata, sizeof(parts1)) ];      posdata +=sizeof(parts1);
						[_data getBytes:&parts2    range:NSMakeRange (posdata, sizeof(parts2)) ]; 
						posdata = posparti+Numparts*4+parts1*16;
						if (kpa<(Numparts-1)) {
							for (int kv=parts1; kv<parts2; kv++) {  
								[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
								[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
								if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
									[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
							}
						}
          	            else {
							for (int kv=parts2; kv<NumPoints; kv++) {  
								[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
								[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
								if (kv==parts2) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
									[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
							}
						}
					}
					posdata = posparti+Numparts*4+NumPoints*16;
				}
				posdata +=8;
			}
			break;  // caso 3 polilinee aperte
			
		case 5 : // Poligoni	
			while ([_data length]>=(posdata+1)) {
				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum)) ];      posdata +=sizeof(recnum);
				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
				[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
				[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);
				[_data getBytes:&Numparts    range:NSMakeRange (posdata, sizeof(Numparts)) ];      posdata +=sizeof(Numparts);
				[_data getBytes:&NumPoints   range:NSMakeRange (posdata, sizeof(NumPoints)) ];     posdata +=sizeof(NumPoints);
				if (Numparts==1) {
					Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES]; 
					[Listavector addObject:Polyincostruzione]; 
					[_data getBytes:&parts    range:NSMakeRange (posdata, sizeof(parts)) ];      posdata +=sizeof(parts);
					for (int i=0; i<NumPoints; i++) {  
						[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
						[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
 					  [Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
					}
				}
				else {
					Polyincostruzione = [Polilinea alloc]; [Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
					[Polyincostruzione setregione:YES];	
					[Listavector addObject:Polyincostruzione]; 
					posparti=posdata;
					for (int kpa=0; kpa<(Numparts-1); kpa++) {  
						posdata = posparti+kpa*4;
						[_data getBytes:&parts1    range:NSMakeRange (posdata, sizeof(parts1)) ];      posdata +=sizeof(parts1);
						[_data getBytes:&parts2    range:NSMakeRange (posdata, sizeof(parts2)) ]; 
						posdata = posparti+Numparts*4+parts1*16;
						if (kpa<(Numparts-1)) {
						  for (int kv=parts1; kv<parts2; kv++) {  
							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
						    if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
						  }
						}
          	            else {
						 for (int kv=parts2; kv<NumPoints; kv++) {  
								[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
								[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
								if (kv==parts2) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
									[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
						 }
						}
					}
					posdata = posparti+Numparts*4+NumPoints*16;
				}
				posdata +=8;
			}
			break; // qua 5 dei Poligoni e Regioni
			
		case 15 : // Poligoni	Z 
			

			
			while ([_data length]>=(posdata+1)) {
				laposizione0 = posdata;

					//				Double[4] Box // Bounding Box
				[_data getBytes:&recnum  range:NSMakeRange (posdata, sizeof(recnum))];      posdata +=sizeof(recnum);
				[_data getBytes:&x1lim   range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
				[_data getBytes:&y1lim   range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
				[_data getBytes:&x2lim   range:NSMakeRange (posdata, sizeof(x2lim)) ];      posdata +=sizeof(x2lim);
				[_data getBytes:&y2lim   range:NSMakeRange (posdata, sizeof(y2lim)) ];      posdata +=sizeof(y2lim);
					//	Integer NumParts // Number of Parts
				[_data getBytes:&Numparts    range:NSMakeRange (posdata, sizeof(Numparts)) ];      posdata +=sizeof(Numparts);
					//	Integer NumPoints // Total Number of Points
				[_data getBytes:&NumPoints   range:NSMakeRange (posdata, sizeof(NumPoints)) ];     posdata +=sizeof(NumPoints);
	
					//			NSLog(@"Tipo %d",recnum);
				if (Numparts==1) {
					Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES]; 
					[Listavector addObject:Polyincostruzione]; 
					[_data getBytes:&parts    range:NSMakeRange (posdata, sizeof(parts)) ];      posdata +=sizeof(parts);
					for (int i=0; i<NumPoints; i++) {  
						[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
						[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
						[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
					}
					
					laposizione = laposizione0 + 44 + (4 * Numparts)  + (16 * NumPoints);
					posdata = posparti+Numparts*4+NumPoints*16;
					posdata = laposizione + 24 + (8 *	 NumPoints);
					
					
				} else {
					Polyincostruzione = [Polilinea alloc]; [Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];
					[Polyincostruzione setregione:YES];	
					[Listavector addObject:Polyincostruzione]; 
					posparti=posdata;
					for (int kpa=0; kpa<(Numparts-1); kpa++) { 
						posdata = posparti+kpa*4;
					    [_data getBytes:&parts1    range:NSMakeRange (posdata, sizeof(parts1)) ];      posdata +=sizeof(parts1);
						[_data getBytes:&parts2    range:NSMakeRange (posdata, sizeof(parts2)) ]; 
						posdata = posparti+Numparts*4+parts1*16;
						if (kpa<(Numparts-1)) {
						for (int kv=parts1; kv<parts2; kv++) {  
							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
						    if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
						 }
						}
					  else {
						for (int kv=parts1; kv<NumPoints; kv++) {  
							[_data getBytes:&x1lim    range:NSMakeRange (posdata, sizeof(x1lim)) ];      posdata +=sizeof(x1lim);
							[_data getBytes:&y1lim    range:NSMakeRange (posdata, sizeof(y1lim)) ];      posdata +=sizeof(y1lim);
							if (kv==parts1) [Polyincostruzione addvertexUp:x1lim:y1lim]; else
								[Polyincostruzione addvertexnoUpdate:x1lim:y1lim:0 ];
						}
					  }
					}


					laposizione = laposizione0 + 44 + (4 * Numparts)  + (16 * NumPoints);
					posdata = posparti+Numparts*4+NumPoints*16;
					posdata = laposizione + 24 + (8 *	 NumPoints);
					
				  }

				}

			break;

    }
	
	
		//	[_data release];
	
	
	

}



- (int) dxfinPiano :(NSString *) _fileContents: (int) _i_filepos   : (NSMutableArray *) defsimbol    : (int) tipoelem               {
	tipoelemento = tipoelem;
  	NSString *tt=@"";
	int numvtlwpoly;
	int flag70;
    int flag72;
    i_filepos=_i_filepos;

/*    
    if ([tt isEqualToString:@"POINT"])      { tipoelemento= 1;  }
    if ([tt isEqualToString:@"INSERT"])     { tipoelemento= 4;  }
    if ([tt isEqualToString:@"LINE"])       { tipoelemento=20;  }
    if ([tt isEqualToString:@"VERTEX"])     { tipoelemento=101;  }
    if ([tt isEqualToString:@"POLYLINE"])   { tipoelemento= 2;  }
    if ([tt isEqualToString:@"CIRCLE"])     { tipoelemento= 5;  }
    if ([tt isEqualToString:@"SEQEND"])     { tipoelemento= 3;  }
    if ([tt isEqualToString:@"TEXT"])       { tipoelemento= 6;  }
    if ([tt isEqualToString:@"ARC"])        { tipoelemento= 7;  }
    if ([tt isEqualToString:@"LWPOLYLINE"]) { tipoelemento= 1000;  } 
    if ([tt isEqualToString:@"HATCH"])      { tipoelemento= 1001;  } 
*/
    bool doit =NO;
    switch (tipoelemento) {
        case 1 : case 4 : case 20 : case 2: case 101 : 
        case 5 : case 3 : case 6 : case 7:  case 1000: case 1001 : 
            doit =YES; break;
        default: doit =NO;
    }
    
    if (!doit) return i_filepos;
        
    NSString * _tt;
    while (YES) {
     _tt= [self leggirigafile:_fileContents:i_filepos]; 
	
	if (([_tt isEqualToString:@"  0"]) |  ([_tt isEqualToString:@"   0"]) ) { [self dxfinobjexecute];	return i_filepos;	}
	
	if ([_tt isEqualToString:@"  1"]) {		dxf_01= @"";	dxf_01= [self leggirigafile:_fileContents:i_filepos];  	     	}
	if ([_tt isEqualToString:@"  2"]) {		dxf_02= @"";	dxf_02= [self leggirigafile:_fileContents:i_filepos];  			}

	if ([_tt isEqualToString:@" 10"]) {	tt= [self leggirigafile:_fileContents:i_filepos]; 	dxf_10= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 20"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_20= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 30"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_30= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 11"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_11= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 21"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_21= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 31"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_31= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 40"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_40= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 41"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_41= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 42"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_42= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 50"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_50= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 51"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_51= [tt doubleValue];		}
	if ([_tt isEqualToString:@" 70"]) {	tt= [self leggirigafile:_fileContents:i_filepos];  	dxf_70= [tt doubleValue];		}
	
     if (tipoelemento==1000) { 
		flag70 =0;
		Polyincostruzione = [Polilinea alloc]; 	
		[Polyincostruzione Init:_disegno : self];  
		[Polyincostruzione InitPolilinea:NO];  
		[Listavector addObject:Polyincostruzione]; 
		tt= [self leggirigafile:_fileContents:i_filepos];
//		tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
		while (![tt isEqualToString:@" 90"]) {	tt= @"";	tt= [self leggirigafile:_fileContents:i_filepos]; 	}
		tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
		numvtlwpoly = [tt intValue];
		while (numvtlwpoly>0) {
			tt=@"";
			tt= [self leggirigafile:_fileContents:i_filepos]; 
			if ([tt isEqualToString:@" 70"]) {   // se e' o meno chiusa
				tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
				flag70 =  [tt intValue];
				if ((flag70==1) | (flag70==3) |  (flag70==9)|  (flag70==17)|  (flag70==33)|  (flag70==65) |  (flag70==129)) 
				{[Polyincostruzione polyinpoligono]; }
			};
			if ([tt isEqualToString:@" 10"]) {	dxf_10= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  }
			if ([tt isEqualToString:@" 20"]) {	dxf_20= [[self leggirigafile:_fileContents:i_filepos] doubleValue]; 		
		                                        [Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		numvtlwpoly--; 	 }			
		}
		[self svuotabooldxf];
	}
    
    if (tipoelemento==1001) { 
        int numgiri =1;
		flag70 =0;
 
        double x1star,y1star;
		tt= [self leggirigafile:_fileContents:i_filepos];
            //		tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
        while (![tt isEqualToString:@" 91"]) { tt= @""; tt= [self leggirigafile:_fileContents:i_filepos];    } 	
        tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
        numgiri = [tt intValue];

        Polyincostruzione = [Polilinea alloc]; 	
        [Polyincostruzione Init:_disegno : self];  
        [Polyincostruzione InitPolilinea:YES];  
        [Listavector addObject:Polyincostruzione]; 
        if (numgiri>1) [Polyincostruzione setregione : YES];
        for (int i=0; i<numgiri; i++) {
          bool primovt=YES;
            flag72 =1;
		  while (![tt isEqualToString:@" 93"]) {	tt= @"";	tt= [self leggirigafile:_fileContents:i_filepos]; 	}
		  tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
		  numvtlwpoly = [tt intValue];
          while (numvtlwpoly>0) {
			tt=@"";
			tt= [self leggirigafile:_fileContents:i_filepos]; 
			if ([tt isEqualToString:@" 70"]) {   // se e' o meno chiusa
				tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
				flag70 =  [tt intValue];
  			};
              if ([tt isEqualToString:@" 72"]) {   // se il vertice e' indicato in angolo raggio
                  tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
                  flag72 =  [tt intValue];
              };
              
              
			if ([tt isEqualToString:@" 10"]) {	dxf_10= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  }
			if ([tt isEqualToString:@" 20"]) {	dxf_20= [[self leggirigafile:_fileContents:i_filepos] doubleValue]; 		
                if (flag72!=2) {
                if (primovt)   { if (i>0)   {[Polyincostruzione addvertexUp: dxf_10:dxf_20 ]; }  x1star = dxf_10; y1star = dxf_20; primovt=NO; };
                [Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		numvtlwpoly--;    
                }
            }			
              if (flag72==2) {
                  if ([tt isEqualToString:@" 40"]) {	dxf_40= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  }
                  if ([tt isEqualToString:@" 50"]) {	dxf_50= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  }
                  if ([tt isEqualToString:@" 51"]) {	dxf_51= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  }		   
                  if ([tt isEqualToString:@" 73"]) {	dxf_73= [[self leggirigafile:_fileContents:i_filepos] doubleValue];  
                      
                      
                      dxf_50 = dxf_50*M_PI/180;                   dxf_51 = dxf_51*M_PI/180;
                      if (dxf_73==0) {  dxf_50 = - dxf_50;  dxf_51 = -dxf_51;             }
                      
                      double newx1= dxf_40*cos(dxf_50);           double newy1= dxf_40*sin(dxf_50);

                      
                          //     dxf_10=0;                   dxf_20=0;
                      if (primovt)   { if (i>0)   {[Polyincostruzione addvertexUp: dxf_10+newx1+newy1:dxf_20 ]; }  
                                        x1star = dxf_10+newx1; y1star = dxf_20+newy1; primovt=NO; };
                     [Polyincostruzione addvertex:dxf_10+newx1:dxf_20+newy1:0 ];		
                     newx1= dxf_40*cos(dxf_51);           newy1= dxf_40*sin(dxf_51);
                     [Polyincostruzione addvertex:dxf_10+newx1:dxf_20+newy1:0 ];		
                      numvtlwpoly--;    
                  }
             }  
		   }
            [Polyincostruzione addvertex:x1star:y1star:0 ];
                //         [Polyincostruzione chiudiconVtSeAperta];
        }
        if (numgiri>1){ [Polyincostruzione addvertexUpHereToStart  ];  [Polyincostruzione updateRegione]; 
        }

        
		[self svuotabooldxf];

     }
    }
    

	
	return i_filepos;
} 

- (void) dxfinPianoK :(NSArray *) Righe: (int *) rigacorrente   : (NSMutableArray *) defsimbol    : (int) tipoelem :(bool) toglictr             {
	tipoelemento = tipoelem;
  	NSString *tt=@"";
	int numvtlwpoly;
	int flag70;
    int flag72;
		//    i_filepos=_i_filepos;

	/*    
	 if ([tt isEqualToString:@"POINT"])      { tipoelemento= 1;  }
	 if ([tt isEqualToString:@"INSERT"])     { tipoelemento= 4;  }
	 if ([tt isEqualToString:@"LINE"])       { tipoelemento=20;  }
	 if ([tt isEqualToString:@"VERTEX"])     { tipoelemento=101;  }
	 if ([tt isEqualToString:@"POLYLINE"])   { tipoelemento= 2;  }
	 if ([tt isEqualToString:@"CIRCLE"])     { tipoelemento= 5;  }
	 if ([tt isEqualToString:@"SEQEND"])     { tipoelemento= 3;  }
	 if ([tt isEqualToString:@"TEXT"])       { tipoelemento= 6;  }
	 if ([tt isEqualToString:@"ARC"])        { tipoelemento= 7;  }
	 if ([tt isEqualToString:@"LWPOLYLINE"]) { tipoelemento= 1000;  } 
	 if ([tt isEqualToString:@"HATCH"])      { tipoelemento= 1001;  } 
	 */
    bool doit =NO;
    switch (tipoelemento) {
        case 1 : case 4 : case 20 : case 2: case 101 : 
        case 5 : case 3 : case 6 : case 7:  case 1000:  case 1001 : 
            doit =YES; break;
				//		case 1001 :    	tipoelemento=0; break;
        default: doit =NO; break;
    }
    
    if (!doit) return;
	
    NSString * _tt;
    while (YES) {

		_tt= [Righe objectAtIndex:*rigacorrente]; *rigacorrente = *rigacorrente+1;	
        if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];
			//		_tt= [self leggirigafile:_fileContents:i_filepos]; 
		if (([_tt isEqualToString:@"  0"]) |  ([_tt isEqualToString:@"   0"]) ) { [self dxfinobjexecute]; 	return;	}
		if ([_tt isEqualToString:@"  1"]) {	dxf_01= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 
			if (toglictr) dxf_01 = [dxf_01 substringToIndex:([dxf_01 length]-1)];  }
		if ([_tt isEqualToString:@"  2"]) {	dxf_02= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 
			if (toglictr) dxf_02 = [dxf_02 substringToIndex:([dxf_02 length]-1)];  }
		if ([_tt isEqualToString:@" 10"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];	dxf_10= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 20"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_20= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 30"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_30= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 11"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_11= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 21"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_21= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 31"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_31= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 40"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_40= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 41"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_41= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 42"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_42= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 50"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_50= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 51"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_51= [_tt doubleValue];		}
		if ([_tt isEqualToString:@" 70"]) {	_tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) _tt = [_tt substringToIndex:([_tt length]-1)];   dxf_70= [_tt doubleValue];		}
		
		if (tipoelemento==1000) { 
			flag70 =0;
			Polyincostruzione = [Polilinea alloc]; 	
			[Polyincostruzione Init:_disegno : self];  
			[Polyincostruzione InitPolilinea:NO];  
			[Listavector addObject:Polyincostruzione]; 
			tt= [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  
			if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
				//		tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere

			while (![tt isEqualToString:@" 90"]) {	
				tt=[Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 

				if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					//			NSLog(@"- del 90 %@ ",tt);
			}

			tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
			if (toglictr) tt = [tt substringToIndex:([tt length]-1)];   
				//		NSLog(@"- Num Giri 90 %@ ",tt);
			
				//			tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
			numvtlwpoly = [tt intValue];
			while (numvtlwpoly>0) {

				tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; 
				if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
				
				if ([tt isEqualToString:@"ENDSEC"]){	return;		} 

					//				tt=@"";			tt= [self leggirigafile:_fileContents:i_filepos]; 
				if ([tt isEqualToString:@" 70"]) {   // se e' o meno chiusa
					tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;
					if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
						//					tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
					flag70 =  [tt intValue];
					if ((flag70==1) | (flag70==3) |  (flag70==9)|  (flag70==17)|  (flag70==33)|  (flag70==65) |  (flag70==129)) 
					{[Polyincostruzione polyinpoligono]; }
				};
				if ([tt isEqualToString:@" 10"]) {
					tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					dxf_10= [tt doubleValue]; }
				if ([tt isEqualToString:@" 20"]) {	
					tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1; if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					dxf_20= [tt doubleValue];  		
					[Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		numvtlwpoly--; 	 }			
			}
			[self svuotabooldxf];
		}
		if (tipoelemento==1001) { 
			int numgiri =1;
			flag70 =0;
			
			double x1star,y1star;
			tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  
			
			if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
				//			tt= [self leggirigafile:_fileContents:i_filepos];
				//		tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
			while (![tt isEqualToString:@" 91"]) { 
				tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					//				tt= @""; tt= [self leggirigafile:_fileContents:i_filepos];    
			} 
			tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
				//			tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
			numgiri = [tt intValue];
			
				//			if ((*rigacorrente>487472) & (*rigacorrente<500000)) NSLog(@"- Numgiri %d %d",numgiri,*rigacorrente);
			
			Polyincostruzione = [Polilinea alloc]; 	
			[Polyincostruzione Init:_disegno : self];  
			[Polyincostruzione InitPolilinea:YES];  
				[Listavector addObject:Polyincostruzione]; 
			if (numgiri>1) [Polyincostruzione setregione : YES];
			for (int i=0; i<numgiri; i++) {
				
				bool primovt=YES;
				flag72 =1;
				while (![tt isEqualToString:@" 93"]) {	
					tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					
						//					tt= @"";	tt= [self leggirigafile:_fileContents:i_filepos]; 	
				}
				tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
					//				tt= @""; tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos]; // spazio spazio da togliere
				numvtlwpoly = [tt intValue];
				while (numvtlwpoly>0) {
					tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
						//					tt=@"";		tt= [self leggirigafile:_fileContents:i_filepos]; 
					if ([tt isEqualToString:@" 70"]) {   // se e' o meno chiusa
						tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
							//						tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
						flag70 =  [tt intValue];
					};
					if ([tt isEqualToString:@" 72"]) {   // se il vertice e' indicato in angolo raggio
						tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
							//						tt=@"";	tt= [self leggirigafilesenzaspazi:_fileContents:i_filepos];
						flag72 =  [tt intValue];
					};
					
					

					if ([tt isEqualToString:@" 10"]) {
						tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
						dxf_10= [tt doubleValue];  }
					if ([tt isEqualToString:@" 20"]) {
						tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
						dxf_20= [tt doubleValue]; 	
						if (flag72!=2) {
							if (primovt)   { if (i>0)   {[Polyincostruzione addvertexUp: dxf_10:dxf_20 ]; }  x1star = dxf_10; y1star = dxf_20; primovt=NO; };
							[Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		numvtlwpoly--;    
						}
					}			
					if (flag72==2) {
						if ([tt isEqualToString:@" 40"]) {
							tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
                            dxf_40= [tt doubleValue];   }
						if ([tt isEqualToString:@" 50"]) {	
							tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
                            dxf_50= [tt doubleValue];   }
						if ([tt isEqualToString:@" 51"]) {
							tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
                            dxf_51= [tt doubleValue];   }		   
						if ([tt isEqualToString:@" 73"]) {
							tt = [Righe objectAtIndex:*rigacorrente];  *rigacorrente = *rigacorrente+1;  if (toglictr) tt = [tt substringToIndex:([tt length]-1)];
                            dxf_73= [tt doubleValue]; 							
							dxf_50 = dxf_50*M_PI/180;                   dxf_51 = dxf_51*M_PI/180;
							if (dxf_73==0) {  dxf_50 = - dxf_50;  dxf_51 = -dxf_51;             }
							
							double newx1= dxf_40*cos(dxf_50);           double newy1= dxf_40*sin(dxf_50);
							
							
								//     dxf_10=0;                   dxf_20=0;
							if (primovt)   { if (i>0)   {[Polyincostruzione addvertexUp: dxf_10+newx1+newy1:dxf_20 ]; }  
								x1star = dxf_10+newx1; y1star = dxf_20+newy1; primovt=NO; };
							[Polyincostruzione addvertex:dxf_10+newx1:dxf_20+newy1:0 ];		
							newx1= dxf_40*cos(dxf_51);           newy1= dxf_40*sin(dxf_51);
							[Polyincostruzione addvertex:dxf_10+newx1:dxf_20+newy1:0 ];		
							numvtlwpoly--;    
						}
					}  
				}
				[Polyincostruzione addvertex:x1star:y1star:0 ];
					//         [Polyincostruzione chiudiconVtSeAperta];
			}
			if (numgiri>1){ [Polyincostruzione addvertexUpHereToStart  ];  [Polyincostruzione updateRegione]; 
			}
			
			
			[self svuotabooldxf];
			
		}
	
    }
} 


- (void) dxfinobjexecute                                                                               {
	Punto *locpunto;
	Testo *loctesto;
	Cerchio *loccerchio;
		//	Simbolo *locsimbolo;
	Arco    *locarco;


	
	switch (tipoelemento) {
		case 1:	locpunto = [Punto alloc];	[locpunto Init:_disegno : self];	
			    [locpunto InitPunto: dxf_10 : dxf_20];		[Listavector addObject:locpunto];		
				//			NSBeep();
			break;
		case 4:
				locpunto = [Punto alloc];	[locpunto Init:_disegno : self];
			[locpunto InitPunto: dxf_10 : dxf_20];		[Listavector addObject:locpunto];		

				//							    locsimbolo = [Simbolo alloc];	[locsimbolo Init:_disegno : self];	
				//			    [locsimbolo InitSimbolo: dxf_10 : dxf_20];	
				//				[Listavector addObject:locsimbolo];	
			break;

		case 20:	
 		   Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO]; 
				[Listavector addObject:Polyincostruzione]; 
				[Polyincostruzione addvertex:dxf_10:dxf_20:0 ];
				[Polyincostruzione addvertex:dxf_11:dxf_21:0 ];
			
				//			NSLog(@"Linea %@ %@",dxf_10,dxf_20);
			
			break;
		case 101 :	[Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		break;
		case 6:
			loctesto = [Testo alloc];
			[loctesto Init:_disegno : self];
			[loctesto InitTestoStr:dxf_10 : dxf_20 : dxf_40 : dxf_50 :dxf_01];  
			[Listavector addObject:loctesto];
			break;
		case 2:
		    Polyincostruzione = [Polilinea alloc]; 	
		    [Polyincostruzione Init:_disegno : self];  
		    [Polyincostruzione InitPolilinea:NO]; 
			if ((dxf_70==1) | (dxf_70==3) |  (dxf_70==9)|  (dxf_70==17)|  (dxf_70==33)|  (dxf_70==65) |  (dxf_70==129)) 
			{[Polyincostruzione polyinpoligono]; }
	       	[Listavector addObject:Polyincostruzione]; 
			break;
		case 3:
			
			break;

        case 7:
			locarco = [Arco alloc];
			[locarco Init:_disegno : self];  
		    [locarco InitArco:dxf_10:dxf_20:dxf_40:dxf_50:dxf_51];
			[Listavector addObject:locarco];
			break;
		case 5:
			loccerchio = [Cerchio alloc];	[loccerchio Init:_disegno : self];
			[loccerchio InitCerchio:dxf_10:dxf_20:dxf_10:dxf_20+dxf_40];
			[Listavector addObject:loccerchio];
			break;
        case 21:	
	        [Polyincostruzione addvertex:dxf_10:dxf_20:0 ]; break;
		default:	break;
	}
	[self svuotabooldxf];
	
		//	NSLog(@"%d",[self givemeNumObjpiano] );
}


- (void) svuotabooldxf                                                                                 {
	b_dxf_10=NO; b_dxf_20=NO; b_dxf_30=NO;
	dxf_50 =0;
	tipoelemento = -1;
}


- (NSString *) prendirigapulita : (int *) indice : (NSArray * ) Lista {
	*indice = *indice+1;
	return [[Lista objectAtIndex:(*indice)-1] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet ]];	
}


	
- (int)  cxfinPiano2:(NSArray *) listarighe :(int *) indriga :(NSString *)_tt:(NSMutableArray *)defsimbol  {
	int indrigaris;
	
	double x1,y1,x2,y2 ;	bool tomakeup=NO;
	double xback,yback;
	int nvt;
	NSString *tt;
	if ([_tt isEqualToString:@"BORDO"]){
		Testo *loctesto=nil;
		for (int i=0; i<2; i++) {  tt = [self prendirigapulita : indriga :listarighe];	}  // lettura delle prime 6 righe
		
		tt = [self prendirigapulita : indriga :listarighe];  x1 = [tt doubleValue];
		tt = [self prendirigapulita : indriga :listarighe];  y1 = [tt doubleValue];
		tt = [self prendirigapulita : indriga :listarighe];  x2 = [tt doubleValue];
		tt = [self prendirigapulita : indriga :listarighe];  y2 = [tt doubleValue];

		
		
		[info catastotoutm : &x1 : &y1 ];
		[info catastotoutm : &x2 : &y2 ];
		if ((![nomepiano isEqualToString:@"STRADA"])  & (![nomepiano isEqualToString:@"ACQUA"]) ) {
			NSRange myrange;	myrange.location=[nomepiano length]-1;    myrange.length = 1;
			if ([nomepiano compare:@"+" options:NSCaseInsensitiveSearch range:myrange] ==0)    {
			} else	{
				loctesto = [Testo alloc];		[loctesto Init:_disegno : self];	
			    [loctesto InitTestoStr:x1 : y1 : 6 : 0 :nomepiano];  
				[Listavector addObject:loctesto];
			}
		}
		
		int nisole;
		tt = [self prendirigapulita : indriga :listarighe];  nisole = [tt intValue];
	    int vtisole[nisole];	
		tt = [self prendirigapulita : indriga :listarighe];  nvt = [tt intValue];
		Polyincostruzione = nil;
		Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:YES];  
	    [Listavector addObject:Polyincostruzione]; 
		if (nisole>0) [Polyincostruzione setregione:YES];
		for (int i=0; i<nisole; i++) { 	tt = [self prendirigapulita : indriga :listarighe];  vtisole[i]=[tt intValue];	}
		int sommavtisole=0;
		for (int i=0; i<nisole; i++) {  sommavtisole = sommavtisole +vtisole[i];}		
		int backvtisola;
		for (int i=0; i<nisole; i++) { 	backvtisola = vtisole[i];	vtisole[i]=nvt-sommavtisole;	sommavtisole = sommavtisole-backvtisola;	}
	    for (int i=0; i<nvt; i++) {  
			tt = [self prendirigapulita : indriga :listarighe];   dxf_10= [tt doubleValue];
			tt = [self prendirigapulita : indriga :listarighe];   dxf_20= [tt doubleValue];
			[info catastotoutm : &dxf_10 : &dxf_20 ];
			if (nisole>0) {		if (i==vtisole[0]-1) {  xback=dxf_10;	  yback=dxf_20;	  }		}
			tomakeup=NO;
			for (int j=0; j<nisole; j++) {  if (i==vtisole[j]) tomakeup=YES;	}
			if (tomakeup) {	[ Polyincostruzione addvertexUp:dxf_10:dxf_20 ];  }
			else  	    [ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];
		}
		double supPol = [Polyincostruzione superficie];
		if (supPol>0) {
			if (supPol<3000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 2.0];	}
			if (supPol>20000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 8.0];	}
			if (supPol>30000) {	if (loctesto!=nil)	[loctesto cambiaaltezza : 10.0];	}
		}
		
		return i_filepos;
	}  // bordo
	
	if (([_tt isEqualToString:@"LINEA"]) | ([_tt isEqualToString:@"LINEA\\"]))  {
		tt = [self prendirigapulita : indriga :listarighe];   
		tt = [self prendirigapulita : indriga :listarighe];   				 nvt = [tt intValue];
		Polyincostruzione = nil;
		Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO];  
		[Listavector addObject:Polyincostruzione]; 
		for (int i=0; i<nvt; i++) {  
			tt = [self prendirigapulita : indriga :listarighe];    dxf_10= [tt doubleValue];
			tt = [self prendirigapulita : indriga :listarighe];    dxf_20= [tt doubleValue];
			[info catastotoutm : &dxf_10 : &dxf_20 ];
			[ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];
		}		
		return i_filepos;
	}
	if ( ([_tt isEqualToString:@"TESTO"]) | ([_tt isEqualToString:@"TESTO\\"]) ){
		NSString *tttesto= [self prendirigapulita : indriga :listarighe];  
		
	    tt = [self prendirigapulita : indriga :listarighe];   		double htxt = [tt doubleValue];
		tt = [self prendirigapulita : indriga :listarighe];  		double angtxt = [tt doubleValue];
		tt = [self prendirigapulita : indriga :listarighe];         dxf_10= [tt doubleValue];
	    tt = [self prendirigapulita : indriga :listarighe];         dxf_20= [tt doubleValue];
		[info catastotoutm : &dxf_10 : &dxf_20 ];
		Testo *loctesto;		
		loctesto = [Testo alloc];		[loctesto Init:_disegno : self];	[loctesto InitTestoStr:dxf_10 : dxf_20 : htxt : angtxt :tttesto];  
		[Listavector addObject:loctesto];
	}
	
	
	if ( [_tt isEqualToString:@"FIDUCIALE"] ) {
		NSString *tttesto=	[self prendirigapulita : indriga :listarighe];  
		tt = [self prendirigapulita : indriga :listarighe];  		 // codice simbolo
		Polyincostruzione = nil;
		Polyincostruzione = [Polilinea alloc]; 	[Polyincostruzione Init:_disegno : self];  [Polyincostruzione InitPolilinea:NO];  
		[Listavector addObject:Polyincostruzione]; 
		tt = [self prendirigapulita : indriga :listarighe];    dxf_10= [tt doubleValue];
        tt = [self prendirigapulita : indriga :listarighe];    dxf_20= [tt doubleValue];
		[info catastotoutm : &dxf_10 : &dxf_20 ];
		[ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		
		tt = [self prendirigapulita : indriga :listarighe];    dxf_10= [tt doubleValue];
        tt = [self prendirigapulita : indriga :listarighe];    dxf_20= [tt doubleValue];
		[info catastotoutm : &dxf_10 : &dxf_20 ];
		[ Polyincostruzione addvertex:dxf_10:dxf_20:0 ];		
		Testo *loctesto;		
		loctesto = [Testo alloc];		[loctesto Init:_disegno : self];	[loctesto InitTestoStr:dxf_10 : dxf_20 : 10 : 0 :tttesto];  
		[Listavector addObject:loctesto];
	}
	
	
	if ( [_tt isEqualToString:@"SIMBOLO"] ) {
        tt = [self prendirigapulita : indriga :listarighe];    	 // codice simbolo
		int codsim = [tt intValue];
        tt = [self prendirigapulita : indriga :listarighe];    	 // angolo simbolo
		double angsim = [tt doubleValue];
		
        tt = [self prendirigapulita : indriga :listarighe];       dxf_10= [tt doubleValue];
        tt = [self prendirigapulita : indriga :listarighe];      dxf_20= [tt doubleValue];
		[info catastotoutm : &dxf_10 : &dxf_20 ];
		
			//		codsim =0;
		Simbolo * locsimb = [Simbolo alloc];
		[locsimb Init:_disegno : self];
		[locsimb InitSimbolo:dxf_10:dxf_20:codsim : defsimbol ];
		[Listavector addObject:locsimb];
		
		[locsimb ruotasimbolo :angsim ];
		
		
	}
	
	
	return indrigaris;
}		



- (void) creadefsimbolo : (NSMutableArray *) listadefsimboli  : (int) indice                           {
	DefSimbolo * locdefsimbolo;
	Punto      * LocPt;
	double xc , yc ;	xc = limx1; yc = limy1;
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if ([objvector dimmitipo]==1) {	LocPt = [Listavector objectAtIndex:i];	xc = [LocPt x]; 	yc = [LocPt y];   break;}
	}
	locdefsimbolo = [DefSimbolo alloc];
	[locdefsimbolo	InitSimbolo :indice  :xc :yc :nomepiano ];
	[listadefsimboli addObject:locdefsimbolo];
		// ora passare tutti i grafici spostati del centro in offset
	NSMutableArray * inlista;	inlista = [locdefsimbolo Listavector];
	
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Sposta  :-xc :  -yc]; 
		if ([objvector dimmitipo]==1) continue;
        [objvector CopiainLista : inlista];
	}
	
	
	
}



- (void) settacolorepiano :(CGContextRef) hdc : (float) _alfal : (float) alfas                         {
	CGContextSetRGBStrokeColor (hdc, f_rosso, f_verde, f_blu, ( f_alfalineepiano     * _alfal ));
	CGContextSetRGBFillColor   (hdc, f_rosso, f_verde, f_blu, ( f_alfasuperficipiano * alfas  ));
	
	if (info.instampa) {
		if ((f_rosso==1.0) & (f_verde==1.0) & (f_blu==1.0) ){
			CGContextSetRGBStrokeColor (hdc, 0.0, 0.0, 0.0,  ( f_alfalineepiano     * _alfal ) );
		}
	}
	
}

- (void) settacolorepallozzi :(CGContextRef) hdc : (float) _alfal : (float) alfas                      {
	CGContextSetRGBStrokeColor (hdc, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor   (hdc, 1.0, 1.0, 1.0, 1.0);
}


- (void)  faicolorepianoint:(int) _value                                                               {
	float locval;
	locval =  (float) fmod(_value,256);  	f_rosso = locval/255;
	_value = _value/256;
	locval =  (float) fmod(_value,256);  	f_verde = locval/255;
	_value = _value/256;
	locval =  (float) fmod(_value,256);  	f_blu   = locval/255;
}



- (float) colorepiano_r  {
	return f_rosso;	
}

- (float) colorepiano_g  {
	return f_verde;
}

- (float) colorepiano_b  {
	return f_blu;
}

- (double) dimpunto      {
	return dimpunto;
}


- (void)  setcolorpianorgb :(float) _r :(float) _g :(float) _b           {
	f_rosso=_r;	f_verde=_g;	f_blu=_b;
}


- (void)  setvisibile    :(int)   _state                                 {
	if (_state==NSOnState) b_visibilepiano=YES; else b_visibilepiano=NO;
}
- (bool)  visibile                                                       { return b_visibilepiano;}
- (void)  seteditabile   :(int)   _state                                 {
	if (_state==NSOnState) b_editabile=YES; else b_editabile=NO;
}
- (bool)  editabile                                                      { return b_editabile;}
- (void)  setsnappabile  :(int)   _state                                 {
	if (_state==NSOnState) b_snappabile=YES; else b_snappabile=NO;
}
- (bool)  snappabile                                                     { return b_snappabile;}

- (void)  SpostaPiano    : (double) dx    : (double) dy                  {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Sposta:dx :dy];
	}
    
        //    limx1 = limx1+ dx; limx2 = limx2 + dx;
        //    limy1 = limy1+ dy; limy2 = limy2 + dy;

    
}

- (void)  RuotaPiano     : (double) xc    : (double) yc: (double) angrot {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Ruota:xc :yc :angrot];
	}
}

- (void)  ScalaPiano     : (double) xc    : (double) yc: (double) scal   {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Scala:xc :yc :scal];
	}
	objvector=nil;
}


- (void)  setalphaline   :(float) _value                                 {
	f_alfalineepiano=_value;
    
}

- (void)  setalphasup    :(float) _value                                 {
    f_alfasuperficipiano=_value;
}

- (void)  setspessore    :(float) _value                                 {
	if (_value<0.1) _value=0.1;
		//	if (_value>1.0) _value=1.0;
	f_spessoreline = _value;
}


- (void) setdimpunto   : (double) dim                                    {
	dimpunto = dim;
}

- (float) getalphaline                                                   {	return f_alfalineepiano; }

- (float) getalphasup                                                    {	return f_alfasuperficipiano; }

- (float) getspessore                                                    {
	return (float)f_spessoreline;
}




- (void)  Disegna:(CGContextRef) hdc:  (float) _alfal : (float) alfas    {
	if (!b_visibilepiano) return;
	CGContextSaveGState    (hdc);
	[self settacolorepiano :hdc : _alfal : alfas];
	
		//	[info settapattern :hdc: i_campitura : f_rosso : f_verde : f_blu : [_disegno alphasup]*f_alfasuperficipiano  ] ;
	
	if (i_campitura!=0) [info settapattern :hdc: i_campitura : f_rosso : f_verde : f_blu : [_disegno alphasup]*f_alfasuperficipiano  ] ;

	 
	CGContextSetLineWidth  (hdc,[self getspessore]);
	[self mettitratteggio  : hdc : i_tratteggio];
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if (![objvector testinternoschermo:info]) {	continue;	}
		[objvector Disegna:hdc : info];
	}
	if (b_dispallinivt)        [self disegnavtpl       : hdc];
    if (b_dispallinivtfinali)  [self disegnavtfinalipl : hdc]; 
	objvector=nil;
	CGContextRestoreGState (hdc);
	
	if ([info VedoVerticiTuttoDisegno] & b_editabile & b_snappabile)  {
		CGContextSaveGState    (hdc);
		[self settacolorepallozzi :hdc : _alfal : alfas];
		if ([_disegno editabile] & [_disegno snappabile] )  [self disegnavtpl       : hdc];
		CGContextRestoreGState (hdc);
	}
	
}

- (void)  DisegnaSplineVirtuale: (CGContextRef) hdc :(int) x1: (int) y1  {
	[Polyincostruzione DisegnaSplineVirtuale:hdc : x1:  y1 : info];
}

- (void) disegnavtpl       :(CGContextRef) hdc                           {
	if (!b_visibilepiano)  return;
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
			//	if ([objvector cancellato]) continue;
		if (![objvector testinternoschermo:info]) {	continue;	}
					[objvector DisegnaVtTutti:hdc : info];
	}
}

- (void) disegnavtfinalipl :(CGContextRef) hdc                           {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		if (![objvector testinternoschermo:info]) {	continue;	}
				[objvector DisegnaVtFinali:hdc : info];
	}
}


- (void)   DisSpostaPiano : (CGContextRef) hdc : (double) dx : (double) dy {
	[self settacolorepiano :hdc :1.0 : 0.1];
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector DisegnaAffineSpo:hdc:info :dx :dy];
	}
	objvector=nil;
}

- (void)   DisRuotaPiano  : (CGContextRef) hdc : (double) xc : (double) yc : (double) ang  {
	[self settacolorepiano :hdc :1.0 : 0.1];
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
//		[objvector DisegnaAffineSpo:hdc:P_info :dx :dy];
		[objvector DisegnaAffineRot:hdc:info :xc :yc :ang];
	}
	objvector=nil;
}

- (void)   DisScalaPiano  : (CGContextRef) hdc : (double) xc : (double) yc : (double) scal {
	[self settacolorepiano :hdc :1.0 : 0.1];
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
//		[objvector DisegnaAffineSpo:hdc:P_info :dx :dy];
		[objvector DisegnaAffineSca:hdc:info :xc :yc :scal];

	}
	objvector=nil;
}

- (void)   Distxtvirtual  : (CGContextRef) hdc : (double) xc : (double) yc : (double) ang : (double) scal {
		//	[Testoincostruzione DisegnaAffineSpo : hdc    : P_info : xc : yc ];
	[Testoincostruzione DisegnaSpoRotSca : hdc : info : xc : yc : ang : scal]; 
}



- (void) disegnailpianino : (CGContextRef) hdc   : (NSRect) fondo        {
	[self settacolorepiano :hdc :1.0 : 1.0];
// qui creare un nuovo info da passare con origine e scala modificata
// superflui in info i 3 parametri vettorino aggiunti
	InfoObj  *IlloInfo = [InfoObj alloc];
	[self faiLimiti];
	[IlloInfo  setLimitiDisV :limx1 : limy1 : limx2 : limy2];
	[IlloInfo setZoomAllVector];  
	
	[IlloInfo set_origineVista:limx1 :limy1 ];
	double locscal,locscal2;
	locscal  = (limx2-limx1)/fondo.size.width;
	locscal2 = (limy2-limy1)/fondo.size.height;
    if (locscal<locscal2) locscal=locscal2;
	[IlloInfo set_scalaVista  :locscal ];
	
	
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector Disegna:hdc : IlloInfo];
	}
	
	[IlloInfo release];
	IlloInfo = nil;
	
}

- (void) dispallinispline : (CGContextRef) hdc                           {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector dispallinispline:hdc :info];
	}
}



- (bool) snapFine        :(double) x1 : (double) y1                      {
	

	bool locres=NO;
	if (!b_visibilepiano) return locres;
    if (!b_snappabile)    return locres;
	
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		locres    = [objvector SnapFine:info :x1:y1];
		if (locres) break;
    }
	

	return locres;
}

- (bool) snapVicino      :(double) x1 : (double) y1	                     {
	bool locres=NO;
    if (!b_visibilepiano) return locres;
	if (!b_snappabile) return locres;
	Vettoriale *objvector;
     for (int i=0; i<Listavector.count; i++) {  
	  objvector = [Listavector objectAtIndex:i];
	  locres    = [objvector SnapVicino:info :x1:y1];
	  if (locres) break;
    }
return locres;
}

- (void) ortosegmenta    :(double) x1 : (double) y1                      {
	[Polyincostruzione ortosegmenta:info: x1 :y1];
}


- (void) faiLimiti                                                       {
    limx1=0; limx2=0; limy1=0;  limy2=0;
	Vettoriale *vet;
    bool iniziato =NO;
	for (int i=0; i<Listavector.count; i++) {  
      vet= [Listavector objectAtIndex:i]; 
      if ([vet cancellato]) continue;
      [vet faiLimiti];
      if (!iniziato) {
          limx1=[vet limx1];	   limx2=[vet limx2]; 	   limy1=[vet limy1];	   limy2=[vet limy2];  iniziato=YES;
      } else {
          if (limx1>[vet limx1])   limx1=[vet limx1];	
          if (limy1>[vet limy1])   limy1=[vet limy1];	 
          if (limx2<[vet limx2])   limx2=[vet limx2];	 
          if (limy2<[vet limy2])   limy2=[vet limy2];	 
      }
	}
}
- (double) limx1                                                         { return limx1;};
- (double) limy1                                                         { return limy1;};
- (double) limx2                                                         { return limx2;};
- (double) limy2                                                         { return limy2;};


- (void) seleziona_conPt  : (CGContextRef) hdc  :(double) x1  : (double) y1  : (NSMutableArray *) _LSelezionati {
	if (![self visibile]) return ;
	if (![self editabile]) return ;

	Vettoriale *objvector;	Vettoriale *objcomp; 
	bool NotinList;
    if (!b_visibilepiano) return ;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		NotinList = YES;
		for (int j=0; j<_LSelezionati.count; j++) { 
		 objcomp = [_LSelezionati objectAtIndex:j];	if (objcomp==objvector)	NotinList = NO;
		}
		if (NotinList) [objvector seleziona_conPt : hdc : info :  x1 : y1 :_LSelezionati];
    }
}


- (void) seleziona_conPtInterno  : (CGContextRef)  hdc     : (double) x1  : (double) y1: (NSMutableArray *) _LSelezionati  {
	if (![self visibile]) return ;
	if (![self editabile]) return ;
	
	Vettoriale *objvector;	Vettoriale *objcomp; 
	bool NotinList;
    if (!b_visibilepiano) return ;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		NotinList = YES;
		for (int j=0; j<_LSelezionati.count; j++) { 
			objcomp = [_LSelezionati objectAtIndex:j];	if (objcomp==objvector)	NotinList = NO;
		}
		if (NotinList) [objvector seleziona_conPtInterno : hdc : info :  x1 : y1 :_LSelezionati];
    }
}


- (bool) Match_conPt      :(double) x1 : (double) y1                       {
	if (![self visibile]) return NO;
	if (![self editabile]) return NO;

	bool locres=NO;
	Vettoriale *objvector;
    if (!b_visibilepiano) return locres;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
        if ([objvector Match_conPt : info :  x1 : y1 ]) {	locres=YES; break; }
    }
	return locres;
}


- (bool) selezionaVtconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati{
	bool locres=NO;
	if (![self visibile]) return NO;
	if (![self editabile]) return NO;

	Vettoriale *objvector; 	
    if (!b_visibilepiano) return locres;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		if ([objvector selezionaVtconPt: hdc: info : x1 : y1 : _LSelezionati ])   { locres=YES; break; }
    }
	return locres;
}

- (bool) selezionaVtspconPt : (CGContextRef) hdc  :(double) x1 : (double) y1 : (NSMutableArray *) _LSelezionati{
	bool locres=NO;
	if (![self visibile]) return NO;
	Vettoriale *objvector; 	
    if (!b_visibilepiano) return locres;
	for (int i=0; i<Listavector.count; i++) {  
		objvector = [Listavector objectAtIndex:i];
		if ([objvector cancellato]) continue;
		if (![objvector isspline]) continue;
		if ([objvector selezionaVtconPt: hdc: info : x1 : y1 : _LSelezionati ])   { locres=YES; break; }
    }
	return locres;
}




- (void) settratteggio : (int) indtratto                                 {
	i_tratteggio = indtratto;
}

- (void) setCampitura  : (int) indcamp                                   {
	i_campitura  = indcamp;
}


- (void) coloreCatastoCivitavecchia                                      {
	
	if ([nomepiano isEqualToString:@"CAT-VARIE"])             [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-SIMBOLI"])           [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-GPARAM"])            [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"TEMP"])                  [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-TEMP"])              [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-LATCHFRAME"])        [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-TESTI-PARAMETRI"])   [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-TESTI-CONFINE"])     [self setvisibile:NSOffState];
	if ([nomepiano isEqualToString:@"CAT-FIDUCIALI"])         [self setvisibile:NSOffState];

	if ([nomepiano isEqualToString:@"CAT-AREE"])           	  [self setcolorpianorgb: 0:0:0];
	if ([nomepiano isEqualToString:@"CAT-BORDO"])         	  [self setcolorpianorgb: 1:1:0];
	
	if ([nomepiano isEqualToString:@"CAT-TEMP"])              [self setcolorpianorgb: 1:0:0];
	if ([nomepiano isEqualToString:@"CAT-TESTI-PARAMETRI"])   [self setcolorpianorgb: 1:0:0];
	
	NSRange myrange;
	myrange.location=0;
	myrange.length = 4;
	if ([nomepiano compare:@"0605" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 0:1:0];
	if ([nomepiano compare:@"0604" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 1:1:0];
	if ([nomepiano compare:@"0602" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 1:0:0]; // chiese
	myrange.length = 5;
	if ([nomepiano compare:@"06014" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 1:0.5:0];    // pubblico
	if ([nomepiano compare:@"06012" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 0.6:0.3:0];  // annesso
	if ([nomepiano compare:@"06011" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 0:1:1];     // baracche
	if ([nomepiano compare:@"06010" options:NSCaseInsensitiveSearch range:myrange] ==0)  [self setcolorpianorgb: 1:0.5:0];     // edifici
	

}


- (void) svuota															 {
	Vettoriale *objvector;
	for (int i=Listavector.count-1; i>0; i--) {  
		objvector= [Listavector objectAtIndex:i];
		[Listavector removeObjectAtIndex:i];
		[objvector svuota];
		[objvector release];
	}
	objvector = nil;
}

- (void) smemora														 {
	[self svuota];
    _disegno=nil;
	info=nil;
	[Listavector   release]; Listavector=nil;
	[nomepiano     release];
	[commentopiano release];
	[nomedbase     release];
	[nometavola    release];
}

- (void) CatToUtm                                                        {
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector CatToUtm : info];
	}
}

- (void) TestoAltoQU        : (Piano *) toLayer                          {

	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		[objvector TestoAltoQU];
		
		if ([objvector dimmitipo]==6) {
			Vettoriale *testTxt;
            testTxt =			[objvector copiaPura];
			[[toLayer Listavector] addObject:[objvector copiaPura]];
			[objvector cancella];
		}
	}
}


- (bool) pianoPlus                                                       {
	bool locres=NO;
	NSRange myrange; 	
	myrange.location=[nomepiano length]-1;    myrange.length = 1;
	if ([nomepiano compare:@"+" options:NSCaseInsensitiveSearch range:myrange] ==0)    {locres=YES;	}		
		//	NSBeep();
	return locres;
}

- (double) SupPoligoni                                                   {
	double risulta = 0;
	
	Vettoriale *objvector;
	for (int i=0; i<Listavector.count; i++) {  
		objvector= [Listavector objectAtIndex:i];
		risulta = risulta + [objvector superficie];
	
	}
	
	
	return risulta;
}


@end
