//
//  CtrEdiFiltro.m
//  MacOrMap
//
//  Created by Carlo Macor on 02/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrEdiFiltro.h"


@implementation CtrEdiFiltro

- (void)     impostaTuttiSubalterni : (Immobili  *) imb  : (Immobili  *) imbFilt        {
	ListaCtrSuber          = [imb      ListaSubalterni];
	ListaCtrSuberFiltrata  = [imbFilt  ListaSubalterni];
	
	LstFogli  = 	 [[NSMutableArray alloc] init];
	LstPart   = 	 [[NSMutableArray alloc] init];
	LstVie    = 	 [[NSMutableArray alloc] init];
	LstCat    = 	 [[NSMutableArray alloc] init];
	LstCivici = 	 [[NSMutableArray alloc] init];
	
}

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}



- (void)     inizTavole {  // prima di aprire la dialog inizializza le tavole 
  // i filtrati come la base   // la dialog abbia il filtro attivo
	[ListaCtrSuberFiltrata removeAllObjects];	[ListaCtrSuberFiltrata setArray:ListaCtrSuber];
	[LstFogli removeAllObjects]; [LstPart removeAllObjects]; [LstVie removeAllObjects]; [LstCat removeAllObjects];	[LstCivici removeAllObjects];	
	BOOL trovato ;
	Subalterno      * suber;
	for (int i=0; i<ListaCtrSuber.count; i++) { 
	 suber= [ListaCtrSuber objectAtIndex:i];		 
	 trovato =NO;
	 for (int j=0; j<LstFogli.count; j++) { if ([ [[LstFogli objectAtIndex:j] Foglio] isEqualToString:[suber Foglio]]) 	{ trovato =YES; break;	 } 	 }
	  if (!trovato) [LstFogli addObject:suber];
	 trovato =NO;
 	 for (int j=0; j<LstPart.count; j++) { if ([ [[LstPart objectAtIndex:j] Particella] isEqualToString:[suber Particella]]) 	{ trovato =YES; break;	 } 	 }
	  if (!trovato) [LstPart addObject:suber];
	 trovato =NO;
	 for (int j=0; j<LstVie.count; j++) { if ([ [[LstVie objectAtIndex:j] Via] isEqualToString:[suber Via]]) 	{ trovato =YES; break;	 } 	 }
	  if (!trovato) [LstVie addObject:suber];
	 trovato =NO;
	 for (int j=0; j<LstCat.count; j++) { if ([ [[LstCat objectAtIndex:j] Categoria] isEqualToString:[suber Categoria]]) 	{ trovato =YES; break;	 } 	 }
	  if (!trovato) [LstCat addObject:suber];
     trovato =NO;
     for (int j=0; j<LstCivici.count; j++) { if ([ [[LstCivici objectAtIndex:j] Civico] isEqualToString:[suber Civico]]) 	{ trovato =YES; break;	 } 	 }
     if (!trovato) [LstCivici addObject:suber];
    }
	
    NSArray *sortedArray1 = [LstFogli  sortedArrayUsingSelector :@selector(CompareFg:  )];  [LstFogli  removeAllObjects];	[LstFogli  setArray:sortedArray1]; 
    NSArray *sortedArray2 = [LstPart   sortedArrayUsingSelector :@selector(ComparePart:)];  [LstPart   removeAllObjects];	[LstPart   setArray:sortedArray2];  
    NSArray *sortedArray3 = [LstVie    sortedArrayUsingSelector :@selector(CompareVia: )];  [LstVie    removeAllObjects];	[LstVie    setArray:sortedArray3];  
	NSArray *sortedArray4 = [LstCat    sortedArrayUsingSelector :@selector(CompareCat: )];  [LstCat    removeAllObjects];	[LstCat    setArray:sortedArray4];  
    NSArray *sortedArray5 = [LstCivici sortedArrayUsingSelector :@selector(CompareCivico: )];  [LstCivici removeAllObjects];	[LstCivici setArray:sortedArray5];  

	[TavFogli noteNumberOfRowsChanged];	[TavParticelle noteNumberOfRowsChanged];	
	[TavVie   noteNumberOfRowsChanged];	[TavCategorie  noteNumberOfRowsChanged];[TavCivici  noteNumberOfRowsChanged];
}


- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	if (tableView == TavFogli)      {
 	    if (rowIndex<LstFogli.count)   {	Subalterno    * suber = [LstFogli objectAtIndex:rowIndex];	 [cell  setStringValue:[suber  Foglio ]] ;	 }	}
	if (tableView == TavParticelle) {
		if (rowIndex<LstPart.count)    {	Subalterno    * suber = [LstPart objectAtIndex:rowIndex];	 [cell  setStringValue:[suber  Particella ]] ;	 }	}
	if (tableView == TavVie)        {
		if (rowIndex<LstVie.count)     {	Subalterno    * suber = [LstVie objectAtIndex:rowIndex];	 [cell  setStringValue:[suber  Via ]] ;	 }	}
	if (tableView == TavCategorie)  {
		if (rowIndex<LstCat.count)     {	Subalterno    * suber = [LstCat objectAtIndex:rowIndex];	 [cell  setStringValue:[suber  Categoria ]] ;	 }	}
    if (tableView == TavCivici)  {
		if (rowIndex<LstCivici.count)     {	Subalterno    * suber = [LstCivici objectAtIndex:rowIndex];	 [cell  setStringValue:[suber  Civico ]] ;	 }	}

}



- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView      {
	NSInteger risulta=0;
	if (tableView == TavFogli)      { risulta = LstFogli.count;};
	if (tableView == TavParticelle) { risulta = LstPart.count;};
	if (tableView == TavVie)        { risulta = LstVie.count;};
	if (tableView == TavCategorie)  { risulta = LstCat.count;};
    if (tableView == TavCivici)     { risulta = LstCivici.count;};

	return risulta;
}

- (IBAction) ClickOnTable          : (id)sender {
	[ListaCtrSuberFiltrata removeAllObjects];
	BOOL dafare;
	Subalterno      * suber;
	Subalterno      * suberJ;
	NSInteger Into; 

	for (int i=0; i<ListaCtrSuber.count; i++) { 
	  dafare =YES;	suber= [ListaCtrSuber objectAtIndex:i];
	  
	  NSIndexSet * selectedRowFg  = [TavFogli selectedRowIndexes];
	  if ([selectedRowFg count ]>0) dafare=NO;
	  Into = [selectedRowFg firstIndex];
	  for (int j=0; j<   [selectedRowFg count ]; j++) { 
	      suberJ = [LstFogli objectAtIndex:Into];  if ([[suberJ Foglio] isEqualToString :[suber Foglio] ] ) dafare = YES;
		  Into = [selectedRowFg indexGreaterThanIndex:Into];
	  }	  if (!dafare) continue;	
		
	  NSIndexSet * selectedRowPart  = [TavParticelle selectedRowIndexes];
 	  if ([selectedRowPart count ]>0) dafare=NO;
   	  Into = [selectedRowPart firstIndex];
	  for (int j=0; j<   [selectedRowPart count ]; j++) { 
	  	  suberJ = [LstPart objectAtIndex:Into];   if ([[suberJ Particella] isEqualToString :[suber Particella] ] ) dafare = YES;
		  Into = [selectedRowPart indexGreaterThanIndex:Into];
	  }	  if (!dafare) continue;	
		
	  NSIndexSet * selectedRowVie  = [TavVie selectedRowIndexes];
	  if ([selectedRowVie count ]>0) dafare=NO;
	  Into = [selectedRowVie firstIndex];
	  for (int j=0; j<   [selectedRowVie count ]; j++) { 
	  	  suberJ = [LstVie objectAtIndex:Into];   if ([[suberJ Via] isEqualToString :[suber Via] ] ) dafare = YES;
		  Into = [selectedRowVie indexGreaterThanIndex:Into];
	  }	  if (!dafare) continue;	
		
	  NSIndexSet * selectedRowCat  = [TavCategorie selectedRowIndexes];
	  if ([selectedRowCat count ]>0) dafare=NO;
	  Into = [selectedRowCat firstIndex];
	  for (int j=0; j<   [selectedRowCat count ]; j++) { 
	  	  suberJ = [LstCat objectAtIndex:Into];   if ([[suberJ Categoria] isEqualToString :[suber Categoria] ] ) dafare = YES;
		  Into = [selectedRowCat indexGreaterThanIndex:Into];
	  }	  if (!dafare) continue;	
		
      NSIndexSet * selectedRowCiv  = [TavCivici selectedRowIndexes];
      if ([selectedRowCiv count ]>0) dafare=NO;
        Into = [selectedRowCiv firstIndex];
        for (int j=0; j<   [selectedRowCiv count ]; j++) { 
            suberJ = [LstCivici objectAtIndex:Into];   if ([[suberJ Civico] isEqualToString :[suber Civico] ] ) dafare = YES;
            Into = [selectedRowCiv indexGreaterThanIndex:Into];
        }	  if (!dafare) continue;	
        
        
	  if (dafare) [ListaCtrSuberFiltrata addObject:suber];
	}	
	[TavolaSubalterni noteNumberOfRowsChanged];
}

- (IBAction) ResetTavole           : (id)sender {
	for (int i=0; i<   [TavFogli      numberOfRows ]; i++)  { if ( [TavFogli      isRowSelected : i ]) [TavFogli      deselectRow:i];	}	  
	for (int i=0; i<   [TavParticelle numberOfRows ]; i++)  { if ( [TavParticelle isRowSelected : i ]) [TavParticelle deselectRow:i];	}	  
	for (int i=0; i<   [TavVie        numberOfRows ]; i++)  { if ( [TavVie        isRowSelected : i ]) [TavVie        deselectRow:i];	}	  
	for (int i=0; i<   [TavCategorie  numberOfRows ]; i++)  { if ( [TavCategorie  isRowSelected : i ]) [TavCategorie  deselectRow:i];	}	  
	for (int i=0; i<   [TavCivici     numberOfRows ]; i++)  { if ( [TavCivici     isRowSelected : i ]) [TavCivici     deselectRow:i];	}	  
	[self ClickOnTable  :self ];
}



@end
