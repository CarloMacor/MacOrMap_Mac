//
//  CtrTerFiltro.m
//  MacOrMap
//
//  Created by Carlo Macor on 04/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrTerFiltro.h"


@implementation CtrTerFiltro

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row                       {
	return 0;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView                        {
	NSInteger risulta=0;
	if (tableView == TavFogli)      { risulta = LstFogli.count;};
	if (tableView == TavParticelle) { risulta = LstPart.count;};
	if (tableView == TavQualita)    { risulta = LstQual.count;};
	if (tableView == TavClasse)     { risulta = LstClasse.count;};
	
		//	NSLog(@"N %d",risulta);
	return risulta;
}

- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	if (tableView == TavFogli)        {
 	    if (rowIndex<LstFogli.count)   {	Terreno    * terer = [LstFogli objectAtIndex:rowIndex];	 [cell  setStringValue:[terer  Foglio ]] ;	     }	}
	if (tableView == TavParticelle)   {
		if (rowIndex<LstPart.count)    {	Terreno    * terer = [LstPart objectAtIndex:rowIndex];	 [cell  setStringValue:[terer  Particella ]] ;	
		
		}	}
	if (tableView == TavQualita)      {
		if (rowIndex<LstQual.count)    {	Terreno    * terer = [LstQual objectAtIndex:rowIndex];	 [cell  setStringValue:[terer  Qualita]] ;	
				//			NSLog(@"P %@ %d %d",[terer  Qualita ],[[terer  Qualita ] length], [[terer  Qualita ] characterAtIndex:[[terer  Qualita ] length]-1 ]  );

		}	}
	if (tableView == TavClasse)      {
		if (rowIndex<LstClasse.count)  {	Terreno    * terer = [LstClasse objectAtIndex:rowIndex];	 [cell  setStringValue:[terer  Classe ]] ;	
		}	}
}


- (void)     impostaTuttiTerreni : (Immobili  *) imb  : (Immobili  *) imbFilt        {
	ListaCtrTer          = [imb      LTer];
	ListaCtrTerFiltrata  = [imbFilt  LTer];
	LstFogli  = 	 [[NSMutableArray alloc] init];
	LstPart   = 	 [[NSMutableArray alloc] init];
	LstQual   = 	 [[NSMutableArray alloc] init];
	LstClasse = 	 [[NSMutableArray alloc] init];
}


- (void)     inizTavole                         {  // prima di aprire la dialog inizializza le tavole 
						   // i filtrati come la base   // la dialog abbia il filtro attivo
	[ListaCtrTerFiltrata removeAllObjects];	[ListaCtrTerFiltrata setArray:ListaCtrTer];
	[LstFogli removeAllObjects];		[LstPart removeAllObjects];		[LstQual removeAllObjects];		[LstClasse removeAllObjects];	

		//	NSLog(@"T %d",ListaCtrTer.count);

	BOOL trovato ;
	Terreno      * terer;
	for (int i=0; i<ListaCtrTer.count; i++) { 
		terer= [ListaCtrTer objectAtIndex:i];		 
		trovato =NO;
		for (int j=0; j<LstFogli.count; j++)  { if ([ [[LstFogli objectAtIndex:j] Foglio] isEqualToString:[terer Foglio]]) 	{ trovato =YES; break;	 } 	 }
		if (!trovato) [LstFogli addObject:terer];
		trovato =NO;
		for (int j=0; j<LstPart.count; j++)   { if ([ [[LstPart objectAtIndex:j] Particella] isEqualToString:[terer Particella]]) 	{ trovato =YES; break;	 } 	 }
		if (!trovato) [LstPart addObject:terer];
		trovato =NO;
		for (int j=0; j<LstQual.count; j++)   { if ([ [[LstQual objectAtIndex:j] Qualita] isEqualToString:[terer Qualita]]) 	{ trovato =YES; break;	 } 	 }
		if (!trovato) [LstQual addObject:terer];
		trovato =NO;
		for (int j=0; j<LstClasse.count; j++) { if ([ [[LstClasse objectAtIndex:j] Classe] isEqualToString:[terer Classe]]) 	{ trovato =YES; break;	 } 	 }
		if (!trovato) [LstClasse addObject:terer];
	}

    NSArray *sortedArray1 = [LstFogli sortedArrayUsingSelector:@selector(CompareFg:  )];  [LstFogli  removeAllObjects];	[LstFogli setArray:sortedArray1]; 
    NSArray *sortedArray2 = [LstPart sortedArrayUsingSelector :@selector(ComparePart:)];  [LstPart   removeAllObjects];	[LstPart  setArray:sortedArray2];  
    NSArray *sortedArray3 = [LstQual sortedArrayUsingSelector :@selector(CompareQl:  )];  [LstQual   removeAllObjects];	[LstQual   setArray:sortedArray3];  
	NSArray *sortedArray4 = [LstClasse sortedArrayUsingSelector:@selector(CompareCl: )];  [LstClasse removeAllObjects];	[LstClasse   setArray:sortedArray4];  
	
	[TavFogli noteNumberOfRowsChanged];	    [TavParticelle noteNumberOfRowsChanged];	
	[TavQualita   noteNumberOfRowsChanged];	[TavClasse  noteNumberOfRowsChanged];
	
}

- (IBAction) ClickOnTable          : (id)sender {

	[ListaCtrTerFiltrata removeAllObjects];
	BOOL dafare;
	Terreno      * Terer;
	Terreno      * TererJ;
	NSInteger Into; 
	
	for (int i=0; i<ListaCtrTer.count; i++) { 
		dafare =YES;	Terer= [ListaCtrTer objectAtIndex:i];
		
		NSIndexSet * selectedRowFg  = [TavFogli selectedRowIndexes];
		if ([selectedRowFg count ]>0) dafare=NO;
		Into = [selectedRowFg firstIndex];
		for (int j=0; j<   [selectedRowFg count ]; j++) { 
			TererJ = [LstFogli objectAtIndex:Into];  if ([[TererJ Foglio] isEqualToString :[Terer Foglio] ] ) dafare = YES;
			Into = [selectedRowFg indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowPart  = [TavParticelle selectedRowIndexes];
		if ([selectedRowPart count ]>0) dafare=NO;
		Into = [selectedRowPart firstIndex];
		for (int j=0; j<   [selectedRowPart count ]; j++) { 
			TererJ = [LstPart objectAtIndex:Into];   if ([[TererJ Particella] isEqualToString :[Terer Particella] ] ) dafare = YES;
			Into = [selectedRowPart indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowVie  = [TavQualita selectedRowIndexes];
		if ([selectedRowVie count ]>0) dafare=NO;
		Into = [selectedRowVie firstIndex];
		for (int j=0; j<   [selectedRowVie count ]; j++) { 
			TererJ = [LstQual objectAtIndex:Into];   if ([[TererJ Qualita] isEqualToString :[Terer Qualita] ] ) dafare = YES;
			Into = [selectedRowVie indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowCat  = [TavClasse selectedRowIndexes];
		if ([selectedRowCat count ]>0) dafare=NO;
		Into = [selectedRowCat firstIndex];
		for (int j=0; j<   [selectedRowCat count ]; j++) { 
			TererJ = [LstClasse objectAtIndex:Into];   if ([[TererJ Classe] isEqualToString :[Terer Classe] ] ) dafare = YES;
			Into = [selectedRowCat indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		
		if (dafare) [ListaCtrTerFiltrata addObject:Terer];
	}	
	[TavolaTerreni noteNumberOfRowsChanged];
	
}

- (IBAction) ResetTavole           : (id)sender {
	for (int i=0; i<   [TavFogli numberOfRows ]; i++)      { if ( [TavFogli isRowSelected      : i ]) [TavFogli deselectRow:i];	}	  
	for (int i=0; i<   [TavParticelle numberOfRows ]; i++) { if ( [TavParticelle isRowSelected : i ]) [TavParticelle deselectRow:i];	}	  
	for (int i=0; i<   [TavQualita numberOfRows ]; i++)    { if ( [TavQualita isRowSelected    : i ]) [TavQualita deselectRow:i];	}	  
	for (int i=0; i<   [TavClasse numberOfRows ]; i++)     { if ( [TavClasse isRowSelected     : i ]) [TavClasse deselectRow:i];	}	  
	[self ClickOnTable  :self ];
}


@end
