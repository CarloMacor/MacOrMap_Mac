//
//  Subalterno.m
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Subalterno.h"


@implementation Subalterno

@synthesize  indice;
@synthesize  Rendita;
@synthesize  Conferma;
@synthesize	 FlagTarsu;
@synthesize  FlagIci;
@synthesize  FlagAbitato;


- (void) svuota                 {
	indice  = -1;
	[Foglio     release];    Foglio        = nil;
	[Particella release];    Particella    = nil;
	[Sub        release];    Sub           = nil;
	[Categoria  release];    Categoria     = nil;
	[Classe     release];    Classe        = nil;
	[Consistenza   release]; Consistenza   = nil;
	[PianoEdificio release]; PianoEdificio = nil;
	[Civico     release];    Civico        = nil;
	[Interno    release];    Interno       = nil;
	[Via        release];    Via           = nil;
	Rendita     = 0.0;
	codCat      = 0;
	FlagAbitato = 0;
	CorrTabelle = 0;
	Conferma    = 0;
}

- (void)       salva            :(NSMutableData *) lodata                      {
	[lodata appendBytes:(const void *)&indice              length:sizeof(indice)            ];
	[lodata appendBytes:(const void *)&Rendita             length:sizeof(Rendita)           ];
	[self addstringaData2 : lodata : Foglio         ];
	[self addstringaData2 : lodata : Particella     ];
	[self addstringaData2 : lodata : Sub            ];
	[self addstringaData2 : lodata : Categoria      ];
	[lodata appendBytes:(const void *)&codCat              length:sizeof(codCat)            ];
	[self addstringaData2 : lodata : Classe         ];
	[self addstringaData2 : lodata : Consistenza    ];
	[self addstringaData2 : lodata : PianoEdificio  ];
	[self addstringaData2 : lodata : Civico         ];
	[self addstringaData2 : lodata : Interno        ];
	[self addstringaData2 : lodata : Via            ];
	[lodata appendBytes:(const void *)&FlagTarsu           length:sizeof(FlagTarsu)         ];
	[lodata appendBytes:(const void *)&FlagIci             length:sizeof(FlagIci)           ];
	[lodata appendBytes:(const void *)&FlagAbitato         length:sizeof(FlagAbitato)       ];
	[lodata appendBytes:(const void *)&CorrTabelle         length:sizeof(CorrTabelle)       ];
	[lodata appendBytes:(const void *)&Conferma            length:sizeof(Conferma)          ];

}

 
- (void)  apri           :(NSData  *) DataFile : (int *) posdata {
	
	[DataFile getBytes:&indice  range:NSMakeRange (*posdata,  sizeof(indice)) ];       *posdata +=sizeof(indice);
	[DataFile getBytes:&Rendita  range:NSMakeRange (*posdata,  sizeof(Rendita)) ];       *posdata +=sizeof(Rendita);

	[Foglio release];		Foglio = [[self GetStringaData2:DataFile :posdata] retain];

	[Particella release];	Particella = [[self GetStringaData2:DataFile :posdata] retain];
	[Sub release];		    Sub = [[self GetStringaData2:DataFile :posdata] retain];
	[Categoria release];	Categoria = [[self GetStringaData2:DataFile :posdata] retain];

		// NSLog(@"-. %@ %@  %@ %@",Foglio,Particella,Sub,Categoria);

	[DataFile getBytes:&codCat  range:NSMakeRange (*posdata,  sizeof(codCat)) ];       *posdata +=sizeof(codCat);
	[Classe release];	Classe = [[self GetStringaData2:DataFile :posdata] retain];
	[Consistenza release];	Consistenza = [[self GetStringaData2:DataFile :posdata] retain];

	[PianoEdificio release];	PianoEdificio = [[self GetStringaData2:DataFile :posdata] retain];
	[Civico release];	Civico = [[self GetStringaData2:DataFile :posdata] retain];
	[Interno release];	Interno = [[self GetStringaData2:DataFile :posdata] retain];

	[Via release];	Via = [[self GetStringaData2:DataFile :posdata] retain];

	[DataFile getBytes:&FlagTarsu    range:NSMakeRange (*posdata,  sizeof(FlagTarsu  )) ];       *posdata +=sizeof(FlagTarsu);
	[DataFile getBytes:&FlagIci      range:NSMakeRange (*posdata,  sizeof(FlagIci    )) ];       *posdata +=sizeof(FlagIci);
	[DataFile getBytes:&FlagAbitato  range:NSMakeRange (*posdata,  sizeof(FlagAbitato)) ];       *posdata +=sizeof(FlagAbitato);
	[DataFile getBytes:&CorrTabelle  range:NSMakeRange (*posdata,  sizeof(CorrTabelle)) ];       *posdata +=sizeof(CorrTabelle);
	[DataFile getBytes:&Conferma     range:NSMakeRange (*posdata,  sizeof(Conferma   )) ];       *posdata +=sizeof(Conferma);

	
}




- (void)       addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;		int remi;
	remi = fmod(indice, 2);
	for (int i=0; i<lungstr; i++) {
		ilcar = [ str characterAtIndex:i];
		if (remi==1) ilcar++; else ilcar--;
		[dat appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
}

- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];	
	NSData *myData = [NSData dataWithBytes: [str UTF8String] length:  lungstr];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	[dat appendData:myData];
}



- (NSString *) GetStringaData   : (NSFileHandle  *) fileHandle                 {
	int lungstr;
	unichar ilcar;		
	NSData *_data;
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:40];
	int remi = fmod(indice, 2);
	_data = [fileHandle readDataOfLength:   sizeof(lungstr)];    [_data getBytes:&lungstr];	
	for (int i=0; i<lungstr; i++) {
		_data = [fileHandle readDataOfLength:   sizeof(ilcar)];    [_data getBytes:&ilcar];	
		if (remi==1) ilcar--; else ilcar++; 		[locres   appendFormat:	 @"%c",ilcar];	}
	return locres;
}

- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos {
	int lungstr;	NSString *resulta;
	[data getBytes:&lungstr  range:NSMakeRange (*pos,  sizeof(lungstr)) ];       *pos +=sizeof(lungstr);
		//	NSLog(@"L %d",lungstr);
	if (lungstr>0) resulta =  [NSString stringWithUTF8String:[[data subdataWithRange:NSMakeRange (*pos,lungstr ) ]  bytes]];  else resulta = @"";
	*pos +=lungstr;
		//   	NSLog(@"st2 -%@-",resulta);
	return resulta;
}



- (NSString *) indicestr         {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
   [locres   appendFormat:	 @"%d", indice];
	return locres;
}

- (NSString *) renditastr        {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres appendFormat:	 @"%1.2f", Rendita];
	return locres;	
}




- (NSString *) Foglio            {
	return Foglio;	
}

- (NSString *) FoglioSingolo     {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Foglio];
	return resulta;
}

- (NSString *) Particella        {
	return Particella;	
}

- (NSString *) ParticellaSingola {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Particella];
	return resulta;
}

- (NSString *) Sub               {
	return Sub;	
}

- (NSString *) SubSingolo               {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Sub];
	return resulta;
}

- (NSString *) Categoria         {
	return Categoria;	
}

- (NSString *) Classe            {
	return Classe;	
}

- (NSString *) Consistenza       {
	return Consistenza;	
}

- (NSString *) PianoEdificio     {
	return PianoEdificio;	
}

- (NSString *) Civico            {
	return Civico;	
}

- (NSString *) Interno           {
	return Interno;	
}

- (NSString *) Via               {
	return Via;	
}

- (int)        codCat         {
	return codCat;
}

- (int)        faicodCat: (NSString *) st            {
	int risulta =0;
	
	if ([st isEqualToString: @"A/1"])  risulta = 1;
	if ([st isEqualToString: @"A/2"])  risulta = 2;
	if ([st isEqualToString: @"A/3"])  risulta = 3;
	if ([st isEqualToString: @"A/4"])  risulta = 4;
	if ([st isEqualToString: @"A/5"])  risulta = 5;
	if ([st isEqualToString: @"A/6"])  risulta = 6;
	if ([st isEqualToString: @"A/7"])  risulta = 7;
	if ([st isEqualToString: @"A/8"])  risulta = 8;
	if ([st isEqualToString: @"A/9"])  risulta = 9;
	if ([st isEqualToString: @"A/10"]) risulta = 10;
	if ([st isEqualToString: @"A/11"]) risulta = 11;
	
	if ([st isEqualToString: @"B/1"])  risulta = 12;
	if ([st isEqualToString: @"B/2"])  risulta = 13;
	if ([st isEqualToString: @"B/3"])  risulta = 14;
	if ([st isEqualToString: @"B/4"])  risulta = 15;
	if ([st isEqualToString: @"B/5"])  risulta = 16;
	if ([st isEqualToString: @"B/6"])  risulta = 17;  // museo
	if ([st isEqualToString: @"B/7"])  risulta = 18;
	if ([st isEqualToString: @"B/8"])  risulta = 19;
	if ([st isEqualToString: @"B/9"])  risulta = 20;
	
	if ([st isEqualToString: @"C/1"])  risulta = 21; // negozio
	if ([st isEqualToString: @"C/2"])  risulta = 22;
	if ([st isEqualToString: @"C/3"])  risulta = 23; // laboratorio
	if ([st isEqualToString: @"C/4"])  risulta = 24;
	if ([st isEqualToString: @"C/5"])  risulta = 25;
	if ([st isEqualToString: @"C/6"])  risulta = 26;  // garage
	if ([st isEqualToString: @"C/7"])  risulta = 27;  // tettoia
	
	if ([st isEqualToString: @"D/1"])  risulta = 28;  // opificio
	if ([st isEqualToString: @"D/2"])  risulta = 29;  
	if ([st isEqualToString: @"D/3"])  risulta = 30;  
	if ([st isEqualToString: @"D/4"])  risulta = 31;  
 	if ([st isEqualToString: @"D/5"])  risulta = 32;
 	if ([st isEqualToString: @"D/6"])  risulta = 33;
	if ([st isEqualToString: @"D/7"])  risulta = 34;  
	if ([st isEqualToString: @"D/8"])  risulta = 35;  
	if ([st isEqualToString: @"D/9"])  risulta = 36;  
	if ([st isEqualToString: @"D/10"]) risulta = 37;  
	
	if ([st isEqualToString: @"E/1"])  risulta = 38;  // lastrico solare 
	if ([st isEqualToString: @"E/2"])  risulta = 39;  // lastrico solare 
	if ([st isEqualToString: @"E/3"])  risulta = 40;  // lastrico solare 
	if ([st isEqualToString: @"E/4"])  risulta = 41;  // lastrico solare 
	if ([st isEqualToString: @"E/5"])  risulta = 42;  // lastrico solare 
	if ([st isEqualToString: @"E/6"])  risulta = 43;  // lastrico solare 
	if ([st isEqualToString: @"E/7"])  risulta = 44;  // lastrico solare 
	if ([st isEqualToString: @"E/8"])  risulta = 45;  // lastrico solare 
	if ([st isEqualToString: @"E/9"])  risulta = 46;  // lastrico solare 
	
	if ([st isEqualToString: @"F/1"])  risulta = 47;  // in costruzione 
	if ([st isEqualToString: @"F/2"])  risulta = 48;  // in costruzione 
	if ([st isEqualToString: @"F/3"])  risulta = 49;  // in costruzione 
	if ([st isEqualToString: @"F/4"])  risulta = 50;  // costruzione da definira 
	if ([st isEqualToString: @"F/5"])  risulta = 51;  // lastrico solare 
	if ([st isEqualToString: @"F/6"])  risulta = 52;  // lastrico solare 
	if ([st isEqualToString: @"F/7"])  risulta = 53;  // lastrico solare 
	if ([st isEqualToString: @"F/8"])  risulta = 54;  // lastrico solare 
	if ([st isEqualToString: @"F/9"])  risulta = 55;  // lastrico solare 
	if ([st isEqualToString: @"F/10"]) risulta = 56;  // lastrico solare 
	if ([st isEqualToString: @"F/11"]) risulta = 57;  // lastrico solare 
	return risulta;
	
}

- (NSString *) Infocompleto                             {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:200];
	[locres   appendFormat:	 @"Fg:%@ Part:%@ Sub:%@ %@ %@ Cat:%@ cl:%@ \"%@\"  Rendita: %1.2f € " 
	 , Foglio , Particella, Sub ,Via, Civico, Categoria, Classe, Consistenza, Rendita ];
	return locres;
}

- (NSString *) EstraiPrimoElemento : (NSString *) strin {
	NSString * resulta;
	NSRange rg,rgloc;
	rg = [strin rangeOfString:@","];
	if (rg.length <= 0) {  resulta = strin;	}
	else {  rgloc.location = 0; rgloc.length = rg.location;	resulta = [strin substringWithRange:rgloc];	}
	return resulta;
}


- (void) setFoglio        : (NSString *) foglio         {
	[foglio retain];  [Foglio release];	    Foglio = foglio;
}

- (void) setParticella    : (NSString *) particella     {
	[particella retain];  [Particella release];	    Particella = particella;
}

- (void) setSub           : (NSString *) sub            {
	[sub retain];  [Sub release];	    Sub = sub;
}

- (void) setCategoria     : (NSString *) categoria      {
	[categoria retain];  [Categoria release];	    Categoria = categoria;
	codCat = [self faicodCat:Categoria];
}

- (void) setClasse        : (NSString *) classe         {
	[classe retain];  [Classe release];	    Classe = classe;
}

- (void) setConsistenza   : (NSString *) consistenza    {
	[consistenza retain];  [Consistenza release];	    Consistenza = consistenza;
}

- (void) setPianoEdificio : (NSString *) pianoEdificio  {
	[pianoEdificio retain];  [PianoEdificio release];	    PianoEdificio = pianoEdificio;
}

- (void) setCivico        : (NSString *) civico         {
	[civico retain];  [Civico release];	    Civico = civico;
}

- (void) setInterno       : (NSString *) interno        {
	[interno retain];  [Interno release];	    Interno = interno;
}

- (void) setVia           : (NSString *) via            {
	[via retain];  [Via release];	    Via = via;
}

- (void) addsetFoglio     : (NSString *) foglio         {
	
	if ([Foglio isEqualToString:foglio]) return;
	
	NSString * Fg = [Foglio stringByAppendingFormat:	 @",%@", foglio  ];	
	[Foglio release];	[Fg retain];	Foglio = Fg;
}

- (void) addsetParticella : (NSString *) particella     {
	NSString * Fg = [Particella stringByAppendingFormat:	 @",%@", particella  ];	
	[Particella release];	[Fg retain];	Particella = Fg;
}

- (void) addsetSub        : (NSString *) sub            {
	NSString * Fg = [Sub stringByAppendingFormat:	 @",%@", sub  ];	
	[Sub release];	[Fg retain];	Sub = Fg;
}

- (id) initWithCoder      : (NSCoder  *) aDecoder       {
	indice        = [aDecoder decodeIntForKey: @"indice"       ];
	Foglio        = [[aDecoder decodeObjectForKey:@"Foglio"       ] retain];
	Particella    = [[aDecoder decodeObjectForKey:@"Particella"   ] retain];
	Sub           = [[aDecoder decodeObjectForKey:@"Sub"          ] retain];
	Categoria     = [[aDecoder decodeObjectForKey:@"Categoria"    ] retain];
	Classe        = [[aDecoder decodeObjectForKey:@"Classe"       ] retain];
	Consistenza   = [[aDecoder decodeObjectForKey:@"Consistenza"  ] retain];
	PianoEdificio = [[aDecoder decodeObjectForKey:@"PianoEdificio"] retain];
	Civico        = [[aDecoder decodeObjectForKey:@"Civico"       ] retain];
	Interno       = [[aDecoder decodeObjectForKey:@"Interno"      ] retain];
	Via           = [[aDecoder decodeObjectForKey:@"Via"          ] retain];
	Rendita       = [aDecoder decodeDoubleForKey:@"Rendita"      ];
	
	return self;
}

- (void) encodeWithCoder  : (NSCoder  *) aCoder         {
	[aCoder encodeInt   :indice         forKey:@"indice"       ];
	[aCoder encodeObject:Foglio         forKey:@"Foglio"       ];
	[aCoder encodeObject:Particella     forKey:@"Particella"   ];
	[aCoder encodeObject:Sub            forKey:@"Sub"          ];
	[aCoder encodeObject:Categoria      forKey:@"Categoria"    ];
	[aCoder encodeObject:Classe         forKey:@"Classe"       ];
	[aCoder encodeObject:Consistenza    forKey:@"Consistenza"  ];
	[aCoder encodeObject:PianoEdificio  forKey:@"PianoEdificio"];
	[aCoder encodeObject:Civico         forKey:@"Civico"       ];
	[aCoder encodeObject:Interno        forKey:@"Interno"      ];
	[aCoder encodeObject:Via            forKey:@"Via"          ];
	[aCoder encodeDouble:Rendita        forKey:@"Rendita"      ];
}

- (bool) inlistanomesub   : (NSString *) nomsuber       {
	bool resulta =NO;
	NSString *SP1,*SP2, *SPT;
	NSRange rg,rgtot,rgloc;
	rg = [[self Particella] rangeOfString:@","];
	rgtot.location=0; rgtot.length = [[self Particella] length];
    if (rg.length>0) {
		SPT = [[self Particella] substringWithRange:rgtot];
 	    rgloc.location = 0; rgloc.length = rg.location; 
        rgtot.location = rg.location+1; rgtot.length -= (rg.location+1); 
		SP1 = [SPT substringWithRange:rgloc];
		SP2 = [SPT substringWithRange:rgtot];
		if ([nomsuber isEqualToString:SP1] ) resulta=YES;
		while ([SP2 length]>0) { // 
			rgtot.location = 0; rgtot.length = [SP2 length]; 
	       	SPT = [SP2 substringWithRange:rgtot];
			rg = [SPT rangeOfString:@","];
			if (rg.length>0) {
				rgloc.location = 0; rgloc.length = rg.location; 
				rgtot.location = rg.location+1; rgtot.length -= (rg.location+1); 
				SP1 = [SPT substringWithRange:rgloc];
				SP2 = [SPT substringWithRange:rgtot];
					//			NSLog(@"prova %@ ",SP1);
				if ([nomsuber isEqualToString:SP1] ) resulta=YES;
  		    }
			else {
				if ([nomsuber isEqualToString:SP2] ) 	{resulta=YES;}
				SP2=@"";
			} 
	 
		}
	} else { if ([nomsuber isEqualToString:[self Particella]] ) resulta=YES;	}
	return resulta;
}


- (int)  IndSePresente     : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub {
	int resulta = -1;
	if ([nfoglio isEqualToString: Foglio] ) {
		NSArray *  l_part = [Particella componentsSeparatedByString:@","];
		NSArray *  l_sub  = [Sub        componentsSeparatedByString:@","];
		
		if ([l_part count]==1) {
			for (int j=0; j<[l_sub count]; j++) { 
				if ( ([nparticel isEqualToString:[l_part objectAtIndex:0 ]]) &  ([nomsub isEqualToString:[l_sub objectAtIndex:j ]])  ) {
					resulta = j;
						//					NSLog(@"Trovato %@ %@ %@",Foglio,[l_part objectAtIndex:j],[l_sub objectAtIndex:j]);
				}
			}
		}
		else {
			for (int j=0; j<[l_part count]; j++) { 
					//				NSLog(@"o %@ %@",[l_part objectAtIndex:j],[l_sub objectAtIndex:j]);
				if (j>=[l_sub count]) continue;
				if ( ([nparticel isEqualToString:[l_part objectAtIndex:j ]]) &  ([nomsub isEqualToString:[l_sub objectAtIndex:j ]])  ) {
					resulta = j;
						//				NSLog(@"Trovato %@ %@ %@",Foglio,[l_part objectAtIndex:j],[l_sub objectAtIndex:j]);
				}
			}
	    }
	}
	return resulta;
}

- (void) Logga {
	NSLog(@"subalterno Fg %@ ",Foglio);
}
 
- (bool) iscasa {
	bool resulta=NO;
	if ((codCat >0) & (codCat<12)) resulta = YES;
	
	return resulta;
}


- (NSComparisonResult)CompareCivico     :(Subalterno *)suber {
	NSComparisonResult 	 risulta = [[self Civico] compare:[suber Civico] options:NSNumericSearch];	

		//	risulta = [[self Civico] caseInsensitiveCompare:[suber Civico]];
		if (risulta == NSOrderedSame) [[self Via] caseInsensitiveCompare:[suber Via]];
	return risulta;
}

- (NSComparisonResult)CompareVia        :(Subalterno *)suber {
	NSComparisonResult risulta = [[self Via] caseInsensitiveCompare:[suber Via]];
	if (risulta == NSOrderedSame) risulta = [[self Civico] compare:[suber Civico] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareVia2       :(Subalterno *)suber {
	NSComparisonResult risulta = [[suber Via] caseInsensitiveCompare:[self Via]];
	if (risulta == NSOrderedSame) risulta = [[self Civico] compare:[suber Civico] options:NSNumericSearch];	
		//	if (risulta == NSOrderedSame) risulta = [[self Civico] caseInsensitiveCompare:[suber Civico]];	
	return risulta;
}

- (NSComparisonResult)ComparePiano        :(Subalterno *)suber {
	NSComparisonResult             risulta = [[self PianoEdificio] compare:[suber PianoEdificio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame)  risulta = [[self Via]           caseInsensitiveCompare:[suber Via]];	
	if (risulta == NSOrderedSame)  risulta = [[self Civico]        compare:[suber Civico] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePiano2       :(Subalterno *)suber {
	NSComparisonResult             risulta = [[suber PianoEdificio] compare:[self PianoEdificio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame)  risulta = [[self Via]            caseInsensitiveCompare:[suber Via]];	
	if (risulta == NSOrderedSame)  risulta = [[self Civico]         compare:[suber Civico] options:NSNumericSearch];	
	return risulta;
}




- (NSComparisonResult)CompareFg         :(Subalterno *)suber {
	NSComparisonResult risulta = [[self Foglio] compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[suber Sub] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareFg2       :(Subalterno *)suber {
	NSComparisonResult risulta = [[suber Foglio] compare:[self Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[suber Sub] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart       :(Subalterno *)suber {
	NSComparisonResult            risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub]        compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart2      :(Subalterno *)suber {
	NSComparisonResult            risulta = [[suber Particella] compare:[self Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio] compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSub       :(Subalterno *)suber {
	NSComparisonResult            risulta = [[self Sub]        compare:[suber Sub]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	return risulta;
}

- (NSComparisonResult)CompareSub2       :(Subalterno *)suber {
	NSComparisonResult            risulta = [[suber Sub]       compare:[self Sub]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	return risulta;
}



- (NSComparisonResult)CompareCat        :(Subalterno *)suber {
	NSComparisonResult risulta = [[self Categoria] caseInsensitiveCompare:[suber Categoria]];
	if (risulta == NSOrderedSame) risulta = [[self Classe] caseInsensitiveCompare:[suber Classe]];	
	if (risulta == NSOrderedSame)
	{ 	if ([self Rendita] == [suber Rendita]) risulta = NSOrderedSame;
		if ([self Rendita] <  [suber Rendita]) risulta = NSOrderedAscending;
		if ([self Rendita] >  [suber Rendita]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareCat2       :(Subalterno *)suber {
	NSComparisonResult risulta = [[suber Categoria] caseInsensitiveCompare:[self Categoria]];
	if (risulta == NSOrderedSame) risulta = [[self Classe] caseInsensitiveCompare:[suber Classe]];	
	if (risulta == NSOrderedSame)
	{ 	if ([self Rendita] == [suber Rendita]) risulta = NSOrderedSame;
		if ([self Rendita] <  [suber Rendita]) risulta = NSOrderedAscending;
		if ([self Rendita] >  [suber Rendita]) risulta = NSOrderedDescending;	}
	return risulta;
}



- (NSComparisonResult)CompareRendita    :(Subalterno *)suber {
	NSComparisonResult risulta;
	{ 	if ([self Rendita] == [suber Rendita]) risulta = NSOrderedSame;
		if ([self Rendita] <  [suber Rendita]) risulta = NSOrderedAscending;
		if ([self Rendita] >  [suber Rendita]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareRendita2   :(Subalterno *)suber {
	NSComparisonResult risulta;
	{ 	if ([self Rendita] == [suber Rendita]) risulta = NSOrderedSame;
		if ([self Rendita] >  [suber Rendita]) risulta = NSOrderedAscending;
		if ([self Rendita] <  [suber Rendita]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareCons     :(Subalterno *)suber   {
	NSComparisonResult            risulta = [[self Consistenza]  compare:[suber Consistenza]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}


- (NSComparisonResult)CompareCons2    :(Subalterno *)suber   {
	NSComparisonResult            risulta = [[suber Consistenza]  compare:[self Consistenza]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareClasse   :(Subalterno *)suber   {
	NSComparisonResult            risulta = [[self Classe]  compare:[suber Classe]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Categoria] caseInsensitiveCompare:[suber Categoria]];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareClasse2  :(Subalterno *)suber   {
	NSComparisonResult            risulta = [[suber Classe]  compare:[self Classe]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Categoria] caseInsensitiveCompare:[suber Categoria]];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareFlagTarsu       :(Subalterno *)suber {
	NSComparisonResult risulta;
	if ([self FlagTarsu] == [suber FlagTarsu]) risulta = NSOrderedSame;
	if ([self FlagTarsu] <  [suber FlagTarsu]) risulta = NSOrderedAscending;
	if ([self FlagTarsu] >  [suber FlagTarsu]) risulta = NSOrderedDescending;	
	return risulta;
}
- (NSComparisonResult)CompareFlagTarsu2       :(Subalterno *)suber {
	NSComparisonResult risulta;
	
	if ([self FlagTarsu] == [suber FlagTarsu]) risulta = NSOrderedSame;
	if ([self FlagTarsu] >  [suber FlagTarsu]) risulta = NSOrderedAscending;
	if ([self FlagTarsu] <  [suber FlagTarsu]) risulta = NSOrderedDescending;	
	
	return risulta;
}

- (NSComparisonResult)CompareResidenza     :(Subalterno *)suber   {
	NSComparisonResult risulta;
	{ 	if ([self FlagAbitato] == [suber FlagAbitato]) risulta = NSOrderedSame;
		if ([self FlagAbitato] <  [suber FlagAbitato]) risulta = NSOrderedAscending;
		if ([self FlagAbitato] >  [suber FlagAbitato]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[suber Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[suber Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[suber Sub]    options:NSNumericSearch];	
	return risulta;
}



@end
