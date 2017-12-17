//
//  Famiglia.m
//  Anagrafe
//
//  Created by Carlo Macor on 13/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Famiglia.h"


@implementation Famiglia

- (void) InitFamiglia  {
     ListaComponenti = [[NSMutableArray arrayWithCapacity:8] retain];
     associatoedif = NO;
     idNucleo      = 0;
     Foglio        = @"";
     Particella = @"";
     Sub = @"";
     dataFormazione = [NSCalendarDate    calendarDate];
     Via = @"";
     nr  = @"";
     Piano = @"";
     interno = @"";
	 codFamiglia = @"";

} 



NSMutableArray *ListaComponenti;


- (void) salva              :(NSMutableData *) lodata {
	
	[lodata appendBytes:(const void *)&associatoedif          length:sizeof(associatoedif)       ];
	[lodata appendBytes:(const void *)&idNucleo               length:sizeof(idNucleo)            ];
	[self addstringaData2 : lodata :  Foglio  ];
	[self addstringaData2 : lodata :  Particella  ];
	[self addstringaData2 : lodata :  Sub  ];
		//NSCalendarDate   * dataFormazione;
	[self addstringaData2 : lodata :  Via  ];
	[self addstringaData2 : lodata :  nr  ];
	[self addstringaData2 : lodata :  Piano  ];
	[self addstringaData2 : lodata :  interno  ];
	[self addstringaData2 : lodata :  codFamiglia  ];
	int ncomp = [ListaComponenti count];
	[lodata appendBytes:(const void *)&ncomp          length:sizeof(ncomp)       ];

}

/*
- (void) apri               : (NSString *) nomefile  {
	
}

 */

- (void)  apri           :(NSData  *) DataFile : (int *) posdata {
	[DataFile getBytes:&associatoedif  range:NSMakeRange (*posdata,  sizeof(associatoedif)) ];       *posdata +=sizeof(associatoedif);
	[DataFile getBytes:&idNucleo       range:NSMakeRange (*posdata,  sizeof(idNucleo)) ];            *posdata +=sizeof(idNucleo);

	[Foglio         release];	Foglio         = [[self GetStringaData2:DataFile :posdata] retain];
	[Particella     release];	Particella     = [[self GetStringaData2:DataFile :posdata] retain];
	[Sub            release];	Sub            = [[self GetStringaData2:DataFile :posdata] retain];

	[Via            release];	Via            = [[self GetStringaData2:DataFile :posdata] retain];
	[nr             release];	nr             = [[self GetStringaData2:DataFile :posdata] retain];
	[Piano          release];	Piano          = [[self GetStringaData2:DataFile :posdata] retain];
	[interno        release];	interno        = [[self GetStringaData2:DataFile :posdata] retain];
	[codFamiglia    release];	codFamiglia    = [[self GetStringaData2:DataFile :posdata] retain];
	int ncomp;
	[DataFile getBytes:&ncomp  range:NSMakeRange (*posdata,  sizeof(ncomp)) ];       *posdata +=sizeof(ncomp);

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


- (NSMutableArray *) ListaComponenti {
	return ListaComponenti;
}

- (bool)        associatoedif{
	return associatoedif;
}

- (int)        idNucleo{
	return idNucleo;
}

- (NSString *) Foglio {
	return Foglio;
}

- (NSString *) Particella{
	return Particella;
}

- (NSString *) Sub{
	return Sub;
}

- (NSCalendarDate   *) dataFormazione{
	return dataFormazione;
}

- (NSString *) Via{
	return Via;
}

- (NSString *) nr{
	return nr;
}

- (NSString *) Piano{
	return Piano;
}

- (NSString *) interno{
	return interno;
}

- (NSString *) codFamiglia{
	return codFamiglia;
}

- (NSString *) Nome1 {
	if (ListaComponenti>0) return  [[ListaComponenti objectAtIndex:0] Nome];
	else return @"";
}

- (NSString *) Cognome1 {
	Residente * resider = [ListaComponenti objectAtIndex:0];
	return [resider Cognome];
}

- (NSString *) dataNascitaStr1 {
	Residente * resider = [ListaComponenti objectAtIndex:0];
	return [resider dataNascitaStr];

}

- (NSString *) viaEstesa1 {
	Residente * resider = [ListaComponenti objectAtIndex:0];
	return [resider viaEstesa];

}

- (NSCalendarDate   *) dataNascita1 {
	if (ListaComponenti>0) return  [[ListaComponenti objectAtIndex:0] dataNascita];
	else return nil;
	
}


- (void)       setassociatoedif: (bool) asso {
	associatoedif = asso;
}

- (void)       setidNucleo: (int) iddo {
	idNucleo = iddo;	
}

- (void)       setFoglio: (NSString *) foglio {
	[Foglio release]; [foglio retain]; Foglio = foglio;
}


- (void)       setParticella: (NSString *) particella{
	[Particella release]; [particella retain]; Particella = particella;
}

- (void)       setSub: (NSString *) sub{
	[Sub release]; [sub retain]; Sub = sub;
}

- (void)       setdataFormazione : (NSCalendarDate   *) data{
	[dataFormazione release]; [data retain]; dataFormazione = data;
}

- (void)       setVia: (NSString *) via{
	[Via release]; [via retain]; Via = via;
}

- (void)       setViacivico: (NSString *) via {
	[Via release]; [nr release];
	NSRange rgciv = [via rangeOfString:@"snc"];
	if (rgciv.length==3) {
		nr = @"snc";
		NSRange rg ; rg.location=0; rg.length = [via length]-4;
		Via = [[via substringWithRange :rg ] retain];
			//		NSLog(@"Via -%@-",Via);		NSLog(@"nr -%@-",nr);
	} else {
		rgciv = [via rangeOfString:@"n."];
		NSRange rg ; rg.location=0; rg.length =  rgciv.location-1;
		Via = [[via substringWithRange :rg ] retain];
        rg.location =  rgciv.location+3;
		rg.length =0;
		for (int i= rg.location; i<[via length]; i++) {
			if ([via characterAtIndex:i] !=32) rg.length++;	else break;
		}
		nr = [[via substringWithRange :rg ] retain];
			//		NSLog(@"Vio -%@-",via);		NSLog(@"Via -%@-",Via);		NSLog(@"nr -%@-",nr);
	}
}



- (void)       setnr: (NSString *) numero{
	[nr release]; [numero retain]; nr = numero;
}

- (void)       setPiano: (NSString *) piano{
	[Piano release]; [piano retain]; Piano = piano;
}

- (void)       setinterno: (NSString *) inter{
	[interno release]; [inter retain]; interno = inter;
}

- (void)       setcodFamiglia : (NSString *) codfam{
	[codFamiglia release]; [codfam retain]; codFamiglia = codfam;
}





- (void)  addResidente  : (Residente *) resider {
	[ListaComponenti addObject:resider];
}

- (NSComparisonResult)CompareNome      :(Famiglia *) famer {
	NSComparisonResult risulta = [[self Nome1] caseInsensitiveCompare:[famer Nome1]];
	if (risulta == NSOrderedSame) risulta = [[self Cognome1] caseInsensitiveCompare:[famer Cognome1]];
	return risulta;
} 

- (NSComparisonResult)CompareCognome   :(Famiglia *) famer  {
	NSComparisonResult risulta = [[self Cognome1] caseInsensitiveCompare:[famer Cognome1]];
	if (risulta == NSOrderedSame) risulta = [[self Nome1] caseInsensitiveCompare:[famer Nome1]];
	return risulta;
} 

- (NSComparisonResult)CompareVia       :(Famiglia *) famer  {
	NSComparisonResult risulta = [[self Via] caseInsensitiveCompare:[famer Via]];
	if (risulta == NSOrderedSame) risulta = [[self nr] compare:[famer nr] options:NSNumericSearch];
	if (risulta == NSOrderedSame) risulta = [[self Cognome1] caseInsensitiveCompare:[famer Cognome1]];
	if (risulta == NSOrderedSame) risulta = [[self Nome1]    caseInsensitiveCompare :[famer Nome1   ]];
	return risulta;
} 

- (NSComparisonResult)CompareData      :(Famiglia *) famer  {
	NSComparisonResult risulta ;
	{ 	if ([self dataNascita1] == [famer dataNascita1]) risulta = NSOrderedSame;
		if ([self dataNascita1] <  [famer dataNascita1]) risulta = NSOrderedAscending;
		if ([self dataNascita1] >  [famer dataNascita1]) risulta = NSOrderedDescending;	}
	if (risulta == NSOrderedSame) risulta = [[self Cognome1] caseInsensitiveCompare:[famer Cognome1]];
	return risulta;
	
} 




@end
