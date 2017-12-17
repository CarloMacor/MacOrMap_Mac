//
//  AzVector.m
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "AzVector.h"
#import "DisegnoV.h"
#import "DefSimbolo.h"
#import "funzioni.h"



@implementation AzVector



- (void) InitAzVector     {
	[[[varbase barilectr] ctrDlgVector]     passaListavector:[varbase ListaVector]];
	[self mandaDisegnoCorrenteaDlg];
	[self CaricaDefsimboli];
    rotoscalatutti = NO;
		//						[self testinters];
}

- (void) testinters  {
	
	DisegnoV  *DisVectCorrente;
	[self CNuovoDisegno:self ];
	DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  @"/Users/carlomacor/Desktop/test.OrMap"  : [varbase ListaDefSimboli]  ];
/*	
	Piano * pia;
	pia = [[DisVectCorrente ListaPiani] objectAtIndex : 0];
	[[varbase ListaSelezionati] addObject:[[pia Listavector] objectAtIndex : 0]];
	[[varbase ListaSelezionati] addObject:[[pia Listavector] objectAtIndex : 1]];
		//	[DisVectCorrente setpianocorrente:1];
		//	[self Intersezione2Poligoni  : self];
	[self CDeseleziona : self];
*/	
	[progetto ZoomAll:self];

	
}


- (void) macroiniziale {
	DisegnoV  *Locdisvector;
    Locdisvector = [DisegnoV  alloc];    
	[Locdisvector InitDisegno:info];
	[[varbase ListaVector] addObject:Locdisvector]; 
	[Locdisvector setpianocorrente:0];

		//	[Locdisvector apriDisegnoCxf: @"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/catastali/D024_012700.CXF"   : [varbase ListaDefSimboli]  ];
		//	[Locdisvector apriDisegnoCxf : @"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/catastali/D024_007100.CXF"   : [varbase ListaDefSimboli]   ];

	[Locdisvector faiLimiti];
	[progetto ZoomDisegno:self];
	
	Locdisvector = [DisegnoV  alloc];    
	[Locdisvector InitDisegno:info];
	[[varbase ListaVector] addObject:Locdisvector]; 
	[Locdisvector setpianocorrente:0];
	
	
	[varbase DoNomiVectorPop];	
		//	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase setindiceVectorCorrente   : 0];

	[self aggiornamentodlgVet];
	[self CambioSubVector       : 0];
}



static NSArray *openFilesVettoriali()                    { 
	NSOpenPanel *panel;
    panel = [NSOpenPanel openPanel];        
    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
	[panel setAllowsMultipleSelection:YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"MoM",@"dxf",@"CXF",@"SHP",@"OrMap",nil] ];
	int i = [panel runModal];
	if(i == NSOKButton){ return [panel filenames];   }
    return nil;
}    

static NSString *SaveFileVettoriale(NSString *nomefileoriginale  )                   { 
	NSSavePanel *panel;
    panel = [NSSavePanel savePanel];        
    [panel setFloatingPanel:YES];
	
	NSURL *url = [NSURL URLWithString: [nomefileoriginale stringByDeletingLastPathComponent]];
	[panel setDirectoryURL:url];

	[panel setNameFieldStringValue:[[nomefileoriginale lastPathComponent] stringByDeletingPathExtension]];
		//    [panel setCanChooseDirectories:YES];
		//    [panel setCanChooseFiles:YES];
		//	[panel setAllowsMultipleSelection:YES];
		//	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"MoM",@"LDA",nil] ];
	int i = [panel runModal];
	if(i == NSOKButton){ 
		return [panel filename];   
	}
    return nil;
}    


	// dlg Info

- (IBAction) MatchdaInfo                    : (id)  sender {
	Vettoriale * locvet = [[varbase ListaInformati] objectAtIndex:[varbase indiceinformato]];
	DisegnoV * disvinf = [locvet disegno];
	Piano    * ilpia   = [locvet piano];
	DisegnoV  *locpia;
	
	for (int i=0; i<[disvinf ListaPiani].count; i++) {  
		locpia = [[disvinf ListaPiani] objectAtIndex:i];
		if ([locpia isEqual: ilpia]) 	 [disvinf setpianocorrente:i];
		
	}
	
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
		if ([locdisvet isEqual: disvinf]) 	 [varbase CambioVector:i];
	}
}


- (IBAction) MettiInfoinSelezionati         : (id)  sender {
	Vettoriale * locvet = [[varbase ListaInformati] objectAtIndex:[varbase indiceinformato]];
	if ([[varbase ListaSelezionati] containsObject:locvet]) return;
	[[varbase ListaSelezionati] addObject:locvet];
	[progetto display];
}

- (IBAction) TogliInfoinSelezionati         : (id)  sender {
	Vettoriale * locvet = [[varbase ListaInformati] objectAtIndex:[varbase indiceinformato]];
	if ([[varbase ListaSelezionati] containsObject:locvet]) {
		[[varbase ListaSelezionati] removeObject:locvet];
		[progetto display];
	}
}

- (IBAction) AlfabPianiDisCorrente          : (id)  sender {
	[[varbase DisegnoVcorrente] RiordinaPianiAlfateticamente];
	[varbase DoNomiVectorPop];	

}


- (void) CaricaDefsimboli    {
	DisegnoV  *Locdisvector;
    Locdisvector = [DisegnoV  alloc];    
	[Locdisvector InitDisegno:info];

	[Locdisvector apriDisegnoMoM:@"/MacOrMap/Symbols/DefSymbols.MoM":nil];

	[Locdisvector faiLimiti];

	NSMutableArray * listadefsimboli  = [varbase ListaDefSimboli];
	[Locdisvector faidefsimboli:listadefsimboli];

	[Locdisvector RemoveDisegno];
	
	NSPopUpButton   * lisnomsimb = [interface lisnomsimb];
	[lisnomsimb removeAllItems];
	DefSimbolo *locdef;
	for (int i=0; i<listadefsimboli.count; i++) {  
		locdef = [listadefsimboli  objectAtIndex:i];
		[lisnomsimb addItemWithTitle:[locdef nome] ];	
	}
}


- (void) comandobottone              : (NSInteger) com {
	[progetto chiusuracomandoprecedente];
	[varbase  comandodabottone : com ];
}



- (IBAction) CNuovoDisegno           : (id)sender {
	DisegnoV  *Locdisvector;
    Locdisvector = [DisegnoV  alloc];    
	[Locdisvector InitDisegno:info];
	[[varbase ListaVector] addObject:Locdisvector]; 
	[Locdisvector setpianocorrente:0];
	[varbase DoNomiVectorPop];	
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[self aggiornamentodlgVet];
	[self CambioSubVector       : 0];
}

- (IBAction) SaveDisegno             : (id)sender {
	NSString *path = SaveFileVettoriale([[varbase DisegnoVcorrente] nomedisegno] );
	if (path==nil) return;
	[[varbase DisegnoVcorrente] salvaDisegnoMoM :path];	
	[varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase indiceVectorCorrente]];
}

- (IBAction) SaveDisegnoDXF                 : (id)sender {
	NSString *path = SaveFileVettoriale([[varbase DisegnoVcorrente] nomedisegno] );
	[[varbase DisegnoVcorrente] SalvaDisegnoDxf:path];	
}


- (IBAction) addVettoriale           : (id)sender {
	
	
	DisegnoV  *DisVectCorrente;

    NSArray *path = openFilesVettoriali();
    if(path){ 

		[progetto ricordaposultimavista];
		for(int i=0; i<[path count]; i++)	{
			NSLog(@"Apro vet %@",[path objectAtIndex:i]);

			if ([varbase presenteDisegno:[path objectAtIndex:i]]>=0)	{[progetto ZoomDisegno:self];	continue;	}
			
			[self CNuovoDisegno:self ];
			DisVectCorrente = [varbase DisegnoVcorrente];	
			NSString *estensioneFile;
			estensioneFile = [[path objectAtIndex:i] pathExtension];
			NSString *upestensione =  [estensioneFile uppercaseString];
				// fare uppercase della estensione file prima di confrontarlo
			if ([upestensione isEqualToString:@"MOM"])   { [DisVectCorrente apriDisegnoMoM:[path objectAtIndex:i] : [varbase ListaDefSimboli]   ];}
   			if ([upestensione isEqualToString:@"ORMAP"]) { [DisVectCorrente apriDisegnoMoM:[path objectAtIndex:i] : [varbase ListaDefSimboli]   ];}
			if ([upestensione isEqualToString:@"DXF"])   { [DisVectCorrente apriDisegnoDxf:[path objectAtIndex:i] : [varbase ListaDefSimboli]  ];}
			if ([upestensione isEqualToString:@"CXF"])   { [DisVectCorrente apriDisegnoCxf:[path objectAtIndex:i] : [varbase ListaDefSimboli]  ];}
			if ([upestensione isEqualToString:@"SHP"])   { [DisVectCorrente apriDisegnoShp:[path objectAtIndex:i] : [varbase ListaDefSimboli]  ];}

				//			NSLog(@"End");

				//		if ([progetto modoaperturavet]==1)  
/*			if ([upestensione isEqualToString:@"CXF"])   {
				NSArray * righetxt = [varbase righetestofile : [path objectAtIndex:i] ];
				for (int j=0; j<[righetxt count]; j++) {NSString *st1 = [righetxt objectAtIndex:j];
					NSLog(@"- %@ ",st1);			
				NSLog(@"+ %@ ",[st1 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet ]]);}			
			}
*/			
			if ([upestensione isEqualToString:@"LDA"] | [upestensione isEqualToString:@"DXF"])   { 
				if ([progetto modoaperturavet]==1) {  // NSBeep();
													  //                             			 [DisVectCorrente CatToUtm];
			 }
			}
										    [progetto ZoomDisegno:self];

		};
	}
	
							[varbase DoNomiVectorPop];
				            [varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
				  	        [varbase CambioVector: [varbase indiceVectorCorrente] ];
	
		//	[progetto ZoomAll:self];

}

- (IBAction) removeVettoriale        : (id)sender {
	[azdialogs ApriDlgConferma:3];
	if (!varbase.rispostaconferma) return;
	DisegnoV  *DisVectCorrente = [varbase  DisegnoVcorrente];
	[varbase RimuoviSelezionatiDelDisegno:DisVectCorrente];
	
	[DisVectCorrente RemoveDisegno];
	[DisVectCorrente release]; //  qui svuotare la memoria
	[[varbase ListaVector] removeObjectAtIndex:[varbase indiceVectorCorrente]];
	[varbase setindiceVectorCorrente   :[varbase indiceVectorCorrente]-1];
	[varbase DoNomiVectorPop];
	[progetto display]; 
	if ([[varbase ListaVector] count]<=0) {    [varbase paintboxcolorepiano];	[varbase Disegnailpianino];  }
	[self aggiornamentodlgVet];

}

- (IBAction) UpVisVector             : (id)sender {
	DisegnoV  *DisVectCorrente = [varbase  DisegnoVcorrente];
	NSButton *bu = sender;
	[DisVectCorrente setvisibile:[bu state]];
    [progetto display];
}

- (IBAction) UpVisSubvector          : (id)sender {
	DisegnoV  *DisVectCorrente = [varbase  DisegnoVcorrente];
	NSButton *bu = sender;
	[DisVectCorrente setvisibilepiano: [DisVectCorrente IndicePianocorrente]:  [bu state]];
    [progetto display];
}

- (IBAction) SnapEditDisegno         : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [[varbase DisegnoVcorrente] seteditabile :![[varbase DisegnoVcorrente] editabile]];    break;
		case 1: [[varbase DisegnoVcorrente] setsnappabile:![[varbase DisegnoVcorrente] snappabile]];   break;
	}
}

- (IBAction) SnapEditPiano           : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [[varbase DisegnoVcorrente] seteditabilepiano :  [[varbase DisegnoVcorrente] IndicePianocorrente]  
															  :  ![[varbase DisegnoVcorrente] editabilepiano
																 : [[varbase DisegnoVcorrente] IndicePianocorrente] ]];    break;
		case 1: [[varbase DisegnoVcorrente] setsnappabilepiano:  [[varbase DisegnoVcorrente] IndicePianocorrente]  
															  :  ![[varbase DisegnoVcorrente] snappabilepiano
																 :[[varbase DisegnoVcorrente] IndicePianocorrente] ]];     break;
	}
}






- (IBAction) UpAlpDisLine            : (id)sender {
	[[varbase  DisegnoVcorrente] setalphaline:[sender floatValue]];
	[progetto display];
}

- (IBAction) UpAlpDisSup             : (id)sender {
	[[varbase  DisegnoVcorrente] setalphasup:[sender floatValue]];
    [progetto display];
}

- (IBAction) UpAlpPianoLine          : (id)sender {
	[[varbase  DisegnoVcorrente] setalphalinepiano: [[varbase  DisegnoVcorrente] IndicePianocorrente ] : [sender floatValue]];
	[progetto display];
}

- (IBAction) UpAlpPianoSup           : (id)sender {
	[[varbase  DisegnoVcorrente] setalphasuppiano: [[varbase  DisegnoVcorrente] IndicePianocorrente ] : [sender floatValue]];
	[progetto display];
}

- (IBAction) UpAlpDisLineCXF         : (id)sender {
    DisegnoV  *DisVectCorrente;
	for (int i=0; i<[[varbase ListaVector] count]; i++) {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
		NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
            [DisVectCorrente setalphaline:[sender floatValue]];
        } 
	}
	[progetto display];
}

- (IBAction) UpAlpDisSupCXF          : (id)sender {
	DisegnoV  *DisVectCorrente;
	for (int i=0; i<[[varbase ListaVector] count]; i++) {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
		NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
            [DisVectCorrente setalphasup:[sender floatValue]];
		} 
	}
    [progetto display];   
}

- (IBAction) UpVisCXF          : (id)sender {
	DisegnoV  *DisVectCorrente;
	for (int i=0; i<[[varbase ListaVector] count]; i++) {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
		NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
			NSButton * butsend = sender;
            [DisVectCorrente setvisibile:[butsend state]];
		} 
	}
    [progetto display];   
}




- (IBAction) CambioVectorPop         : (id)sender {
	[varbase CambioVector:[sender  indexOfSelectedItem]];
	[self aggiornamentodlgVet];
}

- (void)     CambioSubVector         : (int)indice{
	[varbase  CambioSubVector           : indice  ];
}

- (IBAction) CambioSubVectorPop      : (id)sender {
	[self CambioSubVector : [sender indexOfSelectedItem]];
}




- (IBAction) addPiano                : (id)sender {
	[[varbase DisegnoVcorrente] addpiano];
	[[varbase DisegnoVcorrente] setpianocorrente : [ [varbase DisegnoVcorrente] damminumpiani]-1  ];
	[varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente : [varbase indiceVectorCorrente]];
	[self CambioSubVector       : [[varbase DisegnoVcorrente]  IndicePianocorrente] ];
	[varbase paintboxcolorepiano];
	[self aggiornamentodlgVet];
}


- (IBAction) CatCVtoUtm              : (id)sender {
	[[varbase DisegnoVcorrente] CatToUtm];
	[progetto ZoomAll:self];
}


- (IBAction) CatCVtoUtmTutti         : (id)sender {
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [locdisvet CatToUtm];
	}
	[progetto ZoomAll:self];
}


- (IBAction) Com_Vector1             : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [self CPunto     :self];     break;
		case 1: [self CPolilinea :self];     break;
		case 2: [self CPoligono  :self];     break;
		case 3: [self CRegione   :self];     break;
				//	case 4: [self CRettangolo:self];     break;
	}
}

- (IBAction) Com_Vector2             : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [azdialogs Apridlgsimboli:self];     break;
		case 1: [self CRettangolo        :self];     break;
		case 2: [self CCerchio           :self];     break;
		case 3: [self ApridlgTesto       :self];     break;
	}
/*  precedente versione con le spline	
	switch ([sender selectedSegment]) {
		case 0: [azdialogs Apridlgsimboli:self];     break;
		case 1: [self CSplinea        :self];     break;
		case 2: [self CSpoligono      :self];     break;
		case 3: [self CSregione       :self];     break;
		case 4: [self CCerchio        :self];     break;
		case 5: [self ApridlgTesto    :self];     break;
	}
*/	
}


- (IBAction) CPunto                  : (id)sender {	
	if ([[varbase ListaVector] count]<=0) return;
	[self  comandobottone : kStato_Punto ];
}

- (IBAction) CPolilinea              : (id)sender {	
	[self  comandobottone : kStato_Polilinea ];
}

- (IBAction) CPoligono               : (id)sender { 
	[self  comandobottone : kStato_Poligono ];
}

- (IBAction) CRegione                : (id)sender {  
	[self  comandobottone : kStato_Regione ];
}

- (IBAction) CRettangolo             : (id)sender {  
	[self  comandobottone : kStato_Rettangolo ];
}

- (IBAction) CSimbolo                : (id)sender {  
	[azdialogs Chiudidlgsimboli:self];
	[self  comandobottone : kStato_Simbolo ];
}

- (IBAction) CSimboloRot             : (id)sender {
	[azdialogs Chiudidlgsimboli:self];
	[self  comandobottone : kStato_SimboloRot ];

} 

- (IBAction) CSimboloRotSca          : (id)sender {
	[azdialogs Chiudidlgsimboli:self];
	[self  comandobottone : kStato_SimboloRotSca ];
} 

- (IBAction) CSimboloFisso           : (id)sender {
	[azdialogs Chiudidlgsimboli:self];
	[self  comandobottone : kStato_SimboloFisso ];
} 


- (IBAction) CSplinea                : (id)sender {  
	[self  comandobottone : kStato_Splinea ];
}

- (IBAction) CSpoligono              : (id)sender {  
	[self  comandobottone : kStato_Spoligono ];
}

- (IBAction) CSregione               : (id)sender {  
	[self  comandobottone : kStato_Sregione ];
}

- (IBAction) CCerchio                : (id)sender {  
	[self  comandobottone : kStato_Cerchio ];
	
}



- (IBAction) CTesto                  : (id)sender {  
	if ([[[interface FieldTxtTesto] stringValue] length]==0) {	NSBeep(); return;} 
	[self ChiudidlTesto:self];
	[self  comandobottone : kStato_Testo ];
	
	[[varbase DisegnoVcorrente]  faitestovirtuale : [[varbase FieldAltezzaTesto] doubleValue] :  0 : [[varbase FieldTxtTesto] stringValue]];
}

- (IBAction) CTestoRot               : (id)sender {  
	if ([[[interface FieldTxtTesto] stringValue] length]==0) {	NSBeep(); return;} 
	[self ChiudidlTesto:self];
	[self  comandobottone : kStato_TestoRot ];
	[[varbase DisegnoVcorrente]  faitestovirtuale : [[varbase FieldAltezzaTesto] doubleValue] :  0 : [[varbase FieldTxtTesto] stringValue]];

}

- (IBAction) CTestoRotSca            : (id)sender {  
	if ([[[interface FieldTxtTesto] stringValue] length]==0) {	NSBeep(); return;} 
	[self ChiudidlTesto:self];
	[self  comandobottone : kStato_TestoRotSca ];
	[[varbase DisegnoVcorrente]  faitestovirtuale : [[varbase FieldAltezzaTesto] doubleValue] :  0 : [[varbase FieldTxtTesto] stringValue]];

}


- (IBAction) CCatPoligono            : (id)sender {
	[self  comandobottone : kStato_CatPoligono ];
	[info setVedoVerticiTuttoDisegno : YES];
}

- (IBAction) CToPolToCat             : (id)sender {
   if ([varbase comando] == kStato_CatPoligono)  {  [varbase setcomando:kStato_Poligono];   } else {
	   if ([varbase comando] == kStato_Poligono) {  [varbase setcomando:kStato_CatPoligono];}	   
   }
}


- (IBAction) CPuntoTastiera          : (id)sender {
	[self  comandobottone : kStato_PtTastiera ];
	[[bariledlg dlgNuovaCoord] setTitle:@"Posizione Punto"];

	[[varbase interface] cambiataproiezione: varbase.TipoProiezione];
	[[bariledlg dlgNuovaCoord] orderFront:self];
}

- (IBAction) CRettangoloStampa       : (id)sender {
	[self  comandobottone : kStato_RettangoloStampa ];

}

- (IBAction) CRettangoloDoppioStampa : (id)sender {
	[self  comandobottone : kStato_RettangoloDoppioStampa ];

}


- (IBAction) PallozziCatOnOff        : (id)sender {
	[info switchsetVedoVerticiTuttoDisegno];
	[progetto display];
}


	// Edit

- (IBAction) Com_Edit1               : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [self CSeleziona   :self];     break;
        case 1: [self CDeseleziona :self];     break;
		case 2: [self CMatch       :self];     break;
		case 3: [self CInfo        :self];     break;
		case 4: [self CInfoSup     :self];     break;
	}
}

- (IBAction) CSeleziona              : (id)sender { 
	[self  comandobottone : kStato_Seleziona ];
}

- (IBAction) CInfo                   : (id)sender { 
	[self  comandobottone : kStato_Info ];
}

- (IBAction) CInfoSup                : (id)sender { 
	[self  comandobottone : kStato_InfoSup ];
}


- (IBAction) CMatch                  : (id)sender { 
	[self  comandobottone : kStato_Match ];
}

- (IBAction) CDeseleziona            : (id)sender { 
	[[varbase ListaSelezionati] removeAllObjects];
	[progetto display];
}


- (IBAction) Com_EditVt              : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [self CSpostaVertice    :self];     break;
		case 1: [self CInserisciVertice :self];     break;
		case 2: [self CCancellaVertice  :self];     break;
		case 3: [self CEditVtSp         :self];     break;
	}
}

- (IBAction) CSpostaVertice          : (id)sender { 
	[self  comandobottone : kStato_SpostaVertice ];
	[progetto display];
}

- (IBAction) CInserisciVertice       : (id)sender { 
	[self  comandobottone : kStato_InserisciVertice ];
	[progetto display];
}

- (IBAction) CCancellaVertice        : (id)sender { 
	[self  comandobottone : kStato_CancellaVertice ];
	[progetto display];
}

- (IBAction) CEditVtSp               : (id)sender { 
	[self  comandobottone : kStato_EditSpVt ];
	[progetto display];
}



- (IBAction) Com_EditObj             : (id)sender {
	switch ([sender selectedSegment]) {
		case 0: [self CSpostaSelezionati   :self];     break;
		case 1: [self CCopiaselezionati    :self];     break;
		case 2: [self CRuotaSelezionati    :self];     break;
		case 3: [self CScalaSelezionati    :self];     break;
		case 4: [self CCancellaSelezionati :self];     break;
	}
}

- (IBAction) CSpostaSelezionati      : (id)sender { 
	[self  comandobottone : kStato_SpostaSelected ];
} 

- (IBAction) CCopiaselezionati       : (id)sender { 
	[self  comandobottone : kStato_CopiaSelected ];
} 

- (IBAction) CRuotaSelezionati       : (id)sender { 
	[self  comandobottone : kStato_RuotaSelected ];
}

- (IBAction) CScalaSelezionati       : (id)sender { 
	[self  comandobottone : kStato_ScalaSelected ];
} 

- (IBAction) CCancellaSelezionati    : (id)sender {
	if ([varbase ListaSelezionati].count<=0)	return;

	[[varbase MUndor] beginUndoGrouping ];

	Vettoriale *locobj;
	 for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
	 locobj= [[varbase ListaSelezionati] objectAtIndex:i];
	 [locobj cancella];
		 [[[varbase MUndor] prepareWithInvocationTarget:locobj] Decancella];
	 }
	[[varbase ListaSelezionati] removeAllObjects];
	
	[[varbase MUndor] endUndoGrouping ];

	[progetto display];
}   


- (IBAction) CspostaDisegno          : (id)sender {
	[self  comandobottone : kStato_SpostaDisegno ];
}



- (IBAction) VFixCentroRot           : (id)sender {
	[self  comandobottone : kStato_FixVCentroRot ];
}
	
- (IBAction) VCentroRot              : (id)sender {
	DisegnoV *DisegnoCorrente;
    float dif_rotazione;
	if ((varbase.xcentrorotV ==0) & (varbase.ycentrorotV ==0)) {	NSBeep(); return; }
    if (rotoscalatutti) {
	 for (int i=0; i<[[varbase ListaVector] count] ; i++ ) {
		DisegnoCorrente = [[varbase ListaVector] objectAtIndex:i];
        [DisegnoCorrente impostaUndoRot:[varbase MUndor]];
	    dif_rotazione = [sender doubleValue] - [DisegnoCorrente eventuale_ang];
	    DisegnoCorrente.eventuale_ang = [sender doubleValue];
 	    		[DisegnoCorrente RuotaDisegnoang  :varbase.xcentrorotV : varbase.ycentrorotV : dif_rotazione  ];
	 }
    }
    else {
		DisegnoCorrente = [varbase DisegnoVcorrente] ;
        [DisegnoCorrente impostaUndoRot:[varbase MUndor]];
	    dif_rotazione = [sender doubleValue] - [DisegnoCorrente eventuale_ang];
	    DisegnoCorrente.eventuale_ang = [sender doubleValue];
		[DisegnoCorrente RuotaDisegnoang  :varbase.xcentrorotV : varbase.ycentrorotV : dif_rotazione  ];
    }
	
	if (DisegnoCorrente!=nil) {
		NSString * locst = [[NSString alloc] initWithFormat:@"%2.4f",DisegnoCorrente.eventuale_ang*180/M_PI  ];
		[[interface FtxtRot] setStringValue:locst]; 
	}
	[progetto display];
}

- (IBAction) VCentroScal             : (id)sender {
	DisegnoV *DisegnoCorrente;
	double dif_scala;
	
	DisegnoCorrente = [varbase DisegnoVcorrente] ;

    if (DisegnoCorrente.eventuale_scala ==0) DisegnoCorrente.eventuale_scala=1.0;
	
	if ((varbase.xcentrorotV ==0) & (varbase.ycentrorotV ==0)) {	NSBeep(); return; }
	if (rotoscalatutti) {
		for (int i=0; i<[[varbase ListaVector] count] ; i++ ) {
			DisegnoCorrente = [[varbase ListaVector] objectAtIndex:i];
			[DisegnoCorrente impostaUndoSca:[varbase MUndor]];
			dif_scala = [sender doubleValue] / DisegnoCorrente.eventuale_scala;
			DisegnoCorrente.eventuale_scala = [sender doubleValue];
			[DisegnoCorrente ScalaDisegnoPar     :varbase.xcentrorotV : varbase.ycentrorotV : dif_scala   ];
		}
    }
    else {
		DisegnoCorrente = [varbase DisegnoVcorrente] ;
		[DisegnoCorrente impostaUndoSca:[varbase MUndor]];
		dif_scala = [sender doubleValue] / DisegnoCorrente.eventuale_scala;
		DisegnoCorrente.eventuale_scala = [sender doubleValue];
		[DisegnoCorrente ScalaDisegnoPar     :varbase.xcentrorotV : varbase.ycentrorotV : dif_scala   ];
	    }
	
	if (DisegnoCorrente!=nil) {
		NSString * locst = [[NSString alloc] initWithFormat:@"%2.4f",DisegnoCorrente.eventuale_scala  ];
		[[interface FtxtScala] setStringValue:locst]; 
	}
	
	[progetto display];
}

- (IBAction) VCentroX                : (id)sender {
	if ((varbase.xcentrorotV ==0) & (varbase.ycentrorotV ==0)) {	NSBeep(); return; }
	DisegnoV *DisegnoCorrente;
    double dif_x;
	for (int i=0; i<[[varbase ListaVector] count] ; i++ ) {
		DisegnoCorrente = [[varbase ListaVector] objectAtIndex:i];
        [DisegnoCorrente impostaUndoOrigineX:[varbase MUndor]];
	    dif_x = [sender doubleValue] - [DisegnoCorrente eventuale_offx];
	    DisegnoCorrente.eventuale_offx = [sender doubleValue];

		[DisegnoCorrente SpostaDisegnodxdy  : dif_x : 0  ];
	}
	
	if (DisegnoCorrente!=nil) {
		NSString * locst = [[NSString alloc] initWithFormat:@"%2.2f",[DisegnoCorrente eventuale_offx]  ];
		[[interface Ftxoffx] setStringValue:locst]; 
	}
	
	
	[progetto display];
}

- (IBAction) VCentroY                : (id)sender {
	if ((varbase.xcentrorotV ==0) & (varbase.ycentrorotV ==0)) {	NSBeep(); return; }
	DisegnoV *DisegnoCorrente;
    double dif_y;
	for (int i=0; i<[[varbase ListaVector] count] ; i++ ) {
		DisegnoCorrente = [[varbase ListaVector] objectAtIndex:i];
        [DisegnoCorrente impostaUndoOrigineY:[varbase MUndor]];
	    dif_y = [sender doubleValue] - [DisegnoCorrente eventuale_offy];
	    DisegnoCorrente.eventuale_offy = [sender doubleValue];
		[DisegnoCorrente SpostaDisegnodxdy  :0 : dif_y  ];
	}
	
	
	if (DisegnoCorrente!=nil) {
		NSString * locst = [[NSString alloc] initWithFormat:@"%2.2f",[DisegnoCorrente eventuale_offy]  ];
		[[interface Ftxoffy] setStringValue:locst]; 
	}
	
	
	[progetto display];
}

- (IBAction) VSet0RotCen             : (id)sender {
    if ( [ sender isEqual:[interface VB0Rot ]]) [varbase Set0SlRotScaXYVet   : 1];
	if ( [ sender isEqual:[interface VB0Sca ]]) [varbase Set0SlRotScaXYVet   : 2];
    if ( [ sender isEqual:[interface VB0Xoff]]) [varbase Set0SlRotScaXYVet   : 3];
    if ( [ sender isEqual:[interface VB0Yoff]]) [varbase Set0SlRotScaXYVet   : 4];
}

- (IBAction) VSetMinMaxRotCen         : (id)sender {
	BOOL condup =NO;
	if ([sender doubleValue]>50) condup=YES; else condup =NO;
		//	else [varbase SetupminMaxRotCen   : NO   minmax : NO rotsca :YES];

	if ( [ sender isEqual:[interface vtmaxRot  ]]) [varbase SetMinMaxSlVet : 1:condup];
	if ( [ sender isEqual:[interface vtmaxSca  ]]) [varbase SetMinMaxSlVet : 2:condup];
	if ( [ sender isEqual:[interface vtSt0Xoff ]]) [varbase SetMinMaxSlVet : 3:condup];
	if ( [ sender isEqual:[interface vtSt0Yoff ]]) [varbase SetMinMaxSlVet : 4:condup];

	
	[sender setDoubleValue:50.0];
}



- (IBAction) AzBotColorePiano        : (id)sender {
	[varbase paintboxcolorepiano];
	NSColorPanel *pancol = [NSColorPanel sharedColorPanel];
	[pancol orderFront:self];
	[pancol setTarget:self];
	[pancol setAction:@selector(colorpianochanged:)];
}


- (void)     colorpianochanged  :(NSColorPanel *) pancol{
	[[varbase DisegnoVcorrente]  setcolorepianorgb:[[varbase DisegnoVcorrente] IndicePianocorrente] 
				  :  [[pancol color] redComponent]   : [[pancol color] greenComponent] : [[pancol color] blueComponent] ]; 
	[varbase paintboxcolorepiano];
	[progetto display];
}


- (IBAction) Apri_Dlgvector          : (id)sender {
	[self aggiornamentodlgVet];
	[[bariledlg dlgGesVet] orderFront:self];
}

- (void)     mandaDisegnoCorrenteaDlg             {
		//	[ [interface dlgGesVet]    setdisegnoCorrente:[varbase DisegnoVcorrente]];
	[ [[varbase barilectr] ctrDlgVector] setdisegnoCorrente:[varbase DisegnoVcorrente]];
}

- (void)     aggiornamentodlgVet                  {
		//	[[interface dlgGesVet] aggiorna:[varbase indiceVectorCorrente]];
	[[[varbase barilectr] ctrDlgVector] aggiorna:[varbase indiceVectorCorrente]];
	[[[varbase barilectr] ctrDlgVector] updaterighe];
	[[[varbase barilectr] ctrDlgVector] setrowpianocorrente : [[varbase DisegnoVcorrente] IndicePianocorrente]];
		//	[[interface dlgGesVet] aggiornatitolidis:[varbase ListaVector].count-1];
	[[interface nomdispop] removeAllItems];
		//	[[interface dlgGesVet] setdisegnoCorrente:[varbase DisegnoVcorrente]];
	NSString *str=@"";
	if 	([[varbase ListaVector] count]==0)	 {    
		str=@" Nessun disegno presente ... crearne uno ";   [[interface nomdispop] addItemWithTitle:str];   
	} else 
	{
		DisegnoV  *locdisvet;
		for (int i=0; i<[varbase ListaVector].count; i++) {
			locdisvet= [[varbase ListaVector] objectAtIndex:i];
			str = [locdisvet nomedisegno];
			if ([str length]>0) {  str = [str lastPathComponent];	}
			if ([str length]==0) {  str = @"";	str = [str stringByAppendingFormat:	 @" dis %d", i+1];  }
			[[interface nomdispop] addItemWithTitle:str];
		}
		[[interface nomdispop] selectItemAtIndex:[varbase indiceVectorCorrente]];
	}	
}


- (IBAction) Chiudi_Dlgvector         : (id)sender {
	[varbase DoNomiVectorPop];

	[[bariledlg dlgGesVet] orderOut:self];
	[progetto display];
}

- (IBAction) PianoCorrentedaDlgvector : (id)sender {
	if ([varbase pianoDlgSelezionato]<0) return;
	[self CambioSubVector : [varbase pianoDlgSelezionato]];
}

- (IBAction) FondiTuttiDisegni        : (id)sender {
	if ([[varbase ListaVector] count]<=0) return;
	DisegnoV  *DisBase;
	DisegnoV  *DisAdd;

	DisBase = [[varbase ListaVector] objectAtIndex:0];	

	for(int i=1; i<[[varbase ListaVector] count]; i++)	{
         DisAdd = [[varbase ListaVector] objectAtIndex:i];

		[DisBase FondiDis:DisAdd];
		
	}
}



- (IBAction) cambiasimbolo           : (id)sender {
	[varbase setindsimbcorrente:[sender  indexOfSelectedItem]];
	DefSimbolo * locdefsimb;
	locdefsimb = [[varbase ListaDefSimboli] objectAtIndex:[varbase indicecurrentsimbolo]];
	NSView * thumb = [varbase viewsimb];
	[thumb lockFocus];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	NSRect fondo =[thumb bounds];
	CGContextSetRGBFillColor (hdc,0.7 ,0.7,0.7 ,1.0 );
	CGContextFillRect (hdc, fondo);
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0,1.0);
	CGContextSetRGBFillColor (hdc,0.2 ,0.2,0.2 ,1.0 );
	[locdefsimb disegnadef : hdc : fondo];
	[thumb unlockFocus];
	thumb = nil; 
}

- (IBAction) ApridlgTesto            : (id)sender {
	[NSApp runModalForWindow: [bariledlg dlgTesto]];
}

- (IBAction) ChiudidlTesto           : (id)sender {
	[NSApp stopModal]; [[bariledlg dlgTesto] orderOut:self];	
}


- (IBAction) InfoDisegnoCorrente     : (id)sender {
	[interface setlabelAzione:[[varbase DisegnoVcorrente] infodisegno]];
}

- (IBAction) InfoPianoCorrente       : (id)sender {
	[interface setlabelAzione:[[varbase DisegnoVcorrente] infopianocorrente]];
}


- (IBAction) EliminaPianiVuoti       : (id)sender {
	[[varbase DisegnoVcorrente] EliminaPianiVuoti  ];
    [varbase CambioVector: [varbase indiceVectorCorrente] ];
}

- (IBAction) EliminaPianoCorrente    : (id)sender {
	[[varbase DisegnoVcorrente] EliminaPianoCorrente  ];
    [varbase CambioVector: [varbase indiceVectorCorrente] ];
}


- (IBAction) TaglioPoligoni          : (id)sender {
    int numtaglianti =[varbase ListaSelezionati].count;
	Vettoriale *tagliante;

	for (int i=0; i<numtaglianti; i++) {  
		tagliante= [[varbase ListaSelezionati] objectAtIndex:i];    
		if (([tagliante dimmitipo] ==2) | ([tagliante dimmitipo] ==3)) {
		}
	}
}

- (IBAction) CopiaSelPiaCor          : (id)sender {
	Piano *pianocor;
	Vettoriale * objvet;
	Vettoriale * objvetcopia;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
	for (int i=0; i<[varbase ListaSelezionati].count; i++) { 
		objvet = [[varbase ListaSelezionati] objectAtIndex : i]; 
		objvetcopia = [objvet copiaPuraNoaDisegno];
		if (objvetcopia==nil) continue;	
		[objvetcopia Init:[varbase DisegnoVcorrente] :pianocor];
		[[pianocor Listavector] addObject:objvetcopia];
	}
	[[varbase ListaSelezionati] removeAllObjects];
	[[varbase DisegnoVcorrente] faiLimiti];
	[progetto display];
}


- (IBAction) SpostaSelPiaCor          : (id)sender {
	Piano *pianocor;
	Vettoriale * objvet;
	Vettoriale * objvetcopia;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
	for (int i=0; i<[varbase ListaSelezionati].count; i++) { 
		objvet = [[varbase ListaSelezionati] objectAtIndex : i]; 
		objvetcopia = [objvet copiaPuraNoaDisegno];
		if (objvetcopia==nil) continue;	
		[objvetcopia Init:[varbase DisegnoVcorrente] :pianocor];
		[[pianocor Listavector] addObject:objvetcopia];
		[objvet cancella];
	}
	[[varbase ListaSelezionati] removeAllObjects];
	[[varbase DisegnoVcorrente] faiLimiti];
	[progetto display];
}



- (IBAction) CopiaTerreniSelPiaCor          : (id)sender {
	Piano *pianocor;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
	for (int i=0; i<[varbase ListaSelezTerreni].count; i++) {  
		[[pianocor Listavector] addObject:[[varbase ListaSelezTerreni] objectAtIndex:i]];
	}
}

- (IBAction) CopiaEdificiSelPiaCor          : (id)sender {
	Piano *pianocor;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
	for (int i=0; i<[varbase ListaSelezEdifici].count; i++) {  
		[[pianocor Listavector] addObject:[[varbase ListaSelezEdifici] objectAtIndex:i]];
	}
}


- (IBAction) SpostaPianoDis1         : (id)sender {
	Piano *pianocor;
    DisegnoV * dis1;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
    dis1 = [[varbase ListaVector] objectAtIndex:0];
    
    [[dis1 ListaPiani] addObject:pianocor];
    [[[varbase DisegnoVcorrente] ListaPiani] removeObjectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
    [varbase CambioVector: [varbase indiceVectorCorrente] ];

}
    

- (IBAction) PolytoPoligoni          : (id)sender {
   	Piano *pianocor;
	pianocor= [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex:[[varbase DisegnoVcorrente] IndicePianocorrente ]];
    Vettoriale *locvet;
    
    for (int i=0; i <[pianocor Listavector].count ; i++) {
        locvet = [[pianocor Listavector] objectAtIndex:i];
        if ([locvet dimmitipo]==2) { [locvet chiudiSeChiusa];  }
    }
    [progetto display];
}


- (IBAction) CambiaRegioneSel1polig  : (id)sender {
    Vettoriale *locvet;
    for (int i=0; i <[varbase ListaSelezionati].count ; i++) {
        locvet = [[varbase ListaSelezionati] objectAtIndex:i];
        [locvet Cambia1PoligonoaRegione];  
    }
}



- (IBAction) TarquiniaQuadroUnione   : (id)sender {
	DisegnoV  *DisVectCorrente;

	if ([varbase IndiceSepresenteDisegno:[varbase nomequadronione]]>=0)	 {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : [varbase nomequadronione] ]];
		if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else [DisVectCorrente setvisibile:NSOnState];  
			[varbase DoNomiVectorPop];			[progetto display];            // renderlo invisibile
		return;
	}
	
        //    NSLog(@"K %@",[varbase nomequadronione]);

	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  [varbase nomequadronione]   : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.0];
	[DisVectCorrente seteditabile:NO];
	[DisVectCorrente setsnappabile:NO];
	[DisVectCorrente faiLimiti];
		//	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];

 [progetto display];
}



- (IBAction) AproFoglioconPt: (id)sender {
	DisegnoV  *DisVectCorrente;
	if ([varbase IndiceSepresenteDisegno:[varbase nomequadronione]]<0)	 {
		[self CNuovoDisegno:self ];
		DisVectCorrente = [varbase DisegnoVcorrente];	
		[DisVectCorrente apriDisegnoMoM:  [varbase nomequadronione]   : [varbase ListaDefSimboli]  ];
		[DisVectCorrente setalphasup : 0.0];
		[DisVectCorrente seteditabile:NO];
		[DisVectCorrente setsnappabile:NO];
		[DisVectCorrente faiLimiti];
  	    [DisVectCorrente setvisibile:NSOffState];
		[varbase DoNomiVectorPop];

	}
	[self  comandobottone : kStato_TarquiniaFogliopt ];
}


- (IBAction) BackPlineaAdded         : (id)sender {
	[[varbase DisegnoVcorrente] BackPlineaAdded  ];
	varbase.d_xcoordLast = [info xsnap];
	varbase.d_ycoordLast = [info ysnap];
    varbase.x1virt = ([info xsnap]-[info xorigineVista])/[info scalaVista];
	varbase.y1virt = ([info ysnap]-[info yorigineVista])/[info scalaVista];
	[progetto display];
	[progetto ricordasfondo ]; 

}


- (IBAction) PoligoniSelRegione      : (id)sender {
    bool iniziata = NO;
	bool primopol = YES;

	Polilinea * Pol;
	Polilinea * Polyincostr;
	Vertice  * vt;
	Vertice  * lastvtgancio;
	if ([[varbase ListaSelezionati] count]>=0  ) {
		for (int i=0; i<[[varbase ListaSelezionati] count]; i++) {
			Pol = [[varbase ListaSelezionati] objectAtIndex:i];
			if ([Pol chiusa]) {
				if (!iniziata) {
					Polyincostr = [Polilinea alloc]; 	
					[Polyincostr Init:[varbase DisegnoVcorrente] : [[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex: [[varbase DisegnoVcorrente] IndicePianocorrente ] ] ]; 
					[Polyincostr InitPolilinea:YES];  
					[[[[[varbase DisegnoVcorrente] ListaPiani] objectAtIndex: [[varbase DisegnoVcorrente] IndicePianocorrente ] ] Listavector] addObject:Polyincostr]; 
					iniziata = YES;					
				} else { [Polyincostr setregione:YES];	}

			 	for (int j=0; j<[[Pol Spezzata] count];   j++) {
					vt = [[Pol Spezzata] objectAtIndex:j];
                    if ((j==0) & (!primopol))  { lastvtgancio =  [Polyincostr verticeN :([Polyincostr numvt]-1)  ];   [ Polyincostr addvertexUp:[vt xpos]:[vt ypos] ];  }
					[ Polyincostr addvertex:[vt xpos]:[vt ypos]:0 ];
             	}
				
				if (!primopol) [Polyincostr addvertexUp:[lastvtgancio xpos]:[lastvtgancio ypos] ]; 
				if (!primopol)  [Polyincostr updateRegione];

				primopol = NO;

			}
		}
	}
}



- (IBAction) initwork                : (id)sender {
/*	DisegnoV  *DisVectCorrente;
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
	DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoCxf: @"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/catastali/D024_007400.CXF"   : [varbase ListaDefSimboli]   ];
	[DisVectCorrente seteditabile:NO];
	[progetto ZoomDisegno:self];
	[varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
 */
}


- (IBAction) CivitavecchiaFotogrammetrico     : (id)sender{
	
	DisegnoV  *DisVectCorrente;
		[progetto ricordaposultimavista];
			[self CNuovoDisegno:self ];
			DisVectCorrente = [varbase DisegnoVcorrente];	
			[DisVectCorrente apriDisegnoMoM:@"/Users/carlomacor/Desktop/DatiCartografici/Civitavecchia/Fotogrammetrico.MoM" 
																						  : [varbase ListaDefSimboli]   ];	
			[progetto ZoomDisegno:self];
}


- (IBAction) TestoAltoQuadroUCatasto : (id)sender {
	[[varbase DisegnoVcorrente] TestoAltoQU ];
	[progetto display];
}


- (IBAction) testwork                : (id)sender {
	
}

- (IBAction) VedoTestiQuadroUnione   : (id)sender {
	DisegnoV  *DisVectCorrente;
    Piano * ultimoPiano;
	if ([varbase IndiceSepresenteDisegno:[varbase nomequadronione]]>=0)	 {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : [varbase nomequadronione] ]];
		if ([DisVectCorrente visibile]) {
			ultimoPiano = [[DisVectCorrente ListaPiani] objectAtIndex:[[DisVectCorrente ListaPiani] count]-1];
			[ultimoPiano setvisibile:![ultimoPiano visibile]];
		}
		[progetto display];           
	}
}


- (IBAction) BottoneCatasto_1        : (id)sender {
		//	NSLog(@"Start");
    bool dametteretuttiOn = NO;
	DisegnoV  *DisVectCorrente;
	unichar      ilcar;		
	
	[[[varbase interface] LevelIndicatore] setIntValue: 1];
	[[[varbase interface] LevelIndicatore] setHidden:NO];
	[[[varbase interface] LevelIndicatore] display];
	
	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[varbase Dir_Catastali] error:NULL];
	for (int i=0; i<contentsAtPath.count; i++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:i];
		ilcar = [nomf characterAtIndex:0];
		if (ilcar==46) continue; // 46 = '.'
		
		NSString *nomftot = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_Catastali],nomf];
		if ([varbase IndiceSepresenteDisegno:nomftot]>=0)	 {
			DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomftot ]];
			if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else [DisVectCorrente setvisibile:NSOnState];  
				//			[varbase DoNomiVectorPop];
				//			[progetto display];            // renderlo invisibile
			continue;
		}
			//		NSLog(@"z %@",nomftot);

		[self CNuovoDisegno:self ];
		DisVectCorrente = [varbase DisegnoVcorrente];	
		NSString *estensioneFile = [nomf pathExtension];
		NSString *upestensione   =  [estensioneFile uppercaseString];
		if ([upestensione isEqualToString:@"CXF"])   { [DisVectCorrente apriDisegnoCxf:nomftot : [varbase ListaDefSimboli]  ];  
			dametteretuttiOn = YES;
		}
		
		int newind = (int)( (i*200)/contentsAtPath.count);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	
			       [[[varbase interface] LevelIndicatore] setIntValue: newind ];	[[[varbase interface] LevelIndicatore] display];	}

		
			//		[progetto ZoomDisegno:self];
		
		[nomftot release];
	}

	[[[varbase interface] LevelIndicatore] setHidden:YES];

	if (dametteretuttiOn)  {
		for (int i=0; i<[[varbase ListaVector] count]; i++) {
			DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
			NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
			if ([estensioneFile isEqualToString:@"CXF"])   [DisVectCorrente setvisibile:NSOnState]; 
		}
		
		[varbase DoNomiVectorPop];
		[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
		[varbase CambioVector: [varbase indiceVectorCorrente] ];
		[progetto ZoomAll:self];
		
	}
	else [progetto display];
}

- (IBAction) BottoneCatasto_2        : (id)sender {
	NSString *nomefillo = @"Disegni/catastale02.OrMap";
	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	DisegnoV  *DisVectCorrente;
	
		//	if ([varbase presenteDisegno   : nomefilloTutto ]>=0) return;
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0) {
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else [DisVectCorrente setvisibile:NSOnState];  
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];
	[DisVectCorrente setalphaline: 0.8];

	[DisVectCorrente seteditabile:YES];
	[DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
		//	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	
	[progetto display];
	
		//	NSLog(@"A %@",nomefilloTutto);
	
}

- (IBAction) TemaTerreni             : (id)sender {
	if 	(varbase.intematerreni) [self NoTematizzaTerreni]; else [self TematizzaTerreni];
}

- (IBAction) BotInfoIntersezionePolygoni       : (id)sender {
	[self  comandobottone : kStato_InfoIntersezione2Poligoni ];
}




- (void) TematizzaTerreni       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[[varbase interface] LevelIndicatore] setIntValue: 1];
	[[[varbase interface] LevelIndicatore] setHidden:NO];
    [[[varbase interface] LevelIndicatore] display];
	
	varbase.intematerreni =YES;
	DisegnoV  *DisVectCorrente;
	for (int i=0; i<[[varbase ListaVector] count]; i++) {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
		NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
		  [DisVectCorrente setvisibile:NSOnState]; 
		  [DisVectCorrente TematizzaTerreno :	[varbase TuttiImmobili ] ];
		} 
		int newind = (int)( (i*200)/[[varbase ListaVector] count]);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	[[[varbase interface] LevelIndicatore] setIntValue: newind ];	
			[[[varbase interface] LevelIndicatore] display];	}
	}
		[[[varbase interface] LevelIndicatore] setHidden:YES];
	[progetto display];
}



- (void) NoTematizzaTerreni       {
  	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	varbase.intematerreni =NO;
	DisegnoV  *DisVectCorrente;
	for (int i=0; i<[[varbase ListaVector] count]; i++) {
		DisVectCorrente = [[varbase ListaVector] objectAtIndex:i];
		NSString *estensioneFile = [[[DisVectCorrente nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
            [DisVectCorrente setvisibile:NSOnState]; 
            [DisVectCorrente NoTematizzaTerreno ];
		} 
	}
	[progetto display];
  
}

- (IBAction) DisegnoCatastoTematizzato  : (id)sender {
	DisegnoV  *DisVectCorrente;
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[self CNuovoDisegno:self ];
	DisVectCorrente = [varbase DisegnoVcorrente];	
	[[[varbase interface] LevelIndicatore] setIntValue: 1];	[[[varbase interface] LevelIndicatore] setHidden:NO];  
	[[[varbase interface] LevelIndicatore] display];
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i]; 
		NSString *estensioneFile = [[[locdisvet nomedisegno] pathExtension] uppercaseString];
		if ([estensioneFile isEqualToString:@"CXF"])  {
			[locdisvet TematizzaTerrenoSuNuovoDis :DisVectCorrente :	[varbase TuttiImmobili ] ];
		} 
		int newind = (int)( (i*200)/[[varbase ListaVector] count]);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	[[[varbase interface] LevelIndicatore] setIntValue: newind ];	
			[[[varbase interface] LevelIndicatore] display];	}
	}
	[varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	[[[varbase interface] LevelIndicatore] setHidden:YES];	[progetto display];
}


- (void) EsecutoreBottoneComune : (int) tipoAzione  : (NSString *) nomestr {
	
}


- (void) InterpreteBottoneComune : (int) indice {
	
	switch (indice) {
		case 1: [self EsecutoreBottoneComune : 1  : @""];
			
			break;
		default:  break;
	}
	
}

- (IBAction) BottoneComune_01V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Allumiere.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
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
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.0];	[DisVectCorrente setalphaline: 0.8];
		//	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
        //	[progetto display];
}

- (IBAction) BottoneComune_02V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/Orografia.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0) {
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
}

- (IBAction) BottoneComune_03V       : (id)sender {
    DisegnoV  *DisVectCorrente;

    NSString *nomefillo = @"Disegni/FotoGram.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0) {
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];

}

- (IBAction) BottoneComune_04V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/UsiCivici.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0) {
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
}

- (IBAction) BottoneComune_05V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/Zonizzazione.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0){
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
}

- (IBAction) BottoneComune_06V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/zps.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0){
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	
    
}

- (IBAction) BottoneComune_07V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/Tematizzato.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0){
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	
    
	
}

- (IBAction) BottoneComune_08V       : (id)sender {
	DisegnoV  *DisVectCorrente;
    NSString *nomefillo = @"Disegni/ZoneTax.OrMap"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0){
        DisVectCorrente = [[varbase ListaVector] objectAtIndex:[varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
        if ([DisVectCorrente visibile]) [DisVectCorrente setvisibile:NSOffState]; else 
		{	[DisVectCorrente setvisibile:NSOnState];  
			[varbase setindiceVectorCorrente   : [varbase IndiceSepresenteDisegno   : nomefilloTutto ]];
			[varbase CambioVector: [varbase indiceVectorCorrente] ];		}
		[varbase DoNomiVectorPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	[progetto ricordaposultimavista];
	[self CNuovoDisegno:self ];
    DisVectCorrente = [varbase DisegnoVcorrente];	
	[DisVectCorrente apriDisegnoMoM:  nomefilloTutto  : [varbase ListaDefSimboli]  ];
	[DisVectCorrente setalphasup : 0.5];	[DisVectCorrente setalphaline: 0.8];
	[DisVectCorrente seteditabile:YES];	    [DisVectCorrente setsnappabile:YES];
	[DisVectCorrente faiLimiti];
	[progetto ZoomDisegno:self];
    [varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	
}

- (IBAction) BottoneComune_09V       : (id)sender {
    
}

- (IBAction) BottoneComune_10V       : (id)sender {
    
}



- (IBAction) BotLegComune_01V        : (id)sender {
	[self  comandobottone : kStato_InfoLeg ];
}

- (IBAction) PulisciRoma             : (id)sender {
	
	
	
	NSBeep();
	return;
	DisegnoV *Locdis;
	Piano    *LocPiano;
		//	NSString;
	char caroini;
	Locdis = [varbase DisegnoVcorrente];
		//	[Locdis SpostaDisegnodxdy:-6.2 :-9.4];
	for (int i=[[Locdis ListaPiani] count]-1; i>0; i--) {
		LocPiano = [[Locdis ListaPiani] objectAtIndex:i];
		if ([[LocPiano givemenomepiano] isEqualToString: @"MEZZERIA2" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		caroini = [[LocPiano givemenomepiano] characterAtIndex:0];
		if (caroini==71) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // G
		if (caroini==70) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // F

		if (caroini==65) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // A
		if (caroini==66) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // B
		if (caroini==67) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // C
		if (caroini==68) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	} // D

		if ([[LocPiano givemenomepiano] isEqualToString: @"080214" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"050902" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030108" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"080203" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"060120" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060119" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060913" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"030101" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030107" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030201" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030201_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030202" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030202_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030201B" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"030302" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030304" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		
		if ([[LocPiano givemenomepiano] isEqualToString: @"050901" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030207" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030201A" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"020301" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"020301V" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"020407" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"010101T" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"010202" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"010216" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"010217" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		
		if ([[LocPiano givemenomepiano] isEqualToString: @"050204" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030207_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"030301" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"010103" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"050111_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"040205" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"050610" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"050103_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		
		if ([[LocPiano givemenomepiano] isEqualToString: @"080212" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"080213" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"080210" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"020205" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"020205_I" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"020102" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		if ([[LocPiano givemenomepiano] isEqualToString: @"060705" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060705S" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060706" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060706S" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}
		if ([[LocPiano givemenomepiano] isEqualToString: @"060710S" ]) {[[Locdis ListaPiani] removeObjectAtIndex:i]; continue;	}

		
		
		if (([[LocPiano givemenomepiano] isEqualToString: @"010101" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"010101_I" ]) 
			| ([[LocPiano givemenomepiano] isEqualToString: @"010104" ]) 
			| ([[LocPiano givemenomepiano] isEqualToString: @"010104_I" ]) 
			)
		    {[LocPiano setcolorpianorgb:200/255.0 :150/255.0 :0.0];	};

		if (([[LocPiano givemenomepiano] isEqualToString: @"010102" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"010105" ]) 
			| ([[LocPiano givemenomepiano] isEqualToString: @"010102_I" ]) 
			)	    {[LocPiano setcolorpianorgb:144/255.0 :116/255.0 :0.0];	};
		

		if (([[LocPiano givemenomepiano] isEqualToString: @"060101" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"060101G" ]) 
			)	    {[LocPiano setcolorpianorgb:40/255.0 :110/255.0 :130/255.0];	};
	
		if ([[LocPiano givemenomepiano] isEqualToString: @"050401" ]) //| ([[LocPiano givemenomepiano] isEqualToString: @"060101G" ]) 
				    {[LocPiano setcolorpianorgb:1.0 :1.0 :0.0];	};
		if (([[LocPiano givemenomepiano] isEqualToString: @"060805" ])	)	    {[LocPiano setcolorpianorgb:1.0 :1.0 :0.0];	};

		if (([[LocPiano givemenomepiano] isEqualToString: @"060806" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"060803" ]) 
			)	    {[LocPiano setcolorpianorgb:227/255.0 :227/255.0 :227/255.0];	};


		if (([[LocPiano givemenomepiano] isEqualToString: @"060110" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"060110D" ]) 
			)	    {[LocPiano setcolorpianorgb:40/255 :1.0 :1.0];	};

		if (([[LocPiano givemenomepiano] isEqualToString: @"020101" ])	)	    {[LocPiano setcolorpianorgb:0.0 :0.0 :1.0];	};
		if (([[LocPiano givemenomepiano] isEqualToString: @"060201" ])	)	    {[LocPiano setcolorpianorgb:80/255.0 :30/255.0 :80/255.0];	};
		if (([[LocPiano givemenomepiano] isEqualToString: @"060201G" ])	)	    {[LocPiano setcolorpianorgb:80/255.0 :30/255.0 :80/255.0];	};

		if (([[LocPiano givemenomepiano] isEqualToString: @"060401" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"060401G" ]) 
			)	    {[LocPiano setcolorpianorgb:40/255.0 :80/255.0 :80/255.0];	};
		if (([[LocPiano givemenomepiano] isEqualToString: @"060144" ]) | ([[LocPiano givemenomepiano] isEqualToString: @"060146" ]) 
			)	    {[LocPiano setcolorpianorgb:40/255.0 :80/255.0 :80/255.0];	};

		
	}
	
	
	
	[varbase DoNomiVectorPop];
	[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
	[varbase CambioVector: [varbase indiceVectorCorrente] ];
	[progetto display];
	
}


	
@end
