//
//  Patrimonio.m
//  MacOrMap
//
//  Created by Carlo Macor on 16/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Patrimonio.h"


@implementation Patrimonio

- (NSString    *) DirittiOneri {
	return DirittiOneri;
}

- (NSString    *) Foglio       {
	return Foglio;
}

- (NSString    *) Particella   {
	return Particella;
}

- (NSString    *) Sub          {
	return Sub;
}

- (NSString    *) Categoria    {
	return Categoria;
}

- (int)           CodCategoria{
	return CodCategoria;
}

- (NSString *) EstraiPrimoElemento :  (NSString *) strin {
	NSString * resulta;
	NSRange rg,rgloc;
	rg = [strin rangeOfString:@","];
	if (rg.length <= 0) {  resulta = strin;	}
	else {  rgloc.location = 0; rgloc.length = rg.location;	resulta = [strin substringWithRange:rgloc];	}
	return resulta;
}

- (NSString    *) FoglioSingolo {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Foglio];
	return resulta;
}

- (NSString    *) ParticellaSingola {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Particella];
	return resulta;
	
}

- (NSString    *) SubSingolo {
	NSString * resulta;
	resulta = [self EstraiPrimoElemento:Sub];
	return resulta;
}



- (NSString    *) Renditastr   {
	return [NSString stringWithFormat:@"%1.2f", Redditoedile ];
} 

- (NSString    *) Agrariastr   {
	return [NSString stringWithFormat:@"%1.2f", RedditoAgrario ];
} 

- (NSString    *) Domenicalestr   {
	return [NSString stringWithFormat:@"%1.2f", RedditoDomenicale ];
} 


- (NSString    *) Infocompleto {
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:200];
		[locres   appendFormat:	 @"Fg:%@ Part:%@ Sub:%@ " , Foglio , Particella, Sub ];
	return locres;
}

- (NSString    *) percPropStr {
		//	NSLog(@"passa");
		//	NSLog(@"%d %d",NDiritti,DDiritti);
    float  DD = ((float)NDiritti*100)/((float)(DDiritti));
	return [NSString stringWithFormat:@"%1.1f", DD];
}

- (float)         fprop        {
	return fprop;
}

- (int)           TipoEdiTerra {
	return TipoEdiTerra;
}

- (double)         Redditoedile {
	return Redditoedile;
}

- (double)         RedditoDomenicale{
	return RedditoDomenicale;
}

- (double)         RedditoAgrario {
	return RedditoAgrario;
}



- (void) SetPatrimonioEsteso: (NSString *) oneri : (NSString *) infoprop {
	fprop = 0;
	[oneri retain]; [DirittiOneri release];	 DirittiOneri = oneri;

	NSRange rg1 = [infoprop rangeOfString:@"Foglio:"];
	NSRange rg2 = [infoprop rangeOfString:@"Particella:"];
	NSRange rg3 = [infoprop rangeOfString:@"Sub.:"];

    NSRange rg ;
	rg.location = rg1.length+1; 	rg.length = rg2.location-(rg.location+1);

	[self SetFoglio:[infoprop substringWithRange:rg] ];
		//	NSLog(@"fg -%@-",[infoprop substringWithRange:rg]);

	
	rg2.location = rg2.location+12; 	
	if (rg3.length>0) rg2.length = rg3.location-(rg2.location+1);
		           else rg2.length = [infoprop length]-rg2.location;
	[self SetParticella:[infoprop substringWithRange:rg2] ];
		//	NSLog(@"pt -%@-",[infoprop substringWithRange:rg2]);
	
	if (rg3.length>0) {
		rg.location = rg3.location+6; 	rg.length = [infoprop length]-(rg.location);
		[self SetSub:[infoprop substringWithRange:rg] ];
			//	NSLog(@"sub -%@-",[infoprop substringWithRange:rg]);
		
	}
}

- (void) SetFoglio     : (NSString *) foglio               {
	[foglio retain]; [Foglio release];	 Foglio = foglio;
}

- (void) SetParticella : (NSString *) particella           {
	NSMutableString *passapart = [[NSMutableString alloc] initWithCapacity:10];
 	unichar c=0;
	for (int i=0; i<[particella length]; i++) {  
		c=	[particella characterAtIndex:i];
		if ((c!=9) & (c!=32)) [passapart appendFormat:	 @"%C", c];
	}
		//	[particella retain]; 
	[Particella release];	 Particella = passapart;
}

- (void) SetSub        : (NSString *) sub                  {
	[sub retain]; [Sub release];	 Sub = sub;
}

- (void) SetCategoria  : (NSString *) categoria            {
	[categoria retain]; [Categoria release];	 Categoria = categoria;
	CodCategoria = [self faicodCat:Categoria];
}


- (int) faicodCat      : (NSString *) st                   {
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
	if ([st isEqualToString: @"F/2"])  risulta = 48;  // in costruzione + Unita collabenti
	if ([st isEqualToString: @"F/3"])  risulta = 49;  // in costruzione 
	if ([st isEqualToString: @"F/4"])  risulta = 50;  // costruzione da definira 
	if ([st isEqualToString: @"F/5"])  risulta = 51;  // lastrico solare 
	if ([st isEqualToString: @"F/6"])  risulta = 52;  // lastrico solare 
	if ([st isEqualToString: @"F/7"])  risulta = 53;  // lastrico solare 
	if ([st isEqualToString: @"F/8"])  risulta = 54;  // lastrico solare 
	if ([st isEqualToString: @"F/9"])  risulta = 55;  // lastrico solare 
	if ([st isEqualToString: @"F/10"]) risulta = 56;  // lastrico solare 
	if ([st isEqualToString: @"F/11"]) risulta = 57;  // lastrico solare 
	
	
	if ([st isEqualToString: @"SEMINATIVO"]) risulta = 101;  
	if ([st isEqualToString: @"SEMIN"]) 	 risulta = 102;  // arboreo

	if ([st isEqualToString: @"ULIVETO"]) 	 risulta = 121;  
	if ([st isEqualToString: @"VIGNETO"]) 	 risulta = 122;  
	if ([st isEqualToString: @"FRUTTETO"]) 	 risulta = 123;  
	
	
	if ([st isEqualToString: @"ORTOIRRIG"])  risulta = 124;  
	if ([st isEqualToString: @"PASCOLO"]) 	 risulta = 125;  
	if ([st isEqualToString: @"PASC"]) 		 risulta = 126;  
	
	if ([st isEqualToString: @"BOSCO"]) 	 risulta = 130;  
	if ([st isEqualToString: @"CAST"]) 	     risulta = 131;  // frutto

	if ([st isEqualToString: @"STAGNO"]) 	 risulta = 140;  
	if ([st isEqualToString: @"INCOLT"]) 	 risulta = 141;  // prod
	if ([st isEqualToString: @"INCOLTSTER"]) risulta = 142;  

	if ([st isEqualToString: @"FERROVIASP"]) risulta = 150;  
	if ([st isEqualToString: @"FABB"]) 	     risulta = 151;  // Rurale
	if ([st isEqualToString: @"CAVA"]) 	     risulta = 152;  
	if ([st isEqualToString: @"CIMITERO"]) 	 risulta = 153;  
	if ([st isEqualToString: @"COSTRNOAB"])  risulta = 154;  
	if ([st isEqualToString: @"AREAFAB"])    risulta = 155;  
	if ([st isEqualToString: @"FUDACCERT"])  risulta = 156;  
	if ([st isEqualToString: @"RELITSTRAD"]) risulta = 157;  
	if ([st isEqualToString: @"PV"])         risulta = 158;  


	
	
	return risulta;
	
}



- (void) SetCodCategoria : (int) codcategoria              {
	CodCategoria = codcategoria;
}


- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;		
	for (int i=0; i<lungstr; i++) {
		ilcar = [ str characterAtIndex:i];
		ilcar++; 
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
		ilcar--;  	
		[locres   appendFormat:	 @"%c",ilcar];	}
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


- (void) salva          :(NSMutableData *) lodata                     {
	[lodata appendBytes:(const void *)&TipoEdiTerra         length:sizeof(TipoEdiTerra)            ];
	[lodata appendBytes:(const void *)&Redditoedile         length:sizeof(Redditoedile)            ];
	[lodata appendBytes:(const void *)&RedditoDomenicale    length:sizeof(RedditoDomenicale)       ];
	[lodata appendBytes:(const void *)&RedditoAgrario       length:sizeof(RedditoAgrario)          ];
	
	
	[lodata appendBytes:(const void *)&fprop              length:sizeof(fprop)            ];
	[self addstringaData2 : lodata : DirittiOneri  ];
	[self addstringaData2 : lodata : Foglio        ];
	[self addstringaData2 : lodata : Particella    ];
	[self addstringaData2 : lodata : Sub           ];
	[self addstringaData2 : lodata : Categoria     ];
	
	[lodata appendBytes:(const void *)&CodCategoria         length:sizeof(CodCategoria)            ];

	[lodata appendBytes:(const void *)&NDiritti         length:sizeof(NDiritti)            ];
	[lodata appendBytes:(const void *)&DDiritti         length:sizeof(DDiritti)            ];
}
		 /*
- (int)  apri           :(NSFileHandle  *) fileHandle : (int) posfile {
	NSData *_data;

	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(TipoEdiTerra)]; 	    [_data getBytes:&TipoEdiTerra];   
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(Redditoedile)]; 	    [_data getBytes:&Redditoedile];   
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(RedditoDomenicale)]; 	[_data getBytes:&RedditoDomenicale];   
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(RedditoAgrario)]; 	[_data getBytes:&RedditoAgrario];   

	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(fprop)]; 	[_data getBytes:&fprop];   

	[DirittiOneri release];		DirittiOneri =  [self GetStringaData:fileHandle];
	
	[Foglio       release];		Foglio       =  [self GetStringaData:fileHandle];
	
	[Particella   release];		Particella   =  [self GetStringaData:fileHandle];

	[Sub          release];		Sub          =  [self GetStringaData:fileHandle];
	
	[Categoria    release];		Categoria    =  [self GetStringaData:fileHandle];
	
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(CodCategoria)]; 	[_data getBytes:&CodCategoria];   
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(NDiritti)]; 	    [_data getBytes:&NDiritti];   
	_data=nil; _data = [fileHandle readDataOfLength:   sizeof(DDiritti)]; 	    [_data getBytes:&DDiritti];   

	if (DDiritti==0) DDiritti=1;
	return posfile;
}
*/

- (void)  apri           :(NSData  *) DataFile : (int *) posdata     {

		//- (int)  apri           :(NSFileHandle  *) fileHandle : (int) posfile {
		//	NSData *_data;
	[DataFile getBytes:&TipoEdiTerra  range:NSMakeRange (*posdata,  sizeof(TipoEdiTerra)) ];       *posdata +=sizeof(TipoEdiTerra);
	[DataFile getBytes:&Redditoedile  range:NSMakeRange (*posdata,  sizeof(Redditoedile)) ];       *posdata +=sizeof(Redditoedile);
	[DataFile getBytes:&RedditoDomenicale  range:NSMakeRange (*posdata,  sizeof(RedditoDomenicale)) ];       *posdata +=sizeof(RedditoDomenicale);
	[DataFile getBytes:&RedditoAgrario  range:NSMakeRange (*posdata,  sizeof(RedditoAgrario)) ];       *posdata +=sizeof(RedditoAgrario);

	[DataFile getBytes:&fprop  range:NSMakeRange (*posdata,  sizeof(fprop)) ];       *posdata +=sizeof(fprop);

	
	[DirittiOneri release];		DirittiOneri = [ [self GetStringaData2:DataFile :posdata] retain];

	[Foglio       release];		Foglio       = [ [self GetStringaData2:DataFile :posdata] retain];
	
	[Particella   release];		Particella   = [ [self GetStringaData2:DataFile :posdata] retain];
	
	[Sub          release];		Sub          = [ [self GetStringaData2:DataFile :posdata] retain];
	
	[Categoria    release];		Categoria    = [ [self GetStringaData2:DataFile :posdata] retain];
	
	
	[DataFile getBytes:&CodCategoria  range:NSMakeRange (*posdata,  sizeof(CodCategoria)) ];       *posdata +=sizeof(CodCategoria);
	[DataFile getBytes:&NDiritti  range:NSMakeRange (*posdata,  sizeof(NDiritti)) ];       *posdata +=sizeof(NDiritti);
	[DataFile getBytes:&DDiritti  range:NSMakeRange (*posdata,  sizeof(DDiritti)) ];       *posdata +=sizeof(DDiritti);

	if (DDiritti==0) DDiritti=1;

}



- (bool) presenzainfo   : (NSString *)fg :  (NSString *)part :  (NSString *)subo {
	bool resulta =NO;
	int pos1,pos2,pos3 ;
	int pos1f,pos2f,pos3f ;

	pos1=0; pos2=0; pos3=0;
	pos1f=0; pos2f=0; pos3f=0;
	
	
	
	
	return resulta;
}

- (void) setoneri       : (NSString *)oneristr {
		[oneristr retain]; [DirittiOneri release];	 DirittiOneri = oneristr;
	NSRange rg;
	rg = [oneristr rangeOfString:@"(1) Proprieta"];
	if (rg.length==0) return ;

	NSLog(@"AAA") ;

	NSMutableString *ris1 = [[NSMutableString alloc] initWithCapacity:40];
	unichar c=0;
	for (int i=rg.length+1; i<[oneristr length]; i++) {   c=	[oneristr characterAtIndex:i];	[ris1 appendFormat:	 @"%C", c];	}	
	
	NSLog(@"AA1") ;

	
	if ([ris1 length]==0 ) {  NDiritti=1;   DDiritti=1;		  }
	else {                          
		NDiritti=0;DDiritti=1;
		NSMutableString *ris2 = [[NSMutableString alloc] initWithCapacity:40];
		rg = [ris1 rangeOfString:@"per "];
		for (int i=rg.length+1; i<[ris1 length]; i++) { 
			c=	[ris1 characterAtIndex:i];	[ris2 appendFormat:	 @"%C", c];		
		}
		NSLog(@"AA3") ;

			//		NSLog(@"-%@",ris1);		NSLog(@"+%@",ris2);
		NSMutableString *ris3 = [[NSMutableString alloc] initWithCapacity:40];
		NSMutableString *ris4 = [[NSMutableString alloc] initWithCapacity:40];
		rg = [ris2 rangeOfString:@"/"];
		for (int i=0 ; i<rg.location; i++) {   c=	[ris2 characterAtIndex:i];	[ris3 appendFormat:	 @"%C", c];
		
			
			NSLog(@"AA2 %d %c",i,c ) ;

		}	
		NSLog(@"AA4") ;

		for (int i=rg.location+1; i<[ris2 length]; i++) {   c=	[ris2 characterAtIndex:i];	[ris4 appendFormat:	 @"%C", c];	}	
			//		NSLog(@"#%@",ris3);		NSLog(@"#%@",ris4);
        NDiritti=[ris3 intValue];

		NSLog(@"AA5") ;

		
		NSMutableString *ris5 = [[NSMutableString alloc] initWithCapacity:40];
		for (int i=0; i<[ris4 length]; i++) {  
			c=	[ris4 characterAtIndex:i];	
			if (c==32) break;
			[ris5 appendFormat:	 @"%C", c];	
		}	
        DDiritti=[ris5 intValue];
			//		NSLog(@"VV  %d %d",NDiritti,DDiritti);

	}

	

/*	
	NSRange rg;
	rg = [str rangeOfString:@","];
		//			NSLog(@"rg %d %d ",rg.length,rg.location);
	if (rg.length==0) return @"";
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=0; i<rg.location; i++) {   c=	[str characterAtIndex:i];	[risulta appendFormat:	 @"%C", c];	}	
	return risulta;	
*/	
		//	int        NDiritti;
		//	int        DDiritti;
	
	
}

- (void) SetaddedFoglio      : (NSString *) foglio {
	NSString * oldfoglio;
	oldfoglio = [NSString stringWithFormat:@"%@,%@",Foglio,foglio];
	[Foglio release]; Foglio =[NSString stringWithString:oldfoglio];
		//	NSLog(@"F %@",Foglio);
}

- (void) SetaddedParticella  : (NSString *) particella {
	NSString * oldparticella;
	oldparticella = [NSString stringWithFormat:@"%@,%@",Particella,particella];
	[Particella release]; Particella =[NSString stringWithString:oldparticella];
		//			NSLog(@"p %@",Particella);
}

- (void) SetaddedSub         : (NSString *) sub {
	NSString * oldsub;
	oldsub = [NSString stringWithFormat:@"%@,%@",Sub,sub];
	[Sub release]; Sub =[NSString stringWithString:oldsub];
		//	NSLog(@"S %@",Sub);
}


- (void) SetTipoEdiTerra        : (int)   value {
	TipoEdiTerra = value;
}

- (void) SetRedditoedile        : (float) value {
	Redditoedile = value;
}

- (void) SetRedditoDomenicale   : (float) value {
	RedditoDomenicale = value;
}

- (void) SetRedditoAgrario      : (float) value {
	RedditoAgrario = value;
}

- (void) SetRedditoedileStr     : (NSString *) strvalue {
	NSRange rg = [strvalue rangeOfString:@"Euro"];
    NSRange rg2;
	if (rg.length>0) {
		rg2.location = rg.location+rg.length+1;
		rg2.length = [strvalue length]-rg2.location;
		Redditoedile = [self valoresenzapunto:[strvalue substringWithRange:rg2] ];
	}
	else {	Redditoedile = [self valoresenzapunto:strvalue ];    }
}

- (void) SetRedditoDomenicaleStr: (NSString *) strvalue {
	NSRange rg = [strvalue rangeOfString:@"Euro"];
    NSRange rg2;
	if (rg.length>0) {
		rg2.location = rg.location+rg.length+1;
		rg2.length = [strvalue length]-rg2.location;
		RedditoDomenicale = [self valoresenzapunto:[strvalue substringWithRange:rg2] ];
	}
	else {	RedditoDomenicale = [self valoresenzapunto:strvalue ];    }
}

- (void) SetRedditoAgrarioStr   : (NSString *) strvalue {
	NSRange rg = [strvalue rangeOfString:@"Euro"];
    NSRange rg2;
	if (rg.length>0) {
		rg2.location = rg.location+rg.length+1;
		rg2.length = [strvalue length]-rg2.location;
		RedditoAgrario = [self valoresenzapunto:[strvalue substringWithRange:rg2] ];
	}
	else {	RedditoAgrario = [self valoresenzapunto:strvalue ];    }
}



- (bool)  eguaglia              : (Patrimonio *) pat2 {
	bool resulta =NO;
	if ( ([[self Foglio]      isEqualToString : [pat2 Foglio]]       ) & 
		([[self Particella]   isEqualToString : [pat2 Particella]]   ) & 
		([[self Sub]          isEqualToString : [pat2 Sub]]          ) &
		([[self DirittiOneri] isEqualToString : [pat2 DirittiOneri]] ) &
		
		([self Redditoedile]      == [pat2 Redditoedile]      ) &
		([self RedditoDomenicale] == [pat2 RedditoDomenicale] ) &
		([self RedditoAgrario]    == [pat2 RedditoAgrario]    ) &
		([self CodCategoria]      == [pat2 CodCategoria]    ) &
		
		([ self TipoEdiTerra] == [pat2 TipoEdiTerra])
		)	resulta = YES;
	return resulta;
}



- (double) valoresenzapunto : (NSString *) valstr          {
	double locvalue =0;
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	unichar c=0;	
	for (int i=0; i<[valstr length]; i++) {  
		c=	[valstr characterAtIndex:i];
		if (c!=46) { if (c==44) [risulta appendFormat:	 @"%C", 46]; else [risulta appendFormat:	 @"%C", c];	}
	}
	locvalue = [risulta doubleValue];
	return locvalue;
}


- (void)  InterpretaDirittiOneri  {
	NSRange rg,rg2,rgspace;
	NSString * partevalore;
	NSString * partevalore2;
	rg = [DirittiOneri rangeOfString:@"(1) Proprieta` per "];

	if (rg.length>0) {
        partevalore = [DirittiOneri substringFromIndex:(rg.length+rg.location)];
		rgspace = [partevalore rangeOfString:@" "];
		if (rgspace.length>0) {
			NSRange rang; rang.location=0; rang.length= rgspace.location;
			partevalore2 = [partevalore substringWithRange:rang];
		} else {partevalore2 = partevalore;	}

		NSRange rgslasc;
		rgslasc = [partevalore rangeOfString:@"/"];
		NSString * numer, *diver ;
		NSRange rgnumer; rgnumer.location=0; rgnumer.length=rgslasc.location;
		numer = [partevalore substringWithRange:rgnumer];
        diver =  [partevalore2 substringFromIndex:rgslasc.location+1];
			//	NSLog(@"-%@- N:-%@- D:-%@-", partevalore2 ,numer,diver);
		NDiritti = [numer intValue];		DDiritti = [diver intValue];
		if (DDiritti==0) DDiritti=1;
		
	} else {
		rg2 = [DirittiOneri rangeOfString:@"(1) Proprieta`"];
		if (rg2.length>0) {	NDiritti = 1;        DDiritti=1;	} // else 	NSLog(@"- %@", DirittiOneri);
		
	}

	 
	
}

- (void) logga {
	NSLog(@"Patr. Diritti  -%@", DirittiOneri);
	NSLog(@"- %@ %@ %@ -", Foglio , Particella , Sub );
}


- (NSComparisonResult)CompareFg       :(Patrimonio *)pater {
	NSComparisonResult risulta = [[self Foglio] compare:[pater Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[pater Particella] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[pater Sub] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareFg2      :(Patrimonio *)pater {
	NSComparisonResult risulta = [[pater Foglio] compare:[self Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[pater Particella] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub] compare:[pater Sub] options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart     :(Patrimonio *)pater {
	NSComparisonResult            risulta = [[self Particella] compare:[pater Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[pater Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub]        compare:[pater Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)ComparePart2    :(Patrimonio *)pater {
	NSComparisonResult            risulta = [[pater Particella] compare:[self Particella]    options:NSNumericSearch ];
	if (risulta == NSOrderedSame) risulta = [[self Foglio] compare:[pater Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Sub]    compare:[pater Sub]    options:NSNumericSearch];	
	return risulta;
}

- (NSComparisonResult)CompareSub      :(Patrimonio *)pater {
	NSComparisonResult            risulta = [[self Sub]        compare:[pater Sub]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[pater Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[pater Particella]    options:NSNumericSearch ];
	return risulta;
}

- (NSComparisonResult)CompareSub2     :(Patrimonio *)pater {
	NSComparisonResult            risulta = [[pater Sub]       compare:[self Sub]    options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Foglio]     compare:[pater Foglio] options:NSNumericSearch];	
	if (risulta == NSOrderedSame) risulta = [[self Particella] compare:[pater Particella]    options:NSNumericSearch ];
	return risulta;
}

- (NSComparisonResult)CompareCat      :(Patrimonio *)pater {
	NSComparisonResult risulta;
		if ([self CodCategoria] == [pater CodCategoria]) risulta = NSOrderedSame;
		if ([self CodCategoria] <  [pater CodCategoria]) risulta = NSOrderedAscending;
		if ([self CodCategoria] >  [pater CodCategoria]) risulta = NSOrderedDescending;	
	return risulta;
}

- (NSComparisonResult)CompareCat2     :(Patrimonio *)pater {
	NSComparisonResult risulta;
	if ([pater CodCategoria] == [self CodCategoria]) risulta = NSOrderedSame;
	if ([pater CodCategoria] <  [self CodCategoria]) risulta = NSOrderedAscending;
	if ([pater CodCategoria] >  [self CodCategoria]) risulta = NSOrderedDescending;	
return risulta;
}

- (NSComparisonResult)CompareRendPat  :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([self Redditoedile] == [pater Redditoedile]) risulta = NSOrderedSame;
		if ([self Redditoedile] <  [pater Redditoedile]) risulta = NSOrderedAscending;
		if ([self Redditoedile] >  [pater Redditoedile]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareRendPat2 :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([pater Redditoedile] == [self Redditoedile]) risulta = NSOrderedSame;
		if ([pater Redditoedile] <  [self Redditoedile]) risulta = NSOrderedAscending;
		if ([pater Redditoedile] >  [self Redditoedile]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareAgraPat  :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([self RedditoAgrario] == [pater RedditoAgrario]) risulta = NSOrderedSame;
		if ([self RedditoAgrario] <  [pater RedditoAgrario]) risulta = NSOrderedAscending;
		if ([self RedditoAgrario] >  [pater RedditoAgrario]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareAgraPat2 :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([pater RedditoAgrario] == [self RedditoAgrario]) risulta = NSOrderedSame;
		if ([pater RedditoAgrario] <  [self RedditoAgrario]) risulta = NSOrderedAscending;
		if ([pater RedditoAgrario] >  [self RedditoAgrario]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareDomePat  :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([self RedditoDomenicale] == [pater RedditoDomenicale]) risulta = NSOrderedSame;
		if ([self RedditoDomenicale] <  [pater RedditoDomenicale]) risulta = NSOrderedAscending;
		if ([self RedditoDomenicale] >  [pater RedditoDomenicale]) risulta = NSOrderedDescending;	}
	return risulta;
}

- (NSComparisonResult)CompareDomePat2 :(Patrimonio *)pater {
	NSComparisonResult risulta;
	{ 	if ([pater RedditoDomenicale] == [self RedditoDomenicale]) risulta = NSOrderedSame;
		if ([pater RedditoDomenicale] <  [self RedditoDomenicale]) risulta = NSOrderedAscending;
		if ([pater RedditoDomenicale] >  [self RedditoDomenicale]) risulta = NSOrderedDescending;	}
	return risulta;
}



@end
