//
//  AzInterface.m
//  MacOrMap
//
//  Created by Carlo Macor on 10/09/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "AzInterface.h"


@implementation AzInterface





- (void) caricamentosingoloVettoriale : (NSString *) nomefile {
	DisegnoV  *DisVectCorrente;
	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",BaseDir,nomefile   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0) {
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState]; 
			[DisVectCorrente seteditabile:NSOffState];
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[azvector CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
		//	[DisVectCorrente setalphasup : 0.0];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
}


- (void) caricamentosingolaImmagine : (NSString *) nomefile {
   	NSString *nomefilloTutto;
    nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",BaseDir,nomefile   ];
    DisegnoR  *Locdisraster;
    if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
  	  Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
	  if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else 
	  {	[Locdisraster setvisibile:NSOnState];  
		[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
		[varbase DoNomiRasPop];
	    [varbase setrastercorrente:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];  // cosi faccio anche il sottoimmagini
		[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
		[interface setRSlAlphRas   : [Locdisraster alpha ] ];
		  if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
			  [interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	    [azraster CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	  }
	  [progetto display];            // renderlo invisibile
	  return;
     }
   Locdisraster = [ DisegnoR alloc];  	  
   [Locdisraster InitDisegnoR :nomefilloTutto : info];  
   [[varbase Listaraster] addObject:Locdisraster];
   [Locdisraster setalpha:0.7];
   [Locdisraster updateLimiti];
   [varbase DoNomiRasPop];
   [varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
   [progetto ZoomAllRaster:self];
   [interface setRckVisRas:YES];
   [interface setRSlAlphRas   : [Locdisraster alpha ] ];
   if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
	    [interface setRckBackRas :[Locdisraster isMaskabianca]];	}
   [interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
   [azraster CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
		//    [[[varbase barilectr] ctrDlgRaster] updaterighe];
	
}


- (void) caricamentoDirectoryImmagini      : (NSString *) nomefile  {
	unichar      ilcar;		
	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",BaseDir,nomefile   ];
	bool primodiser = YES;
	DisegnoR  *Locdisraster;
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomefilloTutto error:NULL];
	for (int i=0; i<contentsAtPath.count; i++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:i];
		ilcar = [nomf characterAtIndex:0];
		if (ilcar==46) continue; // 46 = '.'
		NSString *estensioneFile = [nomf pathExtension];
		NSString *upestensione =  [estensioneFile uppercaseString];
		bool isformatRaster = NO;

		
		if ([upestensione isEqualToString:@"TIFF"])   isformatRaster = YES;
		if ([upestensione isEqualToString:@"TIF"])    isformatRaster = YES;
		if ([upestensione isEqualToString:@"PNG"])    isformatRaster = YES;
		if ([upestensione isEqualToString:@"JPG"])    isformatRaster = YES;
		if ([upestensione isEqualToString:@"JPEG"])   isformatRaster = YES;
		if ([upestensione isEqualToString:@"TGA"])    isformatRaster = YES;
		if ([upestensione isEqualToString:@"BMP"])    isformatRaster = YES;
		if ([upestensione isEqualToString:@"GIF"])    isformatRaster = YES;
	
		if (!isformatRaster) continue;
		
		NSString *nomedacaricare = [[NSString alloc] initWithFormat:@"%@%@",nomefilloTutto,nomf   ];
		
		
		if (primodiser) {	primodiser=NO;	
			if ([azraster giapresenteImmagine:nomedacaricare]>=0) { 
				Locdisraster = 	[[varbase Listaraster] objectAtIndex:[azraster giapresenteImmagine:nomedacaricare]];
			    [Locdisraster setvisibile : ![Locdisraster isvisibleRaster ]];

				NSBeep();
				[progetto display];		
				return;
			}
			Locdisraster = [ DisegnoR alloc];  	  
			[Locdisraster InitDisegnoR :nomedacaricare : info];  
			[[varbase Listaraster] addObject:Locdisraster]; 			[Locdisraster setalpha:0.7];
			[[[varbase interface] LevelIndicatore] setIntValue: 1];
			[[[varbase interface] LevelIndicatore] setHidden:NO];
			[[[varbase interface] LevelIndicatore] display];
		} else {	[Locdisraster addDisegnoR :nomedacaricare]  ;		}
		int newind = (int)( (i*200)/contentsAtPath.count);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	
			[[[varbase interface] LevelIndicatore] setIntValue: newind ];	[[[varbase interface] LevelIndicatore] display];	}
		[nomedacaricare release];
	}
	[[[varbase interface] LevelIndicatore] setHidden:YES];

	
		//	[Locdisraster updateLimiti];

	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
		[progetto ZoomAllRaster:self];

	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[azraster CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	[nomefilloTutto release];
}


- (void) caricamentoLegenda      : (NSString *) nomefile  {
	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",BaseDir,@"Legende/",nomefile   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}


- (void) caricaQuadroUnione {
	DisegnoV  *DisVectCorrente;
	if ([varbase IndiceSepresenteDisegno:[varbase nomequadronione]]>=0)	 {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : [varbase nomequadronione] ]];
		if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else [DisVectCorrente setvisibile:NSOnState];  
		[varbase DoNomiVectorPop];			[progetto display];            // renderlo invisibile
		return;
	}
	[progetto ricordaposultimavista];
	[azvector CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  [varbase nomequadronione]   : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.0];
	[DisVectCorrente seteditabile:NO];
	[DisVectCorrente setsnappabile:NO];
	[DisVectCorrente faiLimiti];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	[progetto display];
}

	// imposta comandi
- (void) SetAproFoglioconPt        {
	[azvector AproFoglioconPt:self];
}



- (void) setupLabel : (NSTextField *) TField {
	NSMutableParagraphStyle * pStyle = [[NSMutableParagraphStyle alloc] init];
	pStyle.alignment = NSCenterTextAlignment;
	 NSMutableAttributedString *s;
	if (chiocciola == nil) chiocciola = @"NoName";
	if (asterisco  == nil) asterisco  = @"20.0";
	if (percentuale== nil) percentuale= @"40.0";
	if (parentesiSx  == nil) parentesiSx  = @"0.0";
	if (parentesiDx  == nil) parentesiDx  = @"0.0";
	
	 s = [[NSMutableAttributedString alloc] initWithString:chiocciola];
	 [s addAttribute :NSFontAttributeName           value : [NSFont fontWithName:@"Corsiva Hebrew" size:[asterisco floatValue]] range : NSMakeRange(0,[chiocciola length])];
	 [s addAttribute :NSParagraphStyleAttributeName value : pStyle range:[chiocciola rangeOfString:chiocciola]	];
	 [TField setAttributedStringValue:s];
	 NSRect fr;	fr = [TField frame];	fr.origin.y=[[interface boxComune] frame].size.height-([percentuale floatValue]+[asterisco floatValue]);	
	 fr.origin.x    = [parentesiSx floatValue];
	 fr.size.width  = [[interface boxComune] frame].size.width-([parentesiSx floatValue]+[parentesiDx floatValue]);

	[TField setFrame:fr];
	[TField setHidden:NO];
}

- (void) setupBox : (NSBox *) illobox {
	if (asterisco    == nil) asterisco    = @"20.0";
	if (percentuale  == nil) percentuale  = @"40.0";
	if (parentesiSx  == nil) parentesiSx  = @"2.0";
	if (parentesiDx  == nil) parentesiDx  = @"2.0";
	NSRect fr;	fr = [[interface boxComune]     frame];	
	fr.origin.x    = [parentesiSx floatValue];
	fr.origin.y    = [[interface boxComune] frame].size.height -([percentuale floatValue]+[asterisco floatValue]);
	fr.size.height = [asterisco      floatValue];
	fr.size.width  = [[interface boxComune] frame].size.width-([parentesiSx floatValue]+[parentesiDx floatValue]+2.0);
	[illobox setFrame:fr];
	[illobox setHidden:NO];
}

- (void) setupFreccia : (NSButton *) illobutton {
	if (percentuale  == nil) percentuale  = @"40.0";
	if (parentesiSx  == nil) parentesiSx  = @"16.0";
	if (parentesiDx  == nil) parentesiDx  = @"16.0";
	
	NSRect fr;	fr = [[interface boxComune]     frame];	
	NSRect fr_freccia;
	fr_freccia = [illobutton frame];
	fr_freccia.origin.y    = [[interface boxComune] frame].size.height -[percentuale floatValue];
    fr_freccia.origin.x = [parentesiSx floatValue];
	[illobutton setFrame:fr_freccia];
	[illobutton setHidden:NO];
}

- (void) setupBottone : (NSButton *) illobutton {
	if (chiocciola == nil) chiocciola = @"NoName";
	if (asterisco    == nil) asterisco    = @"20.0";
	if (percentuale  == nil) percentuale  = @"40.0";
	if (parentesiSx  == nil) parentesiSx  = @"16.0";
	if (parentesiDx  == nil) parentesiDx  = @"16.0";
	
	NSRect fr;	fr = [[interface boxComune]     frame];	
	fr.origin.x    = [parentesiSx floatValue];
	fr.origin.y    = [[interface boxComune] frame].size.height -([percentuale floatValue]+[asterisco floatValue]);
	fr.size.height = [asterisco      floatValue];
	fr.size.width  = [[interface boxComune] frame].size.width-([parentesiSx floatValue]+[parentesiDx floatValue]+2.0);
	NSString * loctitle = [[NSString alloc] initWithString:chiocciola]; [loctitle retain];
	if (commerciale  !=nil) {
  	  [illobutton setButtonType:NSMomentaryPushButton];

	  [illobutton setBezelStyle:NSTexturedSquareBezelStyle];
	}
	
	[illobutton setTitle:loctitle];
	[illobutton setFrame:fr];
	[illobutton setHidden:NO];
}

- (void) setupBoxcatasto {
	if (percentuale  == nil) percentuale  = @"40.0";
    NSRect fr;	fr = [CatastoBox frame];	
	fr.origin.y    = [[interface boxComune] frame].size.height -([percentuale floatValue]+[asterisco floatValue]);
	[CatastoBox setFrame:fr];
	[CatastoBox setHidden:NO];
}

- (void) svuotastringhe {
        //  if (cancelletto != nil)  { [cancelletto release]; }
    cancelletto = nil;
    
        //	[chiocciola  release];
    chiocciola  = nil;
	
        // [percentuale release];
    percentuale = nil;
        //[asterisco   release];
    asterisco   = nil;
        // [parentesiSx release];
    parentesiSx = nil;
        // [parentesiDx release];
    parentesiDx = nil;
        // [dollaro     release];
    dollaro     = nil;
        // [commerciale release];
    commerciale = nil;
    
}

- (void) svuotatestoazioni {
	azionecifrata01 = @"";	azionecifrata02 = @"";	azionecifrata03 = @"";	azionecifrata04 = @"";	azionecifrata05 = @"";
	azionecifrata06 = @"";	azionecifrata07 = @"";	azionecifrata08 = @"";	azionecifrata09 = @"";	azionecifrata10 = @"";
	azionecifrata11 = @"";	azionecifrata12 = @"";	azionecifrata13 = @"";	azionecifrata14 = @"";	azionecifrata15 = @"";
	azionecifrata06 = @"";	azionecifrata17 = @"";	azionecifrata18 = @"";	azionecifrata19 = @"";	azionecifrata20 = @"";
	azionecifrata21 = @"";	azionecifrata22 = @"";	azionecifrata23 = @"";	azionecifrata24 = @"";	azionecifrata25 = @"";
	azionecifrata06 = @"";	azionecifrata27 = @"";	azionecifrata28 = @"";	azionecifrata29 = @"";	azionecifrata30 = @"";
	azionecifrata31 = @"";	azionecifrata32 = @"";	

	azionecifrataFreccia01 = @"";	azionecifrataFreccia02 = @"";	azionecifrataFreccia03 = @"";	
	azionecifrataFreccia04 = @"";	azionecifrataFreccia05 = @"";	azionecifrataFreccia06 = @"";	
	azionecifrataFreccia07 = @"";	azionecifrataFreccia08 = @"";	azionecifrataFreccia09 = @"";	
	azionecifrataFreccia10 = @"";
	
}

- (void) setupbasedir {
	[BaseDir release]; BaseDir=[[NSString alloc] initWithString:chiocciola]; [BaseDir retain];
}


- (void) nascondiFieldtesti {
	[Testo1 setHidden:YES];
	[Testo2 setHidden:YES];
	[Testo3 setHidden:YES];
	[Testo4 setHidden:YES];
	[Testo5 setHidden:YES];
	[Testo6 setHidden:YES];
	[Testo7 setHidden:YES];
	[Testo8 setHidden:YES];
	[Testo9 setHidden:YES];
	[Testo10 setHidden:YES];
	[Testo11 setHidden:YES];
	[Testo12 setHidden:YES];
}

- (void) nascondiBox     {
	[CatastoBox setHidden:YES];
	[Box01 setHidden:YES];
	[Box02 setHidden:YES];
	[Box03 setHidden:YES];
	[Box04 setHidden:YES];
	[Box05 setHidden:YES];
	[Box06 setHidden:YES];
	[Box07 setHidden:YES];
	[Box08 setHidden:YES];
	[Box09 setHidden:YES];
	[Box10 setHidden:YES];
	[Box11 setHidden:YES];
	[Box12 setHidden:YES];
}

- (void) nascondiResettaSingoloBottone : (NSButton *) illobutton  {
	[illobutton	setState:0];

	[illobutton	setHidden:YES];
	[illobutton setButtonType:NSPushOnPushOffButton];
	[illobutton setBezelStyle:NSRoundedBezelStyle];
}


- (void) nascondiResetBottoni {
	[self nascondiResettaSingoloBottone:Bot01];
	[self nascondiResettaSingoloBottone:Bot02];
	[self nascondiResettaSingoloBottone:Bot03];
	[self nascondiResettaSingoloBottone:Bot04];
	[self nascondiResettaSingoloBottone:Bot05];
	[self nascondiResettaSingoloBottone:Bot06];
	[self nascondiResettaSingoloBottone:Bot07];
	[self nascondiResettaSingoloBottone:Bot08];
	[self nascondiResettaSingoloBottone:Bot09];
	[self nascondiResettaSingoloBottone:Bot10];
	[self nascondiResettaSingoloBottone:Bot11];
	[self nascondiResettaSingoloBottone:Bot12];
	[self nascondiResettaSingoloBottone:Bot13];
	[self nascondiResettaSingoloBottone:Bot14];
	[self nascondiResettaSingoloBottone:Bot15];
	[self nascondiResettaSingoloBottone:Bot16];
	[self nascondiResettaSingoloBottone:Bot17];
	[self nascondiResettaSingoloBottone:Bot18];
	[self nascondiResettaSingoloBottone:Bot19];
	[self nascondiResettaSingoloBottone:Bot20];
	[self nascondiResettaSingoloBottone:Bot21];
	[self nascondiResettaSingoloBottone:Bot22];
	[self nascondiResettaSingoloBottone:Bot23];
	[self nascondiResettaSingoloBottone:Bot24];
	[self nascondiResettaSingoloBottone:Bot25];
	[self nascondiResettaSingoloBottone:Bot26];
	[self nascondiResettaSingoloBottone:Bot27];
	[self nascondiResettaSingoloBottone:Bot28];
	[self nascondiResettaSingoloBottone:Bot29];
	[self nascondiResettaSingoloBottone:Bot30];
	[self nascondiResettaSingoloBottone:Bot31];
	[self nascondiResettaSingoloBottone:Bot32];

	[Btr01 setHidden:YES];
	[Btr02 setHidden:YES];
	[Btr03 setHidden:YES];
	[Btr04 setHidden:YES];
	[Btr05 setHidden:YES];
	[Btr06 setHidden:YES];
	[Btr07 setHidden:YES];
	[Btr08 setHidden:YES];
	[Btr09 setHidden:YES];
	[Btr10 setHidden:YES];

}

- (void) ImpostaElemento {
      NSLog(@"%@",cancelletto);
    if (cancelletto ==NULL) {[self svuotastringhe]; return;}
    
    
	if ([cancelletto isEqualToString:@"SC"])  [self setupBoxcatasto];
	if ([cancelletto isEqualToString:@"DD"])  [self setupbasedir];
	if ([cancelletto isEqualToString:@"DC"])  [varbase setdircatastali:chiocciola];
	if ([cancelletto isEqualToString:@"DU"])  [varbase setnomeQUnione :chiocciola];
	if ([cancelletto isEqualToString:@"O1"])  [info  setoffcxfx:[chiocciola doubleValue] ];
	if ([cancelletto isEqualToString:@"O2"])  [info  setoffcxfy:[chiocciola doubleValue] ];
	
	if ([cancelletto isEqualToString:@"SG"])  {
		info.scalaDisGoogleno =	[percentuale doubleValue];
	}

	if ([cancelletto isEqualToString:@"II"])  [varbase SetNomeFileImmobiliCatOrmap:chiocciola]; 
	
	if ([cancelletto isEqualToString:@"T1"])  [self setupLabel : Testo1];
	if ([cancelletto isEqualToString:@"T2"])  [self setupLabel : Testo2];
	if ([cancelletto isEqualToString:@"T3"])  [self setupLabel : Testo3];
	if ([cancelletto isEqualToString:@"T4"])  [self setupLabel : Testo4];
	if ([cancelletto isEqualToString:@"T5"])  [self setupLabel : Testo5];
	if ([cancelletto isEqualToString:@"T6"])  [self setupLabel : Testo6];
	if ([cancelletto isEqualToString:@"T7"])  [self setupLabel : Testo7];
	if ([cancelletto isEqualToString:@"T8"])  [self setupLabel : Testo8];
	if ([cancelletto isEqualToString:@"T9"])  [self setupLabel : Testo9];
	if ([cancelletto isEqualToString:@"T10"]) [self setupLabel : Testo10];
	if ([cancelletto isEqualToString:@"T11"]) [self setupLabel : Testo11];
	if ([cancelletto isEqualToString:@"T12"]) [self setupLabel : Testo12];
	
	
	if ([cancelletto isEqualToString:@"R1"]) [self setupBox   : Box01];
	if ([cancelletto isEqualToString:@"R2"]) [self setupBox   : Box02];
	if ([cancelletto isEqualToString:@"R3"]) [self setupBox   : Box03];
	if ([cancelletto isEqualToString:@"R4"]) [self setupBox   : Box04];
	if ([cancelletto isEqualToString:@"R5"]) [self setupBox   : Box05];
	if ([cancelletto isEqualToString:@"R6"]) [self setupBox   : Box06];
	if ([cancelletto isEqualToString:@"R7"]) [self setupBox   : Box07];
	if ([cancelletto isEqualToString:@"R8"]) [self setupBox   : Box08];
	if ([cancelletto isEqualToString:@"R9"]) [self setupBox   : Box09];
	if ([cancelletto isEqualToString:@"R10"])[self setupBox   : Box10];
	if ([cancelletto isEqualToString:@"R11"])[self setupBox   : Box11];
	if ([cancelletto isEqualToString:@"R11"])[self setupBox   : Box12];
	
	if ([cancelletto isEqualToString:@"B1"]) { [self setupBottone: Bot01]; 
		if (dollaro !=nil) azionecifrata01 = [[NSString alloc] initWithString: dollaro]; [azionecifrata01 retain];}
	if ([cancelletto isEqualToString:@"B2"]) { [self setupBottone: Bot02]; 
		if (dollaro !=nil) azionecifrata02 = [[NSString alloc] initWithString: dollaro]; [azionecifrata02 retain];}
	if ([cancelletto isEqualToString:@"B3"]) { [self setupBottone: Bot03]; 
		if (dollaro !=nil) azionecifrata03 = [[NSString alloc] initWithString: dollaro]; [azionecifrata03 retain];}
	if ([cancelletto isEqualToString:@"B4"]) { [self setupBottone: Bot04]; 
		if (dollaro !=nil) azionecifrata04 = [[NSString alloc] initWithString: dollaro]; [azionecifrata04 retain];}
	if ([cancelletto isEqualToString:@"B5"]) { [self setupBottone: Bot05]; 
		if (dollaro !=nil) azionecifrata05 = [[NSString alloc] initWithString: dollaro]; [azionecifrata05 retain];}
	if ([cancelletto isEqualToString:@"B6"]) { [self setupBottone: Bot06]; 
		if (dollaro !=nil) azionecifrata06 = [[NSString alloc] initWithString: dollaro]; [azionecifrata06 retain];}
	if ([cancelletto isEqualToString:@"B7"]) { [self setupBottone: Bot07]; 
		if (dollaro !=nil) azionecifrata07 = [[NSString alloc] initWithString: dollaro]; [azionecifrata07 retain];}
	if ([cancelletto isEqualToString:@"B8"]) { [self setupBottone: Bot08]; 
		if (dollaro !=nil) azionecifrata08 = [[NSString alloc] initWithString: dollaro]; [azionecifrata08 retain];}
	if ([cancelletto isEqualToString:@"B9"]) { [self setupBottone: Bot09]; 
		if (dollaro !=nil) azionecifrata09 = [[NSString alloc] initWithString: dollaro]; [azionecifrata09 retain];}
	if ([cancelletto isEqualToString:@"B10"]) { [self setupBottone: Bot10]; 
		if (dollaro !=nil) azionecifrata10 = [[NSString alloc] initWithString: dollaro]; [azionecifrata10 retain];}
	if ([cancelletto isEqualToString:@"B11"]) { [self setupBottone: Bot11]; 
		if (dollaro !=nil) azionecifrata11 = [[NSString alloc] initWithString: dollaro]; [azionecifrata11 retain];}
	if ([cancelletto isEqualToString:@"B12"]) { [self setupBottone: Bot12]; 
		if (dollaro !=nil) azionecifrata12 = [[NSString alloc] initWithString: dollaro]; [azionecifrata12 retain];}
	if ([cancelletto isEqualToString:@"B13"]) { [self setupBottone: Bot13]; 
		if (dollaro !=nil) azionecifrata13 = [[NSString alloc] initWithString: dollaro]; [azionecifrata13 retain];}
	if ([cancelletto isEqualToString:@"B14"]) { [self setupBottone: Bot14]; 
		if (dollaro !=nil) azionecifrata14 = [[NSString alloc] initWithString: dollaro]; [azionecifrata14 retain];}
	if ([cancelletto isEqualToString:@"B15"]) { [self setupBottone: Bot15]; 
		if (dollaro !=nil) azionecifrata15 = [[NSString alloc] initWithString: dollaro]; [azionecifrata15 retain];}
	if ([cancelletto isEqualToString:@"B16"]) { [self setupBottone: Bot16]; 
		if (dollaro !=nil) azionecifrata16 = [[NSString alloc] initWithString: dollaro]; [azionecifrata16 retain];}
	if ([cancelletto isEqualToString:@"B17"]) { [self setupBottone: Bot17]; 
		if (dollaro !=nil) azionecifrata17 = [[NSString alloc] initWithString: dollaro]; [azionecifrata17 retain];}
	if ([cancelletto isEqualToString:@"B18"]) { [self setupBottone: Bot18]; 
		if (dollaro !=nil) azionecifrata18 = [[NSString alloc] initWithString: dollaro]; [azionecifrata18 retain];}
	if ([cancelletto isEqualToString:@"B19"]) { [self setupBottone: Bot19]; 
		if (dollaro !=nil) azionecifrata19 = [[NSString alloc] initWithString: dollaro]; [azionecifrata19 retain];}
	if ([cancelletto isEqualToString:@"B20"]) { [self setupBottone: Bot20]; 
		if (dollaro !=nil) azionecifrata20 = [[NSString alloc] initWithString: dollaro]; [azionecifrata20 retain];}
	
	if ([cancelletto isEqualToString:@"B21"]) { [self setupBottone: Bot21]; 
		if (dollaro !=nil) azionecifrata21 = [[NSString alloc] initWithString: dollaro]; [azionecifrata21 retain];}
	if ([cancelletto isEqualToString:@"B22"]) { [self setupBottone: Bot22]; 
		if (dollaro !=nil) azionecifrata22 = [[NSString alloc] initWithString: dollaro]; [azionecifrata22 retain];}
	if ([cancelletto isEqualToString:@"B23"]) { [self setupBottone: Bot23]; 
		if (dollaro !=nil) azionecifrata23 = [[NSString alloc] initWithString: dollaro]; [azionecifrata23 retain];}
	if ([cancelletto isEqualToString:@"B24"]) { [self setupBottone: Bot24]; 
		if (dollaro !=nil) azionecifrata24 = [[NSString alloc] initWithString: dollaro]; [azionecifrata24 retain];}
	if ([cancelletto isEqualToString:@"B25"]) { [self setupBottone: Bot25]; 
		if (dollaro !=nil) azionecifrata25 = [[NSString alloc] initWithString: dollaro]; [azionecifrata25 retain];}
	if ([cancelletto isEqualToString:@"B26"]) { [self setupBottone: Bot26]; 
		if (dollaro !=nil) azionecifrata26 = [[NSString alloc] initWithString: dollaro]; [azionecifrata26 retain];}
	if ([cancelletto isEqualToString:@"B27"]) { [self setupBottone: Bot27]; 
		if (dollaro !=nil) azionecifrata27 = [[NSString alloc] initWithString: dollaro]; [azionecifrata27 retain];}
	if ([cancelletto isEqualToString:@"B28"]) { [self setupBottone: Bot28]; 
		if (dollaro !=nil) azionecifrata28 = [[NSString alloc] initWithString: dollaro]; [azionecifrata28 retain];}
	if ([cancelletto isEqualToString:@"B29"]) { [self setupBottone: Bot29]; 
		if (dollaro !=nil) azionecifrata29 = [[NSString alloc] initWithString: dollaro]; [azionecifrata29 retain];}
	if ([cancelletto isEqualToString:@"B30"]) { [self setupBottone: Bot30]; 
		if (dollaro !=nil) azionecifrata30 = [[NSString alloc] initWithString: dollaro]; [azionecifrata30 retain];}
	if ([cancelletto isEqualToString:@"B31"]) { [self setupBottone: Bot31]; 
		if (dollaro !=nil) azionecifrata31 = [[NSString alloc] initWithString: dollaro]; [azionecifrata31 retain];}
	if ([cancelletto isEqualToString:@"B32"]) { [self setupBottone: Bot32]; 
		if (dollaro !=nil) azionecifrata32 = [[NSString alloc] initWithString: dollaro]; [azionecifrata32 retain];}
	
	if ([cancelletto isEqualToString:@"F1"]) { [self setupFreccia: Btr01]; 
		if (dollaro !=nil) azionecifrataFreccia01 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia01 retain];}
	if ([cancelletto isEqualToString:@"F2"]) { [self setupFreccia: Btr02]; 
		if (dollaro !=nil) azionecifrataFreccia02 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia02 retain];}
	if ([cancelletto isEqualToString:@"F3"]) { [self setupFreccia: Btr03]; 
		if (dollaro !=nil) azionecifrataFreccia03 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia03 retain];}
	if ([cancelletto isEqualToString:@"F4"]) { [self setupFreccia: Btr04]; 
		if (dollaro !=nil) azionecifrataFreccia04 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia04 retain];}
	if ([cancelletto isEqualToString:@"F5"]) { [self setupFreccia: Btr05]; 
		if (dollaro !=nil) azionecifrataFreccia05 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia05 retain];}
	if ([cancelletto isEqualToString:@"F6"]) { [self setupFreccia: Btr06]; 
		if (dollaro !=nil) azionecifrataFreccia06 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia06 retain];}
	if ([cancelletto isEqualToString:@"F7"]) { [self setupFreccia: Btr07]; 
		if (dollaro !=nil) azionecifrataFreccia07 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia07 retain];}
	if ([cancelletto isEqualToString:@"F8"]) { [self setupFreccia: Btr08]; 
		if (dollaro !=nil) azionecifrataFreccia08 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia08 retain];}
	if ([cancelletto isEqualToString:@"F9"]) { [self setupFreccia: Btr09]; 
		if (dollaro !=nil) azionecifrataFreccia09 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia09 retain];}
	if ([cancelletto isEqualToString:@"F10"]) { [self setupFreccia: Btr10]; 
		if (dollaro !=nil) azionecifrataFreccia10 = [[NSString alloc] initWithString: dollaro]; [azionecifrataFreccia10 retain];}

        [self svuotastringhe];

     }

- (void) ricaricailconfig {
   NSArray * righe;
   NSString * st;
   righe = [varbase  righetestofile:@"/MacOrMap/config.txt"];
   for (int i=0; i<[righe count]; i++) {
	st= [righe objectAtIndex:i];
	if (i==3)  { [varbase setcod_comune   : st];	}
	if (i==5)  { [varbase setnomeQUnione  : st];	}
	if (i==7)  { [varbase setdircatastali : st]; }
	if (i==9)  { [varbase setdirbasedati  : st]; }
	if (i==11) { [info  set_origineVistax:[st doubleValue] ]; }
	if (i==13) { [info  set_origineVistay:[st doubleValue] ]; }
	if (i==15) { [info  setoffxGoogleMaps:[st doubleValue] ]; }
	if (i==17) { [info  setoffyGoogleMaps:[st doubleValue] ]; }
	if (i==19) { [info  setoffcxfx:[st doubleValue] ]; }
	if (i==21) { [info  setoffcxfy:[st doubleValue] ]; }
   }
}

- (void) svuotatutto {
	[self svuotastringhe];
	[self svuotatestoazioni];
	[self nascondiFieldtesti];
	[self nascondiBox];
	[self nascondiResetBottoni];
}

- (void) reloadInterface : (NSString * ) nomefile {
		//	[self ricaricailconfig];
	[self svuotatutto];
   
	[BaseDir release]; BaseDir=[[NSString alloc] initWithString:[varbase Dir_basedati]]; [BaseDir retain];
	[varbase SetNomeFileImmobiliCatOrmap:@"/MacOrMap/Catasto/Immobili.CATMacorMap"]; 

	
	NSArray * righe;	NSString * st;
	righe = [varbase  righetestofile:nomefile];
	int i=0; bool iniziato = NO;

    while (i<[righe count]) {
		st= [righe objectAtIndex:i]; i++;
		if ([st length]<=0) continue;
            	if ([st characterAtIndex:0] == 35) {iniziato=YES; [self ImpostaElemento]; }
		if ([st characterAtIndex:0] == 35) { cancelletto = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 37) { percentuale = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 42) { asterisco   = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 64) { chiocciola  = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 40) { parentesiSx = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 41) { parentesiDx = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 36) { dollaro     = [NSString stringWithString:[st substringFromIndex:1] ]; }
		if ([st characterAtIndex:0] == 38) { commerciale = [NSString stringWithString:[st substringFromIndex:1] ]; }
		
	}

    
   if (iniziato) [self ImpostaElemento];
    
}

- (void) InitAzInterface      {
	[self reloadInterface : @"/MacOrMap/interfaccia.txt"];
}



- (void) interpretaAzione : (NSString *) comandostinga {
	if ([comandostinga length]<4) return;
	char C1 = [comandostinga characterAtIndex:1];
	char C2 = [comandostinga characterAtIndex:2];  // K ==75
	if (C1==86) { if (C2==49) [self caricamentosingoloVettoriale:[comandostinga substringFromIndex:4]];	}
	if (C1==75) { if (C2==49) [self caricamentosingolaImmagine  :[comandostinga substringFromIndex:4]];	}
	if (C1==75) { if (C2==50) [self caricamentoDirectoryImmagini:[comandostinga substringFromIndex:4]];	}

	if ((C1==81) & (C2==85)) { [self caricaQuadroUnione];}
    if ((C1==67) & (C2==67)) {  [azvector BottoneCatasto_1:self];}
	if ((C1==70) & (C2==84)) { [azdialogs ApriDlgFabbricati:self];}
	if ((C1==84) & (C2==84)) { [azdialogs ApriDlgTerreni:self];}
	if ((C1==76) & (C2==49))  [self caricamentoLegenda:[comandostinga substringFromIndex:4]];	

	if ((C1==67) & (C2==49))  [self SetAproFoglioconPt];	
	if ((C1==86) & (C2==67))  [azdialogs ApriDlgCercaViaCiv:self];	
	if ((C1==70) & (C2==80))  [azdialogs ApriDlgCercaPart:self];	

	if ((C1==70) & (C2==49))  [azextra   CInfoEdificio:self];	
	if ((C1==84) & (C2==49))  [azextra   CInfoTerreno :self];	

	if ((C1==84) & (C2==85))  [azvector  VedoTestiQuadroUnione:self];	

	

	
	
}

- (IBAction) eseguiAzione :(id) sender {

	if ([sender isEqual:Bot01]) [self interpretaAzione:azionecifrata01];
	if ([sender isEqual:Bot02]) [self interpretaAzione:azionecifrata02];
	if ([sender isEqual:Bot03]) [self interpretaAzione:azionecifrata03];
	if ([sender isEqual:Bot04]) [self interpretaAzione:azionecifrata04];
	if ([sender isEqual:Bot05]) [self interpretaAzione:azionecifrata05];
	if ([sender isEqual:Bot06]) [self interpretaAzione:azionecifrata06];
	if ([sender isEqual:Bot07]) [self interpretaAzione:azionecifrata07];
	if ([sender isEqual:Bot08]) [self interpretaAzione:azionecifrata08];
	if ([sender isEqual:Bot09]) [self interpretaAzione:azionecifrata09];
	if ([sender isEqual:Bot10]) [self interpretaAzione:azionecifrata10];
	if ([sender isEqual:Bot11]) [self interpretaAzione:azionecifrata11];
	if ([sender isEqual:Bot12]) [self interpretaAzione:azionecifrata12];
	if ([sender isEqual:Bot13]) [self interpretaAzione:azionecifrata13];
	if ([sender isEqual:Bot14]) [self interpretaAzione:azionecifrata14];
	if ([sender isEqual:Bot15]) [self interpretaAzione:azionecifrata15];
	if ([sender isEqual:Bot16]) [self interpretaAzione:azionecifrata16];
	if ([sender isEqual:Bot17]) [self interpretaAzione:azionecifrata17];
	if ([sender isEqual:Bot18]) [self interpretaAzione:azionecifrata18];
	if ([sender isEqual:Bot19]) [self interpretaAzione:azionecifrata19];
	if ([sender isEqual:Bot20]) [self interpretaAzione:azionecifrata20];
	if ([sender isEqual:Bot21]) [self interpretaAzione:azionecifrata21];
	if ([sender isEqual:Bot22]) [self interpretaAzione:azionecifrata22];
	if ([sender isEqual:Bot23]) [self interpretaAzione:azionecifrata23];
	if ([sender isEqual:Bot24]) [self interpretaAzione:azionecifrata24];
	if ([sender isEqual:Bot25]) [self interpretaAzione:azionecifrata25];
	if ([sender isEqual:Bot26]) [self interpretaAzione:azionecifrata26];
	if ([sender isEqual:Bot27]) [self interpretaAzione:azionecifrata27];
	if ([sender isEqual:Bot28]) [self interpretaAzione:azionecifrata28];
	if ([sender isEqual:Bot29]) [self interpretaAzione:azionecifrata29];
	if ([sender isEqual:Bot30]) [self interpretaAzione:azionecifrata30];
	if ([sender isEqual:Bot31]) [self interpretaAzione:azionecifrata31];
	if ([sender isEqual:Bot32]) [self interpretaAzione:azionecifrata32];

	if ([sender isEqual:Btr01]) [self interpretaAzione:azionecifrataFreccia01];
	if ([sender isEqual:Btr02]) [self interpretaAzione:azionecifrataFreccia02];
	if ([sender isEqual:Btr03]) [self interpretaAzione:azionecifrataFreccia03];
	if ([sender isEqual:Btr04]) [self interpretaAzione:azionecifrataFreccia04];
	if ([sender isEqual:Btr05]) [self interpretaAzione:azionecifrataFreccia05];
	if ([sender isEqual:Btr06]) [self interpretaAzione:azionecifrataFreccia06];
	if ([sender isEqual:Btr07]) [self interpretaAzione:azionecifrataFreccia07];
	if ([sender isEqual:Btr08]) [self interpretaAzione:azionecifrataFreccia08];
	if ([sender isEqual:Btr09]) [self interpretaAzione:azionecifrataFreccia09];
	if ([sender isEqual:Btr10]) [self interpretaAzione:azionecifrataFreccia10];

}

static NSArray *openFilesTxt()                         { 
	NSOpenPanel *panel;
    panel = [NSOpenPanel openPanel];        
    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:NO];
	NSURL *url = [NSURL URLWithString: @"/MacOrMap/"];
	[panel setDirectoryURL:url];
    [panel setCanChooseFiles:YES];
	[panel setAllowsMultipleSelection:YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects: @"txt",nil ] ];
	int i = [panel runModal];
	if(i == NSOKButton){ return [panel filenames];   }
    return nil;
}    


- (IBAction) CambiaInterfaccia :(id) sender {
	NSArray *path = openFilesTxt();
    if(path){ [self reloadInterface :  [path objectAtIndex:0] ];};
	NSLog(@"%@",[path objectAtIndex:0]);
		
}

- (IBAction) CambiaInterfaccia_MonteArgentario :(id) sender {
	[self reloadInterface :  @"/MacOrMap/interf_MonteArgentario.txt" ];
}

- (IBAction) CambiaInterfaccia_Allumiere       :(id) sender {
	[self reloadInterface :  @"/MacOrMap/interf_Allumiere.txt" ];
}

- (IBAction) CambiaInterfaccia_Tarquinia       :(id) sender {
	[self reloadInterface :  @"/MacOrMap/interf_Tarquinia.txt" ];
}

- (IBAction) CambiaInterfaccia_Ragusa          :(id) sender {
	[self reloadInterface :  @"/MacOrMap/interf_Ragusa.txt" ];

}



@end
