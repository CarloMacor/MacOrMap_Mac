//
//  ProgDialogs.m
//  MacOrMap
//
//  Created by Carlo Macor on 25/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "ProgDialogs.h"
#import "Progetto.h"


@implementation ProgDialogs


Progetto * progettochiamante;

	// dlg info


- (void) Passaprogettochiamante             : (id)  prog     {
			progettochiamante = prog;
}


	// dlg info oggetto vettoriale

- (void)     ApriDlgInfoVet                                  {
	if ([varbase ListaInformati].count >0) 
	{	[self updatedlginfoVet : 0];	[[[varbase bariledlg] dlgInfo] orderFront:self];	}
}

- (IBAction) OKdlgInfoVet                   : (id)  sender   {
	[varbase comando00];
	[[varbase ListaInformati]  removeAllObjects];
	[[[varbase bariledlg] dlgInfo] orderOut:self];
	[progettochiamante display];
}

- (void)     updatedlginfoVet               : (int) indice   {
	int numinf = [varbase ListaInformati].count;
	if  (numinf<=0) return;
	if (indice>=numinf) indice=0;
	if (indice<0) indice = [varbase ListaInformati].count-1;
	[varbase setindiceInformato:indice];
	NSString * STR_loc;
	STR_loc = @"";	STR_loc = [STR_loc stringByAppendingFormat:	 @"%d / %d",(indice+1),numinf];	
	[[interfacedlg Infoquanti] setStringValue:STR_loc];
	Vettoriale * locvet = [[varbase ListaInformati] objectAtIndex:indice];
	[[interfacedlg Infotipo]   setStringValue:[locvet dimmitipostr]];	                
	[[interfacedlg Infolungo]  setStringValue:[locvet lunghezzastr]];
	[[interfacedlg Infosup]    setStringValue:[locvet supstr]];	
	[[interfacedlg Infonvt]    setStringValue:[locvet nvtstr]];	
	[[interfacedlg Infopia]    setStringValue:[locvet pianostr]];
	[[interfacedlg Infodis]    setStringValue:[locvet disegnostr]];
	[progettochiamante display];
}

- (IBAction) upindiceinfoVet                : (id)  sender   {
	[self updatedlginfoVet : [varbase indiceinformato]+1];
}

- (IBAction) downindiceinfoVet              : (id)  sender   {
	[self updatedlginfoVet : [varbase indiceinformato]-1];
}


	// dlg info area

- (void)     ApriDlgInfoArea                                 {
	if ([varbase ListaInformati].count >0) 
	{	[self updatedlginfoArea : 0];
		[[[varbase bariledlg] dlgInfoArea] orderFront:self];	}
}

- (IBAction) OKdlgInfoArea                  : (id)  sender   {
	[varbase comando00];
	[[varbase ListaInformati]  removeAllObjects];
	[[bariledlg dlgInfoArea] orderOut:self];
	[progettochiamante display];
}

- (void)     updatedlginfoArea              : (int) indice   {
	int numinf = [varbase ListaInformati].count;
	if  (numinf<=0) return;
	if (indice>=numinf) indice=0;
	if (indice<0) indice = [varbase ListaInformati].count-1;
	[varbase setindiceInformato:indice];
	NSString * STR_loc;
	STR_loc = @"";	STR_loc = [STR_loc stringByAppendingFormat:	 @"%d / %d",(indice+1),numinf];	
	[[interfacedlg InfoquantiSup] setStringValue:STR_loc];
	Vettoriale * locvet = [[varbase ListaInformati] objectAtIndex:indice];
	[[interfacedlg InfoDisLeg]    setStringValue:[[locvet disegnostr] stringByDeletingPathExtension]];	
	[[interfacedlg InfosupLeg]    setStringValue:[locvet supstr]];	
	[[interfacedlg InfopiaLeg]    setStringValue:[locvet pianostr]];
	[progettochiamante display];
}

- (IBAction) upindiceinfoArea               : (id)  sender   {
	[self updatedlginfoArea: [varbase indiceinformato]+1];
	
}

- (IBAction) downindiceinfoArea             : (id)  sender   {
	[self updatedlginfoArea: [varbase indiceinformato]-1];
}


	// dlg Griglia

- (IBAction) CambiaGriglia                  : (id) sender    {
    if ([sender selectedSegment]==0) {	varbase.inGriglia = !varbase.inGriglia;	[progettochiamante display];	}	
	if ([sender selectedSegment]==1) {
		if (![[[varbase  interface] ESGriglia] isSelectedForSegment:1]) {
			[[[varbase  bariledlg] dlgGriglia]  orderOut:self];
		} else {
			[[[varbase  bariledlg] dlgGriglia]  orderFront:self];
			varbase.inGriglia = YES; 
			[[[varbase  interface] ESGriglia]  setSelected:YES  forSegment:1];
			[[[varbase  interface] ESGriglia]  setSelected:YES  forSegment:0];
		}
		[progettochiamante display];
	}
}


- (void) ImpostaAppuntiTerrenoPRG           {
	
	if ([varbase ListaSelezTerreni].count<=0) return; 
	Terreno * terer;
	Vettoriale * locvet;	
	NSMutableString * informativa = [[NSMutableString alloc] initWithCapacity:2000];	

	locvet = [[varbase ListaSelezTerreni] objectAtIndex:0];
	NSString   * nompartic;  
	NSString   * nomfoglio;  
 	NSMutableArray * ListTer = [[varbase TuttiImmobili ] LTer];
	bool trovato = NO;
	nomfoglio = [[locvet disegno] nomeFoglioCXF];
	nompartic = [[locvet piano] givemenomepiano];
	for (int i=0; i<  [ListTer count]; i++) {
			terer = [ListTer objectAtIndex:i];
			if ([terer inlistanomepart:nompartic] ) {
				if ([nomfoglio isEqualToString:[terer Foglio]] ) {
					trovato = YES;
					[informativa appendFormat:@"Comune :  Allumiere  \n"];
					[informativa appendFormat:@"Terreno       "];
                   	[informativa appendFormat:@"Foglio :  %@    "  , [terer Foglio]];
					[informativa appendFormat:@"Particella :  %@\n", [terer Particella]];
					[informativa appendFormat:@"Superficie :  %d  mq\n", [terer Superficie]];
					[informativa appendFormat:@"Qualita'  :  %@       "  , [terer Qualita]];
					[informativa appendFormat:@"Classe  :  %@\n"  , [terer Classe]];
					[informativa appendFormat:@"Reddita       Domenicale € :  %1.2f         "  , [terer Renditadomenicale]];
					[informativa appendFormat:@"Agraria € :  %1.2f\n"  , [terer Renditaagraria]];
								[informativa appendFormat:@"\n" ];
					[informativa appendFormat:@"Elenco Intestatari al Catasto :\n" ];
						//					[informativa appendFormat:@"\n" ];
					
					Proprietari * proper;
					Patrimonio  * patr;
					for (int i=0; i<[[varbase Listaproprietari] count]; i++) { 
                        proper= [[varbase Listaproprietari]  objectAtIndex:i];
						for (int j=0; j<[proper ListaPatrimonio].count; j++) { 
							patr = [[proper ListaPatrimonio] objectAtIndex:j];
							if ([patr TipoEdiTerra] != 1) continue;
							if (![[terer Foglio]     isEqualToString:[patr Foglio]]) continue;
							if (![[terer Particella] isEqualToString:[patr Particella]]) continue;
							if (![[terer Zona]       isEqualToString:[patr Sub]]) continue;
							
							[informativa appendFormat:@"  Cognome : %@   ---  Nome : %@     ---- Oneri : %@ \n"  , [proper Cognome], [proper Nome] ,[patr DirittiOneri] ];
							[informativa appendFormat:@"        Data Nascita : %@   Luogo : %@  Codice Fiscale : %@ \n"  , [proper Datanascita], [proper LuogoNascita], [proper Codfis] ];
								//							[informativa appendFormat:@"\n" ];

								//			if (![patr presenzainfo :fg : part : subo]) continue;
								//							[ListaStrOneri   addObject:patr ];
						}
					}
					
					[informativa appendFormat:@"\n" ];
			
	
					Polilinea *TerrenoVet = [[varbase ListaSelezTerreni] objectAtIndex:0];

					Vettoriale * locobj;
					Vettoriale * objkk;
					Polilinea  *P1kk, *P2obj, *PolIntersezione ;
					Piano * locpiano;
					DisegnoV * zonetax;
						// prendere il disegno ZoneTax.
/*					
					NSString *nomefillo = @"Disegni/ZoneTax.OrMap"; 	NSString *nomefilloTutto;
					nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
					if ([varbase IndiceSepresenteDisegno   : nomefilloTutto ]>=0){
*/						
					if ([varbase presenteDisegno             :@"/MacOrMap/Allumiere/Disegni/ZoneTax.OrMap" ]>=0) {
						zonetax = [varbase DisegnoVcorrente];
					  for (int kk=0; kk<[[varbase ListaInformati] count]; kk++) {
						objkk = [[varbase ListaInformati] objectAtIndex:kk];
						  if ( ([objkk dimmitipo]!=3) & ([objkk dimmitipo]!=4) ) continue;  // 3 poligono 4 regione
						  P1kk = [[varbase ListaInformati] objectAtIndex:kk];
						for (int k1=0; k1<[[zonetax ListaPiani] count]; k1++) {
							locpiano = [[zonetax ListaPiani] objectAtIndex:k1];
							if (![locpiano visibile]) continue;
							for (int k2=0; k2<[[locpiano Listavector] count]; k2++) {
								locobj = [[locpiano Listavector] objectAtIndex:k2];
								if ( ([locobj dimmitipo]==3)  | ([locobj dimmitipo]==4)) {  // 3 poligono 4 regione  //	locvet  il poligono terreno
									P2obj = [[locpiano Listavector] objectAtIndex:k2];
									if ([P1kk isEqual:P2obj]) {
										PolIntersezione = [comandipro Esecuzione2Poligoni  :P1kk : TerrenoVet :YES ];
										[informativa appendFormat:@"Ricade nella Zona  : %@  \n",  [locpiano givemenomepiano]];
										[informativa appendFormat:@"Superficie Terreno e Intersezione   : %1.2f  %1.2f \n",
										                             [TerrenoVet superficie] , [PolIntersezione superficie]];
										double rapper = ([PolIntersezione superficie] /  [TerrenoVet superficie] )*100.0;
										if (rapper>99.0) rapper=100.0;
										[informativa appendFormat:@"Percentuale ricadente nella Zona  : %1.2f  %% \n\n", rapper];
										
										
										
										[informativa appendFormat:@"Superficie Catastale in Zona  : %1.0f mq. \n\n",  ([terer Superficie]*rapper)/100.0];
										[informativa appendFormat:@"----------------------------------------- \n\n",  ([terer Superficie]*rapper)/100.0];

										
									}
								}
							}
						}
					  } // ciclo su kk
					}
					break;
				}
			}
	}
		if (trovato) { [[interfacedlg AppuntiTxt] insertText:informativa];	}

	[[varbase ListaSelezTerreni] removeAllObjects];
	[[varbase ListaSelezionati] removeAllObjects];
	[[varbase ListaInformati] removeAllObjects];
	[progettochiamante display];
	
	
}


- (IBAction) ApriDlgAppunti                 : (id) sender    {
	[[bariledlg dlgAppunti] orderFront:self];
	
}



- (IBAction) TogliRettangoloStampa          : (id)sender     {
	if ([varbase rettangoloStampa] !=nil) {
		[[varbase rettangoloStampa] release]; [varbase setnilrettangolostampa];
		[progettochiamante display];
	}
} 





@end
