//
//  ComandiDlg.m
//  MacOrMap
//
//  Created by Carlo Macor on 11/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "ComandiDlg.h"


@implementation ComandiDlg

int indoLastRaster;
int indoRastererino;

DisegnoR * LastRaster;

- (void)     initComandiDlg                          {
} 

- (IBAction) daDlgCorrenteRaster       : (id) sender {
	int indsel = [[[varbase barilectr] ctrDlgRaster]  IndSelezionato];
	[varbase setindiceRasterCorrente: indsel];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
	[varbase AggiornaParametriListeRaster];
}


- (IBAction) daDlgsetOnRaster          : (id) sender {
	DisegnoR *RasterLoc;	// Raster   *RasterinoLoc;	
	int indsel = [[[varbase barilectr] ctrDlgRaster]  IndSelezionato];
	
	RasterLoc = [[varbase Listaraster]  objectAtIndex:indsel];
	if ([RasterLoc isvisibleRaster]) [RasterLoc setvisibile:NSOffState]; else [RasterLoc setvisibile:NSOnState];
/*
	RasterLoc = [self rasterDisInd :indsel];
    if (RasterLoc != nil) {
		[varbase setindiceRasterCorrente: indoLastRaster];
		if ([RasterLoc isvisibleRaster]) [RasterLoc setvisibile:NSOffState]; else [RasterLoc setvisibile:NSOnState];
	}
	else {
		RasterinoLoc = [self rasterinoInd:indsel];
		if (RasterinoLoc != nil) {
			[varbase setindiceRasterCorrente: indoLastRaster];
			[LastRaster setindiceSubRasterCorrente :indoRastererino];
			if ([RasterinoLoc visibile]) [RasterinoLoc setvisibile:NSOffState]; else [RasterinoLoc setvisibile:NSOnState];
		}
	}
*/
    [[[varbase barilectr ]  ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
	[varbase AggiornaParametriListeRaster];

	[progetto display];
}

- (IBAction) daDlgAlphaRaster          : (id) sender {
	DisegnoR *RasterLoc;	// Raster   *RasterinoLoc;	
	int indsel = [[[varbase barilectr ]  ctrDlgRaster]  IndSelezionato];
	
	RasterLoc = [[varbase Listaraster]  objectAtIndex:indsel];
	[RasterLoc setalpha:[sender floatValue ]] ;	

	
/*	
	RasterLoc = [self rasterDisInd :indsel];
    if (RasterLoc != nil) {	
		[varbase setindiceRasterCorrente: indoLastRaster];
		[RasterLoc setalpha:[sender floatValue ]] ;	
	}
	else {	
		   RasterinoLoc = [self rasterinoInd:indsel];	
		   if (RasterinoLoc != nil) { 
			   [varbase setindiceRasterCorrente: indoLastRaster];
			   [LastRaster setindiceSubRasterCorrente :indoRastererino];
			   [RasterinoLoc setalpha:[sender floatValue ]];	
		 }
	}
*/
 [varbase AggiornaParametriListeRaster];
	[progetto display];
}

- (IBAction) daDlgBWRaster             : (id) sender {
	DisegnoR *RasterLoc;	 Raster   *RasterinoLoc;	
	int indsel = [[[varbase barilectr ]  ctrDlgRaster]  IndSelezionato];
	RasterLoc = [self rasterDisInd :indsel];
    if (RasterLoc != nil) {
		[varbase setindiceRasterCorrente: indoLastRaster];
		if ([RasterLoc isMaskableRaster]) [RasterLoc setmaskabile:NO : 1];	  else [RasterLoc setmaskabile:YES : 1];
	}
	else {	RasterinoLoc = [self rasterinoInd:indsel];	
		if (RasterinoLoc != nil) {
			[varbase setindiceRasterCorrente: indoLastRaster];
			[LastRaster setindiceSubRasterCorrente :indoRastererino];
			if ([RasterinoLoc NoBianco]) [RasterinoLoc setmaskabile:NO : 1];	  else [RasterinoLoc setmaskabile:YES : 1];
		}
	}
	[[[varbase barilectr ]  ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
	[varbase AggiornaParametriListeRaster];

	[progetto display];
}

- (IBAction) daDlgUpRaster             : (id)sender {
	DisegnoR *RasterLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgRaster]  IndSelezionato];
    if (indsel>0) {
		RasterLoc = [[varbase Listaraster]  objectAtIndex:indsel];
        [[varbase Listaraster] removeObjectAtIndex:indsel];
		[[varbase Listaraster] insertObject:RasterLoc atIndex:indsel-1];
		if ([varbase indiceRasterCorrente]==indsel) { [varbase setindiceRasterCorrente:indsel-1];	} else {
			if ([varbase indiceRasterCorrente]==(indsel-1)) [varbase setindiceRasterCorrente:indsel];
		}
        [[[varbase barilectr ]  ctrDlgRaster] cambiaselezionato : indsel-1];
		[[[varbase barilectr ]  ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
		[varbase AggiornaParametriListeRaster];
		[progetto display];
	}
}
	// da aggiungere che se era il corrente da modificare lo stato corrente raster

- (IBAction) daDlgDownRaster           : (id)sender {
	DisegnoR *RasterLoc;

	int indsel = [[[varbase barilectr ]  ctrDlgRaster]  IndSelezionato];
    if (indsel<[[varbase Listaraster] count]-1) {
		RasterLoc = [[varbase Listaraster]  objectAtIndex:indsel];
        [[varbase Listaraster] removeObjectAtIndex:indsel];
		
		[[varbase Listaraster] insertObject:RasterLoc atIndex:indsel+1];
		
		if ([varbase indiceRasterCorrente]==indsel) { [varbase setindiceRasterCorrente:indsel+1];	} else {
			if ([varbase indiceRasterCorrente]==(indsel+1)) [varbase setindiceRasterCorrente:indsel];
		}
		
		[[[varbase barilectr ]  ctrDlgRaster] cambiaselezionato : indsel+1];

		[[[varbase barilectr ]  ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
		[varbase AggiornaParametriListeRaster];
		[progetto display];
    }
}


- (IBAction) daDlgTitoloRaster         : (id) sender {
	NSBeep();
}

- (IBAction) daDlgColoreRaster         : (id) sender {
		NSColorPanel *pancol = [NSColorPanel sharedColorPanel];
		[pancol  setContinuous:NO];
		[pancol orderFront:self];
		[pancol setTarget:self];
	[pancol setAction:@selector(cambColRastutti:)];
}

- (void)     cambColRastutti           :(NSColorPanel *) pancol {
	DisegnoR *RasterLoc;	 Raster   *RasterinoLoc;	
	int indsel = [[[varbase barilectr ]  ctrDlgRaster]  IndSelezionato];
	RasterLoc = [self rasterDisInd :indsel];
    if (RasterLoc != nil) { 
		[varbase setindiceRasterCorrente: indoLastRaster];
        [RasterLoc  CambiaColore:[pancol color]];	
	}
	else {	RasterinoLoc = [self rasterinoInd:indsel];	
		if (RasterinoLoc != nil) { 
			[varbase setindiceRasterCorrente: indoLastRaster];
			[RasterinoLoc  CambiaColore:[pancol color]];}
	}
	[[[varbase barilectr ]  ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
	[progetto display];
}

    // vettoriale
- (IBAction) cambioVisibilePiano       : (id) sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;   bool visol;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; 
		visol = [[varbase DisegnoVcorrente] visibilepiano:illo];	
		if (visol == NSOnState) visol = NSOffState; else visol = NSOnState;
		[[varbase DisegnoVcorrente] setvisibilepiano   :illo :visol];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo]; [[varbase DisegnoVcorrente] setvisibilepiano   :illo :visol];	
	}
    [progetto display];
}

- (IBAction) cambioEditPiano           : (id)sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;   bool edittab;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; 
		edittab = [[varbase DisegnoVcorrente] editabilepiano:illo];	
		if (edittab == NSOnState) edittab = NSOffState; else edittab = NSOnState;
		[[varbase DisegnoVcorrente] seteditabilepiano   :illo :edittab];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo]; [[varbase DisegnoVcorrente] seteditabilepiano: illo :edittab];	
	}
    [progetto display];
}

- (IBAction) cambioSnapPiano           : (id)sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;   bool snappab;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; 
		snappab = [[varbase DisegnoVcorrente] snappabilepiano:illo];	
		if (snappab == NSOnState) snappab = NSOffState; else snappab = NSOnState;
		[[varbase DisegnoVcorrente] setsnappabilepiano   :illo :snappab];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo]; [[varbase DisegnoVcorrente] setsnappabilepiano: illo :snappab];	
	}
    [progetto display];
}




- (IBAction) cambioAlphaLinePiano      : (id) sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; [[varbase DisegnoVcorrente] setalphalinepiano : illo: [sender floatValue]];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];
		[[varbase DisegnoVcorrente] setalphalinepiano : illo: [sender floatValue]];
	}
    [progetto display];
}

- (IBAction) cambioAlphaLineDisegno    : (id) sender {
	DisegnoV * DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
	[DisegnoLoc setalphaline:[sender floatValue]];

    [progetto display];
}


- (IBAction) cambioAlphaSupPiano       : (id) sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; [[varbase DisegnoVcorrente] setalphasuppiano:  illo: [sender floatValue]];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];
		[[varbase DisegnoVcorrente] setalphasuppiano : illo: [sender floatValue]];
	}
    [progetto display];
}

- (IBAction) cambioAlphaSupDisegno     : (id) sender {
	DisegnoV * DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
	[DisegnoLoc setalphasup:[sender floatValue]];
		//	[[[varbase barilectr ]  ctrDlgVector] updaterighe];
	
	[progetto display];
}

- (IBAction) cambioSpessorePiano       : (id) sender {
	NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { illo = [listaselected firstIndex]; [[varbase DisegnoVcorrente] setspessorepiano : illo: [sender floatValue]];	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];		[[varbase DisegnoVcorrente] setspessorepiano : illo: [sender floatValue]];
	}
    [progetto display];
}

- (IBAction) cambiatratteggio          : (id) sender {
	NSUInteger  illo;    NSIndexSet * listaselected; 
	listaselected = [TavolaPiani selectedRowIndexes];     illo = [listaselected firstIndex]; 
	[[varbase DisegnoVcorrente] settratteggiopiano:illo:[sender indexOfSelectedItem] ]; 
    [progetto display];

}

- (IBAction) cambiacampitura           : (id) sender {
	NSUInteger  illo;    NSIndexSet * listaselected; 
	listaselected = [TavolaPiani selectedRowIndexes];     illo = [listaselected firstIndex]; 
	[[varbase DisegnoVcorrente] setCampitura:illo:[sender indexOfSelectedItem] ]; 
    [progetto display];
	
}


- (void)     colorpianochangdlg        : (NSColorPanel *) pancol {
	NSIndexSet * listaselected;  	NSUInteger  illo;
	listaselected = [TavolaPiani selectedRowIndexes];
	if (listaselected.count>0) { 
		illo = [listaselected firstIndex]; 
		[[varbase DisegnoVcorrente] setcolorepianorgb: illo  :  [[pancol color] redComponent]   : [[pancol color] greenComponent] : [[pancol color] blueComponent] ];
	}
	for (int i=1; i<listaselected.count; i++) {  
		illo =  [listaselected indexGreaterThanIndex:illo];
		[[varbase DisegnoVcorrente] setcolorepianorgb: illo  :  [[pancol color] redComponent]   : [[pancol color] greenComponent] : [[pancol color] blueComponent] ];
	}
    [progetto display];

    [TavolaPiani noteNumberOfRowsChanged];
}


- (IBAction) daDlgUpPiano              : (id)sender {
	Piano *PianoLoc;
	DisegnoV * DisegnoLoc;
	DisegnoLoc = [varbase DisegnoVcorrente];
	int indsel = [[[varbase barilectr ]  ctrDlgVector]  pianoDlgSelezionato];
    if (indsel>1) {
		PianoLoc = [[DisegnoLoc ListaPiani]  objectAtIndex:indsel];
        [[DisegnoLoc ListaPiani] removeObjectAtIndex:indsel];
		[[DisegnoLoc ListaPiani] insertObject:PianoLoc atIndex:indsel-1];
		/*
		if ([varbase indiceRasterCorrente]==indsel) { [varbase setindiceRasterCorrente:indsel-1];	} else {
			if ([varbase indiceRasterCorrente]==(indsel-1)) [varbase setindiceRasterCorrente:indsel];
		}
		*/
	    [[[varbase barilectr ]  ctrDlgVector] cambiaselezionatopiano: indsel-1];
	    [[[varbase barilectr ]  ctrDlgVector] updaterighe];
			//		[varbase AggiornaParametriListeRaster];
		[progetto display];
	}
}

- (IBAction) daDlgDownPiano            : (id)sender {
	Piano *PianoLoc;
	DisegnoV * DisegnoLoc;
	DisegnoLoc = [varbase DisegnoVcorrente];
	int indsel = [[[varbase barilectr ]  ctrDlgVector]  pianoDlgSelezionato];
	if ((indsel<([[DisegnoLoc ListaPiani] count]-1)) & (indsel>0)) {
		PianoLoc = [[DisegnoLoc ListaPiani]  objectAtIndex:indsel];
        [[DisegnoLoc ListaPiani] removeObjectAtIndex:indsel];
		[[DisegnoLoc ListaPiani] insertObject:PianoLoc atIndex:indsel+1];
		/*
		 if ([varbase indiceRasterCorrente]==indsel) { [varbase setindiceRasterCorrente:indsel-1];	} else {
		 if ([varbase indiceRasterCorrente]==(indsel-1)) [varbase setindiceRasterCorrente:indsel];
		 }
		 */
		[[[varbase barilectr ]  ctrDlgVector] cambiaselezionatopiano: indsel+1];
	    [[[varbase barilectr ]  ctrDlgVector] updaterighe];
			//		[varbase AggiornaParametriListeRaster];
		[progetto display];
	}
}

- (IBAction) daDlgUpDisegno            : (id)sender {
	DisegnoV *DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector]  DisegnoDlgSelezionato];
    if (indsel>0) {
		DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
        [[varbase ListaVector] removeObjectAtIndex:indsel];
		[[varbase ListaVector] insertObject:DisegnoLoc atIndex:indsel-1];

		if ([varbase indiceVectorCorrente]==indsel) { [varbase setindiceVectorCorrente:indsel-1];	} else {
			if ([varbase indiceVectorCorrente]==(indsel-1)) [varbase setindiceVectorCorrente:indsel];
		}
	    [[[varbase barilectr ]  ctrDlgVector] cambiaselezionatodisegno : indsel-1];
		[[[varbase barilectr ]  ctrDlgVector] updaterighe];
			//		[varbase AggiornaParametriListeRaster];
		[progetto display];
	}
}

- (IBAction) daDlgDownDisegno          : (id)sender {
	DisegnoV *DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector]  DisegnoDlgSelezionato];
    if (indsel<([[varbase ListaVector] count]-1)) {
		DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
        [[varbase ListaVector] removeObjectAtIndex:indsel];
		[[varbase ListaVector] insertObject:DisegnoLoc atIndex:indsel+1];

		if ([varbase indiceVectorCorrente]==indsel) { [varbase setindiceVectorCorrente:indsel+1];	} else {
			if ([varbase indiceVectorCorrente]==(indsel+1)) [varbase setindiceVectorCorrente:indsel];
		}
		[[[varbase barilectr ]  ctrDlgVector] cambiaselezionatodisegno : indsel+1];
		[[[varbase barilectr ]  ctrDlgVector] updaterighe];
			//		[varbase AggiornaParametriListeRaster];
		[progetto display];
	}
}


- (IBAction) daDlgsetOnDisegno         : (id)sender {
	DisegnoV * DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
	[DisegnoLoc setvisibile:![DisegnoLoc visibile]];
	[[[varbase barilectr ]  ctrDlgVector] updaterighe];

	[progetto display];
}

- (IBAction) daDlgsetEditDisegno       : (id)sender {
	DisegnoV * DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
	[DisegnoLoc seteditabile:![DisegnoLoc editabile]];
	[[[varbase barilectr ]  ctrDlgVector] updaterighe];

		//	[progetto display];
}

- (IBAction) daDlgsetSnapDisegno       : (id)sender {
	DisegnoV * DisegnoLoc;
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	DisegnoLoc = [[varbase ListaVector]  objectAtIndex:indsel];
	[DisegnoLoc setsnappabile:![DisegnoLoc snappabile]];
	[[[varbase barilectr ]  ctrDlgVector] updaterighe];

		//	[progetto display];
}


- (IBAction) daDlgCorrenteDisegno      : (id)sender {
		//	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
		//	[varbase AggiornaParametriListeRaster];
	
	
	int indsel = [[[varbase barilectr ]  ctrDlgVector] DisegnoDlgSelezionato ];
	[varbase  setindiceVectorCorrente   : indsel];                            
		//	[[[varbase barilectr ]  ctrDlgVector] updaterighe];
	
	
}


- (IBAction) cambioColorePianoTavola   : (id) sender {
	NSColorPanel *pancol = [NSColorPanel sharedColorPanel];
	[pancol orderFront:self];
	[pancol setTarget:self];
    [pancol setAction:@selector(colorpianochangdlg:)];
}


- (Raster   *) rasterinoInd            : (int) ind   {
	DisegnoR *RasterLoc; int contatore=0;
	Raster   *risulta;
	for (int i=0; i<[[varbase Listaraster] count]; i++) {
		RasterLoc = [[varbase Listaraster]  objectAtIndex:i]; contatore ++;
		LastRaster = RasterLoc;
		indoLastRaster = i;
		for (int j=0; j<[RasterLoc numimg]; j++) {
			risulta = [[RasterLoc Listaimgraster] objectAtIndex:j];
			if (contatore==ind) { indoRastererino=j; return risulta;	}
			contatore ++;
		}
	}
	return nil;
}

- (DisegnoR *) rasterDisInd            : (int) ind   {
	DisegnoR *RasterLoc; int contatore=0;
	for (int i=0; i<[[varbase Listaraster] count]; i++) {
		RasterLoc = [[varbase Listaraster]  objectAtIndex:i];
        if (contatore==ind) {
			indoLastRaster = i;
			return RasterLoc;
		} 
		contatore = contatore+[RasterLoc numimg]+1;
	}
	return nil;
}


@end
