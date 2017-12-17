//
//  CtrPossessori.m
//  MacOrMap
//
//  Created by Carlo Macor on 17/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrPossessori.h"
#import "Proprietari.h"


@implementation CtrPossessori

@synthesize  demoSensibili;


- (NSInteger)numberOfRowsInTableView  :(NSTableView *)tableView    {
	if (ListaPossessori ==nil) return 0;
	return ListaPossessori.count;
}

- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
	Proprietari * IlloSelezionato = [self subselezionato];

	if ([[tableColumn identifier] isEqualToString : @"Nome"]) 	{ 
		NomeCresce = !NomeCresce;
		if (NomeCresce) sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareNome:)];  
		else sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareNome2:)]; 
		trovato = YES;}
	
	if ([[tableColumn identifier] isEqualToString : @"Cognome"]){  	
		CognomeCresce = !CognomeCresce;
		if (CognomeCresce) sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareCognome:)]; 	
		else sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareCognome2:)]; 
		trovato = YES;	}
	
	if ([[tableColumn identifier] isEqualToString : @"Luogo"]) 	{ 
		LuogoCresce = !LuogoCresce;
		if (LuogoCresce) sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareLuogo:)];       
		else  sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareLuogo2:)];  
		trovato = YES;}
	
	if ([[tableColumn identifier] isEqualToString : @"data"]) 	{ 
		DataCresce = !DataCresce;
		if (DataCresce)	sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareDataN:)];       
		else sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareDataN2:)]; 
		trovato = YES;}
	
	
	
	if ([[tableColumn identifier] isEqualToString : @"CodFis"]) {
		CfisCresce = !CfisCresce;
		if (CfisCresce) sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareCodFis:)]; 
		else sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareCodFis2:)]; 
		trovato = YES;}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Prop"]) 	{  
		nrPropCresce = !nrPropCresce;
		if (nrPropCresce) sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareNrPr:)];      
		else sortedArray = [ListaPossessori sortedArrayUsingSelector:@selector(CompareNrPr2:)];     
		trovato = YES;
	}
	
    if (trovato)		 {     
		[ListaPossessori removeAllObjects];
		[ListaPossessori setArray:sortedArray];
		[TavolaPossessori noteNumberOfRowsChanged];
		if (IlloSelezionato!=nil) { [self setPropselezionato:IlloSelezionato]; }

    }
	
}


- (id)       tableView                :(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}


- (void)     passaListaPossessori     :(NSMutableArray *)  lista   {
	CopiaListaPossessori = lista;
	demoSensibili =NO;
}


- (void)     impostainfopropieta      :(NSString *)  infotesto     {
	[infotestoproprieta setStringValue:infotesto];
}


- (void)     impostaelencopossessori  :(NSString *) fg : (NSString *) part : (NSString *) subo {
	if (ListaPossessori==nil) ListaPossessori = [[NSMutableArray alloc] init];
	if (ListaStrOneri==nil)   ListaStrOneri   = [[NSMutableArray alloc] init];
	[ListaPossessori removeAllObjects]; 
	[ListaStrOneri   removeAllObjects];
	Proprietari * proper;
	Patrimonio  * patr;
	NSArray *  l_part = [part componentsSeparatedByString:@","];
	NSArray *  l_sub  = [subo componentsSeparatedByString:@","];

	for (int i=0; i<CopiaListaPossessori.count; i++) { 
		proper= [CopiaListaPossessori objectAtIndex:i];
		bool trovato = NO;

		for (int j=0; j<[proper ListaPatrimonio].count; j++) { 
			patr = [[proper ListaPatrimonio] objectAtIndex:j];
			if ([patr TipoEdiTerra] != 0) continue;
			if (![fg isEqualToString:[patr Foglio]]) continue;
			NSArray *  l_part_I = [[patr Particella] componentsSeparatedByString:@","];
			NSArray *  l_sub_I  = [[patr Sub] componentsSeparatedByString:@","];
	
			for (int j=0; j<[l_part count]; j++) { 
				for (int k=0; k<[l_part_I count]; k++) { 
					if (trovato) break;
					if ([[l_part objectAtIndex:j] isEqualToString:[l_part_I objectAtIndex:k]] )  {	
						if (trovato) break;
						if (j>=[l_sub   count]) continue;
						if (k>=[l_sub_I count]) continue;
						if ([[l_sub objectAtIndex:j] isEqualToString:[l_sub_I objectAtIndex:k]] )  {	
							[ListaPossessori addObject:proper];  
							[ListaStrOneri   addObject:patr ];
							trovato = YES; break;
						}
					}
				}
			}
		}
	}
	[self updaterighe];
}


- (void)     impostaelepossessoriFT  :(NSString *) fg : (NSString *) part  :  (NSString *) zona : (int) tipoFT {
	if (ListaPossessori==nil) ListaPossessori = [[NSMutableArray alloc] init];
	if (ListaStrOneri==nil)   ListaStrOneri   = [[NSMutableArray alloc] init];
	[ListaPossessori removeAllObjects]; 
	[ListaStrOneri   removeAllObjects];
	Proprietari * proper;
	Patrimonio  * patr;
	for (int i=0; i<CopiaListaPossessori.count; i++) { 
		proper= [CopiaListaPossessori objectAtIndex:i];
		for (int j=0; j<[proper ListaPatrimonio].count; j++) { 
			patr = [[proper ListaPatrimonio] objectAtIndex:j];
			if ([patr TipoEdiTerra] != tipoFT) continue;
			if (![fg isEqualToString:[patr Foglio]]) continue;
			if (![part isEqualToString:[patr Particella]]) continue;
			if (tipoFT==0) {
				if (![zona isEqualToString:[patr Sub]]) continue;
			} else {
				if (![zona isEqualToString:[patr Sub]]) continue;
			}
				//			int        TipoEdiTerra; // 0 = Edificio  ; 1 = Terra
				//			if (![patr presenzainfo :fg : part : subo]) continue;
			[ListaPossessori addObject:proper];  
			[ListaStrOneri   addObject:patr ];
		}
	}
	[self updaterighe];
}



- (void)     impostaelepossessoriterra  :(NSString *) fg : (NSString *) part  :  (NSString *) zona {
	if (ListaPossessori==nil) ListaPossessori = [[NSMutableArray alloc] init];
	if (ListaStrOneri==nil)   ListaStrOneri   = [[NSMutableArray alloc] init];
	[ListaPossessori removeAllObjects]; 
	[ListaStrOneri   removeAllObjects];
	Proprietari * proper;
	Patrimonio  * patr;

	for (int i=0; i<CopiaListaPossessori.count; i++) { 
		proper= [CopiaListaPossessori objectAtIndex:i];
		for (int j=0; j<[proper ListaPatrimonio].count; j++) { 
			patr = [[proper ListaPatrimonio] objectAtIndex:j];
			if ([patr TipoEdiTerra] != 1) continue;
			if (![fg isEqualToString:[patr Foglio]]) continue;
			if (![part isEqualToString:[patr Particella]]) continue;
			if (![zona isEqualToString:[patr Sub]]) continue;

				//			if (![patr presenzainfo :fg : part : subo]) continue;
			[ListaPossessori addObject:proper];  
			[ListaStrOneri   addObject:patr ];
		}
	}

	[self updaterighe];
}



- (void)     tableView                :(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	Proprietari * proper = [ListaPossessori objectAtIndex:rowIndex];
	Patrimonio  * patr;
	if ([[tableColumn identifier] isEqualToString:   @"Nome"])        { [cell  setStringValue:[proper  Nome ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"Cognome"])     { 
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
		[cell  setStringValue:[proper  Cognome ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"CodFis"])      {
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
        [cell  setStringValue:[proper  Codfis ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"Data"])      {
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
			[cell  setStringValue:[proper  Datanascita ]] ;	}
	
	if ([[tableColumn identifier] isEqualToString:   @"Rapporto"])    { [cell  setStringValue:[[ListaStrOneri objectAtIndex:rowIndex]  percPropStr ]] ;	}

	if ([[tableColumn identifier] isEqualToString:   @"DirOneri"])     { 
	        if (rowIndex<ListaStrOneri.count)	{	patr = [ListaStrOneri objectAtIndex:rowIndex];  [cell  setStringValue:[patr DirittiOneri]] ;	}	}
}


- (void)     updaterighe                                           {
	[TavolaPossessori noteNumberOfRowsChanged];
}


- (Proprietari *) subselezionato                                   {
	int indsel = [TavolaPossessori selectedRow] ;
	if ([ListaPossessori count]==1) indsel =0;
	if (indsel<0) return nil;
	else return [ListaPossessori objectAtIndex:indsel];
}

- (void)      setPropselezionato : (Proprietari *) prop {
	NSUInteger indsel=-1;
	for (int i=0; i<ListaPossessori.count; i++) {
		if ([prop isEqual: [ListaPossessori objectAtIndex:i]]) {	indsel=i; break; }
	}
	if (indsel>=0) {
		[TavolaPossessori selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaPossessori scrollRowToVisible:indsel];
	}
}


@end
