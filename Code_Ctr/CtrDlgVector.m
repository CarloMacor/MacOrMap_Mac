//
//  Control_dlgVector.m
//  GIS2010
//
//  Created by Carlo Macor on 24/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "CtrDlgVector.h"
#import <Quartz/Quartz.h>


@implementation CtrDlgVector



- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView    {
	int resulta=0;
	if ([TavolaPiani isEqual:tableView])	resulta =  [Disvetcorrente  damminumpiani];
	if ([TavolaDisegni isEqual:tableView])	resulta =  [CopiaListaDisegni count];
	return resulta;
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}


- (void)tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {

	
	if ([TavolaDisegni isEqual:tableView])	{
		if ([[tableColumn identifier] isEqualToString:   @"Disegno"]) {
			[cell  setTitle:[[CopiaListaDisegni objectAtIndex:rowIndex] SolonomedisegnoNoext ]] ;	
			if (correntevet==rowIndex) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];
		}
		if ([[tableColumn identifier] isEqualToString:   @"On"]) {
			if ([[CopiaListaDisegni objectAtIndex:rowIndex]  visibile ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];}
		if ([[tableColumn identifier] isEqualToString:   @"Edit"]) {
			if ([[CopiaListaDisegni objectAtIndex:rowIndex]  editabile ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];}
		if ([[tableColumn identifier] isEqualToString:   @"Snap"]) {
			if ([[CopiaListaDisegni objectAtIndex:rowIndex]  snappabile ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];}

		if ([[tableColumn identifier] isEqualToString:   @"alphaL"]) {
			[cell  setFloatValue: [[CopiaListaDisegni objectAtIndex:rowIndex] alphaline]]; 
		}
		if ([[tableColumn identifier] isEqualToString:   @"alphaS"]) {
			[cell  setFloatValue: [[CopiaListaDisegni objectAtIndex:rowIndex] alphasup]]; 
		}
		
	}	
	
	if ([TavolaPiani isEqual:tableView])	{
	  if ( Disvetcorrente ==nil) return;
	  if ([[tableColumn identifier] isEqualToString:   @"Piano"]) {
  	    [cell  setStringValue:[Disvetcorrente givemenomepianoindice:rowIndex]] ;
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"Visibile"]) {
		if ([Disvetcorrente  visibilepiano:rowIndex ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"Snap"]) {
		if ([Disvetcorrente  snappabilepiano:rowIndex ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"Edit"]) {
		if ([Disvetcorrente  editabilepiano:rowIndex ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"alphaL"]) {
		[cell  setFloatValue: [Disvetcorrente alphalinepiano:rowIndex]]; 
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"alphaS"]) {
		[cell  setFloatValue: [Disvetcorrente alphasuppiano:rowIndex]]; 
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"Colore"]) {	
		NSColor *color = [NSColor colorWithCalibratedRed:[Disvetcorrente colorepianoind_r:rowIndex ] 
												   green:[Disvetcorrente colorepianoind_g:rowIndex ]  
												   blue :[Disvetcorrente colorepianoind_b:rowIndex ] alpha:1];
	  [cell  setBackgroundColor:color ]; 	
      }
	  if ([[tableColumn identifier] isEqualToString:   @"Spessore"]) {
			[cell  setFloatValue: [Disvetcorrente spessorepiano:rowIndex]]; 
	  }
	}
	
	
}


- (void)     passaListavector  : (NSMutableArray *)  _vectorList {
	CopiaListaDisegni =  _vectorList;
}

- (void)     setdisegnoCorrente: (DisegnoV *)  mydisvector       {
	Disvetcorrente = mydisvector;
}

- (void)     aggiorna          : (int) _corrente                 {
	correntevet    = _corrente;
	if ([CopiaListaDisegni count]==0) Disvetcorrente =nil;
		else Disvetcorrente = [CopiaListaDisegni objectAtIndex:correntevet];
	[self updaterighe];
}

- (void)     updaterighe                             {
    [TavolaPiani noteNumberOfRowsChanged];
	[TavolaDisegni noteNumberOfRowsChanged];

}


- (void)     setrowpianocorrente     : (int) indice  {
	[TavolaPiani scrollRowToVisible:indice];
}








- (IBAction) cambioEditiabilePiano   : (id)  sender{
	NSIndexSet * listaselected;  	NSUInteger  illo;   bool visol;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; 
		visol = [Disvetcorrente editabilepiano:illo];	
		if (visol == NSOnState) visol = NSOffState; else visol = NSOnState;
        [Disvetcorrente seteditabilepiano:illo :visol];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo]; [Disvetcorrente seteditabilepiano   :illo :visol];	
	}
}

- (IBAction) cambioSnappabilePiano   : (id)  sender{
	NSIndexSet * listaselected;  	NSUInteger  illo;   bool visol;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; 
		visol = [Disvetcorrente snappabilepiano:illo];	
		if (visol == NSOnState) visol = NSOffState; else visol = NSOnState;
        [Disvetcorrente setsnappabilepiano:illo :visol];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo]; [Disvetcorrente setsnappabilepiano   :illo :visol];	
	}
}



- (IBAction) MostraDialogPiano       : (id)  sender{
	NSUInteger  illo; NSIndexSet * listaselected;  	
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) {
		listaselected = [TavolaPiani selectedRowIndexes];
		illo = [listaselected firstIndex]; 
		[FieldTestoPiano setStringValue:[Disvetcorrente  givemenomepianoindice:illo]  ];
		
		[slidedimpunto setDoubleValue:[Disvetcorrente  dimptPianoInd:illo]  ] ;
		[butvttutti  setState:[Disvetcorrente  dispallinivtpiano:illo] ];
		[butvtfinali setState:[Disvetcorrente  dispallinivtfinalipiano:illo] ];
		
		[NSApp runModalForWindow: _dlgNomePiano];
	}	else {	NSBeep();	return;	}
}




- (IBAction) OKNomePiano             : (id)sender{
	NSUInteger  illo;    NSIndexSet * listaselected; 
	[NSApp stopModal];	[_dlgNomePiano orderOut:self];
	listaselected = [TavolaPiani selectedRowIndexes];
    illo = [listaselected firstIndex]; 
	[Disvetcorrente setnomepianoind  :[FieldTestoPiano stringValue] : illo];
	[Disvetcorrente SetdimptPianoInd :[slidedimpunto   doubleValue] : illo];
	[self updaterighe];
}

- (IBAction) CancelNomePiano         : (id)sender{
	[NSApp stopModal];
	[_dlgNomePiano orderOut:self];
}

- (IBAction) eliminapianodeldisegno  : (id)  sender             {
	NSUInteger  illo;    NSIndexSet * listaselected; 
	listaselected = [TavolaPiani selectedRowIndexes];     illo = [listaselected firstIndex]; 
	[Disvetcorrente EliminaPianoIndice:illo];
	[self updaterighe];
	[NSApp stopModal];	[_dlgNomePiano orderOut:self];
}

- (IBAction) setpallitutti           : (id)  sender {
	NSUInteger  illo;    NSIndexSet * listaselected; 
	listaselected = [TavolaPiani selectedRowIndexes];     illo = [listaselected firstIndex]; 
	if ([butvttutti state]==NSOffState ) [Disvetcorrente setdispallinivtpiano :illo :NO]; 
	                         else	 [Disvetcorrente setdispallinivtpiano :illo :YES];
}

- (IBAction) setpallifinale          : (id)  sender {
	NSUInteger  illo;    NSIndexSet * listaselected; 
	listaselected = [TavolaPiani selectedRowIndexes];     illo = [listaselected firstIndex]; 
	if ([butvtfinali state]==NSOffState ) [Disvetcorrente setdispallinivtfinalipiano: illo :NO]; 
							else	 [Disvetcorrente setdispallinivtfinalipiano: illo :YES];
}



- (int)      pianoDlgSelezionato     {
	int resulta=-1;
	NSIndexSet * listaselected;  
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { resulta = [listaselected firstIndex]; 	}
	return resulta;
}

- (int)      DisegnoDlgSelezionato     {
	int resulta=-1;
	NSIndexSet * listaselected;  
	listaselected = [TavolaDisegni selectedRowIndexes];
	if (listaselected.count>0) { resulta = [listaselected firstIndex]; 	}
	return resulta;
}


	////

- (void) cambiaselezionatopiano : (int) passo {
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:passo];
	[TavolaPiani selectRowIndexes:indexes byExtendingSelection:NO];
	
}

- (void)     cambiaselezionatodisegno  : (int) passo  {
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:passo];
	[TavolaDisegni selectRowIndexes:indexes byExtendingSelection:NO];
}



@end
