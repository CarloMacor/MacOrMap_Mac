//
//  Residente.m
//  MacOrMap
//
//  Created by Carlo Macor on 26/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Residente.h"
#import "Famiglia.h"



@implementation Residente


- (void) svuota   {
	Nome        = @"";
	Cognome     = @"";
	codFis      = @"";
	codFamiglia = @"";
	viaEstesa   = @"";
	nr = @"";
	via = @"";
	dataNascita = nil;
	codIntestatario =0;
	suaFamiglia = nil;
}

- (void) salva              :(NSMutableData *) lodata : (int) salvafam {
	[self addstringaData2 : lodata :  Nome         ];
	[self addstringaData2 : lodata :  Cognome      ];
	[self addstringaData2 : lodata :  codFis       ];
	[self addstringaData2 : lodata :  codFamiglia  ];
		//	[self addstringaData2 : lodata :  viaEstesa    ];
	[self addstringaData2 : lodata :  via    ];
	[self addstringaData2 : lodata :  nr    ];

	[self addstringaData2 : lodata :  [self dataNascitaStr] ];

	[lodata appendBytes:(const void *)&codIntestatario              length:sizeof(codIntestatario)            ];
	[lodata appendBytes:(const void *)&salvafam              length:sizeof(salvafam)            ];

}

-(void) spezzaviaestesa {
	NSString * parte1;
	NSString * parte2;
	NSString * parte3;
	NSRange rg;
	NSRange rg2;
	bool fatto = NO;
	rg = [viaEstesa rangeOfString:@" snc"];
	if (rg.length>0) {	fatto = YES;	parte1 = [viaEstesa substringToIndex:rg.location]; via = parte1; [via retain];	nr =@"snc"; }
	if (fatto) { return;  }
	rg = [viaEstesa rangeOfString:@" n."];
	if (rg.length>0) {	fatto = YES;	parte1 = [viaEstesa substringToIndex:rg.location]; via = parte1; [via retain];
	  parte2 = 	[viaEstesa substringFromIndex:rg.location+4];
		rg2 = [parte2 rangeOfString:@" "];
		if (rg2.length>0) {	parte3 = [parte2 substringToIndex:rg2.location]; nr = parte3; [nr retain]; 	} else {nr = parte2; [nr retain]; 	}
	}
}

- (void)  apri           :(NSData  *) DataFile : (int *) posdata {
	[Nome         release];	Nome         = [[self GetStringaData2:DataFile :posdata] retain];
	[Cognome      release];	Cognome      = [[self GetStringaData2:DataFile :posdata] retain];
	[codFis       release];	codFis       = [[self GetStringaData2:DataFile :posdata] retain];
	[codFamiglia  release];	codFamiglia  = [[self GetStringaData2:DataFile :posdata] retain];
		//	[viaEstesa    release];	viaEstesa    = [[self GetStringaData2:DataFile :posdata] retain];
	[via    release];	via    = [[self GetStringaData2:DataFile :posdata] retain];
	[nr    release];	nr    = [[self GetStringaData2:DataFile :posdata] retain];

		//	[via release];	[nr release];	[self spezzaviaestesa];
	
	[dataNascita  release];
	dataNascita = [ [NSCalendarDate alloc] initWithString:[self GetStringaData2:DataFile :posdata] calendarFormat:@"%d/%m/%Y"]  ;
	[DataFile getBytes:&codIntestatario  range:NSMakeRange (*posdata,  sizeof(codIntestatario)) ];       *posdata +=sizeof(codIntestatario);
	[DataFile getBytes:&indsalvaFamiglie  range:NSMakeRange (*posdata,  sizeof(indsalvaFamiglie)) ];     *posdata +=sizeof(indsalvaFamiglie);
}
	



- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];	
	NSData *myData = [NSData dataWithBytes: [str UTF8String] length:  lungstr];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	[dat appendData:myData];
}

- (NSString *) GetStringaData2 : (NSData        *) data : (int *) pos  {
	int lungstr;	NSString *resulta;
	[data getBytes:&lungstr  range:NSMakeRange (*pos,  sizeof(lungstr)) ];       *pos +=sizeof(lungstr);
	if (lungstr>0) resulta =  [NSString stringWithUTF8String:[[data subdataWithRange:NSMakeRange (*pos,lungstr ) ]  bytes]];  else resulta = @"";
	*pos +=lungstr;
	return resulta;
}

- (NSString *) Nome {
	return Nome;	
}

- (NSString *) Cognome {
	return Cognome;
}

- (NSString *) codFis {
    return codFis;	
}

- (NSString *) codFamiglia{
	return codFamiglia;
}

- (NSString *) dataNascitaStr {
		//		NSLog(@"data %d %d %d", [dataNascita yearOfCommonEra],[dataNascita monthOfYear] ,[dataNascita dayOfMonth]);

		return   [dataNascita descriptionWithCalendarFormat:@"%d/%m/%Y"];
}

- (NSString *) viaEstesa {
	return viaEstesa;
}

- (NSString *) via {
	return via;	
}

- (NSString *) nr {
	return nr;
}


- (NSCalendarDate   *) dataNascita {
	return dataNascita;
}


- (int       ) codIntestatario {
	return codIntestatario;
}

- (int       ) indsalvaFamiglie {
	return indsalvaFamiglie;
}


- (void) SetNome : (NSString *) nome {
	[Nome release]; [nome retain]; Nome = nome;
}

- (void) SetCognome : (NSString *) cognome {
	[Cognome release]; [cognome retain]; Cognome = cognome;
}

- (void) SetCodFis  : (NSString *) codfis {
	[codFis release]; [codfis retain]; codFis = codfis;
}

- (void) SetCodFam  : (NSString *) codfam {
	[codFamiglia release]; [codfam retain]; codFamiglia = codfam;
}

- (void) SetviaEstesa  : (NSString *) viaest {
	[viaEstesa release]; [viaest retain]; viaEstesa = viaest;
}

- (void) SetcodIntestatario  : (int ) codint {
	codIntestatario = codint;
}

- (void) ImpostagliFamiglia :  (id) family {
	suaFamiglia = family;	
}

- (id) famigliassociata  {
	return suaFamiglia;
}


- (void) SetDataNascita  : (NSString *) datanasc {
	NSRange aRange;
		//	NSLog(@"Data %@",datanasc);
	
	aRange.location=0; 		aRange.length=4;	NSString * anno = [datanasc substringWithRange : aRange];
	aRange.location=4; 		aRange.length=2;	NSString * mese = [datanasc substringWithRange : aRange];
	aRange.location=6; 		aRange.length=2;	NSString * giorno = [datanasc substringWithRange : aRange];
	dataNascita = [NSCalendarDate dateWithYear:[anno intValue] month:[mese intValue] day:[giorno intValue]
								  hour:0 minute:0 second:0 timeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
	[dataNascita retain];
		// NSLog(@"data %@ %d %d %d",datanasc , [dataNascita yearOfCommonEra],[dataNascita monthOfYear] ,[dataNascita dayOfMonth]);
}

- (void) logga {
	NSLog(@"Residente : %@ %@ %@ %@",Nome, Cognome, codFis, codFamiglia);
}

- (NSComparisonResult)CompareNome   :(Residente *) resider {
	NSComparisonResult risulta = [[self Nome] caseInsensitiveCompare:[resider Nome]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[resider Cognome]];
	return risulta;
}

- (NSComparisonResult)CompareCognome   :(Residente *) resider  {
	NSComparisonResult risulta = [[self Cognome] caseInsensitiveCompare:[resider Cognome]];
	if (risulta == NSOrderedSame) risulta = [[self Nome] caseInsensitiveCompare:[resider Nome]];
	return risulta;
}

- (NSComparisonResult)CompareVia       :(Residente *) resider  {
	NSComparisonResult risulta = [[self via] caseInsensitiveCompare:[resider via]];
	if (risulta == NSOrderedSame) risulta = [[self nr]      compare                :[resider nr     ] options:NSNumericSearch];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare :[resider Cognome]];
	if (risulta == NSOrderedSame) risulta = [[self Nome]    caseInsensitiveCompare :[resider Nome   ]];
	return risulta;
}

- (NSComparisonResult)CompareData      :(Residente *) resider  {
	NSComparisonResult risulta ;
	risulta = [[self dataNascita] compare:[resider dataNascita]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome] caseInsensitiveCompare:[resider Cognome]];
	return risulta;
}



@end
