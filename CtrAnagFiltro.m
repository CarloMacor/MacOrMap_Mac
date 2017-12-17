//
//  CtrAnagFiltro.m
//  MacOrMap
//
//  Created by Carlo Macor on 15/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrAnagFiltro.h"


@implementation CtrAnagFiltro

- (void)     passaAnagrafe  : (Anagrafe *)  an  {
  	anagrafe =  an;
	
	LstIniziali = [[NSMutableArray alloc] initWithCapacity:40];
	[LstIniziali removeAllObjects];
	for (int i=65; i<=90; i++) {NSString * st1 = [[NSString alloc] initWithFormat:@"%c",i];	[LstIniziali addObject:st1];}
	LstVie = [anagrafe ListaVie];
	LstOpzRes = [[NSMutableArray alloc] initWithCapacity:4];
	[LstOpzRes removeAllObjects];
	[LstOpzRes addObject:@""];
	[LstOpzRes addObject:@"*"];
}


- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView                        {
	NSInteger risulta=0;
	if (tableView == TavIniziali)      { risulta = LstIniziali.count;};
	if (tableView == TavVie)           { risulta = LstVie.count;};
	if (tableView == TavResOnoff)      { risulta = LstOpzRes.count;};
	return risulta;
}

- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	if (tableView == TavIniziali)        {
 	    if (rowIndex<LstIniziali.count)   { [cell  setStringValue:[LstIniziali objectAtIndex:rowIndex ]] ;	 }	}

	if (tableView == TavVie)   {
		if (rowIndex<LstVie.count)        { [cell  setStringValue:[LstVie objectAtIndex:rowIndex ]] ;	 }	}
	
	if (tableView == TavResOnoff)   {
		if (rowIndex<LstOpzRes.count)        { [cell  setStringValue:[LstOpzRes objectAtIndex:rowIndex ]] ;	 }	}
}


- (IBAction) ClickOnTable          : (id)sender {
	[[anagrafe ListaFamiglieFiltrata ] removeAllObjects];
	[[anagrafe ListaResidentiFiltrata] removeAllObjects];

	BOOL dafare;
		Residente * resider;
	    Famiglia  * famer;

		NSString  * stvia;
	    NSString  * Iniz;


	NSInteger Into; 
	
	for (int i=0; i<[anagrafe ListaResidenti].count; i++) { 
		dafare =YES;	resider= [[anagrafe ListaResidenti] objectAtIndex:i];
		NSIndexSet * selectedRowVia  = [TavVie selectedRowIndexes];
		if ([selectedRowVia count ]>0) dafare=NO;
		Into = [selectedRowVia firstIndex];
		for (int j=0; j<   [selectedRowVia count ]; j++) { 
			stvia = [LstVie objectAtIndex:Into];  if ([stvia isEqualToString :[resider via] ] ) dafare = YES;
			Into = [selectedRowVia indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowIniz  = [TavIniziali selectedRowIndexes];
		if ([selectedRowIniz count ]>0) dafare=NO;
		Into = [selectedRowIniz firstIndex];
		NSRange rg;
		for (int j=0; j<   [selectedRowIniz count ]; j++) { 
			Iniz = [LstIniziali objectAtIndex:Into];  
			rg = [[resider Cognome] rangeOfString:Iniz];
				//			NSLog(@"-%@ %d",[resider Cognome],rg.location);
			if (rg.location==0)  dafare = YES;
			Into = [selectedRowIniz indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowResOn  = [TavResOnoff selectedRowIndexes];
		if ([selectedRowResOn count ]>0) dafare=NO;
		Into = [selectedRowResOn firstIndex];
		for (int j=0; j<   [selectedRowResOn count ]; j++) { 
			if (Into==0) {	if (![[resider  famigliassociata] associatoedif]) dafare = YES;	}
			if (Into==1) {	if ([[resider  famigliassociata] associatoedif]) dafare = YES;	}
			Into = [selectedRowResOn indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		
		if (dafare) [[anagrafe ListaResidentiFiltrata] addObject:resider];
	}	

	for (int i=0; i<[anagrafe ListaFamiglie].count; i++) { 
		dafare =YES;	famer= [[anagrafe ListaFamiglie] objectAtIndex:i];
		NSIndexSet * selectedRowVia  = [TavVie selectedRowIndexes];
		if ([selectedRowVia count ]>0) dafare=NO;
		Into = [selectedRowVia firstIndex];
		for (int j=0; j<   [selectedRowVia count ]; j++) { 
			stvia = [LstVie objectAtIndex:Into];  if ([stvia isEqualToString :[famer Via] ] ) dafare = YES;
			Into = [selectedRowVia indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowIniz  = [TavIniziali selectedRowIndexes];
		if ([selectedRowIniz count ]>0) dafare=NO;
		Into = [selectedRowIniz firstIndex];
		NSRange rg;
		for (int j=0; j<   [selectedRowIniz count ]; j++) { 
			Iniz = [LstIniziali objectAtIndex:Into];  
            resider= [[famer ListaComponenti] objectAtIndex:0];
			rg = [[resider Cognome] rangeOfString:Iniz];
			if (rg.location==0)  dafare = YES;
			Into = [selectedRowIniz indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		NSIndexSet * selectedRowRes  = [TavResOnoff selectedRowIndexes];
		if ([selectedRowRes count ]>0) dafare=NO;
		Into = [selectedRowRes firstIndex];
		for (int j=0; j<[selectedRowRes count ]; j++) { 
		   if (Into==0) { if (![famer  associatoedif ]) dafare = YES;  }
	       if (Into==1) { if ([famer  associatoedif ]) dafare = YES;  }
			Into = [selectedRowRes indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		
		
		if (dafare) [[anagrafe ListaFamiglieFiltrata] addObject:famer];

 	}	
	
	
	
	[TavolaAnagrafe noteNumberOfRowsChanged];
	[TavolaComponentiFamiglia noteNumberOfRowsChanged];
}

- (IBAction) ResetTavole           : (id)sender {
	for (int i=0; i<   [TavIniziali      numberOfRows ]; i++)  { if ( [TavIniziali      isRowSelected : i ]) [TavIniziali      deselectRow:i];	}	  
	for (int i=0; i<   [TavVie numberOfRows ]; i++)            { if ( [TavVie isRowSelected : i ]) [TavVie deselectRow:i];	}	  
	for (int i=0; i<   [TavResOnoff numberOfRows ]; i++)       { if ( [TavResOnoff isRowSelected : i ]) [TavResOnoff deselectRow:i];	}	  

	[self ClickOnTable  :self ];
}



@end
