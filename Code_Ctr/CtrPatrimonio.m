//
//  CtrPatrimonio.m
//  MacOrMap
//
//  Created by Carlo Macor on 18/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrPatrimonio.h"


@implementation CtrPatrimonio

@synthesize  inpatrimoniofamiliare;
@synthesize  demoSensibili;

- (void)     ImpostaIcone           : (NSMutableArray *) iconeList {
	ListaIconeEdif = iconeList;
	FamigliaIntestataria = nil;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView    {
    NSInteger resulta=0;
	if ( inpatrimoniofamiliare) { resulta  = [[FamigliaIntestataria ListaPatrimonio] count];  }
                           else { resulta  = [[Intestatario        ListaPatrimonio] count];  } 
	return resulta;
}

- (void)     tableView:(NSTableView *)tableView  mouseDownInHeaderOfTableColumn  :(NSTableColumn *)tableColumn            {
	NSArray *sortedArray; 
	bool trovato=NO;
		//	bool                             SubCresce;
	Patrimonio * IlloSelezionato = [self patselezionato];

	if ([[tableColumn identifier] isEqualToString : @"Fg"]) { 
		FgCresce = !FgCresce;
		if (FgCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareFg:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareFg2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Part"]) { 
		PartCresce = !PartCresce;
		if (PartCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(ComparePart:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(ComparePart2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Sub"]) { 
		SubCresce = !SubCresce;
		if (SubCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareSub:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareSub2:)];     
		trovato = YES;
	}
	
	if ([[tableColumn identifier] isEqualToString : @"Tipo"]) { 
		TipoCresce = !TipoCresce;
		if (TipoCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareCat:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareCat2:)];     
		trovato = YES;
	}

	if ([[tableColumn identifier] isEqualToString : @"Rendita"]) { 
		RenditaCresce = !RenditaCresce;
		if (RenditaCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareRendPat:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareRendPat2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Agraria"]) { 
		AgrariaCresce = !AgrariaCresce;
		if (AgrariaCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareAgraPat:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareAgraPat2:)];     
		trovato = YES;
	}
	if ([[tableColumn identifier] isEqualToString : @"Domenicale"]) { 
		DomenicaleCresce = !DomenicaleCresce;
		if (DomenicaleCresce) sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareDomePat:)];      
		else sortedArray = [[Intestatario ListaPatrimonio] sortedArrayUsingSelector:@selector(CompareDomePat2:)];     
		trovato = YES;
	}
	
	
	
	if (trovato)		 {     [[Intestatario ListaPatrimonio] removeAllObjects];
		[[Intestatario ListaPatrimonio] setArray:sortedArray];
		[TavolaPatrimonio noteNumberOfRowsChanged];
		if (IlloSelezionato!=nil)  [self setPatselezionato:IlloSelezionato]; 
    }
	
}	


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}


- (void)  impostainfotitolo :(NSString *) titolo {
	if (demoSensibili) 	[infotestoPatrimonio setStringValue:@"Demo dati mascherati"];
	               else [infotestoPatrimonio setStringValue:titolo];
}

- (NSImage *) iconaCodice : (int) cod  {
	NSImage * resulta;
	
	resulta = [ListaIconeEdif objectAtIndex : 0];
	if (cod<=57) {	resulta = [ListaIconeEdif objectAtIndex : cod ]; } 
	
	if (cod == 101) resulta = [ListaIconeEdif objectAtIndex : 58 ]; 
	if (cod == 102) resulta = [ListaIconeEdif objectAtIndex : 59 ]; 

	if (cod == 121) resulta = [ListaIconeEdif objectAtIndex : 60 ]; 
	if (cod == 122) resulta = [ListaIconeEdif objectAtIndex : 61 ]; 
	if (cod == 123) resulta = [ListaIconeEdif objectAtIndex : 62 ]; 

	if (cod == 124) resulta = [ListaIconeEdif objectAtIndex : 63 ]; 
	if (cod == 125) resulta = [ListaIconeEdif objectAtIndex : 64 ]; 
	if (cod == 126) resulta = [ListaIconeEdif objectAtIndex : 65 ]; 


	if (cod == 130) resulta = [ListaIconeEdif objectAtIndex : 66 ]; 
	if (cod == 131) resulta = [ListaIconeEdif objectAtIndex : 67 ]; 

	
	
	if (cod == 140) resulta = [ListaIconeEdif objectAtIndex : 68 ]; 
	if (cod == 141) resulta = [ListaIconeEdif objectAtIndex : 69 ]; 
	if (cod == 142) resulta = [ListaIconeEdif objectAtIndex : 70 ]; 

	
	if (cod == 150) resulta = [ListaIconeEdif objectAtIndex : 71 ]; 
	if (cod == 151) resulta = [ListaIconeEdif objectAtIndex : 72 ]; 
	if (cod == 152) resulta = [ListaIconeEdif objectAtIndex : 73 ]; 
	if (cod == 153) resulta = [ListaIconeEdif objectAtIndex : 74 ]; 
	if (cod == 154) resulta = [ListaIconeEdif objectAtIndex : 75 ]; 
	if (cod == 155) resulta = [ListaIconeEdif objectAtIndex : 76 ]; 

	if (cod == 156) resulta = [ListaIconeEdif objectAtIndex : 77 ]; 
	if (cod == 157) resulta = [ListaIconeEdif objectAtIndex : 78 ]; 
	if (cod == 158) resulta = [ListaIconeEdif objectAtIndex : 79 ]; 

	
	
	return resulta;
}

- (void)  impostaFamigliaIntestataria :(Proprietari *) proper {
	[FamigliaIntestataria release];
	FamigliaIntestataria = proper;
	[FamigliaIntestataria retain];
	inpatrimoniofamiliare = YES;
	[self updaterighe];
}

- (void)  impostaintestatario :(Proprietari *) proper {
	Intestatario = proper;
	inpatrimoniofamiliare = NO;
	[self updaterighe];
}

- (void)tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	Patrimonio  * patr;
	int numelepat =0;

	if ( inpatrimoniofamiliare) { numelepat=[[FamigliaIntestataria ListaPatrimonio] count]; }
                       	   else { numelepat=[[Intestatario ListaPatrimonio] count];  } 

	if (rowIndex<numelepat) {
		if ( inpatrimoniofamiliare) { patr  = [[FamigliaIntestataria ListaPatrimonio] objectAtIndex:rowIndex];  }
		else { patr  = [[Intestatario ListaPatrimonio] objectAtIndex:rowIndex];  }  
	  if ([[tableColumn identifier] isEqualToString:   @"Fg"])         { [cell  setStringValue:[patr  Foglio ]] ;	        }
	  if ([[tableColumn identifier] isEqualToString:   @"Part"])       { [cell  setStringValue:[patr  Particella ]] ;	    }
	  if ([[tableColumn identifier] isEqualToString:   @"Sub"])        { [cell  setStringValue:[patr  Sub ]] ;	            }
	  if ([[tableColumn identifier] isEqualToString:   @"Tipo"])       { [cell  setImage      :[self  iconaCodice:[patr CodCategoria]]] ;	}
	  if ([[tableColumn identifier] isEqualToString:   @"Cat"])        { [cell  setStringValue:[patr  Categoria]] ;	}

	  if ([[tableColumn identifier] isEqualToString:   @"Via"])        { 
		   if ([patr TipoEdiTerra]==0)  {
		    Subalterno * locsub = [Loc_ctredi SubaltConFgPartSub : [patr  Foglio ] : [patr  ParticellaSingola ] :[patr  SubSingolo ] ];
			if (locsub != nil) [cell  setStringValue: [[NSString alloc] initWithFormat:@"%@ n.%@",[locsub  Via],[locsub Civico]]] ;	
		   }
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"Sup"])        { 
		  if ([patr TipoEdiTerra]==0)  {
			  Subalterno * locsub = [Loc_ctredi SubaltConFgPartSub : [patr  Foglio ] : [patr  ParticellaSingola ] :[patr  SubSingolo ] ];
			  if (locsub != nil) [cell  setStringValue: [locsub Consistenza ]] ;	
		  }
	  }
		
	  if ([[tableColumn identifier] isEqualToString:   @"Rendita"])    { [cell  setStringValue:[patr Renditastr]]  ;		}
	  if ([[tableColumn identifier] isEqualToString:   @"Agraria"])    { [cell  setStringValue:[patr Agrariastr]]  ;		}
	  if ([[tableColumn identifier] isEqualToString:   @"Domenicale"]) { [cell  setStringValue:[patr Domenicalestr]]  ;		}
	  if ([[tableColumn identifier] isEqualToString:   @"Rapporto"])   { [cell  setStringValue:[patr percPropStr]] ;	}
	  if ([[tableColumn identifier] isEqualToString:   @"DirOneri"])   { [cell  setStringValue:[patr DirittiOneri]] ;	    }
	} else {
		/*
	  if ([[tableColumn identifier] isEqualToString:   @"Rendita"])  {  double tot=0;
		  for (int i=0; i<[Intestatario ListaPatrimonio].count; i++) { 
			tot = tot + [ [[Intestatario ListaPatrimonio] objectAtIndex:i] Redditoedile]; }	
		  [cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ;			}
	  if ([[tableColumn identifier] isEqualToString:   @"Agraria"])  {  double tot=0;
		  for (int i=0; i<[Intestatario ListaPatrimonio].count; i++) { 
			tot = tot + [ [[Intestatario ListaPatrimonio] objectAtIndex:i] RedditoAgrario]; }	
		  [cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ;			}
		if ([[tableColumn identifier] isEqualToString:   @"Domenicale"])   {  double tot=0;
		  for (int i=0; i<[Intestatario ListaPatrimonio].count; i++) { 
		    tot = tot + [ [[Intestatario ListaPatrimonio] objectAtIndex:i] RedditoDomenicale]; }	
		  [cell  setDoubleValue:(double)( (int)(tot*100)/100.0) ] ;			} 
		 */
	}

}


- (Patrimonio *) patselezionato {
	Patrimonio * resulta;
	int indsel = [TavolaPatrimonio selectedRow] ;
	if ([[Intestatario ListaPatrimonio] count]==1) indsel =0;
	if (indsel<0) return nil;
	if ( inpatrimoniofamiliare) { resulta=[[FamigliaIntestataria ListaPatrimonio] objectAtIndex:indsel]; }
	                       else { resulta=[[Intestatario ListaPatrimonio] objectAtIndex:indsel];  } 
	return resulta; 
}

- (void)      setPatselezionato : (Patrimonio *) pat {
	NSUInteger indsel=-1;
	for (int i=0; i<[Intestatario ListaPatrimonio].count; i++) {
		if ([pat isEqual: [[Intestatario ListaPatrimonio] objectAtIndex:i]]) {	indsel=i; break; }
	}
	if (indsel>=0) {
		[TavolaPatrimonio selectRowIndexes:[[NSIndexSet alloc ]initWithIndex:indsel] byExtendingSelection:NO];
		[TavolaPatrimonio scrollRowToVisible:indsel];
	}
	
}


- (void)          updaterighe                             {
	[TavolaPatrimonio noteNumberOfRowsChanged];
}

- (Proprietari *) Intestatario                            {
	return Intestatario;
}

- (Proprietari *) FamigliaIntestataria {
	return FamigliaIntestataria;
}



@end
