//
//  CtrDlgRaster.m
//  MacOrMap
//
//  Created by Carlo Macor on 10/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "CtrDlgRaster.h"


@implementation CtrDlgRaster

DisegnoR *LastRaster;
int indselected; 
BOOL subcorrente;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView    {
	return [CopiaListaRaster  count];
/*	
	int risulta=0; DisegnoR *RasterLoc;
	for (int i=0; i<[CopiaListaRaster  count]; i++) {
		RasterLoc = [CopiaListaRaster objectAtIndex:i];
		risulta = risulta+[RasterLoc numimg]+1;
	}
	return risulta;	
 */
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return 0;
}

- (void)tableView:(NSTableView *)tableView  willDisplayCell:(id)cell  forTableColumn:(NSTableColumn *) tableColumn row:(NSInteger)rowIndex {
	DisegnoR *RasterLoc;
	RasterLoc = [CopiaListaRaster objectAtIndex:rowIndex ];// [self rasterDisInd :rowIndex];
    if (RasterLoc != nil) {
	  if ([[tableColumn identifier] isEqualToString:   @"Nome"])  {   [cell setTitle:[RasterLoc damminomefileNoExt:0]] ;
		                                                              [cell setAlignment: NSLeftTextAlignment]; 
		if (rowIndex==IndRastCorrente)  [cell  setState:NSOnState]; else  [cell  setState:NSOffState];
	  }
	  if ([[tableColumn identifier] isEqualToString:   @"On"])    {   if ([RasterLoc  isvisibleRaster ]) [cell  setState:NSOnState]; else  [cell  setState:NSOffState];	}
	  if ([[tableColumn identifier] isEqualToString:   @"alpha"]) {	  [cell  setFloatValue: [RasterLoc alpha]]; }
	}
}

- (void)     passaRaster  : (NSMutableArray *)  RasterList {
	CopiaListaRaster =  RasterList;
	lightOn  =	[NSImage imageNamed: [NSString stringWithFormat:@"LightOn.png"]];
    lightOff =	[NSImage imageNamed: [NSString stringWithFormat:@"LightOff.png"]];
}

- (void)     updaterighe    : (int) indcorrente            {
	IndRastCorrente = indcorrente;
	
		//	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:indcorrente];
		//	[Tavola selectRowIndexes:indexes byExtendingSelection:NO];
	
	[Tavola noteNumberOfRowsChanged];
}

- (void) cambiaselezionato : (int) passo {
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:passo];
	[Tavola selectRowIndexes:indexes byExtendingSelection:NO];

}

- (Raster *) rasterinoInd : (int) ind {
	DisegnoR *RasterLoc; int contatore=0;
	Raster   *risulta;
	subcorrente = NO;
	BOOL possibilesubcorrente;
	
	for (int i=0; i<[CopiaListaRaster count]; i++) {
		RasterLoc = [CopiaListaRaster  objectAtIndex:i]; contatore ++;
		possibilesubcorrente =NO;
        if ((indselected<=contatore) & ((indselected+[RasterLoc numimg] )>contatore)) possibilesubcorrente =YES;
		LastRaster = RasterLoc;
		for (int j=0; j<[RasterLoc numimg]; j++) {
			subcorrente = NO;
			risulta = [[RasterLoc Listaimgraster] objectAtIndex:j];
            if ((j==[LastRaster indiceSubRastercorrente]) & (possibilesubcorrente)) subcorrente=YES;
			if (contatore==indselected)  subcorrente=YES;
			if (contatore==ind)    return risulta;
			contatore ++;
		}
	}
	return nil;
}

- (DisegnoR *) rasterDisInd : (int) ind {
	DisegnoR *RasterLoc; int contatore=0;
	subcorrente = NO;
	for (int i=0; i<[CopiaListaRaster count]; i++) {
		RasterLoc = [CopiaListaRaster  objectAtIndex:i];
        if (contatore==ind) return RasterLoc;
		contatore = contatore+[RasterLoc numimg]+1;
	}
	return nil;
}

- (int)      IndSelezionato {
	indselected = [Tavola selectedRow];
	return indselected;			
}




@end
