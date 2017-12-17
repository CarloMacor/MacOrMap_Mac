//
//  AzDialogs.m
//  MacOrMap
//
//  Created by Carlo Macor on 22/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "AzDialogs.h"


@implementation AzDialogs

- (void) InitAzDialogs       {
	
}


	// dlg Fabbricati 

- (IBAction) ApriDlgFabbricati              : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
    [[barilectr ctrEdi] AttivaFiltro:NO];
	[[barilectr ctrEdi] updaterighe];
	[[barilectr ctrEdi] preimpostaBackinLista];
	[[bariledlg dlgEdifici]	orderFront:self];
}

- (IBAction) OKdlgFabbricati                : (id) sender       {
	[varbase comando00];
	[[bariledlg dlgEdifici] orderOut:self];
}

- (IBAction) ApriDlgFiltriFabbricati        : (id) sender       {
	[[barilectr ctrEdiFiltro]     inizTavole];
	[[barilectr ctrEdi]	            AttivaSoloFiltro:YES];
	[[bariledlg dlgFiltriEdifici]	orderFront:self];
}

- (IBAction) ApriDlgIcidaFabbricati         : (id) sender       {
	switch ([sender selectedSegment]) {
		case 0: [self ApriDlgICI   :self];    break;
		case 1: [self ApriDlgICI   :self];    break;
	}
}

- (IBAction) ApriDlgTarsudaFabbricati       : (id) sender       {
	switch ([sender selectedSegment]) {
		case 0: [self ApriDlgTarsuCircadaFabbricati   :self];    break;
		case 1: [self ApriDlgTarsuSeccadaFabbricati   :self];    break;
	}
}

- (IBAction) ApriDlgTarsuSeccadaFabbricati  : (id) sender       {
 	Subalterno * suber = [[barilectr ctrEdi] subselezionato];	if (suber == nil) return;
	[[barilectr ctrTax]      impostaTarsuFoglioPartSub : [suber Foglio] : [suber Particella] : [suber Sub]];
	[[bariledlg dlgTarsu]  orderFront:self];
	[[barilectr ctrTax] updaterighe];
}

- (IBAction) ApriDlgTarsuCircadaFabbricati  : (id) sender       {
 	Subalterno * suber = [[barilectr ctrEdi] subselezionato];	if (suber == nil) return;
	[[barilectr ctrTax]      impostaCirca : suber ];
	[[bariledlg dlgTarsu]  orderFront:self];
}

- (IBAction) ApridlgAnagrafedaFabbricati    : (id) sender       {
	Subalterno * suber = [[barilectr ctrEdi] subselezionato];	if (suber ==nil) return;
	[[barilectr ctrAnagrafe] impostaResidFiltInfoEdif :[suber Foglio]:[suber ParticellaSingola]:[suber SubSingolo]];
	if ([[[varbase anagrafe] ListaFamiglieFiltrata] count]==0) {
		[[barilectr ctrAnagrafe] impostaResidFiltInfoViaNoassegnata :[suber Via]];
	}
	[[barilectr ctrAnagrafe] riordinacognome];
	[[bariledlg dlgAnagrafe]   orderFront:self];
}

- (IBAction) VaiGrafEdifdaFabbricati        : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
	NSArray        * listaSubselez = [[barilectr ctrEdi] SubSelezionati];
	[azextra AddinListaGruppoSuber   : listaSubselez : [varbase ListaSelezEdifici] ];
}

- (IBAction) ApridlgPossdaFabbricati        : (id) sender       {
	Subalterno * suber = [[barilectr ctrEdi] subselezionato];	if (suber ==nil) return;
	[[barilectr ctrPossessori] impostainfopropieta :[suber Infocompleto]];
    [[barilectr ctrPossessori] impostaelencopossessori : [suber Foglio] : [suber Particella]: [suber Sub]];
	[[bariledlg dlgPossessori]   orderFront:self];
}

- (IBAction) ApriVisuradaFabbricati         : (id) sender       {
	NSString *nomedirro;
	PDFDocument   *pdfDoc;		
	
	[[interface PdfViewVisura] setDocument:nil ];
	if (([[barilectr ctrProprietari] demoSensibili]) | (![varbase  AutorizzatoDatiSensibili]))	{
		nomedirro = @"/MacOrMap/Catasto/visurademo.pdf"; 	
		pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: nomedirro ]];
		[[interface PdfViewVisura] setDocument:pdfDoc ];
		[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
		[[bariledlg dlgVisuraPdf] setTitle:@"Visura Demo"];
		[[bariledlg dlgVisuraPdf] orderFront:self];
		return;
	}
	
	Subalterno * suber = [[barilectr ctrEdi] subselezionato];
	
	if (suber==nil) return;
	
	NSString * Nomecompleto;
	NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
	[ParteSt appendFormat:	 @"_%@_%@_%@.",[suber Foglio],[suber Particella],[suber Sub] ];
	nomedirro = @"/MacOrMap/Catasto/Fabbricati_pdf/"; 	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
	for (int j=0; j<contentsAtPath.count; j++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:j];
		NSRange rg;
		rg = [nomf rangeOfString:ParteSt];
		if (rg.length>0) {
			Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
			pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
			[[interface PdfViewVisura] setDocument:pdfDoc ];
			[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
			break;
		}
	}
	
	[[bariledlg dlgVisuraPdf] setTitle:Nomecompleto];
	[[bariledlg dlgVisuraPdf] orderFront:self];
}

	// dlg Filtra Fabbricati 

- (IBAction) OKdlgFiltriEdifici             : (id) sender       {
	[[bariledlg dlgFiltriEdifici] orderOut:self];
	[[barilectr ctrEdi] preimpostaBackinLista ];
}



	// dlg Terreni 

- (IBAction) ApriDlgTerreni                 : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
    [[barilectr ctrTer] AttivaFiltro:NO];
	[[barilectr ctrTer] updaterighe];
	[[barilectr ctrTer] preimpostaBackinLista];
	[[bariledlg dlgTerreni]  orderFront:self];
}

- (IBAction) OkdlgTerreni                   : (id) sender       {
	[varbase comando00];
	[[bariledlg dlgTerreni]  orderOut:self];
}

- (IBAction) ApriDlgFiltriTerreni           : (id) sender       {
	[[barilectr ctrTerFiltro]     inizTavole];
	[[barilectr ctrTer]	            AttivaSoloFiltro:YES];
	[[bariledlg dlgFiltriTerreni]	orderFront:self];
}

- (IBAction) VaiGrafTerradaTerra            : (id) sender       {
	[[varbase ListaSelezTerreni]  removeAllObjects];
	NSArray        * listaTererselez = [[barilectr ctrTer] SubSelezionati];
	[azextra AddinListaGruppoTerer: listaTererselez : [varbase ListaSelezTerreni] ];
}

- (IBAction) ApridlgPossdaTerra             : (id) sender       {
	Terreno * terer = [[barilectr ctrTer] subselezionato];	if (terer ==nil) return;
	[[barilectr ctrPossessori] impostainfopropieta :[terer Infocompleto]];
	[[barilectr ctrPossessori] impostaelepossessoriterra : [terer Foglio] : [terer Particella]: [terer Zona]];
	[[bariledlg dlgPossessori]   orderFront:self];
}

- (IBAction) ApriVisuradaTerreni            : (id) sender       {
	NSString *nomedirro;
	PDFDocument   *pdfDoc;		
	
	[[interface PdfViewVisura] setDocument:nil ];
	if (([[barilectr ctrProprietari] demoSensibili]) | (![varbase  AutorizzatoDatiSensibili]))	{
		nomedirro = @"/MacOrMap/Catasto/visurademo.pdf"; 	
		pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: nomedirro ]];
		[[interface PdfViewVisura] setDocument:pdfDoc ];
		[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
		[[bariledlg dlgVisuraPdf] orderFront:self];
		return;
	}
	
	
	
	Terreno * terer = [[barilectr ctrTer] subselezionato];
	if (terer==nil) return;
	NSString * Nomecompleto;
	NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
	[ParteSt appendFormat:	 @"_%@_%@.",[terer Foglio],[terer Particella] ];
	nomedirro = @"/MacOrMap/Catasto/Terreni_pdf/"; 	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
	for (int j=0; j<contentsAtPath.count; j++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:j];
		NSRange rg;
		rg = [nomf rangeOfString:ParteSt];
		if (rg.length>0) {
			Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
			pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
			[[interface PdfViewVisura] setDocument:pdfDoc ];
			[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
			break;
		}
	}
	
	[[bariledlg dlgVisuraPdf] setTitle:Nomecompleto];
	[[bariledlg dlgVisuraPdf] orderFront:self];
}

	// dlg Filtra Terreni 

- (IBAction) OKdlgFiltriTerreni             : (id) sender       {
	[[bariledlg dlgFiltriTerreni] orderOut:self];
	[[barilectr ctrTer] preimpostaBackinLista ];
}



	// dlg ICI

- (IBAction) ApriDlgICI                     : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[bariledlg dlgICI]  orderFront:self];
}

- (IBAction) OkdlgICI                       : (id) sender       {
	[[bariledlg dlgICI]  orderOut:self];
}

- (IBAction) ApriDlgTarsudaIci              : (id) sender       {
	Tax_ele * taxer = [[barilectr ctrTax] TarserSelezionato:YES];	if (taxer == nil) return;
	[[barilectr ctrTax]      impostaIciFoglioPartSub : [taxer Foglio] : [taxer Particella] : [taxer Sub]];
	[[bariledlg dlgTarsu]  orderFront:self];
	[[barilectr ctrTax] updaterighe];
}

- (IBAction) ApridlgAnagrafedaIci           : (id) sender       {
	Tax_ele * taxer = [[barilectr ctrTax] TarserSelezionato:NO];	if (taxer ==nil) return;
	[[barilectr ctrAnagrafe] impostaResidFiltInfoTaxer :[taxer CodFis]];
	[[bariledlg dlgAnagrafe]   orderFront:self];
}

- (IBAction) VaiGrafEdifdaIci               : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
    Tax_ele *tarser = [[barilectr ctrTax] TarserSelezionato:NO];  if (tarser ==nil) return;
	int indo =   [ azextra aproFoglio : [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
	indo =  [  azextra aproFoglioA: [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
	indo =  [  azextra aproFoglio0A: [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
}

- (IBAction) ApridlgPossdaIci               : (id) sender       {
    Tax_ele *tarser = [[barilectr ctrTax] TarserSelezionato:NO];  if (tarser ==nil) return;
	[[barilectr ctrPossessori] impostainfopropieta :@""];
    [[barilectr ctrPossessori] impostaelencopossessori : [tarser Foglio] : [tarser Particella]: [tarser Sub]];
	[[bariledlg dlgPossessori]   orderFront:self];
}


	// dlg Tarsu

- (IBAction) ApriDlgTarsu                   : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[barilectr ctrTax] setfiltro:NO]; 
	[[bariledlg dlgTarsu]  orderFront:self];
}

- (IBAction) OkdlgTarsu                     : (id) sender       {
	[[bariledlg dlgTarsu]  orderOut:self];
}


- (IBAction) ConnettiAnagrafeTarsuFab        : (id) sender       {
	NSArray    * LeFamiglie;
	NSArray    * Componenti;
	Famiglia   * unaFamiglia;
	Residente  * Loresidente;
	Subalterno * suber;
	Tax_ele    * tarser;
	int contatore = 0;
		//	NSArray * ListaFabbricati = [[varbase TuttiImmobili] ListaSubalterni];
	NSArray * ListaTarse      = [[varbase TuttaTax   ] ListaTarsuEle];

    LeFamiglie = [[varbase anagrafe] ListaFamiglie];
	for (int i=0; i<[LeFamiglie count]; i++) {
			//		NSLog(@"- %d",i);
		unaFamiglia = [LeFamiglie objectAtIndex:i];
		if ([unaFamiglia associatoedif]) continue;
		
		Componenti = [unaFamiglia  ListaComponenti];
		
		for (int j=0; j<[Componenti count]; j++) {
			Loresidente = [Componenti objectAtIndex:j];
				//			NSLog(@"- %d %@",j,[Loresidente codFis]);
			for (int k1=0; k1<[ListaTarse count];   k1++) {
					// analiziamo tutti i pagamenti
				tarser = [ListaTarse objectAtIndex:k1];
				if ([[tarser CodFis] isEqualToString:[Loresidente codFis]]) {
					// che sia casa
					NSRange rg = [[tarser ConsisCat] rangeOfString:@"vani"];
					if (rg.length>0) {

						for (int k2=0; k2<[[[varbase TuttiImmobili] ListaSubalterni] count]; k2++) {
							suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:k2];
							if (([suber Foglio]==[tarser Foglio]) & ([suber Particella]==[tarser Particella]) & ([suber Sub]==[tarser Sub]) )
							{
									//							if ([[tarser Via] isEqualToString:[unaFamiglia Via] ]) 
								{
									contatore ++;
																		NSLog(@"- %d %@ %@ %@ %@",contatore,[Loresidente codFis],[tarser ConsisCat],[tarser Via],[unaFamiglia Via]  );
									NSLog(@" %@",[Loresidente Cognome]);
									break;
								}
							}
							
							
						}
						
					} 
					
				}
			}
			
		}
	}
}

- (IBAction) ConnettiTarsuFabbricati        : (id) sender       {
	NSArray * ListaFabbricati = [[varbase TuttiImmobili] ListaSubalterni];
	NSArray * ListaTarse      = [[varbase TuttaTax   ] ListaTarsuEle];
	Subalterno * suber;
	Tax_ele  * tarser;
    int conta =0;
	for (int i=0; i<[ListaFabbricati count];   i++) {
		suber = [ListaFabbricati objectAtIndex:i];
		if ([suber Conferma]>=6) continue;
		NSArray *  l_part = [[suber Particella] componentsSeparatedByString:@","];
		NSArray *  l_sub  = [[suber Sub]        componentsSeparatedByString:@","];
		
		
		for (int j=0; j<[ListaTarse count];   j++) {
			tarser = [ListaTarse objectAtIndex:j];
			if ([[suber Foglio] isEqualToString:[tarser Foglio]]) {	
				for (int k=0; k<[l_part count]; k++) { 
					if ([[l_part objectAtIndex:k] isEqualToString:[tarser Particella]]) {
						if (k<[l_sub count]) {
							if ([[l_sub objectAtIndex:k] isEqualToString:[tarser Sub]]) {
								[tarser SetConsisCat:[suber Consistenza]]; conta ++;
								
								suber.Conferma=6;
								[suber setVia:[tarser Via] ];
								[suber setCivico:[tarser Civico] ];
								
									//					NSLog(@"c %d %@ %@",conta,[suber Consistenza],[tarser ConsisCat] );
							}
						}
					}
				}
			}
		}
	}
	[[barilectr ctrTax] updaterighe];
	[[barilectr ctrEdi] updaterighe];
	
}

- (IBAction) TarsuCambiaFlag                : (id) sender       {
    if (![barilectr ctrTax].filtroattivoTarsu) return;
	Subalterno * suber = [[barilectr ctrEdi] subselezionato];	if (suber == nil) return;
    NSArray * listaTarer =	[[varbase TuttaTaxFiltrata] ListaTarsuEle];
	Tax_ele * tarser;
	NSMutableArray * listaCorrispondenti = [[NSMutableArray alloc] initWithCapacity : 40];
	for (int i = 0; i< listaTarer.count  ; i++) {
		tarser = [listaTarer objectAtIndex:i];
		if ([suber IndSePresente : [tarser Foglio] : [tarser Particella] : [tarser Sub] ]>=0)
		{	[listaCorrispondenti addObject:tarser];	}
	}
	
	if ((listaCorrispondenti.count>0) | ([sender selectedSegment]==1)) { suber.FlagTarsu = [sender selectedSegment]; }
	
	switch ([sender selectedSegment]) {
		case 0:
			for (int i = 0; i< listaCorrispondenti.count  ; i++) {
				tarser = [listaCorrispondenti objectAtIndex:i];		tarser.FlagAssociato=0;			}
			break;
		case 2:	case 3:
			for (int i = 0; i< listaCorrispondenti.count  ; i++) {
				tarser = [listaCorrispondenti objectAtIndex:i];		tarser.FlagAssociato=1;			}
			break;
	}
	
	[[barilectr ctrEdi] updaterighe];
	[[barilectr ctrTax] updaterighe];
	
}

- (IBAction) ApriDlgIcidaTarsu              : (id) sender       {
	Tax_ele * taxer = [[barilectr ctrTax] TarserSelezionato:NO];	if (taxer == nil) return;
	[[barilectr ctrTax]      impostaTarsuFoglioPartSub : [taxer Foglio] : [taxer Particella] : [taxer Sub]];
	[[bariledlg dlgICI]  orderFront:self];
	[[barilectr ctrTax] updaterighe];
}

- (IBAction) ApridlgAnagrafedaTarsu         : (id) sender       {
	Tax_ele * taxer = [[barilectr ctrTax] TarserSelezionato:YES];	if (taxer ==nil) return;
	[[barilectr ctrAnagrafe] impostaResidFiltInfoTaxer :[taxer CodFis]];
	[[bariledlg dlgAnagrafe]   orderFront:self];
}

- (IBAction) VaiGrafEdifdaTarsu             : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
    Tax_ele *tarser = [[barilectr ctrTax] TarserSelezionato:YES];  if (tarser ==nil) return;
	int indo =   [ azextra aproFoglio : [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
	    indo =  [  azextra aproFoglioA: [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
	    indo =  [  azextra aproFoglio0A: [tarser Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [tarser Particella]];	}
	if ([[varbase ListaSelezEdifici] count]<=0) NSBeep();
}

- (IBAction) ApridlgPossdaTarsu             : (id) sender       {
    Tax_ele *tarser = [[barilectr ctrTax] TarserSelezionato:YES];  if (tarser ==nil) return;
	[[barilectr ctrPossessori] impostainfopropieta :@""];
    [[barilectr ctrPossessori] impostaelencopossessori : [tarser Foglio] : [tarser Particella]: [tarser Sub]];
	[[bariledlg dlgPossessori]   orderFront:self];
}

- (IBAction) ApridlgEdifdaTarsu             : (id) sender       {
	Tax_ele * tarser = [[barilectr ctrTax] TarserSelezionato : YES];	if (tarser == nil) return;
	[[barilectr ctrEdi]     impostaFoglioPartSub :[tarser Foglio] :[tarser Particella] :[tarser Sub]];
	[[bariledlg dlgEdifici]	orderFront:self];
		//	[progetto display];
}


	// dlg Anagrafe

- (IBAction) ApriDlgAnagrafe                : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[barilectr ctrAnagrafe]       AttivaFiltro:NO];
	[[barilectr ctrAnagrafe] preimpostaBackinLista];
	[[bariledlg dlgAnagrafe]  orderFront:self];
	
}

- (IBAction) OkdlgAnagrafe                  : (id) sender       {
	[[bariledlg dlgAnagrafe]  orderOut:self];
}

- (IBAction) ApriDlgFiltriAnagrafe          : (id) sender       {
	[[barilectr ctrAnagrafe]       AttivaFiltro:YES];
	[[bariledlg dlgFiltriAnagrafe]	     orderFront:self];
}

- (IBAction) ApriDlgTarsudaAnagrafe         : (id) sender       {
	Famiglia * family =[[barilectr ctrAnagrafe]  subFamselezionato] ; if (family ==nil) return;
	[[barilectr ctrTax]      impostaCircaFamiglia: family ];
	[[bariledlg dlgTarsu]  orderFront:self];
}

- (IBAction) ApridlgPatrdaAnagrafe          : (id) sender       {
	Famiglia * family =[[barilectr ctrAnagrafe]  subFamselezionato] ; if (family ==nil) return;
	[[barilectr ctrPatrimonio] impostainfotitolo :@""];
    Proprietari * properFamily;
    Proprietari * proper;
	properFamily = [Proprietari alloc]; [properFamily initProprietario];
	Residente * resider;
	Patrimonio * patrim;
	for (int i=0; i<[[family ListaComponenti] count]; i++) {
		resider = [[family ListaComponenti] objectAtIndex:i];
		for (int j=0; j<[[varbase Listaproprietari] count]; j++) {
			proper = [[varbase Listaproprietari] objectAtIndex:j];
			if ([[resider codFis] isEqualToString :[proper Codfis]] ) {
				for (int k=0; k<[[proper ListaPatrimonio] count]; k++) {
					patrim = [[proper ListaPatrimonio] objectAtIndex:k];
					[[properFamily ListaPatrimonio] addObject:patrim];
				}
			}
		}
	}
	[[barilectr ctrPatrimonio] impostaFamigliaIntestataria: properFamily ];
	[[bariledlg dlgPatrimoni]  orderFront:self];
}

- (IBAction) VaiGrafEdifdaAnagrafe          : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
	Famiglia * family = [[barilectr ctrAnagrafe] subFamselezionato];	
	if (family==nil) return;
	if ([family associatoedif]) {
		int indo =  [ azextra aproFoglio : [family Foglio]];
		if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [family Particella]];	}
		indo =  [ azextra aproFoglioA: [family Foglio]];
		if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [family Particella]];	}
		indo =  [ azextra aproFoglio0A: [family Foglio]];
		if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [family Particella]];	}
	} 
	
}

- (IBAction) VaiTabellaEdifdaAnagrafe       : (id) sender       {
	Famiglia * family = [[barilectr ctrAnagrafe] subFamselezionato];		if (family==nil) return;
	[[barilectr ctrEdi]     impostaFoglioPartSub :[family Foglio] :[family Particella] :[family Sub]];
	if ([[[varbase TuttiImmobiliFiltrati] ListaSubalterni] count]==0) {
		[[barilectr ctrEdi] 	impostaConViadaAnag : [family Via ]];
	}
	[[bariledlg dlgEdifici]	orderFront:self];
}


	// dlg Filtro Anagrafe

- (IBAction) OkdlgFiltroAnag                : (id) sender       {
	[[bariledlg dlgFiltriAnagrafe]  orderOut:self];
	[[barilectr ctrAnagrafe] preimpostaBackinLista ];
}


    // dlg Attivita'

- (IBAction) ApriDlgAttivita                : (id) sender       {
	[[bariledlg dlgAttivita]  orderFront:self];
}

- (IBAction) OkdlgAttivita                  : (id) sender       {
	[[bariledlg dlgAttivita]  orderOut:self];
}


    // dlg Proprietari

- (IBAction) ApridlgProprietari             : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
    [[barilectr ctrProprietari] AttivaFiltro:NO];
	[[bariledlg dlgProprietari]  orderFront:self];
}

- (IBAction) OkdlgProprietari               : (id) sender       {
	[[bariledlg dlgProprietari]  orderOut:self];
}

- (IBAction) ApridlgPatrdaProprietari       : (id) sender       {
	Proprietari * proper = [[barilectr ctrProprietari] subselezionato];	if (proper ==nil) return;
	[[barilectr ctrPatrimonio] impostainfotitolo :[proper Infocompleto]];
	[[barilectr ctrPatrimonio] impostaintestatario :proper ];
	[[bariledlg dlgPatrimoni]  orderFront:self];
}


    // dlg Filtra Proprietari

- (IBAction) ApriDlgFiltraProprietari       : (id) sender       {
		//	[[interface ContrEdiFiltro]     inizTavole];
	[[barilectr ctrProprietari]	  AttivaFiltro:YES];
	[[bariledlg dlgFiltraProprietari] orderFront:self];
	
}

- (IBAction) OkDlgFiltraProprietari         : (id) sender       {
	[[bariledlg dlgFiltraProprietari] orderOut:self];
	
}


    // dlg Possessori

- (IBAction) OkdlgPossessori                : (id) sender       {
	[[bariledlg dlgPossessori]  orderOut:self];
}

- (IBAction) ApridlgPatrdaPossessori        : (id) sender       {
	Proprietari * proper = [[barilectr ctrPossessori] subselezionato];	if (proper ==nil) return;
	[[barilectr ctrPatrimonio] impostainfotitolo :[proper Infocompleto]];
	[[barilectr ctrPatrimonio] impostaintestatario :proper ];
	[[bariledlg dlgPatrimoni]  orderFront:self];
}


    // dlg Patrimonio

- (IBAction) OkdlgPatrimoni                 : (id) sender       {
	[[bariledlg dlgPatrimoni]  orderOut:self];
}

- (IBAction) ApridlgPossdaPatri             : (id) sender       {
	Patrimonio * pater = [[barilectr ctrPatrimonio] patselezionato];	if (pater == nil) return;
	[[barilectr ctrPossessori] impostainfopropieta :[pater Infocompleto]];
	[[barilectr ctrPossessori] impostaelepossessoriFT : [pater Foglio] : [pater Particella]: [pater Sub] : [pater TipoEdiTerra] ];
	[[bariledlg dlgPossessori]   orderFront:self];
}

- (IBAction) VaiGrafEdifdaPatrimAll         : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
	Proprietari               * LocIntestatario;
    if ([[barilectr ctrPatrimonio] inpatrimoniofamiliare]) { LocIntestatario =[[barilectr ctrPatrimonio] FamigliaIntestataria];}
	                                                  else { LocIntestatario =[[barilectr ctrPatrimonio] Intestatario];	}

	for (int i=0; i<[[LocIntestatario ListaPatrimonio] count]; i++)	{
		Patrimonio * pater = [[LocIntestatario ListaPatrimonio] objectAtIndex:i];	if (pater ==nil) return;
		int indo =  [ azextra aproFoglio : [pater Foglio]];
		if (indo>=0) { [azextra AddinListaParticellaNoDisplay: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
		indo =  [ azextra aproFoglioA: [pater Foglio]];
		if (indo>=0) { [azextra AddinListaParticellaNoDisplay: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
		indo =  [ azextra aproFoglio0A: [pater Foglio]];
		if (indo>=0) { [azextra AddinListaParticellaNoDisplay: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
	}
	[azextra zoommaEdifSelected];
	[progetto display];
}

- (IBAction) VaiGrafEdifdaPatrim            : (id) sender       {
	[[varbase ListaSelezEdifici]  removeAllObjects];
	Patrimonio * pater = [[barilectr ctrPatrimonio] patselezionato];	if (pater ==nil) return;
	int indo =  [ azextra aproFoglio : [pater Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
	indo =  [ azextra aproFoglioA: [pater Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
	indo =  [ azextra aproFoglio0A: [pater Foglio]];
	if (indo>=0) { [azextra AddinListaParticella: indo : [varbase ListaSelezEdifici] : [pater ParticellaSingola]];	}
}

- (IBAction) ApridlgImmodaPatrim            : (id) sender       {
	Patrimonio * pater = [[barilectr ctrPatrimonio] patselezionato];	if (pater == nil) return;
	if ([pater TipoEdiTerra]==0) {  // qui edifici
		[[barilectr ctrEdi]     impostaFoglioPartSub :[pater Foglio] :[pater Particella] :[pater Sub]];
		[[bariledlg dlgEdifici]	orderFront:self];
	}
	else  {   // qui terreni
		[[barilectr ctrTer]         ImpostaTerraFoglio   :[pater Foglio] :[pater Particella]];
		[[bariledlg dlgTerreni]  orderFront:self];
	}
	[progetto display];
}

- (IBAction) ApriVisuradaPatrimonio         : (id) sender       {
	PDFDocument   *pdfDoc;		
	NSString * Nomecompleto = nil;
	NSString *nomedirro;
	[[interface PdfViewVisura] setDocument:nil ];
	
	if (([[barilectr ctrProprietari] demoSensibili] ) | (![varbase  AutorizzatoDatiSensibili]))	{
		nomedirro = @"/MacOrMap/Catasto/visurademo.pdf"; 	
		pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: nomedirro ]];
		[[interface PdfViewVisura] setDocument:pdfDoc ];
		[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
		[[bariledlg dlgVisuraPdf] orderFront:self];
		return;
	}
	
	
	Patrimonio *patrdaVeder =   [[barilectr ctrPatrimonio] patselezionato];
	NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
	
	if ([patrdaVeder TipoEdiTerra]==0) 	{  // edificio
		[ParteSt appendFormat:	 @"_%@_%@_%@.",[patrdaVeder Foglio],[patrdaVeder Particella],[patrdaVeder Sub] ];
			// NSLog(@"- %@",ParteSt);
		nomedirro = @"/MacOrMap/Catasto/Fabbricati_pdf/"; 	
		NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
		bool trovato = NO;
		for (int j=0; j<contentsAtPath.count; j++) {  
			NSString *nomf = [contentsAtPath objectAtIndex:j];
			NSRange rg;
			rg = [nomf rangeOfString:ParteSt];
			if (rg.length>0) {
				Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
				pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
				[[interface PdfViewVisura] setDocument:pdfDoc ];
				[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
				trovato = YES;		break;
			}
	    }
			// eccezione per il fatto che la proprieta' e' indicata con mulitparticlla sub mentre a visura e' su un singolo
		if (!trovato) {
			NSMutableString *ParteSt2 = [[NSMutableString alloc] initWithCapacity:40];
			[ParteSt2 appendFormat:	 @"_%@_%@_%@.",[patrdaVeder FoglioSingolo],[patrdaVeder ParticellaSingola],[patrdaVeder SubSingolo] ];
			for (int j=0; j<contentsAtPath.count; j++) {  
				NSString *nomf = [contentsAtPath objectAtIndex:j];
				NSRange rg;
				rg = [nomf rangeOfString:ParteSt2];
				if (rg.length>0) {
					Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
					pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
					[[interface PdfViewVisura] setDocument:pdfDoc ];
					[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
					trovato = YES;		break;
				}
			}
				// lo cerco con un solo part, sub ma e' in nome multipart e multi sub
			if (!trovato) {
					// trovare l'immobile in lista immobili e da li trovare il pdf
				Subalterno * subero = [[barilectr ctrEdi] SubaltConFgPartSub : [patrdaVeder FoglioSingolo] : [patrdaVeder ParticellaSingola] : [patrdaVeder SubSingolo]  ] ;
				if (subero !=nil) {
					NSMutableString *ParteSt2 = [[NSMutableString alloc] initWithCapacity:40];
					[ParteSt2 appendFormat:	 @"_%@_%@_%@.",[subero Foglio],[subero Particella],[subero Sub] ];
					for (int j=0; j<contentsAtPath.count; j++) {  
						NSString *nomf = [contentsAtPath objectAtIndex:j];
						NSRange rg;
						rg = [nomf rangeOfString:ParteSt2];
						if (rg.length>0) {
							Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
							pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
							[[interface PdfViewVisura] setDocument:pdfDoc ];
							[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
							trovato = YES;		break;
						}
					}
				}
			}
				// lo cerco con un solo part, sub ma e' in nome multipart e multi sub  FINE
		}
		
	}  else {  // terreno
		[ParteSt appendFormat:	 @"_%@_%@.",[patrdaVeder Foglio],[patrdaVeder Particella] ];
		nomedirro = @"/MacOrMap/Catasto/Terreni_pdf/"; 	
		NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
		for (int j=0; j<contentsAtPath.count; j++) {  
			NSString *nomf = [contentsAtPath objectAtIndex:j];
			NSRange rg;
			rg = [nomf rangeOfString:ParteSt];
			if (rg.length>0) {
				Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
				pdfDoc = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: Nomecompleto ]];
				[[interface PdfViewVisura] setDocument:pdfDoc ];
				[[interface PdfViewVisura] setShouldAntiAlias:NO];		[[interface PdfViewVisura] setAutoScales:YES];
				break;
			}
			
		}	
		
		
	}
	
	if (Nomecompleto!=nil) [[bariledlg dlgVisuraPdf] setTitle:Nomecompleto]; else [[bariledlg dlgVisuraPdf] setTitle:@"Visura"];
	
	[[bariledlg dlgVisuraPdf] orderFront:self];
	
}


	// dlg cerca Particelle catastali

- (IBAction) ApriDlgCercaPart               : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[interface FinderFgPart]  removeAllItems];
	[[interface FinderFgPart2] removeAllItems];
    [[interface FinderFgPart]  addItemWithTitle:@"###"];
	[[interface FinderFgPart2] addItemWithTitle:@"###"];
	for (int i=0; i<[[[varbase TuttiImmobili] LTer] count]; i++) {
		Terreno    * terer = [[[varbase TuttiImmobili] LTer] objectAtIndex:i];
        [[interface FinderFgPart] addItemWithTitle:[terer Foglio]];
	}
	[[bariledlg dlgCercaFgPart]  orderFront:self];    
}

- (IBAction) OkdlgCercaPart                 : (id) sender       {
   	[[bariledlg dlgCercaFgPart]  orderOut:self];
	[[varbase ListaSelezTerreni]  removeAllObjects];
	NSMutableArray        * listaTererselez = [[NSMutableArray alloc] initWithCapacity:40];
	for (int i=0; i<[[[varbase TuttiImmobili] LTer] count]; i++) {
		Terreno    * terer = [[[varbase TuttiImmobili] LTer] objectAtIndex:i];
		if (([[terer Foglio] isEqualToString:[[interface FinderFgPart] titleOfSelectedItem ]]  )   & 
			([[terer Particella] isEqualToString:[[interface FinderFgPart2] titleOfSelectedItem ]]  )) 
		{ [listaTererselez addObject:terer]; }
	}
	[azextra AddinListaGruppoTerer: listaTererselez : [varbase ListaSelezTerreni] ];
}

- (IBAction) ImpostaFgCercaPart             : (id) sender       {
		//	NSLog(@"Foglio : %@",[[interface FinderFgPart] titleOfSelectedItem ]);
	[[interface FinderFgPart2] removeAllItems];
	for (int i=0; i<[[[varbase TuttiImmobili] LTer] count]; i++) {
		Terreno    * terer = [[[varbase TuttiImmobili] LTer] objectAtIndex:i];
		if ([[terer Foglio] isEqualToString:[[interface FinderFgPart] titleOfSelectedItem ]]) 
			[[interface FinderFgPart2] addItemWithTitle:[terer Particella]];
	}
}

- (IBAction) ChiudiDlgCercaPart             : (id) sender       {
   	[[bariledlg dlgCercaFgPart]  orderOut:self];
}

- (IBAction) ApriDlgCercaViaCiv             : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	[[interface FinderViaCiv]  removeAllItems];    [[interface FinderViaCiv]  addItemWithTitle:@"###"];
	[[interface FinderViaCiv2] removeAllItems];    [[interface FinderViaCiv2] addItemWithTitle:@"###"];
	NSMutableArray * listaVieloc = [[NSMutableArray alloc] initWithCapacity:200];	
	NSString * stvialoc;
	for (int i=0; i<[[[varbase TuttiImmobili] ListaSubalterni] count]; i++) {
		Subalterno   * suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:i];
		bool trovato = NO;
		for (int j=0; j<[listaVieloc count]; j++) {
			stvialoc = [listaVieloc objectAtIndex:j];
			if ([stvialoc isEqualToString: [suber Via] ]) {
				trovato=YES; break;
			}
 		}
	    if (!trovato) {	[listaVieloc addObject:[suber Via]];}
		
	}
	
	NSArray * listaord ;
	listaord = [listaVieloc sortedArrayUsingSelector:@selector(compare:)];  
	for (int j=0; j<[listaord count]; j++) {
		[[interface FinderViaCiv] addItemWithTitle: [listaord objectAtIndex:j] ];
	}
	
	
	[[bariledlg dlgCercaViaCiv]  orderFront:self];    
}

- (IBAction) OkdlgCercaViaCiv               : (id) sender       {
   	[[bariledlg dlgCercaViaCiv]  orderOut:self];
	
	[[varbase ListaSelezEdifici]  removeAllObjects];
	NSMutableArray        * listaEdifselez = [[NSMutableArray alloc] initWithCapacity:40];
	for (int i=0; i<[[[varbase TuttiImmobili] ListaSubalterni] count]; i++) {
		Subalterno    * suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:i];
		if (([[suber Via] isEqualToString:[[interface FinderViaCiv] titleOfSelectedItem ]]  ) 
			&   (([[[interface FinderViaCiv2] titleOfSelectedItem ] isEqualToString: @"Tutti"])  
				 | 	([[suber Civico] isEqualToString:[[interface FinderViaCiv2] titleOfSelectedItem ]]  ) ) 
			)
		{ [listaEdifselez addObject:suber]; }
	}
	[azextra AddinListaGruppoSuber: listaEdifselez : [varbase ListaSelezEdifici] ];
}

- (IBAction) ImpostaViaCercaSubalterno      : (id) sender       {
	NSMutableArray * listaCivloc = [[NSMutableArray alloc] initWithCapacity:100];	
	
	[[interface FinderViaCiv2] removeAllItems];
	[[interface FinderViaCiv2] addItemWithTitle:@"Tutti"];
	for (int i=0; i<[[[varbase TuttiImmobili] ListaSubalterni] count]; i++) {
		Subalterno    * suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:i];
		if ([[suber Via] isEqualToString:[[interface FinderViaCiv] titleOfSelectedItem ]]) 
			[listaCivloc addObject:[suber Civico]];
			//			[[interface FinderViaCiv2] addItemWithTitle:[suber Civico]];
	}
	NSArray * listaord ;
	listaord = [listaCivloc sortedArrayUsingSelector:@selector(compare:)];  
	for (int j=0; j<[listaord count]; j++) {
		[[interface FinderViaCiv2] addItemWithTitle: [listaord objectAtIndex:j] ];
	}
	
	
}

- (IBAction) ChiudiDlgCercaViaCiv           : (id) sender       {
   	[[bariledlg dlgCercaViaCiv]  orderOut:self];
}


    // dlg Griglia

- (IBAction) ApriDlgGriglia                 : (id) sender       {
	[[bariledlg dlgGriglia]  orderFront:self];
	varbase.inGriglia = YES;
	[progetto display];
}
  
- (IBAction) AttivaGriglia                  : (id) sender       {
	varbase.inGriglia = !varbase.inGriglia;
	[progetto display];
}

- (IBAction) OkdlgGriglia                   : (id) sender       {
	[[bariledlg dlgGriglia]  orderOut:self];
	[[interface ESGriglia]  setSelected:NO  forSegment:1];
}


    // dlg Password

- (IBAction) ApriDlgPassword                : (id) sender       {
	[[bariledlg DlgPassword] orderFront:self];
}

- (IBAction) OkDlgPassword                  : (id) sender       {
	[[bariledlg DlgPassword] orderOut:self];
	if ([[[interface txtPassword] stringValue] isEqualToString: @"2x3"]) {	varbase.AutorizzatoDatiSensibili = YES;	
		if ([varbase giacaricatoCat]) {    [varbase aprodatiSensibili];	}	
	} else NSBeep();
}


    // dlg Quantificatori

- (IBAction) ApriDlgQuantificatori          : (id) sender       {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	
	NSMutableString * st = [[NSMutableString alloc] initWithCapacity:400];
	
    int conta, contares;
	
	conta = [[[varbase anagrafe] ListaResidenti] count];
	[st appendFormat:@"Residenti Tot: %d \n",conta];
	conta = [[[varbase anagrafe] ListaFamiglie] count];
	[st appendFormat:@"Famiglie Tot:  %d \n",conta];
	
	
	conta = 0;
	contares =0;
	Famiglia  *family;
	for (int k=0; k<[[[varbase anagrafe] ListaFamiglie] count]; k++) {
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:k];
		if ([family associatoedif]) {
			conta++;	contares =	contares+[[family ListaComponenti] count];
		}
	}
	[st appendFormat:@"Residenti di cui conosco Casa: %d \n",contares];
	[st appendFormat:@"Famiglie  di cui conosco Casa: %d \n",conta];
	
	conta = 0;	contares =0;
	Subalterno * suber;
	for (int k=0; k<[[[varbase TuttiImmobili] ListaSubalterni] count]; k++) {
		suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex : k];
		if (![suber iscasa]) continue;
		conta ++;
		if ([suber Conferma]>=2) contares++;
	}
	[st appendFormat:@"--------------------\n"];
	[st appendFormat:@"Case presenti          : %d \n",conta];
	[st appendFormat:@"Case a cui corretto Indirizzo: %d \n",contares];
	
	
	
	[[interface txtdlgQuantificatori] setStringValue:st ];
	[[bariledlg dlgQuantificatori] orderFront:self];
	
}

- (IBAction) OkDlgQuantificatori            : (id) sender       {
	[[bariledlg dlgQuantificatori] orderOut:self];
	
}


	// dlg visura 

- (IBAction) ChiudiVisuraPdf                : (id) sender       {
	[[bariledlg dlgVisuraPdf] orderOut:self];
}


    // dlg Conferma

- (void)     ApriDlgConferma                : (int)codmsg       {
	if (codmsg==0)	[[interface stringa_conferma]  setStringValue:@"Chiudi Programma"];
	if (codmsg==1)	[[interface stringa_conferma]  setStringValue:@"Chiudi Gruppo Immagini"];
	if (codmsg==2)	[[interface stringa_conferma]  setStringValue:@"Chiudi Immagine"];
	if (codmsg==3)	[[interface stringa_conferma]  setStringValue:@"Chiudi Disegno"];
	[NSApp runModalForWindow: [bariledlg dlgConferma]];
}

- (IBAction) OKdlgConferma                  : (id) sender       {
	[varbase comando00];
	[NSApp stopModal]; [[bariledlg dlgConferma] orderOut:self]; 	varbase.rispostaconferma=YES;
}

- (IBAction) CanceldlgConferma              : (id) sender       {
	[varbase comando00]; [NSApp stopModal]; [[bariledlg dlgConferma] orderOut:self];	varbase.rispostaconferma=NO;
}


	// dlg legenda Immagine Raster
- (IBAction) OkDlgLegendaImmagine           : (id) sender       {
	[[bariledlg dlgLegenda] orderOut:self];
}


	// dlg simboli

- (IBAction) Apridlgsimboli                 : (id) sender       {
	[[bariledlg dlsimboli] orderFront:self];
}

- (IBAction) Chiudidlgsimboli               : (id) sender       {
	[[bariledlg dlsimboli] orderOut:self];
}





	// dlgWeb condizioni google e MacOrMap web site

- (IBAction) ApridlgGoogleCondizioni        : (id) sender       {
	[[bariledlg webusabile] orderFront:self];
	[[[bariledlg webcondizioni]  mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com/intl/it_it/help/terms_maps.html"]]];
}

- (IBAction) OKdlgGoogleCondizioni          : (id) sender       {
	[[bariledlg webusabile] orderOut:self];
}

- (IBAction) ApridlgWebMacOrMap             : (id) sender       {
	[[bariledlg webusabile] orderFront:self];
	[[[bariledlg webcondizioni]  mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.macormap.com/MacOrMap/MainPage.html"]]];
}


    // dlg Comandi amministrativi
- (IBAction) ApriDlgComandiamministrativi   : (id) sender       {
	[[bariledlg dlgComandiAmministrativi] orderFront:self];

}

- (IBAction) OKdlgComandiAmministrativi     : (id) sender       {
	[[bariledlg dlgComandiAmministrativi] orderOut:self];

}


	// dlg appunti

- (IBAction) OKdlgAppunti                   : (id) sender       {
	[[bariledlg dlgAppunti] orderOut:self];
}

- (IBAction) SalvaAppunti                   : (id) sender  {
	NSSavePanel *panel = [NSSavePanel savePanel];        [panel setFloatingPanel:YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"txt",nil] ];
	if([panel runModal] == NSOKButton){ 
		NSString *Str =[[NSString alloc] initWithString:[[interfacedlg AppuntiTxt] string]];
		[Str writeToFile :[panel filename] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
	}
}


@end
