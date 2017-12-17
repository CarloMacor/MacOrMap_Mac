//
//  Proprietari.m
//  MacOrMap
//
//  Created by Carlo Macor on 04/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Proprietari.h"


@implementation Proprietari

- (void)          initProprietario   {
	Indice          = 0;
	Nome            = @"";
	Cognome         = @"";
	Datanascita     = @"";
	LuogoNascita    = @"";
	Codfis          = @"";
	ListaPatrimonio = [[NSMutableArray alloc] init];
	
		//		sporcademo      = YES;
		 sporcademo      = NO;
}

- (NSString       *) Infocompleto    {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:200];
	[locres   appendFormat:	 @"%@  %@ %@ %@ %@",Nome,Cognome,Datanascita,LuogoNascita,Codfis ]; 
	return locres;
}

- (NSString       *) indicestr       {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres   appendFormat:	 @"%d", Indice];
	return locres;
}

- (NSString       *) numprostr       {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres   appendFormat:	 @"%d", ListaPatrimonio.count];
	return locres;
}

- (NSString       *) Nome            {
	return Nome;
}

- (NSString       *) Cognome         {
	return Cognome;
}

- (NSString       *) LuogoNascita    {
	return LuogoNascita;
}

- (NSString       *) Codfis          {
	return Codfis;
}

- (NSString       *) Datanascita     {
	return Datanascita;
}

- (NSMutableArray *) ListaPatrimonio {
	return ListaPatrimonio;
}
- (NSCalendarDate *) DataNumerica    {
	return DataNumerica;
}


- (void) SetNomeEsteso  : (NSString *) nome           {
	NSRange rg;
	NSRange rgluogo;
	NSRange rgmomd;

	NSString * Upst; 
	NSString * Norst; 
	NSString * Momdata; 

		// togli eventuali spazi vuoti a termine stringa o trovare il primo / a ritroso
	
    rg = [nome rangeOfString:@"nato a"];
	if (rg.length==0) rg = [nome rangeOfString:@"nata a"];
	if (rg.length==0) rg = [nome rangeOfString:@"nato in"];
	if (rg.length==0) rg = [nome rangeOfString:@"nata in"];

	if (rg.length>0) {
		rgluogo.location = rg.location+rg.length+1;
		rgluogo.length   = [nome length]-(rgluogo.location+14);
			//	unichar c=[nome characterAtIndex:rgluogo.length-1];   // tolog spazi finali
			//		if (c==32) rgluogo.length --;
		/*
		for (int i=0; i<[str length]; i++) { c=	[str characterAtIndex:i];  if ((c!=32) & (c!=9)) {	[risulta appendFormat:	 @"%C", c];	//	NSLog(@"P %c %d",c,c);
			}	
		}	
		*/
		
		[self SetLuogoNat:[nome substringWithRange:rgluogo  ]];
		
		rgluogo.location = [nome length]-16;rgluogo.length   = 16;
		Momdata = [nome substringWithRange:rgluogo  ];
		rgmomd  = [Momdata rangeOfString:@"/"];
		rgluogo.location = rgmomd.location-2; rgluogo.length   = 10;
		[self SetDataNat:[Momdata substringWithRange:rgluogo  ]];
	
		
		rgluogo.location = 0;
		rgluogo.length   = 1;
		int posn=0;
		for (int i=0; i<rg.location-1; i++) {  
			rgluogo.location = i;
			Norst = [nome substringWithRange:rgluogo];
		    Upst  = [Norst uppercaseString];
			if (![Norst isEqualToString:Upst])
			{ posn=i-2; break; }
		}
		rgluogo.location = 0;		rgluogo.length   = posn;
		[self SetCognome:[nome substringWithRange:rgluogo  ]];
		rgluogo.location = posn+1;  rgluogo.length   = (rg.location-1)-rgluogo.location;
		[self SetNome:[nome substringWithRange:rgluogo  ]];
		
	}
}

- (void) SetNome        : (NSString *) nome           {
	[nome retain]; [Nome release];	 Nome = nome;
}

- (void) SetCognome     : (NSString *) cognome        {
	[cognome retain]; [Cognome release];	 Cognome = cognome;
}

- (void) SetCodfisSecco : (NSString *) codfis         {
	[codfis retain]; [Codfis release];	 Codfis = codfis;
}

- (void) SetCodfis      : (NSString *) codfis         {
	[codfis retain]; 
	[Codfis release];	  
	NSRange aRange; aRange.location=0; 
	if ([codfis length] >=16) 
	{	aRange.length =16;	} else
	{aRange.length = [codfis length];	};
	Codfis = [codfis substringWithRange:aRange];
}

- (void) SetLuogoNat    : (NSString *) luogo          {
	[luogo retain]; [LuogoNascita release];	 LuogoNascita = luogo;
}

- (void) SetDataNat     : (NSString *) datastr        {
	[datastr retain]; [Datanascita release];	 Datanascita = datastr;
	DataNumerica = [NSCalendarDate dateWithString:Datanascita calendarFormat:@"%d/%m/%y"];
}

- (void) loggapatrimonio                              {
	Patrimonio * illopatrimonio;
	
	for (int i=0; i<ListaPatrimonio.count; i++) {  
		illopatrimonio = [ListaPatrimonio objectAtIndex:i];
					NSLog(@"loggo -%@",[illopatrimonio DirittiOneri]);
					NSLog(@"loggo -%@ %@ %@ ",[illopatrimonio Foglio] , [illopatrimonio Particella] ,[illopatrimonio Sub] );


	}
}

- (void) logga                                        {
		    NSLog(@"proprietario     %@  %@ %@ %@ %@ ",Nome,Cognome,Codfis,LuogoNascita,Datanascita);
			[self loggapatrimonio];
}


- (Patrimonio *) addPatrimonio                        {
	Patrimonio * illopatrimonio;
	illopatrimonio = [Patrimonio alloc];
		//	[illopatrimonio SetPatrimonioEsteso: oneri : infoprop];
	[ListaPatrimonio addObject:illopatrimonio];
	return illopatrimonio;
}


- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;		int remi;
	remi = fmod(Indice, 2);
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


- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle {
	int lungstr;
	unichar ilcar;		
	NSData *_data;
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:40];
	int remi = fmod(Indice, 2);
	_data = [fileHandle readDataOfLength:   sizeof(lungstr)];    [_data getBytes:&lungstr];	
	
	for (int i=0; i<lungstr; i++) {
		_data = [fileHandle readDataOfLength:   sizeof(ilcar)];    [_data getBytes:&ilcar];	
				if (remi==1) ilcar--; else ilcar++; 	
					if (sporcademo) { if (i> 1) ilcar = 45;		}
				[locres   appendFormat:	 @"%c",ilcar];	
	}
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


- (void) salva          :(NSMutableData *) lodata                         {
	[lodata appendBytes:(const void *)&Indice              length:sizeof(Indice)            ];
	[self addstringaData2 : lodata : Nome           ];
	[self addstringaData2 : lodata : Cognome        ];
	[self addstringaData2 : lodata : Datanascita    ];
	[self addstringaData2 : lodata : LuogoNascita   ];
	[self addstringaData2 : lodata : Codfis         ];
	int numele ;
	numele = ListaPatrimonio.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	Patrimonio * patrer;
	for (int i=0; i<numele; i++) {
		patrer = [ListaPatrimonio objectAtIndex:i];
        [patrer salva:lodata];
	}
}


- (void)  apri           :(NSData  *) DataFile : (int *) posdata     {
	[DataFile getBytes:&Indice  range:NSMakeRange (*posdata,  sizeof(Indice)) ];       *posdata +=sizeof(Indice);


	[Nome release];		        Nome         = [[self GetStringaData2:DataFile :posdata] retain];
	[Cognome release];          Cognome      = [[self GetStringaData2:DataFile :posdata] retain];
	[Datanascita release];		Datanascita  = [[self GetStringaData2:DataFile :posdata] retain];
	DataNumerica = [NSCalendarDate dateWithString:Datanascita calendarFormat:@"%d/%m/%Y"];
	[DataNumerica retain];
	[LuogoNascita release];		LuogoNascita = [[self GetStringaData2:DataFile :posdata] retain];
	[Codfis release];		    Codfis       = [[self GetStringaData2:DataFile :posdata] retain];
	int numobj;
	[DataFile getBytes:&numobj  range:NSMakeRange (*posdata,  sizeof(numobj)) ];       *posdata +=sizeof(numobj);
	for (int i=0; i<numobj; i++) {  
		Patrimonio * patrer;
		patrer = [Patrimonio alloc];   [patrer	apri : DataFile :posdata];  [ListaPatrimonio addObject:patrer];  [patrer retain];
	}

}


- (NSComparisonResult)CompareNome   :(Proprietari *)proper {
	NSComparisonResult risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];
	return risulta;
}

- (NSComparisonResult)CompareNome2     :(Proprietari *)proper {
	NSComparisonResult risulta = [[proper Nome] caseInsensitiveCompare:[self Nome]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];	
	return risulta;
}

- (NSComparisonResult)CompareCognome:(Proprietari *)proper {
	NSComparisonResult risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;
}

- (NSComparisonResult)CompareCognome2  :(Proprietari *)proper {
	NSComparisonResult risulta = [[proper Cognome] caseInsensitiveCompare:[self Cognome]];
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;
}



- (NSComparisonResult)CompareCodFis :(Proprietari *)proper {
	return [[self Codfis] caseInsensitiveCompare:[proper Codfis]];
}

- (NSComparisonResult)CompareCodFis2   :(Proprietari *)proper {
	return [[proper Codfis] caseInsensitiveCompare:[self Codfis]];
}


- (NSComparisonResult)CompareLuogo    :(Proprietari *)proper {
	NSComparisonResult risulta = [[self LuogoNascita] caseInsensitiveCompare:[proper LuogoNascita]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];	
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;
}

- (NSComparisonResult)CompareLuogo2    :(Proprietari *)proper {
	NSComparisonResult risulta = [[proper LuogoNascita] caseInsensitiveCompare:[self LuogoNascita]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];	
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;
}


- (NSComparisonResult)CompareDataN      :(Proprietari *)proper {
	NSComparisonResult risulta = [[self DataNumerica] compare:[proper DataNumerica]];   
	return risulta;
} 

- (NSComparisonResult)CompareDataN2     :(Proprietari *)proper {
	NSComparisonResult risulta = [[proper DataNumerica] compare:[self DataNumerica]];   
	return risulta;
} 


- (NSComparisonResult)CompareNrPr   :(Proprietari *)proper {
	NSComparisonResult risulta = risulta = [[self numprostr] compare:[proper numprostr]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];	
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;
}

- (NSComparisonResult)CompareNrPr2   :(Proprietari *)proper {
	NSComparisonResult risulta = risulta = [[proper numprostr] compare:[self numprostr]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[proper Cognome]];	
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[proper Nome]];
	return risulta;

}







- (void) alternasporcademo {
	sporcademo      = 		!sporcademo;
}


@end
