//
//  Terreno.m
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Terreno.h"


@implementation Terreno

@synthesize  Indice;
@synthesize  Superficie;
@synthesize  Renditadomenicale;
@synthesize  Renditaagraria;
@synthesize  CorrTabelle;

- (void) svuota                  {
	Indice  = -1;
	[Foglio     release];    Foglio        = nil;
	[Particella release];    Particella    = nil;
	[Qualita    release];    Qualita       = nil;
	[Classe     release];    Classe        = nil;
	[Zona       release];    Zona          = nil;
	Superficie            =     0;
	Renditadomenicale     =   0.0;
	Renditaagraria        =   0.0;
	CorrTabelle           =     0;
}


- (void) salva              :(NSMutableData *) lodata {
	[lodata appendBytes:(const void *)&Indice              length:sizeof(Indice)            ];
    [lodata appendBytes:(const void *)&Superficie          length:sizeof(Superficie)        ];
	[lodata appendBytes:(const void *)&Renditadomenicale   length:sizeof(Renditadomenicale) ];
	[lodata appendBytes:(const void *)&Renditaagraria      length:sizeof(Renditaagraria)    ];
	[lodata appendBytes:(const void *)&CorrTabelle         length:sizeof(CorrTabelle)       ];
	[self addstringaData2 : lodata : Foglio     ];
	[self addstringaData2 : lodata : Particella ];
	[self addstringaData2 : lodata : Qualita    ];
	[self addstringaData2 : lodata : Classe     ];
	[self addstringaData2 : lodata : Zona       ];
}


- (void)  apri           :(NSData  *) DataFile : (int *) posdata {
	[DataFile getBytes:&Indice  range:NSMakeRange (*posdata,  sizeof(Indice)) ];       *posdata +=sizeof(Indice);
	
	[DataFile getBytes:&Superficie  range:NSMakeRange (*posdata,  sizeof(Superficie)) ];       *posdata +=sizeof(Superficie);
	[DataFile getBytes:&Renditadomenicale  range:NSMakeRange (*posdata,  sizeof(Renditadomenicale)) ];       *posdata +=sizeof(Renditadomenicale);
	[DataFile getBytes:&Renditaagraria  range:NSMakeRange (*posdata,  sizeof(Renditaagraria)) ];       *posdata +=sizeof(Renditaagraria);
	[DataFile getBytes:&CorrTabelle  range:NSMakeRange (*posdata,  sizeof(CorrTabelle)) ];       *posdata +=sizeof(CorrTabelle);

	[Foglio release];		Foglio = [[self GetStringaData2:DataFile :posdata] retain];

	[Particella release];		Particella = [[self GetStringaData2:DataFile :posdata] retain];
	[Qualita release];		Qualita = [[self GetStringaData2:DataFile :posdata] retain];
	[Classe release];		Classe = [[self GetStringaData2:DataFile :posdata] retain];
	[Zona release];		Zona = [[self GetStringaData2:DataFile :posdata] retain];

	
		//	NSLog(@"-. %@ %@  %@ %@ %@",Foglio,Particella,Qualita,Classe,Zona);

}



- (bool) inlistanomepart    :(NSString      *) nompartic {
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
		if ([nompartic isEqualToString:SP1] ) resulta=YES;
		while ([SP2 length]>0) { // 
			rgtot.location = 0; rgtot.length = [SP2 length]; 
	       	SPT = [SP2 substringWithRange:rgtot];
			rg = [SPT rangeOfString:@","];
			if (rg.length>0) {
				rgloc.location = 0; rgloc.length = rg.location; 
				rgtot.location = rg.location+1; rgtot.length -= (rg.location+1); 
				SP1 = [SPT substringWithRange:rgloc];
				SP2 = [SPT substringWithRange:rgtot];
				if ([nompartic isEqualToString:SP1] ) resulta=YES;
  		    }
			else {
				if ([nompartic isEqualToString:SP2] ) 	{resulta=YES;}
				SP2=@"";
			} 
		}
	} else { if ([nompartic isEqualToString:[self Particella]] ) resulta=YES;	}
	return resulta;
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


- (NSString *) Infocompleto {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:200];
	[locres   appendFormat:	 @"Fg:%@ Part:%@ Qual:%@ cl:%@ sup:%d Domenicale: %1.2f €  Agraria: %1.2f € " 
	                , Foglio , Particella, Qualita ,Classe, Superficie, Renditadomenicale, Renditaagraria ];
	return locres;
}




- (NSString *) indicestr                              {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres   appendFormat:	 @"%d", Indice];
	return locres;
}

- (NSString *) Renditadomenicalestr                   {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres appendFormat:	 @"%1.2f", Renditadomenicale];
	return locres;	
}

- (NSString *) Renditaagrariastr                      {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres appendFormat:	 @"%1.2f", Renditaagraria];
	return locres;	
}


- (NSString *) Foglio                                 {
	return Foglio;
}

- (NSString *) Particella                             {
	return Particella;
}

- (NSString *) Qualita                                {
	return Qualita;
}

- (NSString *) Classe                                 {
	return Classe;
}

- (NSString *) Zona                                   {
	return Zona;
}


- (NSString *) Superficiestr                          {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:10];
	[locres appendFormat:	 @"%d", Superficie];
	return locres;	
}


- (NSString *) EstraiPrimoElemento :  (NSString *) strin {
	NSString * resulta;
	NSRange rg,rgloc;
	rg = [strin rangeOfString:@","];
	if (rg.length <= 0) {  resulta = strin;	}
	else {  rgloc.location = 0; rgloc.length = rg.location;	resulta = [strin substringWithRange:rgloc];	}
	return resulta;
}

- (NSString *) FoglioSingolo    {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Foglio];
	return resulta;
}

- (NSString *) ParticellaSingola {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Particella];
	return resulta;
}


- (void) SetFoglio      : (NSString *) foglio         {
	[foglio retain];  [Foglio release];	    Foglio = foglio;
}

- (void) SetParticella  : (NSString *) particella     {
	[particella retain];  [Particella release];	    Particella = particella;
}

- (void) SetQualita     : (NSString *) qualita        {
	[qualita retain];  [Qualita release];	    Qualita = qualita;
}

- (void) SetClasse      : (NSString *) classe         {
	[classe retain];  [Classe release];	    Classe = classe;
}

- (void) SetZona        : (NSString *) zona           {
	[zona retain];  [Zona release];	    Zona = zona;
}



- (NSComparisonResult)CompareFg       :(Terreno *)ter {
	NSComparisonResult risulta = [[self Foglio] compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareFg2      :(Terreno *)ter {
	NSComparisonResult risulta = [[ter Foglio] compare:[self Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart     :(Terreno *)ter {
	NSComparisonResult            risulta = [[self Particella] compare:[ter Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart2    :(Terreno *)ter {
	NSComparisonResult            risulta = [[ter Particella]  compare:[self Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareQl       :(Terreno *)ter {
	NSComparisonResult risulta = [[self Qualita] caseInsensitiveCompare:[ter Qualita] ];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];		
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareQl2      :(Terreno *)ter {
	NSComparisonResult risulta = [[ter Qualita] caseInsensitiveCompare:[self Qualita] ];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	

	return risulta;
}

- (NSComparisonResult)CompareCl       :(Terreno *)ter {
	NSComparisonResult risulta = [[self Classe] caseInsensitiveCompare:[ter Classe] ];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];		
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareCl2      :(Terreno *)ter {
	NSComparisonResult risulta = [[ter Classe] caseInsensitiveCompare:[self Classe] ];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];		
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSup      :(Terreno *)ter {
	NSComparisonResult risulta ;
	{ 	if ([self Superficie] == [ter Superficie]) risulta = NSOrderedSame;
		if ([self Superficie] <  [ter Superficie]) risulta = NSOrderedAscending;
		if ([self Superficie] >  [ter Superficie]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSup2     :(Terreno *)ter {
	NSComparisonResult risulta ;
	{ 	if ([ter Superficie] == [self Superficie]) risulta = NSOrderedSame;
		if ([ter Superficie] <  [self Superficie]) risulta = NSOrderedAscending;
		if ([ter Superficie] >  [self Superficie]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareDom      :(Terreno *)ter {
	NSComparisonResult risulta ;
	{ 	if ([self Renditadomenicale] == [ter Renditadomenicale]) risulta = NSOrderedSame;
		if ([self Renditadomenicale] <  [ter Renditadomenicale]) risulta = NSOrderedAscending;
		if ([self Renditadomenicale] >  [ter Renditadomenicale]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareDom2     :(Terreno *)ter {
	NSComparisonResult risulta ;
	{ 	if ([ter Renditadomenicale] == [self Renditadomenicale]) risulta = NSOrderedSame;
		if ([ter Renditadomenicale] <  [self Renditadomenicale]) risulta = NSOrderedAscending;
		if ([ter Renditadomenicale] >  [self Renditadomenicale]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareAg       :(Terreno *)ter{
	NSComparisonResult risulta ;
	{ 	if ([self Renditaagraria] == [ter Renditaagraria]) risulta = NSOrderedSame;
		if ([self Renditaagraria] <  [ter Renditaagraria]) risulta = NSOrderedAscending;
		if ([self Renditaagraria] >  [ter Renditaagraria]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareAg2      :(Terreno *)ter{
	NSComparisonResult risulta ;
	{ 	if ([ter Renditaagraria] == [self Renditaagraria]) risulta = NSOrderedSame;
		if ([ter Renditaagraria] <  [self Renditaagraria]) risulta = NSOrderedAscending;
		if ([ter Renditaagraria] >  [self Renditaagraria]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[ter Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[ter Particella] options:NSNumericSearch];	
	return risulta;
}



@end
