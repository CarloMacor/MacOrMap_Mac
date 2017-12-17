//
//  Control_Terreni.m
//  MacOrMap
//
//  Created by Carlo Macor on 02/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrTer.h"
#import "DisegnoV.h"



@implementation CtrTer

int           maxbacksTerList = 5;

- (void)     impostaTuttiTerreni : (Immobili  *) imb   : (Immobili  *) imbFilt         {
	ListaCtrTer          = [imb      LTer];
	ListaCtrTerFiltrata  = [imbFilt  LTer];
	Listebacks     =   [[NSMutableArray alloc] initWithCapacity : 10] ;
    correnteback = 0;

}

- (void)     AttivaFiltro        : (bool ) bol                                         {
	filtroattivo = bol;
}

- (void)     AttivaSoloFiltro       : (bool ) bol                                      {
	filtroattivo = bol;
}



- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView   {
	NSInteger risulta=0;
	if (filtroattivo) { risulta = ListaCtrTerFiltrata.count+1; } else { risulta = ListaCtrTer.count+1; }
	if (risulta<=2) risulta--;	
	return risulta;
}

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
	Terreno * IlloSelezionato = [self subselezionato];

	NSMutableArray                   * ListaAttiva;
	if (filtroattivo) ListaAttiva = ListaCtrTerFiltrata; else ListaAttiva = ListaCtrTer;

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
	
	if ([[tableColumn identifier] isEqualToString : @"Qualita"]) { 
		QlCresce = !QlCresce;
		if (QlCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareQl:)];      
		         else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareQl2:)];     
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"Classe"]) { 
		ClCresce = !ClCresce;
		if (ClCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCl:)];      
				 else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCl2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Superficie"]) { 
		SupCresce = !SupCresce;
		if (SupCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSup:)];      
		          else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareSup2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Domenicale"]) { 
		DomCresce = !DomCresce;
		if (DomCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareDom:)];      
		          else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareDom2:)];     
		trovato = YES;
	}
    if ([[tableColumn identifier] isEqualToString : @"Agraria"]) { 
         AgraCresce = !AgraCresce;
         if (AgraCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareAg:)];      
                    else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareAg2:)];     
         trovato = YES;
    }
	
	
	if (trovato)		 {     [ListaAttiva removeAllObjects];
		[ListaAttiva setArray:sortedArray];
		[TavolaTerreni noteNumberOfRowsChanged];
		if (IlloSelezionato!=nil) { [self setTerselezionato:IlloSelezionato]; }
    }
	
}

- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	NSMutableArray                   * ListaCtr;
	if (filtroattivo) ListaCtr = ListaCtrTerFiltrata; else ListaCtr = ListaCtrTer;

	if (rowIndex<ListaCtr.count) {
		Terreno    * terer = [ListaCtr objectAtIndex:rowIndex];
		if ([[tableColumn identifier] isEqualToString:   @"Nr"])         { [cell  setIntValue:(rowIndex+1)] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Fg"])         { [cell  setStringValue:[terer  Foglio     ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Part"])       { [cell  setStringValue:[terer  Particella ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Qualita"])    { [cell  setStringValue:[terer  Qualita    ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Classe"])     { [cell  setStringValue:[terer  Classe     ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Zona"])       { [cell  setStringValue:[terer  Zona     ]] ;	}
		if ([[tableColumn identifier] isEqualToString:   @"Superficie"]) { [cell  setIntValue:   [terer  Superficie]];	}
		if ([[tableColumn identifier] isEqualToString:   @"Domenicale"]) { [cell  setDoubleValue:[terer  Renditadomenicale]];  }
		if ([[tableColumn identifier] isEqualToString:   @"Agraria"])    { [cell  setDoubleValue:[terer  Renditaagraria]];	  }
	}
	else {
		if ([[tableColumn identifier] isEqualToString:   @"Superficie"])   { double tot=0;
		  for (int i=0; i<ListaCtr.count; i++) { tot = tot + [ [ListaCtr objectAtIndex:i] Superficie]; }	      
		  [cell  setDoubleValue:tot ]; }
		if ([[tableColumn identifier] isEqualToString:   @"Domenicale"])   { double tot=0;
			for (int i=0; i<ListaCtr.count; i++) { tot = tot + [ [ListaCtr objectAtIndex:i] Renditadomenicale]; }  
			[cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ; }
		if ([[tableColumn identifier] isEqualToString:   @"Agraria"])   { double tot=0;
			for (int i=0; i<ListaCtr.count; i++) { tot = tot + [ [ListaCtr objectAtIndex:i] Renditaagraria]; }	   
			[cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ; }
	}
}

- (void)     updaterighe                                                              {
	[TavolaTerreni noteNumberOfRowsChanged];
}


- (void)     ImpostaTerraFoglio :(NSString *) nfoglio :(NSString *) nparticel         {
	Terreno      * terer;
	[self AttivaFiltro:YES];
	if (ListaCtrTerFiltrata==nil) ListaCtrTerFiltrata = [[NSMutableArray alloc] init];
	[ListaCtrTerFiltrata removeAllObjects];	
    for (int i=0; i<ListaCtrTer.count; i++) { 
		terer= [ListaCtrTer objectAtIndex:i];
		if ([terer inlistanomepart:nparticel] ) {
			if ([ [terer  Foglio] isEqualToString:nfoglio] ) {	[ListaCtrTerFiltrata addObject:terer];  }
		}
	}
	[self updaterighe];
	[self preimpostaBackinLista];
	
		//	NSLog(@"Passo di qui");

}

- (void)     preimpostaBackinLista {
	Terreno      * terer;
	NSMutableArray * newListaBack;
	
	if (filtroattivo) {
		newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaCtrTerFiltrata.count];
		for (int i=0; i<[ListaCtrTerFiltrata count]; i++) { terer= [ListaCtrTerFiltrata objectAtIndex:i];	[newListaBack addObject:terer];}
      }
	else {
		newListaBack = [[NSMutableArray alloc] initWithCapacity:ListaCtrTer.count];
		for (int i=0; i<[ListaCtrTer count]; i++) { terer= [ListaCtrTer objectAtIndex:i];	[newListaBack addObject:terer];}
	}
	
		// nel caso la corrente sia non 0 riportarla a 0
	
	if (correnteback>0) {
		NSArray * MovedListaBack = [Listebacks objectAtIndex:correnteback];
		[Listebacks removeObjectAtIndex:correnteback];
		[Listebacks  insertObject:MovedListaBack atIndex:0 ];
	}
	
		// loggare per test di cosa succede !
	
	
	
	[Listebacks insertObject:newListaBack atIndex:0];
	if (Listebacks.count>maxbacksTerList ) {	[Listebacks removeObjectAtIndex:maxbacksTerList];	}
	correnteback =0;
	
		//	NSLog(@"- %d",Listebacks.count);
	
}


- (IBAction)  BachingLista   : (id) sender    {
	Terreno      * terer;
	filtroattivo = YES;

	switch ([sender selectedSegment]) {
		case 0 :  correnteback ++;  if (correnteback>=maxbacksTerList)  correnteback=maxbacksTerList-1;
			if (correnteback>= Listebacks.count) correnteback = Listebacks.count-1; 
			[ListaCtrTerFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				terer= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrTerFiltrata addObject:terer];
			}
			break;
		case 1 :  correnteback --;  if (correnteback<=0)  correnteback=0;
			[ListaCtrTerFiltrata removeAllObjects];
			for (int i=0; i<[[Listebacks objectAtIndex:correnteback] count]; i++) { 
				terer= [[Listebacks objectAtIndex:correnteback] objectAtIndex:i];
				[ListaCtrTerFiltrata addObject:terer];
			}
			break;
	}
	[self updaterighe];
		//	NSLog(@"- %d",correnteback);
}




- (Terreno *) subselezionato {
	Terreno * risulta=nil;
	int indsel = [TavolaTerreni selectedRow] ;
	if (filtroattivo) {
		if ([ListaCtrTerFiltrata count]==1) { indsel =0;}
		else { if (indsel == ([ListaCtrTerFiltrata count])) return nil;	}
		if (indsel<0) risulta=nil;	else return [ListaCtrTerFiltrata objectAtIndex:indsel];
	} else {
		if ([ListaCtrTer count]==1)  { indsel =0;}
		else { if (indsel == ([ListaCtrTer count])) return nil;	}
		if (indsel<0) risulta=nil;	else return [ListaCtrTer objectAtIndex:indsel];
	}
	return risulta;
}



- (void)      setTerselezionato : (Terreno *) ter {
	NSUInteger indsel=-1;
	NSMutableArray                   * ListaAttiva;
	if (filtroattivo) ListaAttiva = ListaCtrTerFiltrata; else ListaAttiva = ListaCtrTer;
	for (int i=0; i<ListaAttiva.count; i++) {
		if ([ter isEqual: [ListaAttiva objectAtIndex:i]]) {	indsel=i; break; }
	}
	if (indsel>=0) {
		[TavolaTerreni selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaTerreni scrollRowToVisible:indsel];
	}
}


- (NSArray *)    SubSelezionati {
	NSMutableArray * risulta;
	NSInteger Into; 
	NSIndexSet * selectedRow  = [TavolaTerreni selectedRowIndexes];
	if ([selectedRow count ]<=0)  return risulta;
	risulta = [[NSMutableArray alloc] init];
	Into = [selectedRow firstIndex];
	for (int j=0; j<   [selectedRow count ]; j++) { 
		if (filtroattivo) {  if (Into<[ListaCtrTerFiltrata count]) [risulta addObject:[ListaCtrTerFiltrata objectAtIndex:Into]   ];	}
				     else {	 if (Into<[ListaCtrTer         count]) [risulta addObject:[ListaCtrTer objectAtIndex:Into]   ]; };
		Into = [selectedRow indexGreaterThanIndex:Into];
	}
	return risulta;
}



@end
