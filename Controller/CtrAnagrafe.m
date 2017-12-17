//
//  CtrAnagrafe.m
//  MacOrMap
//
//  Created by Carlo Macor on 14/04/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrAnagrafe.h"


@implementation CtrAnagrafe
int           maxbacksanagList = 5;

@synthesize  demoSensibili;

- (void)     passaAnagrafe             : (Anagrafe *)  an  {
  	anagrafe =  an;
	solointestatari = NO;
	demoSensibili = NO;
	Listebacks     =   [[NSMutableArray alloc] initWithCapacity : 10] ;
    correnteback = 0;
}

- (void)     AttivaFiltro              : (bool )       bol {
	filtroattivo = bol;
	[[anagrafe ListaFamiglieFiltrata ] removeAllObjects];
	[[anagrafe ListaResidentiFiltrata] removeAllObjects];
	[[anagrafe ListaFamiglieFiltrata ] addObjectsFromArray:[anagrafe ListaFamiglie]];
	[[anagrafe ListaResidentiFiltrata ] addObjectsFromArray:[anagrafe ListaResidenti]];
	[self updaterighe];
}

- (NSInteger)numberOfRowsInTableView   :(NSTableView *)tableView    {

	if ([anagrafe ListaFamiglie] ==nil) return 0;
	int resulta =0;
		//	NSLog(@"Famiglie:%d Residenti:%d",[anagrafe ListaFamiglie].count,[anagrafe ListaResidenti].count);
	
	
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
	             else {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	
	
	if ([TavolaAnagrafe isEqual:tableView])	{
		if (solointestatari) resulta = ListaAttivaFam.count; 
		                else resulta = ListaAttivaRes.count;}
	

	famigliaselezionata = nil;
	if ([TavolaComponentiFamiglia isEqual:tableView])	{
		int selo = 	[TavolaAnagrafe selectedRow];
		Residente * resider; 
		bool deter = NO;
		if (selo>=0) {
		 if (solointestatari) { famigliaselezionata = [ListaAttivaFam objectAtIndex:selo]; }
	                     else { resider = [ListaAttivaRes objectAtIndex:selo];
			 for (int i=0; i<[[anagrafe ListaFamiglie] count]; i++) {
				 Famiglia    * family = [[anagrafe ListaFamiglie] objectAtIndex:i];
				 for (int j=0; j<[[family ListaComponenti] count]; j++) {

					 if ([resider isEqual:[[family ListaComponenti] objectAtIndex:j] ]) {
						 famigliaselezionata = family; deter = YES;
					 }
				 }
				 if (deter) break;
			 }
     	 }
		}
		if (famigliaselezionata!=nil) resulta = [[famigliaselezionata ListaComponenti] count]; else resulta =0;
	}
	
	return resulta;
}

- (id)       tableView                 :(NSTableView *)tableView 
			 objectValueForTableColumn :(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}


- (void)     tableView                 :(NSTableView *)tableView  
	         mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
	            else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	
	NSArray *sortedArrayFam; 	NSArray *sortedArrayRes; 
		Famiglia  * IlloFamSelezionato = [self subFamselezionato];
		Residente * IlloResSelezionato = [self subResselezionato];
	
		bool trovatoFam=NO;
		if ([[tableColumn identifier] isEqualToString : @"Via"]) { 
			sortedArrayFam = [ListaAttivaFam sortedArrayUsingSelector:@selector(CompareVia:)];      
			trovatoFam = YES;  }

        if ([[tableColumn identifier] isEqualToString : @"Nome"]) { 
			sortedArrayFam = [ListaAttivaFam sortedArrayUsingSelector:@selector(CompareNome:)];      
			trovatoFam = YES;  }
		if ([[tableColumn identifier] isEqualToString : @"Cognome"]) { 
			sortedArrayFam = [ListaAttivaFam sortedArrayUsingSelector:@selector(CompareCognome:)];      
			trovatoFam = YES;	}
		if ([[tableColumn identifier] isEqualToString : @"data"]) { 
			sortedArrayFam = [ListaAttivaFam sortedArrayUsingSelector:@selector(CompareData:)];      
			trovatoFam = YES;  }
	    if (trovatoFam)		 {     [ListaAttivaFam removeAllObjects];   [ListaAttivaFam setArray:sortedArrayFam]; }

	  bool trovatoRes=NO;
	  if ([[tableColumn identifier] isEqualToString : @"Via"]) { 
		sortedArrayRes = [ListaAttivaRes sortedArrayUsingSelector:@selector(CompareVia:)];      
		trovatoRes = YES;  }
	  if ([[tableColumn identifier] isEqualToString : @"Nome"]) { 
		sortedArrayRes = [ListaAttivaRes sortedArrayUsingSelector:@selector(CompareNome:)];      
		trovatoRes = YES;  }
	  if ([[tableColumn identifier] isEqualToString : @"Cognome"]) { 
		sortedArrayRes = [ListaAttivaRes sortedArrayUsingSelector:@selector(CompareCognome:)];      
		trovatoRes = YES;	}
	  if ([[tableColumn identifier] isEqualToString : @"data"]) { 
		sortedArrayRes = [ListaAttivaRes sortedArrayUsingSelector:@selector(CompareData:)];      
		trovatoRes = YES;  }
	  if (trovatoRes)		 {     [ListaAttivaRes removeAllObjects];
		[ListaAttivaRes setArray:sortedArrayRes];
	}

	[TavolaAnagrafe noteNumberOfRowsChanged];   
	[TavolaComponentiFamiglia noteNumberOfRowsChanged];  
	
	if (solointestatari) {	if (IlloFamSelezionato!=nil) { [self setFamselezionato:IlloFamSelezionato]; }	}
	                else {	if (IlloResSelezionato!=nil) { [self setResselezionato:IlloResSelezionato]; }	}
			
}


- (void)     tableView                 :(NSTableView *)tableView  
			 willDisplayCell           :(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {

	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
			if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
			            else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}

		//	NSLog(@"- Fam:%d Res:%d",ListaAttivaFam.count,ListaAttivaRes.count);

	
	if (![TavolaAnagrafe isEqual:tableView])	{
		Residente * resider = [ [famigliaselezionata ListaComponenti] objectAtIndex:rowIndex];
		if ([[tableColumn identifier] isEqualToString:   @"Nome"])     	{ [cell  setStringValue:[resider  Nome  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Cognome"])  	{
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
			[cell  setStringValue:[resider  Cognome  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"data"])    	{ 
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
             [cell  setStringValue:[resider  dataNascitaStr  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"CodFis"])  	{ 
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
			[cell  setStringValue:[resider  codFis  ]] ;		}
	} else {
	 if (solointestatari) {
		Famiglia    * family = [ListaAttivaFam objectAtIndex:rowIndex];
		if ([[tableColumn identifier] isEqualToString:   @"Via"])    	{ [cell  setStringValue:[family  Via  ]] ;		}
		if ([[tableColumn identifier] isEqualToString:   @"Nome"])     	{ [cell  setStringValue:[family  Nome1  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Cognome"])   {
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
               [cell  setStringValue:[family  Cognome1  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"N"])    	    { [cell  setStringValue:[family  nr  ]] ;		}
		if ([[tableColumn identifier] isEqualToString:   @"data"])    	{
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
              [cell  setStringValue:[family  dataNascitaStr1  ]] ;	}
	    if ([[tableColumn identifier] isEqualToString:   @"casa"])    	{ 
		  if ([family associatoedif])	[cell  setStringValue:@"*" ] ;	
		}
	 }
	 else {
		Residente * resider = [ListaAttivaRes objectAtIndex:rowIndex];
		if ([[tableColumn identifier] isEqualToString:   @"Nome"])     	{ [cell  setStringValue:[resider  Nome  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Cognome"])  	{ 
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
			[cell  setStringValue:[resider  Cognome  ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Via"])    	{ [cell  setStringValue:[resider  via ]] ;		}
		if ([[tableColumn identifier] isEqualToString:   @"N"])    	    { [cell  setStringValue:[resider  nr  ]] ;		}

			 //	    if ([[tableColumn identifier] isEqualToString:   @"N"])    	    { [cell  setStringValue:[resider  viaEstesa  ]] ;		}
		if ([[tableColumn identifier] isEqualToString:   @"data"])    	{ 
			if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
                [cell  setStringValue:[resider  dataNascitaStr  ]] ;	}
		 if ([[tableColumn identifier] isEqualToString:   @"casa"])    	{ 
			 if ([[resider famigliassociata] associatoedif])	[cell  setStringValue:@"*" ] ;	
		 }
		 
 	 }

	}
    
}


- (IBAction) ButInestatario            : (id)   sender {
	Famiglia * famsel = [self subFamselezionato];
	solointestatari = !solointestatari;
	[TavolaAnagrafe noteNumberOfRowsChanged];
	[TavolaComponentiFamiglia noteNumberOfRowsChanged];
	if (solointestatari) { [titoloresidenti setStringValue:@"Intestatari"];	} else
	{ [titoloresidenti setStringValue:@"Tutti i Residenti"];	}
	if (famsel!=nil) {
		if (solointestatari) {
			[self setFamselezionato:famsel];
		} else {
			[self setResselezionato:[[famsel ListaComponenti] objectAtIndex:0]];
		}
	}
}


- (void) setButIntestatari             : (bool) stato  {
	solointestatari = stato;
	if (solointestatari) { [titoloresidenti setStringValue:@"Intestatari"];	} else
	                     { [titoloresidenti setStringValue:@"Tutti i Residenti"];	}
	if (solointestatari) { [ButSolointestatari setState:NSOnState];	} else
                         { [ButSolointestatari setState:NSOffState];}
}

- (void)tableViewSelectionDidChange    :(NSNotification *) aNotification {
	[TavolaComponentiFamiglia noteNumberOfRowsChanged];    
}

- (Famiglia *)  subFamselezionato      {
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
	            else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	Famiglia * risulta=nil;
	int indsel = [TavolaAnagrafe selectedRow] ;
    if (solointestatari) {
       if (indsel>=0) {   risulta = [ListaAttivaFam objectAtIndex:indsel];   }
    } else {
		if (indsel>=0) {	risulta = [[ListaAttivaRes objectAtIndex:indsel] famigliassociata];}
	}

	return risulta;
}

- (Residente *) subResselezionato      {
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
	else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	
	Residente * risulta=nil;
	int indsel = [TavolaAnagrafe selectedRow] ;
    if (!solointestatari) {
		risulta = [ListaAttivaRes                                    objectAtIndex:indsel];
    }
	return risulta;
}


- (void)      setFamselezionato        : (Famiglia  *) fam {
	NSUInteger indsel=-1;
	for (int i=0; i<[anagrafe ListaFamiglie].count; i++) {
		if ([fam isEqual: [[anagrafe ListaFamiglie] objectAtIndex:i]]) {	indsel=i; break; }	}
	if (indsel>=0) {
		[TavolaAnagrafe selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaAnagrafe scrollRowToVisible:indsel];	}
}

- (void)      setResselezionato        : (Residente *) resid {
	NSUInteger indsel=-1;
	for (int i=0; i<[anagrafe ListaResidenti].count; i++) {
		if ([resid isEqual: [[anagrafe ListaResidenti] objectAtIndex:i]]) {	indsel=i; break; }	}
	if (indsel>=0) {
		[TavolaAnagrafe selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaAnagrafe scrollRowToVisible:indsel];	}
}


- (void)     preimpostaBackinLista     {
		//	return;
	
		////////////////    disattivata
		//	NSLog(@"---");

	Famiglia      * family;
	Residente     * resider;
	NSMutableArray * newListaBack;	
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	
			//		NSLog(@"potenzialmente immmetto famiglie %d ",[[anagrafe ListaFamiglieFiltrata] count]);

	} 
	            else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	
		 if (solointestatari) {
			 newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaAttivaFam.count];
				 //		 NSLog(@"immmetto famiglie %d ",[ListaAttivaFam count]);
			 for (int i=0; i<[ListaAttivaFam count]; i++) { family= [ListaAttivaFam objectAtIndex:i];	[newListaBack addObject:family];}		 
		 } else {
			 newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaAttivaRes.count];
				 //			 NSLog(@"immmetto residenti %d ",[ListaAttivaRes count]);
			 for (int i=0; i<[ListaAttivaRes count]; i++) { resider= [ListaAttivaRes objectAtIndex:i];	[newListaBack addObject:resider];}		
		 }

		//	[newListaBack retain];
	if (correnteback>0) {
		NSArray * MovedListaBack = [Listebacks objectAtIndex:correnteback];
		[Listebacks removeObjectAtIndex:correnteback];
		[Listebacks  insertObject:MovedListaBack atIndex:0 ];
	}
	[Listebacks insertObject:newListaBack atIndex:0]; 
	if (Listebacks.count>maxbacksanagList ) {
			//	NSArray * MovedListaBack = [Listebacks objectAtIndex:maxbacksanagList]; [MovedListaBack release];
		[Listebacks removeObjectAtIndex:maxbacksanagList];	}
	correnteback =0;
		//	NSLog(@"impostalista Nuova %d ",[newListaBack count]);

	for (int i=0; i<[Listebacks count]; i++) {
		newListaBack = [Listebacks objectAtIndex:i];
			//		NSLog(@"impostaliste %d %d",i,[newListaBack count]);
	}
	
}


- (void)     updaterighe               {
	[TavolaAnagrafe noteNumberOfRowsChanged];
	[TavolaComponentiFamiglia noteNumberOfRowsChanged];
}

- (void)     impostaResidFiltInfoEdif : (NSString *) fg :  (NSString *) part : (NSString *) sub  {
		//	solointestatari = NO; // impostaBottone;
	Famiglia * family;
	filtroattivo = YES;
	solointestatari = YES;
	[ButSolointestatari setState:NSOnState]; [titoloresidenti setStringValue:@"Intestatari"];
	[[anagrafe ListaFamiglieFiltrata] removeAllObjects];
	[[anagrafe ListaResidentiFiltrata] removeAllObjects];
	for (int i=0; i<[ [anagrafe ListaFamiglie] count]; i++) {
		family = [ [anagrafe ListaFamiglie]  objectAtIndex:i];
		if (([[family Foglio] isEqualToString : fg])&  ([[family Particella] isEqualToString : part]) &  ([[family Sub] isEqualToString : sub])	)	{
			[[anagrafe ListaFamiglieFiltrata] addObject:family];
			for (int j=0; j<[[family ListaComponenti] count]; j++) {[[anagrafe ListaResidentiFiltrata] addObject:[[family ListaComponenti] objectAtIndex:j]];	}
		}
	} 
    if ([[anagrafe ListaFamiglieFiltrata] count]>0)	[self preimpostaBackinLista];
	[self updaterighe];
}

- (void)     impostaResidFiltInfoViaNoassegnata: (NSString *) viasub {
	Famiglia * family;
	filtroattivo = YES;
	solointestatari = YES;
	[ButSolointestatari setState:NSOnState]; [titoloresidenti setStringValue:@"Intestatari"];
	[[anagrafe ListaFamiglieFiltrata] removeAllObjects];
	[[anagrafe ListaResidentiFiltrata] removeAllObjects];
	NSArray *  l_part     = [viasub componentsSeparatedByString:@","];

	NSRange rg;
	for (int i=0; i<[ [anagrafe ListaFamiglie] count]; i++) {
		family = [ [anagrafe ListaFamiglie]  objectAtIndex:i];
		if ([family associatoedif]) continue;
		
		for (int j=0; j<[l_part count]; j++) {
		  rg = [[family Via] rangeOfString: [l_part objectAtIndex:j ] ];
		  if (rg.length>0) {
			 [[anagrafe ListaFamiglieFiltrata ] addObject:family];
			 for (int j=0; j<[[family ListaComponenti] count]; j++) {[[anagrafe ListaResidentiFiltrata] addObject:[[family ListaComponenti] objectAtIndex:j]];
		   }
		  }
		 break;
		}
	}  
    if ([[anagrafe ListaFamiglieFiltrata] count]>0)	[self preimpostaBackinLista];
		//		[self preimpostaBackinLista];
	[self updaterighe];
} 


- (void)     impostaResidFiltInfoTaxer: (NSString *) codfiscale  {
	Famiglia  * family;
	Residente * resider;
	filtroattivo = YES;
	solointestatari = YES; 
	[ButSolointestatari setState:NSOnState]; [titoloresidenti setStringValue:@"Intestatari"];
	[[anagrafe ListaFamiglieFiltrata] removeAllObjects];
	[[anagrafe ListaResidentiFiltrata] removeAllObjects];
	for (int i=0; i<[ [anagrafe ListaFamiglie] count]; i++) {
		family = [ [anagrafe ListaFamiglie]  objectAtIndex:i];
		for (int j=0; j<[ [family ListaComponenti] count]; j++) {
			resider = [ [family ListaComponenti] objectAtIndex:j];
			if ([[resider codFis] isEqualToString : codfiscale])	{
				[[anagrafe ListaFamiglieFiltrata ] addObject:family];
								for (int k=0; k<[[family ListaComponenti] count]; k++) {[[anagrafe ListaResidentiFiltrata] addObject:[[family ListaComponenti] objectAtIndex:k]];	}
			}
		}
	}  
    if ([[anagrafe ListaFamiglieFiltrata] count]>0)	[self preimpostaBackinLista];
	[self updaterighe];
}


- (IBAction)  BachingLista            : (id) sender    {
	Famiglia  * family;
	Residente * resider;
	if (Listebacks.count<=0) return;
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	
	[ListaAttivaFam removeAllObjects];	                [ListaAttivaRes removeAllObjects];
	NSArray * passalista ; 
	filtroattivo = YES;
	switch ([sender selectedSegment]) {
		case 0 :  correnteback ++;  if (correnteback>=maxbacksanagList)  correnteback=maxbacksanagList-1;
			if (correnteback>= Listebacks.count) correnteback = Listebacks.count-1; 
			if (correnteback> Listebacks.count) return;
			passalista = [Listebacks objectAtIndex:correnteback];
			id testobj = [ passalista objectAtIndex:0];
			if ([testobj isKindOfClass:[Famiglia class]]) {	solointestatari =YES;} else {	solointestatari =NO;}
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
			   if (solointestatari) {
				   family= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];				   [ListaAttivaFam addObject:family];
			   } else {
				   resider = [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];				   [ListaAttivaRes addObject:resider];
			   }
			}
			break;
		case 1 :  correnteback --;  if (correnteback<=0)  correnteback=0;
			passalista = [Listebacks objectAtIndex:correnteback];
			id testobj2 = [ passalista objectAtIndex:0];
			if ([testobj2 isKindOfClass:[Famiglia class]]) {solointestatari =YES; } else {	solointestatari =NO;}
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				if (solointestatari) {
					family= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];				   [ListaAttivaFam addObject:family];
				} else {
					resider = [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];			   [ListaAttivaRes addObject:resider];
				}
            }
			break;
	}
	
	[self setButIntestatari:solointestatari];

		// ampliare automaticamente le  liste complementari
	if (solointestatari) {
		for (int i=0; i<[ListaAttivaFam count]; i++) { 
			family = [ListaAttivaFam objectAtIndex:i];
			for (int j=0; j<[[family ListaComponenti] count]; j++) { 
				resider = [[family ListaComponenti] objectAtIndex:j];
				[ListaAttivaRes addObject:resider];
			}
		}
	} else {
		for (int i=0; i<[ListaAttivaRes count]; i++) { 
			resider = [ListaAttivaRes objectAtIndex:i];
			bool found =NO;
			for (int j=0; j<[ListaAttivaFam count]; j++) { 
				family = [ListaAttivaFam objectAtIndex:j];
				if ([family isEqual:[resider famigliassociata]]) found = YES;
			}
			if (!found) {
				[ListaAttivaFam addObject:[resider famigliassociata]];
			}
		}
	}

	
		//	[self subFamselezionato:];
	
	[self updaterighe];
	
		//		NSLog(@"- Res:%d Fam:%d -", [ListaAttivaRes count],[ListaAttivaFam count]);
	
}


- (void)      riordinacognome         {
	NSMutableArray                   * ListaAttivaFam;	NSMutableArray                   * ListaAttivaRes;
	NSArray *sortedArrayFam; 	NSArray *sortedArrayRes; 

	if (filtroattivo) { ListaAttivaFam = [anagrafe ListaFamiglieFiltrata];	ListaAttivaRes = [anagrafe ListaResidentiFiltrata];	} 
	            else  {	ListaAttivaFam = [anagrafe ListaFamiglie];  		ListaAttivaRes = [anagrafe ListaResidenti];      	}
	
	  sortedArrayFam = [ListaAttivaFam sortedArrayUsingSelector:@selector(CompareCognome:)];      
  	  [ListaAttivaFam removeAllObjects];	  [ListaAttivaFam setArray:sortedArrayFam];
	  sortedArrayRes = [ListaAttivaRes sortedArrayUsingSelector:@selector(CompareCognome:)];      
	  [ListaAttivaRes setArray:sortedArrayRes];
}


@end
