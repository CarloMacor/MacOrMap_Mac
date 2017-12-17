//
//  Tarsu_ele.m
//  MacOrMap
//
//  Created by Carlo Macor on 16/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Tax_ele.h"


@implementation Tax_ele

@synthesize  FlagAssociato;


- (void)       salva            :(NSMutableData *) lodata                      {
	[self addstringaData2 : lodata : Nome        ];
	[self addstringaData2 : lodata : Cognome     ];
	[self addstringaData2 : lodata : Codfis      ];
	[self addstringaData2 : lodata : Foglio      ];
	[self addstringaData2 : lodata : Particella  ];
	[self addstringaData2 : lodata : Sub         ];
	[self addstringaData2 : lodata : Via         ];
	[self addstringaData2 : lodata : Civico      ];
	[self addstringaData2 : lodata : ConsisCat      ];
	[lodata appendBytes:(const void *)&SupDich     length:sizeof(SupDich) ];
	[lodata appendBytes:(const void *)&TaxDich     length:sizeof(TaxDich) ];
	[lodata appendBytes:(const void *)&TaxPagata   length:sizeof(TaxPagata) ];
	[lodata appendBytes:(const void *)&FlagAssociato   length:sizeof(FlagAssociato) ];

	
	
}

/*
- (void)       apri             :(NSFileHandle  *) fileHandle {
}
*/
 
- (void)  apri           :(NSData  *) DataFile : (int *) posdata {
	
	[Nome       release];	Nome       = [[self GetStringaData2:DataFile :posdata] retain];
	[Cognome    release];	Cognome    = [[self GetStringaData2:DataFile :posdata] retain];
	[Codfis     release];	Codfis     = [[self GetStringaData2:DataFile :posdata] retain];
	[Foglio     release];	Foglio     = [[self GetStringaData2:DataFile :posdata] retain];
	[Particella release];	Particella = [[self GetStringaData2:DataFile :posdata] retain];
	[Sub        release];	Sub        = [[self GetStringaData2:DataFile :posdata] retain];
	[Via        release];	Via        = [[self GetStringaData2:DataFile :posdata] retain];
	[Civico     release];	Civico     = [[self GetStringaData2:DataFile :posdata] retain];
	[ConsisCat  release];	ConsisCat  = [[self GetStringaData2:DataFile :posdata] retain];
	
	[DataFile getBytes:&SupDich  range:NSMakeRange (*posdata,  sizeof(SupDich)) ];       *posdata +=sizeof(SupDich);
	[DataFile getBytes:&TaxDich  range:NSMakeRange (*posdata,  sizeof(TaxDich)) ];       *posdata +=sizeof(TaxDich);
	[DataFile getBytes:&TaxPagata  range:NSMakeRange (*posdata,  sizeof(TaxPagata)) ];       *posdata +=sizeof(TaxPagata);
	[DataFile getBytes:&FlagAssociato  range:NSMakeRange (*posdata,  sizeof(FlagAssociato)) ];       *posdata +=sizeof(FlagAssociato);
	
}	


- (Tax_ele *) duplica {
	Tax_ele * newtarser = [Tax_ele alloc];  [newtarser svuota];
   [newtarser SetNome:[self Nome]];
   [newtarser SetCognome:[self Cognome]];
   [newtarser SetCodFis:[self CodFis]];
   [newtarser SetFoglio:[self Foglio]];
   [newtarser SetParticella:[self Particella]];
   [newtarser SetSub:[self Sub]];
   [newtarser SetVia:[self Via]];
   [newtarser SetCivico:[self Civico]];
   [newtarser SetConsisCat:[self ConsisCat]];
   [newtarser SetSupDich:[self SupDich]];
   [newtarser SetTaxDich:[self TaxDich]];

	 return newtarser;
}


- (void)       addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;		
	for (int i=0; i<lungstr; i++) {
		ilcar = [ str characterAtIndex:i];
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
	_data = [fileHandle readDataOfLength:   sizeof(lungstr)];    [_data getBytes:&lungstr];	
	for (int i=0; i<lungstr; i++) {
		_data = [fileHandle readDataOfLength:   sizeof(ilcar)];    [_data getBytes:&ilcar];	
 		[locres   appendFormat:	 @"%c",ilcar];	}
	return locres;
}

- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos  {
	int lungstr;	NSString *resulta;
	[data getBytes:&lungstr  range:NSMakeRange (*pos,  sizeof(lungstr)) ];       *pos +=sizeof(lungstr);
		//	NSLog(@"L %d",lungstr);
	if (lungstr>0) resulta =  [NSString stringWithUTF8String:[[data subdataWithRange:NSMakeRange (*pos,lungstr ) ]  bytes]];  else resulta = @"";
	*pos +=lungstr;
		//   	NSLog(@"st2 -%@-",resulta);
	return resulta;
}


- (void) svuota                  {
	[Nome        release];    Nome       = nil;
	[Cognome     release];    Cognome    = nil;
	[Codfis      release];    Codfis     = nil;
	[Foglio      release];    Foglio     = nil;
	[Particella  release];    Particella = nil;
	[Sub         release];    Sub        = nil;
	[Via         release];    Via        = nil;
	[Civico      release];    Civico     = nil;
	[ConsisCat   release];    ConsisCat  = nil; ConsisCat=@"";

	SupDich  = 0;
	TaxDich  = 0;
	TaxPagata= 0;
}


- (void)       SetNome       : (NSString * ) _nome {
	[Nome release];  Nome = [[NSString alloc]  initWithString: _nome];
}

- (void)       SetCognome    : (NSString * ) _cognome {
	[Cognome release];  Cognome = [[NSString alloc]  initWithString: _cognome];
}

- (void)       SetCodFis     : (NSString * ) _codfis {
	[Codfis release]; Codfis = [[NSString alloc]  initWithString: _codfis];
}

- (void)       SetFoglio     : (NSString * ) _foglio  {
	[Foglio release];  Foglio = [[NSString alloc]  initWithString: _foglio];
}

- (void)       SetParticella : (NSString * ) _particella  {
	[Particella release];  Particella = [[NSString alloc]  initWithString: _particella];
}

- (void)       SetSub        : (NSString * ) _sub  {
	[Sub release];  Sub = [[NSString alloc]  initWithString: _sub];
}

- (void)       SetVia        : (NSString * ) _via  {
	[Via release];  Via = [[NSString alloc]  initWithString: _via];
}

- (void)       SetCivico     : (NSString * ) _civico {
	[Civico release];  Civico = [[NSString alloc]  initWithString: _civico];
}

- (void)       SetConsisCat  : (NSString * ) _conscat {
	[ConsisCat release];  ConsisCat = [[NSString alloc]  initWithString: _conscat];
}

- (void)       SetSupDich  : (double ) _supdic {
	SupDich = _supdic;
}

- (void)       SetTaxDich    : (double )     _taxdic {
	TaxDich = _taxdic;
}

- (void)       SetTaxPagata  : (double )     _taxpagata {
	TaxPagata = _taxpagata;
}




- (NSString * )       Nome         {	return Nome;      }
- (NSString * )       Cognome      {	return Cognome;   }
- (NSString * )       CodFis       {	return Codfis;    }
- (NSString * )       Foglio       {	return Foglio;    }
- (NSString * )       Particella   {	return Particella;}
- (NSString * )       Sub          {	return Sub;       }
- (NSString * )       Via          {	return Via;       }
- (NSString * )       Civico       {    return Civico;    }
- (NSString * )       ConsisCat    {    return ConsisCat; }
- (double     )       SupDich      {    return SupDich;   }
- (double     )       TaxDich      {    return TaxDich;   }
- (double     )       TaxPagata    {    return TaxPagata; }

- (NSString * )       TaxPagataStr {
	return [[NSString  alloc] initWithFormat:@"%1.2f",(((int)TaxPagata*100)/100.0)];
}


- (NSComparisonResult)CompareSupDic       :(Tax_ele *)tar {
	NSComparisonResult risulta;
	{ 	if ([self SupDich] == [tar SupDich]) risulta = NSOrderedSame;
		if ([self SupDich] <  [tar SupDich]) risulta = NSOrderedAscending;
		if ([self SupDich] >  [tar SupDich]) risulta = NSOrderedDescending;	}
		//	if (risulta == NSOrderedSame) risulta = [[self CodFis] compare:[tar CodFis] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSupDic2      :(Tax_ele *)tar {
	NSComparisonResult risulta;
	{ 	if ([tar SupDich] == [self SupDich]) risulta = NSOrderedSame;
		if ([tar SupDich] >  [self SupDich]) risulta = NSOrderedAscending;
		if ([tar SupDich] <  [self SupDich]) risulta = NSOrderedDescending;	}
		//	if (risulta == NSOrderedSame) risulta = [[self CodFis] compare:[tar CodFis] options:NSNumericSearch];	
	return risulta;
}


- (NSComparisonResult)Comparetaxpagata       :(Tax_ele *)tar {
	NSComparisonResult risulta;
	{ 	if ([self TaxPagata] == [tar TaxPagata]) risulta = NSOrderedSame;
		if ([self TaxPagata] <  [tar TaxPagata]) risulta = NSOrderedAscending;
		if ([self TaxPagata] >  [tar TaxPagata]) risulta = NSOrderedDescending;	}
		//	if (risulta == NSOrderedSame) risulta = [[self CodFis] compare:[tar CodFis] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)Comparetaxpagata2      :(Tax_ele *)tar {
	NSComparisonResult risulta;
	{ 	if ([tar TaxPagata] == [self TaxPagata]) risulta = NSOrderedSame;
		if ([tar TaxPagata] >  [self TaxPagata]) risulta = NSOrderedAscending;
		if ([tar TaxPagata] <  [self TaxPagata]) risulta = NSOrderedDescending;	}
		//	if (risulta == NSOrderedSame) risulta = [[self CodFis] compare:[tar CodFis] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareCodfis       :(Tax_ele *)tar {
	NSComparisonResult risulta = [[self CodFis] caseInsensitiveCompare:[tar CodFis]];
	if (risulta == NSOrderedSame) risulta = [[self ConsisCat] compare:[tar ConsisCat] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareCodfis2      :(Tax_ele *)tar {
	NSComparisonResult risulta = [[tar CodFis] caseInsensitiveCompare:[self CodFis]];
	if (risulta == NSOrderedSame) risulta = [[self ConsisCat] compare:[tar ConsisCat] options:NSNumericSearch];	
	return risulta;
}



- (NSComparisonResult)CompareFg       :(Tax_ele *)tar {
	NSComparisonResult risulta = [[self Foglio] compare:[tar Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[tar Particella] options:NSNumericSearch];	
 	 if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[tar Sub] options:NSNumericSearch];	

	return risulta;
}

- (NSComparisonResult)CompareFg2      :(Tax_ele *)tar {
	NSComparisonResult risulta = [[tar Foglio] compare:[self Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[tar Particella] options:NSNumericSearch];	
 	 if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[tar Sub] options:NSNumericSearch];	
	return risulta;
}


- (NSComparisonResult)CompareVia      :(Tax_ele *)tar  {
	NSComparisonResult risulta = [[self Via] compare:[tar Via] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Civico] compare:[tar Civico] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareVia2     :(Tax_ele *)tar {
	NSComparisonResult risulta = [[tar Via] compare:[self Via] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Civico] compare:[tar Civico] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareNome     :(Tax_ele *)tar   {
	NSComparisonResult risulta = [[self Nome] compare:[tar Nome] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Via] compare:[tar Via] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareNome2    :(Tax_ele *)tar  {
	NSComparisonResult risulta = [[tar Nome] compare:[self Nome] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Via] compare:[tar Via] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSonsCat     :(Tax_ele *)tar   {
	NSComparisonResult risulta = [[self ConsisCat] compare:[tar ConsisCat] options:NSNumericSearch];	
	return risulta;
}


- (NSComparisonResult)CompareFlagAssociato       :(Tax_ele *)tar {
	NSComparisonResult risulta;
	 	if ([self FlagAssociato] == [tar FlagAssociato]) risulta = NSOrderedSame;
		if ([self FlagAssociato] <  [tar FlagAssociato]) risulta = NSOrderedAscending;
		if ([self FlagAssociato] >  [tar FlagAssociato]) risulta = NSOrderedDescending;	
	return risulta;
}
- (NSComparisonResult)CompareFlagAssociato2      :(Tax_ele *)tar {
	NSComparisonResult risulta;

	if ([self FlagAssociato] == [tar FlagAssociato]) risulta = NSOrderedSame;
	if ([self FlagAssociato] >  [tar FlagAssociato]) risulta = NSOrderedAscending;
	if ([self FlagAssociato] <  [tar FlagAssociato]) risulta = NSOrderedDescending;	
	
	return risulta;
}



- (void) logga {
	NSLog(@"- %@ %@ %@ %@ %@ %@ %@ %@" , Nome, Cognome, Codfis , Foglio, Particella , Sub , Via, Civico );
}



@end
