//
//  Control_dlgVector.m
//  GIS2010
//
//  Created by Carlo Macor on 24/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrEdi.h"


@implementation CtrEdi

int           maxbacksEdiList = 5;

- (void)     ImpostaIcone           : (NSMutableArray *) iconeList {
	ListaIconeEdif = iconeList;
}

- (void)     impostaTuttiSubalterni : (Immobili  *) imb  : (Immobili  *) imbFilt        {
	ListaCtrSuber          = [imb      ListaSubalterni];
	ListaCtrSuberFiltrata  = [imbFilt  ListaSubalterni];
	Listebacks     =   [[NSMutableArray alloc] initWithCapacity : 10] ;
    correnteback = 0;

/*	
	Subalterno      * suber;
	if (ListaCtrSuber==nil) ListaCtrSuber = [[NSMutableArray alloc] init]; else	[ListaCtrSuber removeAllObjects];	
	for (int i=0; i<[imb  ListaSubalterni].count; i++) { suber= [[imb  ListaSubalterni] objectAtIndex:i];	[ListaCtrSuber addObject:suber];  }
	if (ListaCtrSuberFiltrata==nil) ListaCtrSuberFiltrata = [[NSMutableArray alloc] init];
	[ListaCtrSuberFiltrata removeAllObjects];	
*/	
}

- (void)     impostaElencoViaAnagrafe : (NSArray  *) listaVie  {
    for (int i=0; i<[listaVie count]; i++) {
        [CombVie addItemWithObjectValue:[listaVie objectAtIndex:i]];
    }
}


- (void)     AttivaFiltro           : (bool ) bol                  {
	filtroattivo = bol;
	[ButFilta setHidden:filtroattivo];
}

- (void)     AttivaSoloFiltro       : (bool ) bol                  {
	filtroattivo = bol;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView      {
	NSInteger risulta=0;
      if (filtroattivo) { risulta = ListaCtrSuberFiltrata.count;	} 
	               else { risulta = ListaCtrSuber.count;		    }
		//	  if (risulta<=2) risulta--;	
	return risulta;
}

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
	Subalterno * IlloSelezionato = [self subselezionato];

	NSMutableArray                   * ListaAttiva;
	if (filtroattivo) ListaAttiva = ListaCtrSuberFiltrata; else ListaAttiva = ListaCtrSuber;

	if ([[tableColumn identifier] isEqualToString : @"Fg"]) { 
		FgCresce = !FgCresce;
		if (FgCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg:)];      
		         else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Part"]) { 
		PartCresce = !PartCresce;
		if (PartCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(ComparePart:)];      
              	   else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(ComparePart2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Sub"]) { 
		SubCresce = !SubCresce;
		if (SubCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSub:)];      
	         	  else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSub2:)];     
		trovato = YES;
	}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Via"]) { 
		ViaCresce = !ViaCresce;
		if (ViaCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareVia:)];      
			      else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareVia2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"civico"]) 
	{  	sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCivico:)];   trovato = YES;}
	
	if ([[tableColumn identifier] isEqualToString : @"piano"]) 	{  
		PianoCresce = !PianoCresce;
		if (PianoCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(ComparePiano:)];      
	           	    else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(ComparePiano2:)];     
		trovato = YES;
	}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Cat"]) {
		CatCresce = !CatCresce;
		if (CatCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCat:)];      
		          else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCat2:)];     
        trovato = YES;
	}

	if ([[tableColumn identifier] isEqualToString : @"Cons"]) {
		ConsCresce = !ConsCresce;
		if (ConsCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCons:)];      
		           else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCons2:)];     
        trovato = YES;
	}

	if ([[tableColumn identifier] isEqualToString : @"cla"]) {
		ClasseCresce = !ClasseCresce;
		if (ClasseCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareClasse:)];      
		             else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareClasse2:)];     
        trovato = YES;
	}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Rendita"]) 
	{  rendCresce = !rendCresce;
		if (rendCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareRendita:)];      
		           else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareRendita2:)];     
		trovato = YES;
	}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Tarsu"]) 
	{  FlagTarsuCresce = !FlagTarsuCresce;
		if (FlagTarsuCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFlagTarsu:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFlagTarsu2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString:   @"R"])        { 
		 sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareResidenza:)];   
		trovato = YES;
	}
    
	if (trovato)		 {     [ListaAttiva removeAllObjects];
		[ListaAttiva setArray:sortedArray];
		if (IlloSelezionato!=nil) { [self setSuberselezionato:IlloSelezionato]; }
		[TavolaSubalterni noteNumberOfRowsChanged];
    }
	
}

- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	NSMutableArray                   * ListaCtr;
	if (filtroattivo) ListaCtr = ListaCtrSuberFiltrata; else ListaCtr = ListaCtrSuber;
		if (rowIndex<ListaCtr.count) {
            
            
			Subalterno    * suber = [ListaCtr objectAtIndex:rowIndex];
			if ([[tableColumn identifier] isEqualToString:   @"Nr"])        { [cell  setIntValue:(rowIndex+1)];}
            if ([[tableColumn identifier] isEqualToString:   @"Fg"])        { [cell  setStringValue:[suber  Foglio       ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"Part"])      { [cell  setStringValue:[suber  Particella   ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"Sub"])       { [cell  setStringValue:[suber  Sub          ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"Cat"])       { [cell  setStringValue:[suber  Categoria    ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"cla"])       { [cell  setStringValue:[suber  Classe       ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"Cons"])      { [cell  setStringValue:[suber  Consistenza  ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"Rendita"])   { [cell  setDoubleValue:[suber  Rendita      ]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"piano"])     { [cell  setStringValue:[suber  PianoEdificio]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"C"])        { if ([suber Conferma]>=2 ) { [cell  setStringValue:@"*"];}}
			if ([[tableColumn identifier] isEqualToString:   @"R"])        { 
				switch (suber.FlagAbitato) {
					case 0:[cell  setStringValue:@""];				break;
					case 1:[cell  setStringValue:@"1"];				break;
					case 2:[cell  setStringValue:@"2"];				break;
					case 5:[cell  setStringValue:@"K"];				break;
					default: [cell  setStringValue:@"#"];				break;
				}

			}

			if ([[tableColumn identifier] isEqualToString:   @"civico"])    {
                    //             if (suber.FlagCivico==3) { [cell setTextColor:[NSColor blueColor] ];    }
                [cell  setStringValue:[suber  Civico       ]] ;	
                    //                if (suber.FlagCivico==3) { [cell setTextColor:[NSColor blackColor] ];    }
            }
			if ([[tableColumn identifier] isEqualToString:   @"Via"])       {
                    //                if (suber.FlagVia==3) { [cell setTextColor:[NSColor blueColor] ];    }
                [cell  setStringValue:[suber  Via          ]] ;	
                    //                if (suber.FlagVia==3) { [cell setTextColor:[NSColor blackColor] ];    }
            }
		
			if ([[tableColumn identifier] isEqualToString:   @"Tarsu"])     { [cell  setSelectedSegment:[suber  FlagTarsu]] ;	}
			if ([[tableColumn identifier] isEqualToString:   @"ICI"])       { [cell  setSelectedSegment:[suber  FlagIci]] ;	}

            
            if ([[tableColumn identifier] isEqualToString:   @"Ico"])       { [cell  setImage :[ListaIconeEdif objectAtIndex:[suber codCat]]];};
		} else {
			if ([[tableColumn identifier] isEqualToString:   @"Rendita"])   {	  double tot=0;
				for (int i=0; i<ListaCtr.count; i++) { tot = tot + [ [ListaCtr objectAtIndex:i] Rendita]; }	 
				[cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ;	
			}
	
		}
}

- (void)     updaterighe                             {
	[TavolaSubalterni noteNumberOfRowsChanged];
}


- (void)     ImpostaFoglioPart    : (NSString *) nfoglio :(NSString *) nparticel                      {
	if (ListaCtrSuberFiltrata==nil) return;
	Subalterno      * suber;
	[self AttivaFiltro:YES];
	[ListaCtrSuberFiltrata removeAllObjects];	
	for (int i=0; i<ListaCtrSuber.count; i++) { 
		suber= [ListaCtrSuber objectAtIndex:i];	
		if ([suber inlistanomesub:nparticel])
		{ if ([nfoglio isEqualToString:[suber Foglio]] )   {	[ListaCtrSuberFiltrata addObject:suber];  
		} }
	}
	[self updaterighe];
}


- (Subalterno * ) SubaltConFgPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub {
	Subalterno * resulta=nil;
	Subalterno * suber;

	for (int i=0; i<[ListaCtrSuber count]; i++) { 
		suber= [ListaCtrSuber objectAtIndex:i];
	    if (![nfoglio isEqualToString:[suber Foglio] ] )  continue;

		NSArray *  l_part = [[suber Particella] componentsSeparatedByString:@","];
		NSArray *  l_sub  = [[suber Sub]        componentsSeparatedByString:@","];
		if ([l_part count]==1) {
			if (![nparticel isEqualToString:[suber Particella]] )  continue;
			for (int j=0; j<[l_sub count]; j++) { 
				if ([nomsub isEqualToString:[l_sub objectAtIndex:j]] ) {
					return suber;
				}
			}
		} else 
		{
		   for (int j=0; j<[l_part count]; j++) { 
			 if ([[l_part objectAtIndex:j] isEqualToString:nparticel] )  {	
				if (j>=[l_sub count]) {   }	else 
					{if ([[l_sub objectAtIndex:j] isEqualToString:nomsub] ) { return suber;  }	 
				}
			}
		   }
		} // else

	}
	
	return resulta;
}

- (void)     impostaFoglioPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub {
	if (ListaCtrSuberFiltrata==nil) return;
	if ( (nfoglio==nil) | (nparticel==nil) | (nomsub==nil) ) return;
	if ( (nfoglio==@"") | (nparticel==@""))  {	NSBeep(); return;	}
	Subalterno      * suber;
	[self AttivaFiltro:YES];
	[ListaCtrSuberFiltrata removeAllObjects];
	
	NSArray *  l_part = [nparticel componentsSeparatedByString:@","];
	NSArray *  l_sub  = [nomsub componentsSeparatedByString:@","];
	for (int i=0; i<[ListaCtrSuber count]; i++) { 
		suber= [ListaCtrSuber objectAtIndex:i];
		bool trovato = NO;
		if (![nfoglio isEqualToString:[suber Foglio]] ) continue;
		NSArray *  l_part_I = [[suber Particella] componentsSeparatedByString:@","];
		NSArray *  l_sub_I  = [[suber Sub] componentsSeparatedByString:@","];
		for (int j=0; j<[l_part count]; j++) { 
			for (int k=0; k<[l_part_I count]; k++) { 
				if (trovato) break;
				if ([[l_part objectAtIndex:j] isEqualToString:[l_part_I objectAtIndex:k]] )  {	
				if (trovato) break;
				if (j>=[l_sub   count]) continue;
				if (k>=[l_sub_I count]) continue;
				if ([[l_sub objectAtIndex:j] isEqualToString:[l_sub_I objectAtIndex:k]] )  {	
					[ListaCtrSuberFiltrata addObject:suber];  trovato = YES; break;
				}
			}
		  }
		}
	}
   [self updaterighe];
	[self preimpostaBackinLista];

}


- (void)     impostaConViadaAnag : (NSString *) via {
	if (ListaCtrSuberFiltrata==nil) return;
	Subalterno      * suber;
	[self AttivaFiltro:YES];	[ListaCtrSuberFiltrata removeAllObjects];
	for (int i=0; i<[ListaCtrSuber count]; i++) { 
		suber= [ListaCtrSuber objectAtIndex:i];
		if (![suber iscasa]) continue;
		if ([suber FlagAbitato]>0) continue;
		if ([via isEqualToString:[suber Via]] )  {[ListaCtrSuberFiltrata addObject:suber];  }
	}
	[self updaterighe];
	[self preimpostaBackinLista];
}


- (int)      indiceprimoselezionato                  {
	return [TavolaSubalterni selectedColumn] ;
}


- (Subalterno *) subselezionato {
	Subalterno * risulta=nil;
	int indsel = [TavolaSubalterni selectedRow] ;
	
	if (filtroattivo) {
		if ([ListaCtrSuberFiltrata count]==1) {  indsel =0;	}
		else { if (indsel == ([ListaCtrSuberFiltrata count])) return nil;	}

		if (indsel<0) risulta=nil;	else  risulta = [ListaCtrSuberFiltrata objectAtIndex:indsel];
	} else {
		if ([ListaCtrSuber count]==1) {  indsel =0;	}
		else { if (indsel == ([ListaCtrSuber count])) return nil;	}
		if (indsel<0) risulta=nil;	else  risulta = [ListaCtrSuber objectAtIndex:indsel];	}
	return risulta;
}

- (NSArray *)    SubSelezionati {
	NSMutableArray * risulta;
	NSInteger Into; 
	NSIndexSet * selectedRow  = [TavolaSubalterni selectedRowIndexes];
	if ([selectedRow count ]<=0)  return risulta;
	risulta = [[NSMutableArray alloc] init];
	Into = [selectedRow firstIndex];
	for (int j=0; j<   [selectedRow count ]; j++) { 
		if (filtroattivo) {  if (Into<[ListaCtrSuberFiltrata count]) [risulta addObject:[ListaCtrSuberFiltrata objectAtIndex:Into]   ];	}
		             else {	 if (Into<[ListaCtrSuber         count]) [risulta addObject:[ListaCtrSuber objectAtIndex:Into]   ]; };
		Into = [selectedRow indexGreaterThanIndex:Into];
	}
	
	return risulta;
}

- (void)      setSuberselezionato : (Subalterno *) sub {
	NSUInteger indsel=-1;
	NSMutableArray                   * ListaAttiva;
	if (filtroattivo) ListaAttiva = ListaCtrSuberFiltrata; else ListaAttiva = ListaCtrSuber;
	for (int i=0; i<ListaAttiva.count; i++) {
		if ([sub isEqual: [ListaAttiva objectAtIndex:i]]) {	indsel=i; break; }
	}
	if (indsel>=0) {
		[TavolaSubalterni selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaSubalterni scrollRowToVisible:indsel];
	}
}



- (IBAction) ElencoVieTxtCatasto            : (id)sender        {
 	NSMutableString *Strout= [[NSMutableString alloc] initWithCapacity:40000];	
    NSString *nomeLastvia=@"";
    int numcaseVia=0;
    int numImmobiliVia=0;

    int lungcarvia=0;
    int numvie =0;
    int totCase;
    int totImmobili=0;

    bool primacasa=YES;
        //    Subalterno    * suber = [ListaCtr objectAtIndex:rowIndex];

    [Strout appendString:@"Elenco strade presenti in Catasto: \n"];
    totCase = [ListaCtrSuberFiltrata count];
    for (int i=0; i<[ListaCtrSuberFiltrata count]; i++) {
        Subalterno    * suber = [ListaCtrSuberFiltrata objectAtIndex:i];

        
            //        totabitanti = totabitanti+[family numcomponenti];
        if ([[suber Via] isEqualToString: nomeLastvia]) {
            numcaseVia = numcaseVia+1;
            numImmobiliVia = numImmobiliVia+1;
            totImmobili = totImmobili+1;
        }
        else {         // prima quantifichiamo
            if (!primacasa) { 
                for (int j=1;   j<=(50- lungcarvia); j++) { [Strout appendString:@" "]; }
                [Strout appendFormat:@" Case: %3d        sub: %4d",numcaseVia,numImmobiliVia];      }
            [Strout appendString:@"\n"]; [Strout appendString:[suber Via]]; 
            lungcarvia = [[suber Via] length]; 
            numvie = numvie+1;
            totImmobili = totImmobili+1;
            numcaseVia =1;
            numImmobiliVia =1;
            [nomeLastvia release]; nomeLastvia = [suber  Via  ];
            primacasa =NO;
        }
    }
    
    for (int j=1;   j<=(50- lungcarvia); j++) { [Strout appendString:@" "]; }
    
    [Strout appendFormat:@" Case: %3d        sub: %4d",numcaseVia,numImmobiliVia];     
    [Strout appendString:@"\n"];
    [Strout appendString:@"\n\n"];
    [Strout appendFormat:@" Totale Vie                 : %4d",numvie];  [Strout appendString:@"\n"];
    [Strout appendFormat:@" Totale Immobili nel comune : %4d",totImmobili];  [Strout appendString:@"\n"];
    [Strout appendFormat:@" Totale Case     nel comune : %4d",totCase];  [Strout appendString:@"\n"];
    
    
	[Strout writeToFile :@"/MacOrMap/Catasto/VieCatasto.txt" atomically:YES encoding:NSASCIIStringEncoding error:NULL];
    
  
}


- (IBAction) CambiaCivico                   : (id)sender {
	NSMutableArray                   * ListaCtr;
	if (filtroattivo) ListaCtr = ListaCtrSuberFiltrata; else ListaCtr = ListaCtrSuber;
    NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaSubalterni selectedRowIndexes];
	if (listaselected.count>0) {
        illo = [listaselected firstIndex]; 
        if (illo<ListaCtr.count) {
            Subalterno    * suber = [ListaCtr objectAtIndex:illo];
            [suber setCivico : [NewCiv stringValue]     ];
			suber.Conferma +=4; // FlagCivico =3;  // 3 = cambiato // 2 = confermato

        }
    }
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];
        if (illo<ListaCtr.count) {
            Subalterno    * suber = [ListaCtr objectAtIndex:illo];
            [suber setCivico : [NewCiv stringValue] ];
			suber.Conferma +=4;	//            suber.FlagCivico =3;  // 3 = cambiato // 2 = confermato
            
        }
	}
    [self updaterighe];

}

- (IBAction) CambiaVia                      : (id)sender {
 	NSMutableArray                   * ListaCtr;
	if (filtroattivo) ListaCtr = ListaCtrSuberFiltrata; else ListaCtr = ListaCtrSuber;
    NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaSubalterni selectedRowIndexes];
	if (listaselected.count>0) {
        illo = [listaselected firstIndex]; 
        if (illo<ListaCtr.count) {
            Subalterno    * suber = [ListaCtr objectAtIndex:illo];
            [suber setVia : [CombVie stringValue]     ];
			suber.Conferma += 2;  // 3 = cambiato // 2 = confermato
        }
    }
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];
        if (illo<ListaCtr.count) {
            Subalterno    * suber = [ListaCtr objectAtIndex:illo];
            [suber setVia:[CombVie stringValue]     ];
			suber.Conferma +=2;	//            suber.FlagVia =3;  // 3 = cambiato // 2 = confermato
        }
	}
    [self updaterighe];

}


- (IBAction) ShowdlgEditViaCivico    : (id)  sender {
    [ PanelEditViaCivico orderFront:self];
}


- (IBAction) OKdlgEditViaCivico      : (id)  sender {
    [ PanelEditViaCivico orderOut:self];
    [self updaterighe];
}

- (IBAction) AzioButInEdit           : (id)  sender {
    inFaseEdit = !inFaseEdit;
	[ButInEdit setState:inFaseEdit];
}

- (IBAction) AzioButInTarsu          : (id)  sender {
	inFaseTarsu = !inFaseTarsu;
	[ButInTarsu setState:inFaseTarsu];
	NSTableColumn * colonnaTarsu = [TavolaSubalterni tableColumnWithIdentifier:@"Tarsu"];
	NSRect windowFrame = 	[PannelloTutto frame];
	if (inFaseTarsu ) {	[colonnaTarsu setHidden:NO]; windowFrame.size.width  += 66;	} else
	                  {	[colonnaTarsu setHidden:YES];windowFrame.size.width  -= 66;	}
	[PannelloTutto setFrame: windowFrame display:YES ];
}

- (IBAction) AzioButInIci            : (id)  sender {
	inFaseICI = !inFaseICI;
	[ButInIci setState:inFaseICI];
	NSTableColumn * colonnaIci = [TavolaSubalterni tableColumnWithIdentifier:@"ICI"];
	NSRect windowFrame = 	[PannelloTutto frame];
	if (inFaseICI ) {	[colonnaIci setHidden:NO]; windowFrame.size.width  += 80;	} else
	                {	[colonnaIci setHidden:YES];windowFrame.size.width  -= 80;	}
	[PannelloTutto setFrame: windowFrame display:YES ];
}

- (IBAction) AzioButInConferma       : (id)  sender {
	inFaseConferma = !inFaseConferma;
		//	[ButInTarsu setState:inFaseTarsu];
	NSTableColumn * colonnaConferma = [TavolaSubalterni tableColumnWithIdentifier:@"C"];
	NSRect windowFrame = 	[PannelloTutto frame];
	if (inFaseConferma ) {	[colonnaConferma setHidden:NO]; windowFrame.size.width  += 24;	} else
	{	[colonnaConferma setHidden:YES];windowFrame.size.width  -= 24;	}
	[PannelloTutto setFrame: windowFrame display:YES ];
}

- (IBAction) AzioButInAbitato       : (id)  sender {
	inFaseAbitato = !inFaseAbitato;
	NSTableColumn * colonnaConferma = [TavolaSubalterni tableColumnWithIdentifier:@"R"];
	NSRect windowFrame = 	[PannelloTutto frame];
	if (inFaseAbitato ) {	[colonnaConferma setHidden:NO]; windowFrame.size.width  += 24;	} else
	{	[colonnaConferma setHidden:YES];windowFrame.size.width  -= 24;	}
	[PannelloTutto setFrame: windowFrame display:YES ];
}


- (IBAction) AzioButInwork            : (id)  sender {
	switch ([sender selectedSegment]) {
		case 0: [self AzioButInIci     :self];    break;
		case 1: [self AzioButInTarsu   :self];    break;
		case 2: [self AzioButInConferma:self];    break;
		case 3: [self AzioButInAbitato:self];    break;
	}	
}

- (IBAction) FiltraSoloCase          : (id)  sender {
	NSArray * ListaLoc;
	Subalterno      * suber;
	Subalterno * IlloSelezionato = [self subselezionato];

	if (filtroattivo) ListaLoc = [[NSArray alloc] initWithArray:ListaCtrSuberFiltrata]; 
	             else ListaLoc = [[NSArray alloc] initWithArray:ListaCtrSuber];  
	[ListaCtrSuberFiltrata removeAllObjects];	
	for (int i=0; i<[ListaLoc count]; i++) {
		suber= [ListaLoc objectAtIndex:i];
		if ([suber iscasa]) {
			[ListaCtrSuberFiltrata addObject:suber];
		}
	}
	[self AttivaFiltro:YES];
	if (IlloSelezionato!=nil) { [self setSuberselezionato:IlloSelezionato]; }

	[self updaterighe];
	[self preimpostaBackinLista];
}


- (void)     preimpostaBackinLista {
	Subalterno      * suber;

	NSMutableArray * newListaBack;	
	if (filtroattivo) {
		newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaCtrSuberFiltrata.count];
		for (int i=0; i<[ListaCtrSuberFiltrata count]; i++) { suber= [ListaCtrSuberFiltrata objectAtIndex:i];	[newListaBack addObject:suber];}
	}
	else {
		newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaCtrSuber.count];
		for (int i=0; i<[ListaCtrSuber count]; i++) { suber= [ListaCtrSuber objectAtIndex:i];	[newListaBack addObject:suber];}
	}
	
		// nel caso la corrente sia non 0 riportarla a 0
	
	if (correnteback>0) {
		NSArray * MovedListaBack = [Listebacks objectAtIndex:correnteback];
		[Listebacks removeObjectAtIndex:correnteback];
		[Listebacks  insertObject:MovedListaBack atIndex:0 ];
	}
	
		// loggare per test di cosa succede !
	
	
	
	[Listebacks insertObject:newListaBack atIndex:0];
	if (Listebacks.count>maxbacksEdiList ) {	[Listebacks removeObjectAtIndex:maxbacksEdiList];	}
	correnteback =0;
	
}


- (IBAction)  BachingLista   : (id) sender    {
	Subalterno      * suber;
	if (Listebacks.count<=0) return;
	filtroattivo = YES;
	switch ([sender selectedSegment]) {
		case 0 :  correnteback ++;  if (correnteback>=maxbacksEdiList)  correnteback=maxbacksEdiList-1;
			if (correnteback>= Listebacks.count) correnteback = Listebacks.count-1; 
			[ListaCtrSuberFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				suber= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrSuberFiltrata addObject:suber];
			}
			break;
		case 1 :  correnteback --;  if (correnteback<=0)  correnteback=0;
			[ListaCtrSuberFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				suber= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrSuberFiltrata addObject:suber];
			}
			break;
	}
	[self updaterighe];
		//	NSLog(@"- %d %d",correnteback,Listebacks.count);
}




@end
