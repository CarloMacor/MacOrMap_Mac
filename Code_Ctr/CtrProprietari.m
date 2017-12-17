//
//  CtrProprietari.m
//  MacOrMap
//
//  Created by Carlo Macor on 14/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrProprietari.h"


@implementation CtrProprietari

@synthesize  demoSensibili;
NSTableColumn * TableColumninEditProp;
NSInteger       rowIndexinEditProp;


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView    {
	NSInteger risulta=0;
	if (filtroattivo) { risulta = ListaProprietariFiltrata.count;	} 
	             else { risulta = ListaProprietari.count;		    }
	return risulta;
}

- (void)     AttivaFiltro        : (bool ) bol                                         {
	filtroattivo = bol;
	[ListaProprietariFiltrata removeAllObjects];
	[ListaProprietariFiltrata addObjectsFromArray:ListaProprietari];
	[self updaterighe];
}


- (id)       tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (void)     passaListaproprietari  : (NSMutableArray *)  lista : (NSMutableArray *)  listaFiltrata  {
	ListaProprietari =  lista;
	ListaProprietariFiltrata = listaFiltrata;
	demoSensibili = NO;
	filtroattivo =NO;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldEditTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	TableColumninEditProp = aTableColumn;
	rowIndexinEditProp    = rowIndex;
		//	NSLog(@"in edit %d",rowIndexinEditProp);	

	return YES;
}


- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
	Proprietari * IlloSelezionato = [self subselezionato];
	
	NSMutableArray                   * ListaAttiva;
	if (filtroattivo) ListaAttiva = ListaProprietariFiltrata; else ListaAttiva = ListaProprietari;

	

	if ([[tableColumn identifier] isEqualToString : @"Nome"]) 	{ 
		NomeCresce = !NomeCresce;
		if (NomeCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNome:)];  
				   else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNome2:)]; 
		trovato = YES;}

	if ([[tableColumn identifier] isEqualToString : @"Cognome"]){  	
		CognomeCresce = !CognomeCresce;
		if (CognomeCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCognome:)]; 	
		              else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCognome2:)]; 
		trovato = YES;	}

	if ([[tableColumn identifier] isEqualToString : @"Luogo"]) 	{ 
		LuogoCresce = !LuogoCresce;
		if (LuogoCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareLuogo:)];       
		           else  sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareLuogo2:)];  
		trovato = YES;}

	if ([[tableColumn identifier] isEqualToString : @"data"]) 	{ 
		DataCresce = !DataCresce;
		if (DataCresce)	sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareDataN:)];       
		          else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareDataN2:)]; 
		trovato = YES;}
	
	
	
	if ([[tableColumn identifier] isEqualToString : @"CodFis"]) {
		CfisCresce = !CfisCresce;
		if (CfisCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCodFis:)]; 
		           else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareCodFis2:)]; 
		trovato = YES;}
	
	
	if ([[tableColumn identifier] isEqualToString : @"Prop"]) 	{  
		nrPropCresce = !nrPropCresce;
		if (nrPropCresce) sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNrPr:)];      
	           	     else sortedArray = [ListaAttiva sortedArrayUsingSelector:@selector(CompareNrPr2:)];     
		trovato = YES;
	}
	
				
		//	Proprietari * proper;
    if (trovato)		 {     
		[ListaAttiva removeAllObjects];
		[ListaAttiva setArray:sortedArray];
			// for (int i=0; i<sortedArray.count; i++) {  proper = [sortedArray objectAtIndex:i];  [ListaProprietari addObject:proper];  }
		[self updaterighe];
			//	   [TavolaProprietari noteNumberOfRowsChanged];
		if (IlloSelezionato!=nil) { [self setPropselezionato:IlloSelezionato]; }

    }
}

 
 
- (void)     tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	NSMutableArray                   * ListaAttuale;

	if (filtroattivo) ListaAttuale = ListaProprietariFiltrata; else ListaAttuale = ListaProprietari;
	
	Proprietari    * proper = [ListaAttuale objectAtIndex:rowIndex];
	if ([[tableColumn identifier] isEqualToString:   @"nr"])     	{ [cell  setStringValue:[proper  indicestr  ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"Nome"])      { [cell  setStringValue:[proper  Nome       ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"Cognome"])   { 
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
		[cell  setStringValue:[proper  Cognome    ]] ;	}
   if ([[tableColumn identifier] isEqualToString:   @"Luogo"])     { 
	   if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
	   [cell  setStringValue:[proper  LuogoNascita ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"data"])      {
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
         [cell  setStringValue:[proper  Datanascita ]] ;	}
 	if ([[tableColumn identifier] isEqualToString:   @"CodFis"])    {
		if (demoSensibili) [cell  setStringValue: @"----- -----"]; 	else 
        [cell  setStringValue:[proper  Codfis     ]] ;	}
	if ([[tableColumn identifier] isEqualToString:   @"Prop"])      { [cell  setStringValue:[proper  numprostr  ]] ;    }
}

- (void)     updaterighe                                         {
	[TavolaProprietari noteNumberOfRowsChanged];
}


- (Proprietari *) subselezionato {
	int indsel = [TavolaProprietari selectedRow] ;
	if ([ListaProprietari count]==1) indsel =0;
	if (indsel<0) return nil;
	else return [ListaProprietari objectAtIndex:indsel];
}

- (void)      setPropselezionato : (Proprietari *) prop {
	NSUInteger indsel=-1;
	for (int i=0; i<ListaProprietari.count; i++) {
		if ([prop isEqual: [ListaProprietari objectAtIndex:i]]) {	indsel=i; break; }
	}
	if (indsel>=0) {
		[TavolaProprietari selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaProprietari scrollRowToVisible:indsel];
	}
}


- (IBAction)     switcheditabiletavola           : (id)sender;              {
	NSTableColumn * colonna; 
	colonna =   [TavolaProprietari tableColumnWithIdentifier:@"Nome"];	[[colonna dataCell] setEditable: ![[colonna dataCell] isEditable]];
	colonna =   [TavolaProprietari tableColumnWithIdentifier:@"Cognome"];	[[colonna dataCell] setEditable: ![[colonna dataCell] isEditable]];
	colonna =   [TavolaProprietari tableColumnWithIdentifier:@"Luogo" ];	[[colonna dataCell] setEditable: ![[colonna dataCell] isEditable]];
	colonna =   [TavolaProprietari tableColumnWithIdentifier:@"data"  ];	[[colonna dataCell] setEditable: ![[colonna dataCell] isEditable]];
	colonna =   [TavolaProprietari tableColumnWithIdentifier:@"CodFis"];	[[colonna dataCell] setEditable: ![[colonna dataCell] isEditable]];
}

 
- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	Proprietari    * proper = [ListaProprietari objectAtIndex:rowIndexinEditProp]; 
	NSLog(@"modifico : %d",rowIndexinEditProp);	

    if ([[TableColumninEditProp identifier] isEqualToString : @"Nome"])   { [proper SetNome    : [fieldEditor string]];}
    if ([[TableColumninEditProp identifier] isEqualToString : @"Cognome"]){ [proper SetCognome : [fieldEditor string]];}
		//   if ([[TableColumninEditProp identifier] isEqualToString : @"Luogo"])  {	[proper SetLuogoNat: [fieldEditor string]]; }
		//    if ([[TableColumninEditProp identifier] isEqualToString : @"data"])   {	[proper SetDataNat : [fieldEditor string]]; }
	if ([[TableColumninEditProp identifier] isEqualToString : @"CodFis"]) {	[proper SetCodfisSecco: [fieldEditor string]]; }
	
	return YES;
}

- (IBAction)     FondiProprietariStessoNome : (id)sender {
    for ( int i=0; i<ListaProprietari.count; i++ ) {
			//		NSLog(@"- %d ",i);

		Proprietari    * proper1 = [ListaProprietari objectAtIndex:i];
		for ( int j=i+1; j<ListaProprietari.count; j++ ) {
				//	NSLog(@"+j %d ",j);
			Proprietari    * proper2 = [ListaProprietari objectAtIndex:j];
			if ( ( [[proper1 Nome] isEqualToString :[proper2 Nome]] )   &  
				( [[proper1 Cognome] isEqualToString :[proper2 Cognome]] )   &
				//			( [[proper1 LuogoNascita] isEqualToString :[proper2 LuogoNascita]] ) &
				( [[proper1 Codfis] isEqualToString :[proper2 Codfis]] ) 			 
				)			{
				for (int k=0; k<[proper2 ListaPatrimonio].count; k++ ) {
					Patrimonio * illopatrimonio;
                    illopatrimonio = [[proper2 ListaPatrimonio] objectAtIndex:k];
					[[proper1 ListaPatrimonio] addObject:illopatrimonio];
				}
			  [ListaProprietari  removeObjectAtIndex:j];	
			}
		}
	}
	[self updaterighe];
}


@end
