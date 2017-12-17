//
//  Anagrafe.m
//  MacOrMap
//
//  Created by Carlo Macor on 14/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Anagrafe.h"


@implementation Anagrafe


    // ListaFamiglie

- (void) initAnagrafe {
    ListaFamiglie            = [[NSMutableArray alloc] initWithCapacity:10000];
	ListaResidenti           = [[NSMutableArray alloc] initWithCapacity:40000];
    ListaVie                 = [[NSMutableArray alloc] initWithCapacity:1000];
	ListaFamiglieFiltrata    = [[NSMutableArray alloc] initWithCapacity:40000];
	ListaResidentiFiltrata   = [[NSMutableArray alloc] initWithCapacity:10000];

}

- (void) salva : (NSString *) nomefile                 {
   NSMutableData *lodata;
   lodata = [NSMutableData dataWithCapacity:1000000];
   int numresid = ListaResidenti.count;
   [lodata appendBytes:(const void *)&numresid              length:sizeof(numresid)            ];
	Residente * resider;
	for (int i=0; i<ListaResidenti.count; i++) { resider = [ListaResidenti objectAtIndex:i]; 
		
		int salvafam=0;		
		Famiglia * famyl;
			for (int j=0; j<ListaFamiglie.count; j++) {
				famyl = [ListaFamiglie objectAtIndex:j];
				if ([[resider codFamiglia] isEqualToString: [famyl codFamiglia]]) {
					salvafam = j; break;
				}
			}
		[resider salva : lodata :salvafam]; 
	}
	
	int numfam = ListaFamiglie.count;
	[lodata appendBytes:(const void *)&numfam              length:sizeof(numfam)            ];
	Famiglia * famyl;
	for (int i=0; i<ListaFamiglie.count; i++) { famyl = [ListaFamiglie objectAtIndex:i]; [famyl salva : lodata];  }
	
	NSLog(@"Salvo Fam %d",ListaFamiglie.count);
	
   [lodata writeToFile:nomefile atomically:NO];
}

- (void) apri  : (NSString *) nomefile {
	NSData * DataFile ;
	int posdata =0;
	int numobj;
	DataFile = [NSData dataWithContentsOfFile:nomefile];
	if (DataFile==nil) return;
	[DataFile getBytes:&numobj  range:NSMakeRange (posdata,  sizeof(numobj)) ];       posdata +=sizeof(numobj);
	Residente * resider;
	for (int i=0; i<numobj; i++) {  
		resider = [Residente alloc]; 	[resider svuota]; 
		[resider	apri : DataFile :&posdata]; 
		[ListaResidenti addObject:resider];  
	}
	
	
	[DataFile getBytes:&numobj  range:NSMakeRange (posdata,  sizeof(numobj)) ];       posdata +=sizeof(numobj);
	Famiglia * famyl;
	
		//	NSLog(@" Fam %d",numobj);
	
	for (int i=0; i<numobj; i++) {  
		famyl = [Famiglia alloc]; 	[famyl InitFamiglia]; 
		[famyl	apri : DataFile :&posdata]; 
		[ListaFamiglie addObject:famyl];  
		
			//		NSLog(@"- %@ ",[famyl Via]);
	}

	
	for (int i=0; i<ListaResidenti.count; i++) {
	  resider = [ListaResidenti objectAtIndex:i];
	  famyl = [ListaFamiglie objectAtIndex:[resider indsalvaFamiglie]];
	  [[famyl ListaComponenti] addObject:resider];
	}
 
		// ricostruzione vie;
	for (int i=0; i<ListaFamiglie.count; i++) {
		famyl = [ListaFamiglie objectAtIndex:i];
		bool trovata = NO;
		for (int j=0; j<ListaVie.count; j++) {
			if ([[famyl Via] isEqualToString: [ListaVie objectAtIndex:j]]) {
			 trovata=YES; break;
		 }
		}
	    if (!trovata){	[ListaVie addObject:[famyl Via]  ];	} 
	}

	
	for (int i=0; i<ListaFamiglie.count; i++) {
		famyl = [ListaFamiglie objectAtIndex:i];
		for (int j=0; j<[[famyl ListaComponenti] count]; j++) {
			  resider = [[famyl ListaComponenti] objectAtIndex:j];
			[resider ImpostagliFamiglia:famyl];
		}
	}
	
		//	for (int j=0; j<ListaVie.count; j++) {	NSLog(@" - %d %@",j,[ListaVie objectAtIndex:j]);	}
	
	NSArray *sortedArray; 
	sortedArray = [ListaVie sortedArrayUsingSelector:@selector(compare:)];    

		//	for (int j=0; j<sortedArray.count; j++) {	NSLog(@" - %d %@",j,[sortedArray objectAtIndex:j]);	}
	
	[ListaVie removeAllObjects];
	[ListaVie setArray:sortedArray];
		// qui riporre nuovamente i residenti nelle appropiate famiglie;

		//	[self salva:nomefile];
}

- (NSMutableArray *) ListaFamiglie {
    return ListaFamiglie;
}

- (NSMutableArray *) ListaResidenti {
	return ListaResidenti;
}


- (NSMutableArray *) ListaVie {
    return ListaVie;
}

- (NSMutableArray *) ListaFamiglieFiltrata {
	return ListaFamiglieFiltrata;
}

- (NSMutableArray *) ListaResidentiFiltrata {
	return ListaResidentiFiltrata;
}


- (Famiglia *) givemeaddFamily : (NSString *) codfam  {
	Famiglia * resulta = nil;
	Famiglia * locFam;
	for (int i=0; i<ListaFamiglie.count; i++) {
		locFam = [ListaFamiglie objectAtIndex:i];
		if ([[locFam codFamiglia] isEqualToString:codfam]) {
			resulta = locFam; break;
		}
	}
	return resulta;
}



- (NSString *) senzaspazifinali : (NSString *) str {
	NSString * resulta;
	int finale =[str length]-1;
	NSRange rg; rg.location=0;
	for (int i= [str length]-1; i>0; i--) {
		if ([str characterAtIndex:i]==32) finale=i; else break;
	}
	rg.length = finale;
	resulta = [str substringWithRange:rg];
	return resulta;
}



- (void) FormaAnagrafe                  {
	NSStringEncoding encoding;
	NSString * filestr = [NSString stringWithContentsOfFile:@"/MacOrMap/Catasto/ANAGRAFE.txt"  usedEncoding:&encoding  error: NULL];
	NSArray * righe = [filestr componentsSeparatedByString:@"\n"];
	NSLog(@"- a-%d ",righe.count);
	for (int i=1; i<righe.count; i++) {
		Residente * resider;
		Famiglia  * familyRelativa;

			//	NSLog(@"- - %d %@",i, [righe objectAtIndex:i] );
		NSRange aRange;
		aRange.location=0; 		aRange.length=10;
		NSString * riga = [righe objectAtIndex:i];
		if ([riga length]<20) continue;
		NSString * codicefam = [riga substringWithRange : aRange];
			//		NSLog(@"cod - %d -%@-",i, codicefam );
		
		aRange.location=10; 		aRange.length=40;
		NSString * _Cognome = [self senzaspazifinali: [riga substringWithRange : aRange] ];
			//		NSLog(@"cod - %d -%@-",i, _Cognome );
		
		aRange.location=50; 		aRange.length=40;
		NSString * _Nome = [self senzaspazifinali: [riga substringWithRange : aRange]];
			//		NSLog(@"cod - %d -%@-",i, _Nome );
		
		aRange.location=90; 		aRange.length=8;
		NSString * _DataNasc = [riga substringWithRange : aRange];
			//	NSLog(@"cod - %d -%@-",i, _DataNasc );
		
		aRange.location=98; 		aRange.length=8;
			//		NSString * _Info = [riga substringWithRange : aRange];
			//		NSLog(@"cod - %d -%@-",i, _Info );
		aRange.location=105; 		aRange.length=1;
				NSString * intestatario = [riga substringWithRange : aRange];

		
		
		aRange.location=106; 		aRange.length=80;
		NSString * _Indirizzo = [self senzaspazifinali: [riga substringWithRange : aRange]];
			//			NSLog(@"via - %d -%@-",i, _Indirizzo );
		
		aRange.location=186; 		aRange.length=16;
		NSString * _CodFis = [riga substringWithRange : aRange];
			//		NSLog(@"cod - %d -%@-",i, _CodFis );
		
		resider = [Residente alloc];
		[ListaResidenti addObject:resider];
		[resider SetNome:_Nome];
		[resider SetCognome:_Cognome];
		[resider SetCodFis:_CodFis];
		[resider SetCodFam:codicefam];
		[resider SetDataNascita:_DataNasc];
		[resider SetviaEstesa:_Indirizzo];
		[resider SetcodIntestatario:[intestatario intValue]];

		
		familyRelativa = [self givemeaddFamily:codicefam];
		if (familyRelativa==nil) {
			familyRelativa = [Famiglia alloc];  [familyRelativa InitFamiglia];
			[familyRelativa setcodFamiglia:codicefam];
			[familyRelativa setViacivico:_Indirizzo];
			[ListaFamiglie addObject:familyRelativa ];
		}
		
		[familyRelativa addResidente: resider];
	}
	
		// [self logga];
	[self salva:@"/MacOrMap/Catasto/Anafrafe.AnMap"];
}


- (void) logga {
	Residente * resider;
	for (int i=0; i<ListaResidenti.count; i++) {
		resider = [ListaResidenti objectAtIndex:i];
		[resider logga];
	}
}



@end
