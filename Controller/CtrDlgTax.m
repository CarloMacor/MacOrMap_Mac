//
//  CtrDlgTarsu.m
//  MacOrMap
//
//  Created by Carlo Macor on 17/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrDlgTax.h"
#import "Proprietari.h"


@implementation CtrDlgTax

@synthesize     filtroattivoTarsu;
@synthesize  	filtroattivoIci;

@synthesize     demoSensibili;
NSTableColumn * TableColumninEdit;
NSInteger       rowIndexinEdit;
int             maxbacks = 5;


- (Tax_ele *) TarserSelezionato : (bool) tarsTavola {
	Tax_ele * risulta;
	if (tarsTavola) {
	  int indsel = [TavolaTarsu selectedRow] ;
	  if (indsel<0) {	return nil;	}
	  if (filtroattivoTarsu) { risulta =  [ListaCtrTarsuFiltrata objectAtIndex:indsel];}
	                    else { risulta =  [ListaCtrTarsu objectAtIndex:indsel];}
	} else {
		int indsel = [TavolaIci selectedRow] ;
		if (indsel<0) {	return nil;	}
		if (filtroattivoIci) { risulta =  [ListaCtrIciFiltrata objectAtIndex:indsel];}
		else { risulta =  [ListaCtrIci objectAtIndex:indsel];}
	}
	return risulta;
}

- (void)      setTaxerselezionato : (Tax_ele *) taxer :  (bool) tarsTavola {
	NSUInteger indsel=-1;
	if (tarsTavola) {
		if (filtroattivoTarsu) {
		  for (int i=0; i<ListaCtrTarsuFiltrata.count; i++) {
			  if ([taxer isEqual: [ListaCtrTarsuFiltrata objectAtIndex:i]]) {	indsel=i; break; }	  }
		} else {
			for (int i=0; i<ListaCtrTarsu.count; i++) {
				if ([taxer isEqual: [ListaCtrTarsu objectAtIndex:i]]) {	indsel=i; break; }	  }  
		}
		if (indsel>=0) {
		 [TavolaTarsu selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		 [TavolaTarsu scrollRowToVisible:indsel];
		}
	} else {
		if (filtroattivoIci) {
			for (int i=0; i<ListaCtrIciFiltrata.count; i++) {
				if ([taxer isEqual: [ListaCtrIciFiltrata objectAtIndex:i]]) {	indsel=i; break; }	  }
		} else {
			for (int i=0; i<ListaCtrIci.count; i++) {
				if ([taxer isEqual: [ListaCtrIci objectAtIndex:i]]) {	indsel=i; break; }	  }  
		}
		if (indsel>=0) {
			[TavolaIci selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
			[TavolaIci scrollRowToVisible:indsel];
		}
	}
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView   {
	NSInteger risulta=0;
	if ([tableView isEqual:TavolaTarsu]) {
	  if (filtroattivoTarsu) { risulta = ListaCtrTarsuFiltrata.count; } else { risulta = ListaCtrTarsu.count; }
	}
	if ([tableView isEqual:TavolaIci]) {  
		if (filtroattivoIci) { risulta = ListaCtrIciFiltrata.count; } else { risulta = ListaCtrIci.count; }
	}
	return risulta;
}

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}


- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	NSMutableArray                   * ListaCtr;
	
	
	if ([tableView isEqual:TavolaTarsu]) {	if (filtroattivoTarsu) ListaCtr = ListaCtrTarsuFiltrata; else ListaCtr = ListaCtrTarsu;	}
	if ([tableView isEqual:TavolaIci])   {	if (filtroattivoIci) ListaCtr = ListaCtrIciFiltrata; else ListaCtr = ListaCtrIci;	}
	
		//	double           TaxDich;
		//	double           TaxPagata;
	
	
	if (rowIndex<ListaCtr.count) {
		Tax_ele    * el_tarsu = [ListaCtr objectAtIndex:rowIndex];
		if ([[tableColumn identifier] isEqualToString:   @"Cod"])         { [cell  setIntValue:(rowIndex+1)] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Nome"])        { 
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
			[cell  setStringValue:[el_tarsu  Nome         ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"CodFis"])      {
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
            [cell  setStringValue:[el_tarsu  CodFis       ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Fg"])          { [cell  setStringValue:[el_tarsu  Foglio       ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Part"])        { [cell  setStringValue:[el_tarsu  Particella   ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Sub"])         { [cell  setStringValue:[el_tarsu  Sub          ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"ConsCat"])     { [cell  setStringValue:[el_tarsu  ConsisCat    ]] ;	}

		if ([[tableColumn identifier] isEqualToString:   @"Via"])  { [cell  setStringValue:[el_tarsu  Via    ]] ;	}
	
		if ([[tableColumn identifier] isEqualToString:   @"Redd"])  { [cell  setStringValue:[el_tarsu TaxPagataStr     ]] ;	}

			//        { [cell  setStringValue:[NSString stringWithFormat:@"%@ n.%@",[el_tarsu  Via ],[el_tarsu  Civico]]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"nr"])          { [cell  setStringValue:[el_tarsu  Civico    ]] ;		}

		if ([[tableColumn identifier] isEqualToString:   @"SupDic"])      { [cell  setDoubleValue:[el_tarsu  SupDich    ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Controllo"])   { [cell  setState:[el_tarsu  FlagAssociato]] ;	}

	}
}



- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
	
	NSMutableArray                   * ListaAttiva;
	
	if ([tableView isEqual:TavolaTarsu]) {	if (filtroattivoTarsu) ListaAttiva = ListaCtrTarsuFiltrata; else ListaAttiva = ListaCtrTarsu;	}
	if ([tableView isEqual:TavolaIci])   {	if (filtroattivoIci) ListaAttiva = ListaCtrIciFiltrata; else ListaAttiva = ListaCtrIci;	}
	
	Tax_ele * IlloSelezionato = [self TarserSelezionato : [tableView isEqual:TavolaTarsu] ];


	if ([[tableColumn identifier] isEqualToString : @"Fg"]) { 
/*		FgCresce = !FgCresce;
		if (FgCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg2:)];     */
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg:)];      
		trovato = YES;
	}

	if ([[tableColumn identifier] isEqualToString : @"Nome"]) { 
/*		NomeCresce = !NomeCresce;
		if (NomeCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNome:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNome2:)];     
*/
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNome:)];      
		trovato = YES;
	}

	if ([[tableColumn identifier] isEqualToString : @"Via"]) { 
/*		ViaCresce = !ViaCresce;
		if (ViaCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareVia:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareVia2:)];      */
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareVia:)];      
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"CodFis"]) { 
/*		CodFisCresce = !CodFisCresce;
		if (CodFisCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCodfis:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCodfis2:)];     
*/
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCodfis:)];      
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"SupDic"]) { 
/*		SupDicCresce = !SupDicCresce;
		if (SupDicCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSupDic)];      
		else
 */
			sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSupDic2:)];     
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"Redd"]) { 
		/*		FgCresce = !FgCresce;
		 if (FgCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg:)];      
		 else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFg2:)];     */
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(Comparetaxpagata:)];      
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"ConsCat"]) { 
		sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSonsCat:)];      
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"Controllo"]) { 
		 FlagCresce= !FlagCresce;
		if (FlagCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFlagAssociato:)];      
		else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareFlagAssociato2:)];     
		trovato = YES;
	}
	
	
	
	if (trovato)		 {     [ListaAttiva removeAllObjects];
		[ListaAttiva setArray:sortedArray];
		if ([tableView isEqual:TavolaTarsu])	[TavolaTarsu noteNumberOfRowsChanged];
		if ([tableView isEqual:TavolaIci])      [TavolaIci noteNumberOfRowsChanged];
		if (IlloSelezionato!=nil) { [self setTaxerselezionato:IlloSelezionato : [tableView isEqual:TavolaTarsu] ]; }

    }
	
}



- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	TableColumninEdit = aTableColumn;
	rowIndexinEdit    = rowIndex;
	return YES;
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	Tax_ele * tarser = [self TarserSelezionato:YES];
    if ([[TableColumninEdit identifier] isEqualToString : @"Nome"])   {	 [tarser SetNome    : [fieldEditor string]];}
    if ([[TableColumninEdit identifier] isEqualToString : @"CodFis"]) {	[tarser SetCodFis  : [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Fg"])     {	[tarser SetFoglio  : [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Part"])   {	[tarser SetParticella: [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Sub"])    {	[tarser SetSub     : [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Via"])    {	[tarser SetVia     : [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"nr"]) {	[tarser SetCivico  : [fieldEditor string]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"ConsCat"]){	[tarser SetConsisCat : [fieldEditor string]]; }

    if ([[TableColumninEdit identifier] isEqualToString : @"SupDic"]){	[tarser SetSupDich :   [[fieldEditor string] doubleValue]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Redd"])  {	[tarser SetTaxDich :   [[fieldEditor string] doubleValue]]; }
    if ([[TableColumninEdit identifier] isEqualToString : @"Pagata"]){	[tarser SetTaxPagata : [[fieldEditor string] doubleValue]]; }
	
	return YES;
}

- (void)     updaterighe                                                                              {
	[TavolaTarsu noteNumberOfRowsChanged];
	[TavolaIci noteNumberOfRowsChanged];
}

- (void)     impostaListe : (Tax *) taxer   : (Tax *) taxerFilt                          {
	ListaCtrTarsu          = [taxer      ListaTarsuEle];
	ListaCtrTarsuFiltrata  = [taxerFilt  ListaTarsuEle];
	ListaCtrIci            = [taxer      ListaIciEle];
	ListaCtrIciFiltrata    = [taxerFilt  ListaIciEle];

	
	Listebacks     =   [[NSMutableArray alloc] initWithCapacity : 10] ;
    correnteback = 0;
	demoSensibili = NO;
	filtroattivoTarsu= NO;
	filtroattivoIci = NO;
}

- (void)     preimpostaBackinLista {
	Tax_ele      * tarser;
	NSMutableArray * newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaCtrTarsuFiltrata.count];
	for (int i=0; i<[ListaCtrTarsuFiltrata count]; i++) { tarser= [ListaCtrTarsuFiltrata objectAtIndex:i];	[newListaBack addObject:tarser];}
	
		// nel caso la corrente sia non 0 riportarla a 0
	
	if (correnteback>0) {
		NSArray * MovedListaBack = [Listebacks objectAtIndex:correnteback];
		[Listebacks removeObjectAtIndex:correnteback];
		[Listebacks  insertObject:MovedListaBack atIndex:0 ];
	}
	
		// loggare per test di cosa succede !
	
	
	
	[Listebacks insertObject:newListaBack atIndex:0];
	if (Listebacks.count>maxbacks ) {	[Listebacks removeObjectAtIndex:maxbacks];	}
	correnteback =0;

		//	NSLog(@"- - %d",Listebacks.count);
	
		//	for (int i=0; i<Listebacks.count; i++)	{NSLog(@"-  %d %d",i,[[Listebacks objectAtIndex:i] count]);	}
		 
}


- (void)     impostaTarsuFoglioPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub {
	if (ListaCtrTarsuFiltrata==nil) return;
	
	Tax_ele      * tarser;
	filtroattivoTarsu = YES;
	[ListaCtrTarsuFiltrata removeAllObjects];
	NSArray *  l_part = [nparticel componentsSeparatedByString:@","];
	NSArray *  l_sub  = [nomsub componentsSeparatedByString:@","];
	for (int i=0; i<[ListaCtrTarsu count]; i++) { 
		tarser= [ListaCtrTarsu objectAtIndex:i];
		if (![nfoglio isEqualToString:[tarser Foglio]] ) continue;
		for (int j=0; j<[l_part count]; j++) {
			if ([[l_part objectAtIndex:j] isEqualToString:[tarser Particella]] )  {	
				if (j< [l_sub count]) {
					if ([[l_sub objectAtIndex:j] isEqualToString:[tarser Sub]] ) {
						[ListaCtrTarsuFiltrata addObject:tarser]; break; 	}
				}
			}
		}
	}
	[self preimpostaBackinLista ];

	[self updaterighe];
}

- (void)     impostaIciFoglioPartSub : (NSString *) nfoglio :(NSString *) nparticel :(NSString *) nomsub {
	
}


- (NSArray * ) pezziNomeVia : (NSString * ) str {

	NSMutableArray * resulta = [[NSMutableArray alloc] initWithCapacity:10];
	NSString * locuploadString;
	NSMutableString * Locmutable =  [[NSMutableString alloc] initWithCapacity:100];
	char c ; 
	for (int i=0; i<[str length]; i++) {
		c=[str characterAtIndex:i];
		if ((c !=32) & (c!=39)) [Locmutable appendFormat: @"%C", c]; 
		else {		
 		  if ([Locmutable length]>3) {
			  if (([Locmutable isEqualToString:@"DELLA"] ) | ([Locmutable isEqualToString:@"DELLE"]) | ([Locmutable isEqualToString:@"PIAZZA"])
				  | ([Locmutable isEqualToString:@"VIALE"] ) | ([Locmutable isEqualToString:@"VICOLO"] ) | ([Locmutable isEqualToString:@"LARGO"] )
				  | ([Locmutable isEqualToString:@"BORGATA"] ) | ([Locmutable isEqualToString:@"CONTRADA"] ) |([Locmutable isEqualToString:@"LOCALITA'"] )
				  
				  ) {
			  } else {
				  locuploadString	= [[NSString alloc] initWithString:Locmutable ];
				  [resulta addObject:locuploadString];
			  }
			}
			[Locmutable setString:@""];
		  }
	}
	

 if ([Locmutable length]>3) {
		locuploadString	= [[NSString alloc] initWithString:Locmutable ];
		[resulta addObject:locuploadString];
		
	}

	return resulta;
}



- (void)     impostaCirca :  (Subalterno * ) suber  {
	if (ListaCtrTarsuFiltrata==nil) return;
	Tax_ele      * tarser;
	filtroattivoTarsu = YES;
	[ListaCtrTarsuFiltrata removeAllObjects];
	NSArray *  l_part     = [[suber Particella] componentsSeparatedByString:@","];
	NSArray *  l_Nomevia ;
	l_Nomevia = [self pezziNomeVia:[suber Via]];

	for (int i=0; i<[ListaCtrTarsu count]; i++) { 
		tarser= [ListaCtrTarsu objectAtIndex:i];
		if ([tarser FlagAssociato]>0) continue;
		bool fatto = NO;
		if ([[suber Foglio] isEqualToString:[tarser Foglio]] ) {
		 for (int j=0; j<[l_part count]; j++) {
			if ([[l_part objectAtIndex:j] isEqualToString:[tarser Particella]] )  {	[ListaCtrTarsuFiltrata addObject:tarser];  fatto = YES; break; }
		  }
		}
		NSRange rg;
     if (!fatto) {
			for (int j=0; j<l_Nomevia.count; j++) {
				
				rg = [[tarser Via] rangeOfString: [l_Nomevia objectAtIndex:j ] ];
				if (rg.length>0) {[ListaCtrTarsuFiltrata addObject:tarser];	break;}
			}
		}
	}

    [self preimpostaBackinLista ];
 
	[self updaterighe];
} 

- (void)     impostaCircaFamiglia : (Famiglia * ) family  {
	if (ListaCtrTarsuFiltrata==nil) return;
	filtroattivoTarsu = YES;
	[ListaCtrTarsuFiltrata removeAllObjects];
    Residente * resider;
	Tax_ele      * tarser;
	for (int i=0; i<[[family ListaComponenti] count]; i++) {
		resider = [[family ListaComponenti] objectAtIndex:i];
		for (int j=0; j<[ListaCtrTarsu count]; j++) { 
			tarser= [ListaCtrTarsu objectAtIndex:j];
            if ([[resider codFis] isEqualToString: [tarser CodFis]]) {
	         	[ListaCtrTarsuFiltrata addObject:tarser];
            }
		}
	}
	[self preimpostaBackinLista ];
	[self updaterighe];
} 


- (void)     setfiltro : (bool) modo {
	filtroattivoTarsu = modo;
	[self updaterighe];
}

- (IBAction)  EliminaRecord   : (id) sender   {
	Tax_ele * tarser = [self TarserSelezionato:YES];
	for (int i=0; i<ListaCtrTarsu.count; i++) {
		if ([tarser isEqual:[ListaCtrTarsu objectAtIndex:i]]) {	[ListaCtrTarsu removeObjectAtIndex:i];	break;	}
	}
	for (int i=0; i<ListaCtrTarsuFiltrata.count; i++) {
		if ([tarser isEqual:[ListaCtrTarsuFiltrata objectAtIndex:i]]) {	[ListaCtrTarsuFiltrata removeObjectAtIndex:i];	break;	}
	}
    [tarser release];
	[self updaterighe];
}

- (IBAction)  DuplicaRecord   : (id) sender   {
	Tax_ele * tarser = [self TarserSelezionato:YES];
	Tax_ele * newtarser =  [tarser duplica];
	[ListaCtrTarsu addObject:newtarser];
	[ListaCtrTarsuFiltrata addObject:newtarser];
	[self updaterighe];
}

- (IBAction)  BachingLista   : (id) sender    {
	Tax_ele      * tarser;
	filtroattivoTarsu = YES;

	switch ([sender selectedSegment]) {
		case 0 :  correnteback ++;  if (correnteback>=maxbacks)  correnteback=maxbacks-1;
			if (correnteback>= Listebacks.count) correnteback = Listebacks.count-1; 
			[ListaCtrTarsuFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				tarser= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrTarsuFiltrata addObject:tarser];
			}
			break;
		case 1 :  correnteback --;  if (correnteback<=0)  correnteback=0;
			[ListaCtrTarsuFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				tarser= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrTarsuFiltrata addObject:tarser];
			}
			break;
	}
	[self updaterighe];
		//	NSLog(@"- %d",correnteback);
}



@end
