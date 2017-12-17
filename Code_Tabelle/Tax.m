//
//  Tarsu.m
//  MacOrMap
//
//  Created by Carlo Macor on 16/06/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "Tax.h"


@implementation Tax

- (void) initTax  {
	ListaTarsuEle     = [[NSMutableArray alloc] initWithCapacity:40000];
	ListaIciEle       = [[NSMutableArray alloc] initWithCapacity:40000];
}

- (void) salva                 {
	NSString * nomefile =  @"/MacOrMap/Catasto/Tax.TaxMap" ;
	NSMutableData *lodata;
	lodata = [NSMutableData dataWithCapacity:1000000];
	[self salvaTarsu : lodata];    [self salvaIci   : lodata];
	[lodata writeToFile:nomefile atomically:NO];
}

- (void) apri                 {
	NSString * nomefile =  @"/MacOrMap/Catasto/Tax.TaxMap" ;
		//	NSString * nomefile =  @"/MacOrMap/Catasto/Tarsu.TarsuMap" ;
	
	NSData * DataFile ;
	int posdata =0;	
	DataFile = [NSData dataWithContentsOfFile:nomefile];
	if (DataFile==nil) return;
	[self apriTarsu:DataFile:&posdata];
	[self apriIci  :DataFile:&posdata];
}


- (void) salvaTarsu : (NSMutableData *) lodata                 {
		Tax_ele    * loctarsu_ele;
	int numele = ListaTarsuEle.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	for (int i=0; i<ListaTarsuEle.count; i++)    { 	loctarsu_ele = [ListaTarsuEle    objectAtIndex:i]; 	[loctarsu_ele salva : lodata];  	}
}

- (void) apriTarsu  : (NSData *) lodata  : (int*) posizione  {
	int numobj;
	[lodata getBytes:&numobj  range:NSMakeRange (*posizione,  sizeof(numobj)) ];       *posizione +=sizeof(*posizione);
	Tax_ele    * loctarsu_ele;
	for (int i=0; i<numobj; i++) {  
		loctarsu_ele = [Tax_ele alloc]; 	[loctarsu_ele svuota]; 
		[loctarsu_ele	apri : lodata :posizione]; 
		[ListaTarsuEle addObject:loctarsu_ele];  
	}
}






- (void) salvaIci : (NSMutableData *) lodata                 {
	Tax_ele    * locIci_ele;
	int numele = ListaIciEle.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	for (int i=0; i<ListaIciEle.count; i++)    { 	locIci_ele = [ListaIciEle    objectAtIndex:i]; 	[locIci_ele salva : lodata];  	}
}

- (void) apriIci    : (NSData *) lodata  : (int*) posizione   {
	int numobj;
	[lodata getBytes:&numobj  range:NSMakeRange (*posizione,  sizeof(numobj)) ];        *posizione +=sizeof(*posizione);
	Tax_ele    * locIci_ele;
	for (int i=0; i<numobj; i++) {  
		locIci_ele = [Tax_ele alloc]; 	[locIci_ele svuota]; 
		[locIci_ele	apri : lodata :posizione]; 
		[ListaIciEle addObject:locIci_ele];  
	}
}



- (NSMutableArray *) ListaTarsuEle {
	return ListaTarsuEle;
}

- (NSMutableArray *) ListaIciEle {
	return ListaIciEle;
}

- (void) togliDoppiFgPartSub  {
	Tax_ele    * loctarsu_ele;
	Tax_ele    * loctarsu_eleJ;

	for (int i=ListaTarsuEle.count-1; i>0; i--)    { 
			//		NSLog(@"Faccio %d",i);
		loctarsu_ele = [ListaTarsuEle    objectAtIndex:i]; 
		for (int j=i-1; j>=0; j--)    { 
			loctarsu_eleJ  = [ListaTarsuEle    objectAtIndex:j]; 
			if (([[loctarsu_ele Foglio] isEqualToString:[loctarsu_eleJ Foglio]]) &
			    ([[loctarsu_ele Particella] isEqualToString:[loctarsu_eleJ Particella]]) &
				([[loctarsu_ele Sub] isEqualToString:[loctarsu_eleJ Sub]]))		{
				if ([[loctarsu_ele CodFis] isEqualToString:[loctarsu_eleJ CodFis]])      {
					NSLog(@"Rimuovo %d %d %@ %@ %@",i ,j,[loctarsu_ele Foglio] ,	 [loctarsu_ele Particella], [loctarsu_ele Sub] );
					[ListaTarsuEle removeObjectAtIndex:i]; 
				}
				
		
				break;
			}
			
		}
	
	}
}



- (void) logga {
	NSLog(@"Log di Tarsu Nr. ele : %d ", [ListaTarsuEle count] );
	NSLog(@"Log di Ici   Nr. ele : %d ", [ListaIciEle count] );
		//	Tax_ele    * loc_ele;
		//	for (int i=0; i<[ListaTarsuEle count]; i++) {loc_ele = [ListaTarsuEle objectAtIndex:i];	[loc_ele logga];	}

}


@end
