//
//  Immobili.m
//  MacOrMap
//
//  Created by Carlo Macor on 28/09/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Immobili.h"



@implementation Immobili




- (void) initimmobili                                  {
	VersioneImmobili = @"V1";
	CodiceComune     = @"";
	nomecomune       = @"";
	ListaTerreni    = [[NSMutableArray alloc] init];
	ListaSubalterni = [[NSMutableArray alloc] init];
}


- (void) svuotaListaTerreni                            {
	[ListaTerreni  removeAllObjects];
}

- (void) svuotaListaSubalterni                         {
	[ListaSubalterni  removeAllObjects];
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


- (void) salva : (NSString *) nomefile                 {
	NSMutableData *lodata;
	lodata = [NSMutableData dataWithCapacity:1000000];
	[self addstringaData2 : lodata : VersioneImmobili];
	[self addstringaData2 : lodata : CodiceComune];
	[self addstringaData2 : lodata : nomecomune];
	Terreno    * locter;
	Subalterno * locsub;
	int numele ;
		//	[ListaTerreni removeAllObjects];
	
	numele = ListaTerreni.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	for (int i=0; i<ListaTerreni.count; i++)    { 	locter = [ListaTerreni    objectAtIndex:i]; 	[locter salva : lodata];  	}
	
	numele = ListaSubalterni.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	for (int i=0; i<ListaSubalterni.count; i++) { locsub = [ListaSubalterni objectAtIndex:i]; [locsub salva : lodata];  }
	
	
	[lodata writeToFile:nomefile atomically:NO];

}

- (void) apri  : (NSString *) nomefile                 {

	NSData * DataFile ;
	int posdata =0;
	int numobj;
	DataFile = [NSData dataWithContentsOfFile:nomefile];
	if (DataFile==nil) return;

	[VersioneImmobili release];	    VersioneImmobili =  [[self GetStringaData2:DataFile :&posdata] retain];
	
	[CodiceComune     release];		CodiceComune     =  [[self GetStringaData2:DataFile :&posdata] retain];
	[nomecomune       release];		nomecomune       =  [[self GetStringaData2:DataFile :&posdata] retain];

	[DataFile getBytes:&numobj  range:NSMakeRange (posdata,  sizeof(numobj)) ];       posdata +=sizeof(numobj);
	
	Terreno    * terer;
	for (int i=0; i<numobj; i++) { terer = [Terreno alloc]; [terer svuota]; [terer	apri : DataFile :&posdata];  [ListaTerreni addObject:terer];  }
	
	[DataFile getBytes:&numobj  range:NSMakeRange (posdata,  sizeof(numobj)) ];       posdata +=sizeof(numobj);
	Subalterno    * suber;
	for (int i=0; i<numobj; i++) {  
		suber = [Subalterno alloc]; [suber svuota]; 	
		[suber	apri : DataFile :&posdata];  
		
		[ListaSubalterni addObject:suber];  
	}

	
		//	[self salva: nomefile];
	
}



- (NSString       *) VersioneImmobili                  {
	return VersioneImmobili;
}

- (NSString       *) CodiceComune                      {
	return CodiceComune;
}

- (NSString       *) nomecomune                        {
	return nomecomune;
}


- (NSMutableArray *) LTer                              {
	return ListaTerreni;
}


- (NSMutableArray *) ListaSubalterni                   {
	return ListaSubalterni;
}




- (int)        numTuttiSubalterni                      {
	return [ListaSubalterni count];
}


- (int)        numTuttiTerreni                         {
	return [ListaTerreni count];
}


- (NSString       *) indicesubStr        :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] indicestr  ];
}

- (NSString       *) renditasubStr       :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] renditastr  ];
}


- (NSString       *) foglioSubStr        :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Foglio  ];
}

- (NSString       *) particSubStr        :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Particella  ];
}

- (NSString       *) SubSubStr           :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Sub  ];
}

- (NSString       *) CatSubStr           :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Categoria  ];
}

- (NSString       *) ClaSubStr           :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Classe  ];
}

- (NSString       *) ConsistenzaSubStr   :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Consistenza  ];
}

- (NSString       *) PianoedifSubStr     :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] PianoEdificio  ];
}

- (NSString       *) CivicoSubStr        :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Civico  ];
}

- (NSString       *) InternoSubStr       :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Interno  ];
}

- (NSString       *) ViaSubStr           :(int) indice {
	return [[ListaSubalterni objectAtIndex:indice] Via  ];
}


- (NSString       *) indiceTsubStr       :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] indicestr  ];
}

- (NSString       *) foglioTSubStr       :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Foglio  ];
}

- (NSString       *) particTSubStr       :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Particella  ];
}

- (NSString       *) qualitaTSubStr      :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Qualita  ];
}

- (NSString       *) classeTSubStr       :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Classe  ];
}

- (NSString       *) superficieTSubStr   :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Superficiestr  ];
}

- (NSString       *) domenicaleTSubStr   :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Renditadomenicalestr  ];
}

- (NSString       *) agrariaTSubStr      :(int) indice {
	return [[ListaTerreni objectAtIndex:indice] Renditaagrariastr  ];
}


- (bool)          EsisteTerreno    : (NSString *) Fg :  (NSString *) Part {
    bool risulta=NO;    
    Terreno    * terer;
	for (int i=0; i<[ListaTerreni count]; i++) {  
		terer = [ListaTerreni objectAtIndex:i]; 	
        if (([[terer Foglio] isEqualToString:Fg]) & ([terer inlistanomepart  : Part])  ) {
            risulta=YES; break;
        }
    }
    return risulta;
}

- (bool)          EsisteFabbricato : (NSString *) Fg :  (NSString *) Part {
    bool risulta=NO;    
        //    NSLog(@"N^ %@ %@",Fg,Part);
   
    Subalterno    * suber;
	for (int i=0; i<[ListaSubalterni count]; i++) {  
		suber = [ListaSubalterni objectAtIndex:i]; 	

        if ([[suber Foglio] isEqualToString:Fg]) {
                //          NSLog(@"^ %@ %@",[suber Foglio],[suber Particella]);

           if ([suber inlistanomesub  : Part])   {
            risulta=YES; break;
        }
        }
    }
    

    return risulta;
}

- (NSString       *) QualitaTerrenoFgPart  : (NSString *) Fg :  (NSString *) Part {
  NSString * risulta=@"";
	Terreno    * terer;
	for (int i=0; i<[ListaTerreni count]; i++) {  
		terer = [ListaTerreni objectAtIndex:i]; 	
        if (([[terer Foglio] isEqualToString:Fg]) & ([terer inlistanomepart  : Part])  ) {
            risulta=[terer Qualita] ; break;
        }
    }
  return risulta;
}


@end
