//
//  CtrPropFiltro.m
//  MacOrMap
//
//  Created by Carlo Macor on 21/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrPropFiltro.h"


@implementation CtrPropFiltro


- (void)     passaListaproprietari  : (NSMutableArray *)  lista : (NSMutableArray *)  listaFiltrata {
	ListaProprietari =  lista;
	ListaProprietariFiltrata = listaFiltrata;
	LstIniziali = [[NSMutableArray alloc] initWithCapacity:40];
	[LstIniziali removeAllObjects];
	for (int i=65; i<=90; i++) {NSString * st1 = [[NSString alloc] initWithFormat:@"%c",i];	[LstIniziali addObject:st1];}
	
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView                        {
	NSInteger risulta=0;
	risulta = LstIniziali.count;
	return risulta;
}

- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
 	 if (rowIndex<LstIniziali.count)   { [cell  setStringValue:[LstIniziali objectAtIndex:rowIndex ]] ;	 }	
}

- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (IBAction) ClickOnTable          : (id)sender {

	[ ListaProprietariFiltrata removeAllObjects];
	Proprietari * proper;
	bool dafare;
	NSInteger Into; 
	NSString  * Iniz;

	for (int i=0; i<ListaProprietari.count; i++) {
		proper = [ListaProprietari objectAtIndex:i];  dafare =YES;
	
		NSIndexSet * selectedRowIniz  = [TavIniziali selectedRowIndexes];
		if ([selectedRowIniz count ]>0) dafare=NO;
		Into = [selectedRowIniz firstIndex];
		NSRange rg;
		for (int j=0; j<   [selectedRowIniz count ]; j++) { 
			Iniz = [LstIniziali objectAtIndex:Into];  
			rg = [[proper Cognome] rangeOfString:Iniz];
				//			NSLog(@"-%@ %d",[resider Cognome],rg.location);
			if (rg.location==0)  dafare = YES;
			Into = [selectedRowIniz indexGreaterThanIndex:Into];
		}	  if (!dafare) continue;	
		if (dafare) [ListaProprietariFiltrata addObject:proper];
	}
	[TavolaProprietari noteNumberOfRowsChanged];
}


- (IBAction) ResetTavole           : (id)sender {
	for (int i=0; i<   [TavIniziali      numberOfRows ]; i++)  { if ( [TavIniziali      isRowSelected : i ]) [TavIniziali      deselectRow:i];	}	  
	[self ClickOnTable  :self ];
	
}

@end
