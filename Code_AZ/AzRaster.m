//
//  AzRaster.m
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "AzRaster.h"
#import "DisegnoR.h"



@implementation AzRaster

- (void) InitAzRaster                                     {
	[[[varbase barilectr] ctrDlgRaster]     passaRaster:[varbase Listaraster]];
}


 

-(NSArray *) OpenNomiFilesRaster                          { 
	NSOpenPanel *panel;
    panel = [NSOpenPanel openPanel];        
    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
	[panel setAllowsMultipleSelection:YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects: @"tif", @"tiff",@"pdf",@"gif",@"png",@"jpg",@"bmp",nil ] ];
	int i = [panel runModal];
	if(i == NSOKButton){ return [panel filenames];   }
    return nil;
}    



- (void) comandobottone                : (NSInteger) com  {
	[progetto chiusuracomandoprecedente];
	[varbase  comandodabottone : com ];
}

- (IBAction) Apri_DlgRaster            : (id)sender {
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];
	[[bariledlg dlgGesRast] orderFront:self];
}

- (IBAction) Chiudi_DlgRaster          : (id)sender {
	[[bariledlg dlgGesRast] orderOut:self];
}

- (int)     giapresenteImmagine       : (NSString * ) nomefile {
	int risulta =-1;
	DisegnoR *locdisras;
	for (int i=0; i<[varbase Listaraster].count; i++) {  
		locdisras= [[varbase Listaraster] objectAtIndex:i];	
		if ([[locdisras interonomefile:0] isEqualToString: nomefile]) {	risulta=i; break;	}
	}
	return risulta;
}


- (IBAction) openCalRaster             : (id)sender{
	[progetto chiusuracomandoprecedente ];
	if ([varbase comando]==kStato_Calibraraster) [varbase setcomando:kStato_nulla]; else	[varbase setcomando:kStato_Calibraraster];  
	[varbase setfasecomando:0];	
	[varbase AggiornaInterfaceComandoAzione];
    varbase.d_x1coord = 0;	varbase.d_y1coord = 0;   varbase.d_x2coord = 0;	varbase.d_y2coord = 0;
    varbase.d_x3coord = 0;	varbase.d_y3coord = 0;   varbase.d_x4coord = 0;	varbase.d_y4coord = 0;
	[[varbase dlcalRas] orderFront:self];
}

- (IBAction) OKCalibraRaster           : (id)sender{

		// NSLog(@"OK G");

	
	 [[varbase dlcalRas]  orderOut:self];
     bool utmcord =YES;
	 if (((varbase.d_x1coord==0) | (varbase.d_y3coord==0))  |	((varbase.d_x2coord==0) | (varbase.d_y4coord==0)) )  {	NSBeep(); return;  }
	 double x1cordins = [txtX1rast doubleValue];
	 double y1cordins = [txtY1rast doubleValue];
	 double x2cordins = [txtX2rast doubleValue];
	 double y2cordins = [txtY2rast doubleValue];
	 if (((x1cordins==0) | (y1cordins==0))  |	((x2cordins==0) | (y2cordins==0)) )  {	NSBeep(); return;  }

	[[varbase DisegnoRcorrente] impostaUndoCorrenteTutto: [varbase MUndor]];

	 if (y1cordins<1000000) utmcord=NO;
	 if (utmcord) {
		 [info catastotoutm    :  &x1cordins : &y1cordins ];
		 [info catastotoutm    :  &x2cordins : &y2cordins ];
			 //	 	   while (x1cordins>1010000) {  x1cordins= x1cordins-1010000;	}
			 //	 	   while (x2cordins>1010000) {  x2cordins= x2cordins-1010000;	}
	 [[varbase DisegnoRcorrente] rotoscala   :varbase.d_x1coord : varbase.d_y3coord :varbase.d_x2coord : varbase.d_y4coord
											 :x1cordins : y1cordins :x2cordins : y2cordins 	 : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ]; 
	                         } else {
	 [info catastotoutm    :  &x1cordins : &y1cordins ];
	 [info catastotoutm    :  &x2cordins : &y2cordins ];
	 [[varbase DisegnoRcorrente] rotoscala   :varbase.d_x1coord : varbase.d_y3coord :varbase.d_x2coord : varbase.d_y4coord
	                                         :x1cordins : y1cordins :x2cordins : y2cordins  : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ]; 
	 }
	 [varbase comando00];
	 [self CambioSubRaster : [[varbase DisegnoRcorrente] indiceSubRastercorrente]];

	 [progetto ZoomLocRaster:self];
}

- (IBAction) CancCalibraRaster         : (id)sender{
	[[varbase dlcalRas] orderOut:self];
	[varbase comando00];
}

- (IBAction) comx1calras               : (id)sender{
	[[varbase dlcalRas]  orderOut:self];
	[varbase setcomando:kStato_Calibraraster]; 
	[varbase setfasecomando:1];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) comx2calras               : (id)sender{
	[[varbase dlcalRas]  orderOut:self];
	[varbase setcomando:kStato_Calibraraster];
	[varbase setfasecomando:2];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) comy1calras               : (id)sender{
	[[varbase dlcalRas]  orderOut:self];
	[varbase setcomando:kStato_Calibraraster];
	[varbase setfasecomando:3];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) comy2calras               : (id)sender{
	[[varbase dlcalRas]  orderOut:self];
	[varbase setcomando:kStato_Calibraraster]; 
	[varbase setfasecomando:4];
	[varbase AggiornaInterfaceComandoAzione];
}



- (IBAction) openFCalRaster            : (id)sender{
	[progetto chiusuracomandoprecedente ];
	if ([varbase comando]==kStato_CalibrarasterFix) [varbase setcomando:kStato_nulla]; else	
		[varbase setcomando:kStato_CalibrarasterFix];  
	[varbase setfasecomando:0];	
	[varbase AggiornaInterfaceComandoAzione];
    varbase.d_x1coord = 0;	varbase.d_y1coord = 0;   varbase.d_x2coord = 0;	varbase.d_y2coord = 0;
    varbase.d_x3coord = 0;	varbase.d_y3coord = 0;   varbase.d_x4coord = 0;	varbase.d_y4coord = 0;
	[[varbase dlcalRasF] orderFront:self];
}

- (IBAction) OKFCalibraRaster          : (id)sender{
	[[varbase dlcalRasF]  orderOut:self];
	 bool utmcord =YES;
	 if ((varbase.d_x1coord==0) | (varbase.d_y2coord==0))   {	NSBeep(); return;  }
		//	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
		//	int dimmoimg = [RasterCorrente getdimx_indrast:  [RasterCorrente indiceSubRastercorrente]];
		//	if (dimmoimg == 2376) {		NSBeep(); dximgint=2198;	}
	 double offxpx   = 100;
	 double offypx   = 100;
	 double dximgint = 1512;
	 double d_x2calcolato ;
	 double d_y2calcolato ;
	 double x1cordins = [txtFX1rast doubleValue];
	 double y1cordins = [txtFY1rast doubleValue];
	 double x2cordins = x1cordins+offxpx;
	 double y2cordins = y1cordins+offypx; 
	
	int indscala = [Csegscafix selectedSegment];
	switch (indscala) {
		case 0:  // 500
			d_x2calcolato = varbase.d_x1coord + (offxpx/133.5)*dximgint;
			d_y2calcolato = varbase.d_y2coord + (offypx/133.5)*dximgint;
			break;
		case 1:  // 1.000
			d_x2calcolato = varbase.d_x1coord + (offxpx/267)*dximgint;
			d_y2calcolato = varbase.d_y2coord + (offypx/267)*dximgint;
 		break;
		case 2:  // 2.000
			d_x2calcolato = varbase.d_x1coord + (offxpx/534)*dximgint; 
			d_y2calcolato = varbase.d_y2coord + (offxpx/534)*dximgint; 
		break;
		case 3:  // 4.000
			d_x2calcolato = varbase.d_x1coord + (offxpx/1068)*dximgint;
			d_y2calcolato = varbase.d_y2coord + (offxpx/1068)*dximgint;;
		break;
		case 4:  // 10.000
			d_x2calcolato = varbase.d_x1coord + (offxpx/2670)*dximgint; 
			d_y2calcolato = varbase.d_y2coord + (offxpx/2670)*dximgint; 
		break;
		default:		break;
	}
	
		//	NSLog(@"x1  %1.2f",x1cordins);
	[[varbase DisegnoRcorrente] impostaUndoCorrenteTutto: [varbase MUndor]];

     if (x1cordins<100000) utmcord=NO;
	if (utmcord) {	 
		[info catastotoutm    :  &x1cordins : &y1cordins ];
		[info catastotoutm    :  &x2cordins : &y2cordins ];
	 [[varbase DisegnoRcorrente] rotoscala   :varbase.d_x1coord : varbase.d_y2coord :d_x2calcolato : d_y2calcolato
                                       	     :x1cordins : y1cordins :x2cordins : y2cordins 	 : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ]; 
	 } else {
	 [info catastotoutm    :  &x1cordins : &y1cordins ];
	 [info catastotoutm    :  &x2cordins : &y2cordins ];
			 //	 NSLog(@"px1 %1.2f",x1cordins);		 NSLog(@"px2 %1.2f",x2cordins);		 NSLog(@"py1 %1.2f",y1cordins);		 NSLog(@"py2 %1.2f",y2cordins);
	 [[varbase DisegnoRcorrente] rotoscala   :varbase.d_x1coord : varbase.d_y2coord :d_x2calcolato : d_y2calcolato
	                                         :x1cordins : y1cordins :x2cordins : y2cordins 	 : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ]; 
	 }
	 [progetto ZoomLocRaster:self];
	 [self CambioSubRaster : [[varbase DisegnoRcorrente] indiceSubRastercorrente]];

	 [varbase comando00];
}

- (IBAction) CancFCalibraRaster        : (id)sender{
	[[varbase dlcalRasF] orderOut:self];
	[varbase comando00];
}

- (IBAction) comFx1calras              : (id)sender{
	[varbase setcomando:kStato_CalibrarasterFix]; 
	[varbase setfasecomando:1];
	[varbase AggiornaInterfaceComandoAzione];
	[[varbase dlcalRasF]  orderOut:self];
}

- (IBAction) comFy1calras              : (id)sender{
	[varbase setcomando:kStato_CalibrarasterFix];
	[varbase setfasecomando:2];
	[varbase AggiornaInterfaceComandoAzione];
    [[varbase dlcalRasF]  orderOut:self];
}






- (IBAction) OKRighello                : (id)sender{
	double         d_datoinserito;
	d_datoinserito= [[txtdimrighello stringValue] doubleValue];	
	if (d_datoinserito>0.1) {	if ([varbase DisegnoRcorrente] !=nil)
		{ 
			[[varbase DisegnoRcorrente] impostaUndoCorrenteScala: [varbase MUndor]];
			[[varbase DisegnoRcorrente] setscalaDisraster: (varbase.d_lastdist/d_datoinserito) 
			: (varbase.d_lastdist/d_datoinserito) : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ] ; }	}
	[varbase comando00];
	[ [varbase dlrighello] orderOut:self];
    [progetto display];
	[self CambioSubRaster : [[varbase DisegnoRcorrente] indiceSubRastercorrente]];
} 

- (IBAction) CancRighello              : (id)sender{
	[varbase comando00];
	[ [varbase dlrighello] orderOut:self];
} 

- (IBAction) CancMancaPolTaglio        : (id)sender {
	[[bariledlg dlgMancaPoligonoSelected] orderOut:self];
}

- (IBAction) OkMancaPolTaglio          : (id)sender {
	[[bariledlg dlgMancaPoligonoSelected] orderOut:self];
	[self  comandobottone : kStato_Seleziona ];
}



- (IBAction) OKdlgNuovaCoord                : (id)sender   {

	int project =varbase.TipoProiezione;
	double	newx,newy;
	switch (project) {
		case 0:	case 2: case 4: case 5:
			newx= [[[interface newXdlgSpostaRaster] stringValue] doubleValue];	
			newy= [[[interface newYdlgSpostaRaster] stringValue] doubleValue];	
		break;
		case 1:	case 3:
			newx= (double)[[[interface newXdlgSpRasterGra ] stringValue] doubleValue]        +
			      (double)([[[interface newXdlgSpRasterMin] stringValue] doubleValue]/60.0)  +
     			  (double)([[[interface newXdlgSpRasterPri] stringValue] doubleValue]/3600.0);
			newy= (double)[[[interface newYdlgSpRasterGra ] stringValue] doubleValue]        +
			      (double)([[[interface newYdlgSpRasterMin] stringValue] doubleValue]/60.0)  +
			      (double)([[[interface newYdlgSpRasterPri] stringValue] doubleValue]/3600.0);
		break;
		default:		break;
	}
	
	
	switch (project) {
		case 0:			break;
		case 1:	[info latlonToUtm   :  &newx : &newy ] ;   break;
		case 2:	[info utm50toutm    :  &newx : &newy ] ;   break;
		case 3:	[info latlon50ToUtm :  &newx : &newy ] ;   break;
		case 4:	[info catastotoutm  :  &newx : &newy ] ;   break;
		case 5:	[info GBoagaToUtm   :  &newx : &newy ] ;   break;

		default:		break;
	}
	
	
	if ([varbase comando] == kStato_spostaRaster2pt_uno)	{
		[[varbase DisegnoRcorrente] impostaUndoCorrenteOrigine: [varbase MUndor]];
		[[varbase DisegnoRcorrente] SpostaOrigine :(newx-varbase.d_xcoordLast) :(newy-varbase.d_ycoordLast) : NO  : [[varbase DisegnoRcorrente] indiceSubRastercorrente] ];
	} 
	if ([varbase comando] == kStato_spostaRaster2pt_tutti)  {
		[[varbase DisegnoRcorrente] impostaUndoTuttiOrigine: [varbase MUndor]];
		[[varbase DisegnoRcorrente] SpostaOrigine :(newx-varbase.d_xcoordLast) :(newy-varbase.d_ycoordLast) : YES : [[varbase DisegnoRcorrente] indiceSubRastercorrente] ];
	}
	
	if ([varbase comando] == kStato_PtTastiera)  {
		[[varbase DisegnoVcorrente] faipunto   :[[NSGraphicsContext currentContext]  graphicsPort] : newx : newy : [varbase MUndor]];   
	}
	if ([varbase comando] == kStato_rotoScal2PtCentrato)  {
		[[varbase DisegnoRcorrente] FissaUndoSeNonRotScaSubcorrente:[varbase MUndor]];
		 //	[[varbase DisegnoRcorrente] impostaUndoCorrenteTutto: [varbase MUndor]];
		 [[varbase DisegnoRcorrente] rotoscala:varbase.xcentrorot : varbase.ycentrorot 
		                                      :varbase.d_xcoordLast : varbase.d_ycoordLast 
		                                      :varbase.xcentrorot : varbase.ycentrorot 
		                                      :newx: newy
		                                      : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ]]; 
		
	}
	
	varbase.xcentrorot = newx;
	varbase.ycentrorot = newy;

	[varbase comando00];	 [NSApp stopModal];	[[bariledlg dlgNuovaCoord] orderOut:self];
	[progetto display]; 	
} 

- (IBAction) CanceldlgNuovaCoord            : (id)sender   {
	[varbase comando00]; [NSApp stopModal];	[ [bariledlg  dlgNuovaCoord] orderOut:self];
}



	// Gruppo Raster

- (IBAction) AddRaster                                      : (id)sender   {
	NSArray *path = [self OpenNomiFilesRaster];
	DisegnoR  *Locdisraster;
    if(path){ 
		for(int i=0; i<[path count]; i++)	{
			if (i==0) {
				Locdisraster = [ DisegnoR alloc];  	  
				[Locdisraster InitDisegnoR :[path objectAtIndex:i] : info];  
				[[varbase Listaraster] addObject:Locdisraster];
				[Locdisraster setalpha:0.7];
			} else {  [Locdisraster addDisegnoR :[path objectAtIndex:i]  ];  }
				//			NSLog(@"Nome Immagine %@",[path objectAtIndex:i]);
		};
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}

	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
			//	[progetto display]; 
			//	[varbase upinterfaceraster];

	}
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) RemoveRaster                                   : (id)sender   {
	[azdialogs ApriDlgConferma:1];
	if (!varbase.rispostaconferma) return;
	DisegnoR *locdisras;
	locdisras= [[varbase Listaraster] objectAtIndex:[varbase indiceRasterCorrente]];
	[[varbase Listaraster] removeObjectAtIndex:[varbase indiceRasterCorrente]];
	[locdisras RemoveDisegnoR];	   [locdisras release];
	[varbase setrastercorrente : [varbase indiceRasterCorrente]-1];
	[varbase DoNomiRasPop];
		//	[self Disegnarasterino];
	[progetto display]; 
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) UpVisRaster                                    : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	NSButton *bu = sender;
	[RasterCorrente setvisibile:[bu state]];
	[progetto display];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) UpAlphaRaster                                  : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
   [RasterCorrente setalpha:[sender floatValue ]];
   [progetto display];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) UpMaskBackRaster                               : (id)sender   {
    int indsel = [sender selectedSegment];
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
    [RasterCorrente setmaskabile:[sender isSelectedForSegment:indsel] :indsel ];
	if (indsel==0) indsel=1; else indsel=0;	[sender setSelected:NO  forSegment:indsel];
	[progetto display];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}


- (IBAction) CmoveRasterAll                                 : (id)sender   {
    [self  comandobottone : kStato_spostaRaster_tutti ];
}

- (IBAction) CmoveRaster2PtAll                              : (id)sender   {
    [self  comandobottone : kStato_spostaRaster2pt_tutti ];
}


- (IBAction) CRotoScal2PtCentrato                           : (id)sender {
	if ((varbase.xcentrorot ==0) & (varbase.ycentrorot ==0)) {	NSBeep(); return; }
	[self  comandobottone : kStato_rotoScal2PtCentrato ];
}


- (IBAction) CambioRasterdaPop                              : (id)sender   {
	if ([varbase Listaraster].count==0) return;
	int indice = [sender indexOfSelectedItem];
	[varbase setrastercorrente   : indice];
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	[interface setRckVisRas:[RasterCorrente isvisibleRaster]];
	[varbase DoNomiSubRasPop];
	[interface setRckVisSubRas : [RasterCorrente visibleRasterIndice:[RasterCorrente indiceSubRastercorrente] ] ];
	[interface setRSlAlphRas   : [RasterCorrente alpha ] ];
	if (![RasterCorrente isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[RasterCorrente isMaskabianca]];	}
	[self CambioSubRaster   : [RasterCorrente indiceSubRastercorrente]];  
}




	// singolo raster

- (IBAction) AddSubRaster                                   : (id)sender   {
	NSArray *path = [self OpenNomiFilesRaster];
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
    if(path){ for(int i=0; i<[path count]; i++)	{ [RasterCorrente addDisegnoR :[path objectAtIndex:i]  ]; };	}
		//    [locdisras setrastercorrente:[varbase Listaraster].count-1];
	[RasterCorrente setindiceSubRasterCorrente  :[RasterCorrente numimg]-1 ];
	[RasterCorrente updateLimiti];
	[progetto ZoomAllRaster:self];
	[varbase DoNomiSubRasPop];
	[interface  setRckVisSubRas:YES];
	[self  CambioSubRaster : [RasterCorrente indiceSubRastercorrente]  ];
	[progetto display]; 
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) RemoveSubRaster                                : (id)sender   {
	[azdialogs ApriDlgConferma:2];
	if (!varbase.rispostaconferma) return;
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	
	if ([RasterCorrente numimg]==1) {
		[RasterCorrente RemoveDisegnoR];	[RasterCorrente release];
		[[varbase Listaraster] removeObjectAtIndex:[varbase indiceRasterCorrente]];
		if ( [varbase indiceRasterCorrente] >= [varbase Listaraster].count ) {
			[varbase setindiceRasterCorrente: ([varbase indiceRasterCorrente]-1) ];
		}
	} else {
		int oldsubindice = [RasterCorrente indiceSubRastercorrente];
		[RasterCorrente RemoveDisegnoRindice:oldsubindice];
		if (oldsubindice>=[RasterCorrente numimg]) oldsubindice --;
		[RasterCorrente setindiceSubRasterCorrente:oldsubindice];
	}
	RasterCorrente = [varbase DisegnoRcorrente];
	[varbase DoNomiRasPop];
		//	if (RasterCorrente !=nil) [self CambioSubRaster  : [RasterCorrente indiceSubRastercorrente ] ];
		//	                     else [self Disegnarasterino ];
	[progetto display]; 
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) UpVisSubRaster                                 : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	NSButton *bu = sender;
	[RasterCorrente setvisibileindice:[RasterCorrente indiceSubRastercorrente] :[bu state]];
    [progetto display];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (IBAction) UpAlphaSubRaster                               : (id)sender   {
    DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	[RasterCorrente setalphaindice: [RasterCorrente indiceSubRastercorrente] :  [sender floatValue] ];
	[progetto display];
	[[[varbase barilectr] ctrDlgRaster] updaterighe:[varbase indiceRasterCorrente]];

}

- (void)     CambioSubRaster                                : (int)indice  {
	 NSString *STR_loc = @"";
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	if (RasterCorrente==nil) { [varbase Disegnarasterino]; STR_loc = @"Dimensione";[[varbase txtDimxyraster] setStringValue:STR_loc];	return;		}
	[RasterCorrente setindiceSubRasterCorrente   : indice];
	[interface setRckVisSubRas    :	[RasterCorrente visibleRasterIndice:[RasterCorrente indiceSubRastercorrente] ] ];
	[interface setRSlAlphSubRas   : [RasterCorrente  alphaindice        :[RasterCorrente indiceSubRastercorrente] ] ];
   
	STR_loc = [STR_loc stringByAppendingFormat: @"%d : %d", [ RasterCorrente	getdimx_indrast:[RasterCorrente indiceSubRastercorrente ]] ,
															[ RasterCorrente	getdimy_indrast:[RasterCorrente indiceSubRastercorrente ]] ];
	[[varbase txtDimxyraster] setStringValue:STR_loc];
	[varbase     aggiornaslideCalRaster ];
	[varbase Disegnarasterino];
}



- (IBAction) CambioSubRasterdaPop                           : (id)sender   {
	[self CambioSubRaster : [sender indexOfSelectedItem]];
}

- (IBAction) CCropRaster                                    : (id)sender   { 
	[progetto chiusuracomandoprecedente];
	bool EsistePol = NO;
	if ([varbase ListaSelezionati].count!=1) { } else {
		Vettoriale * objvector= [[varbase ListaSelezionati] objectAtIndex:0];
		if ([objvector dimmitipo]==3) { EsistePol = YES;  }
	}
	if (!EsistePol) { [[bariledlg dlgMancaPoligonoSelected] orderFront:self];     	return;	} 

	
	[[varbase DisegnoRcorrente] CropConPoligono:[varbase ListaSelezionati] : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) CCropRectRaster                                : (id)sender   { 
	[progetto chiusuracomandoprecedente];
	bool EsistePol = NO;
	if ([varbase ListaSelezionati].count!=1) { } else {
		Vettoriale * objvector= [[varbase ListaSelezionati] objectAtIndex:0];
		if ([objvector dimmitipo]==3) { EsistePol = YES;  }
	}
	if (!EsistePol) { [[bariledlg dlgMancaPoligonoSelected] orderFront:self];     	return;	} 
	
	[[varbase DisegnoRcorrente] CropConRettangolo:[varbase ListaSelezionati] : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) CMaskRaster                                    : (id)sender   { 
	[progetto chiusuracomandoprecedente];
	bool EsistePol = NO;
	if ([varbase ListaSelezionati].count!=1) { } else {
		Vettoriale * objvector= [[varbase ListaSelezionati] objectAtIndex:0];
		if ([objvector dimmitipo]==3) { EsistePol = YES;  }
	}
	if (!EsistePol) { [[bariledlg dlgMancaPoligonoSelected] orderFront:self];     	return;	} 
	
	 [[varbase DisegnoRcorrente] MaskConPoligono:[varbase ListaSelezionati] : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ]  ];
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) CCalibra8Pt                                    : (id)sender   { 
	[self  comandobottone : kStato_calibra8click ];
}

- (IBAction) CUnisciRasters                                 : (id)sender   {
		//
	Raster *locrasterino;
	
	NSSavePanel *   savePanel;
    savePanel = [NSSavePanel savePanel];
	IKSaveOptions * saveOptions;
	saveOptions = [[IKSaveOptions alloc] initWithImageProperties:NULL imageUTType: NULL];
		//	saveOptions = [[IKSaveOptions alloc] initWithImageProperties: metaData imageUTType: utType];
	[saveOptions addSaveOptionsAccessoryViewToSavePanel: savePanel];
	[savePanel setTitle:@"Salva Rasters Uniti"];
    [savePanel setNameFieldStringValue:[[varbase DisegnoRcorrente] damminomefile:0] ];
	[savePanel runModal];
	
	double x1L,x2L,y1L,y2L,scalL;

	for (int i=0; i<[[[varbase DisegnoRcorrente] Listaimgraster] count]; i++) {
		locrasterino = [[[varbase DisegnoRcorrente] Listaimgraster] objectAtIndex:i];
		[locrasterino updateLimiti];
		if (i==0) { x1L = [locrasterino limx1]; x2L = [locrasterino limx2]; y1L = [locrasterino limy1]; y2L = [locrasterino limy2]; scalL = [locrasterino xscala]; }
		if (x1L>[locrasterino limx1]) x1L=[locrasterino limx1];
		if (x2L<[locrasterino limx2]) x2L=[locrasterino limx2];
		if (y1L>[locrasterino limy1]) y1L=[locrasterino limy1];
		if (y2L<[locrasterino limy2]) y2L=[locrasterino limy2];
		
			//		scalL = [locrasterino xscala];
	}
	
	
//	NSLog(@"Limer %2.2f %2.2f %2.2f %2.2f",x1L,y1L,x2L,y2L);
	
	
	NSSize _size;
	_size.width  = (float)((x2L-x1L)/scalL);
	_size.height = (float)((y2L-y1L)/scalL);
	
	NSLog(@"dim %2.2f %2.2f",_size.width,_size.height);
	
	NSImage  *newImage = [[NSImage alloc] initWithSize:_size];  
	[newImage lockFocus];
/*	[[NSColor whiteColor] set];
	NSBezierPath *croppingPath = [NSBezierPath bezierPath];
	NSPoint aPt;
	aPt.x=0;	aPt.y=0; 	[croppingPath moveToPoint:aPt];
	aPt.x=_size.width;	aPt.y=0; 	[croppingPath lineToPoint:aPt];
	aPt.x=_size.width;	aPt.y=_size.height;	[croppingPath lineToPoint:aPt];
	aPt.x=0;	aPt.y=_size.height;	[croppingPath lineToPoint:aPt];
	aPt.x=0;	aPt.y=0; 	[croppingPath lineToPoint:aPt];
	[croppingPath closePath];
	[croppingPath fill];
*/	
	
	NSRect bRect;
	double xr1,yr1;
	
	bRect.origin.x=0;	bRect.origin.y=0;
	bRect.size.width  = _size.width;
	bRect.size.height = _size.height;

	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	

	
	
	for (int i=0; i<[[[varbase DisegnoRcorrente] Listaimgraster] count]; i++) {
	  locrasterino = [[[varbase DisegnoRcorrente] Listaimgraster] objectAtIndex:i];
		xr1 = ([locrasterino xorigine] - x1L)/ scalL ;
		yr1 = ([locrasterino yorigine] - y1L)/ scalL ;
		
		bRect.origin.x=xr1;	bRect.origin.y=yr1;
		bRect.size.width  = [locrasterino dimx];
		bRect.size.height = [locrasterino dimy];

 	  CGContextSaveGState (hdc);
            //	  if ([locrasterino angolo]!=0) {
		CGAffineTransform trRot  = CGAffineTransformMakeRotation    ( [locrasterino angolo] );
		CGAffineTransform tr0    = CGAffineTransformMakeTranslation ( -xr1 ,-yr1 );
		CGAffineTransform tr1    = CGAffineTransformMakeTranslation (  xr1 , yr1 );
        CGAffineTransform trSca  = CGAffineTransformMakeScale       ([locrasterino xscala]/scalL,[locrasterino yscala]/scalL);
          
          
		CGAffineTransform trAll  = CGAffineTransformConcat          ( tr0   , trSca );
          
        trAll  = CGAffineTransformConcat          ( trAll , trRot );   
		trAll  = CGAffineTransformConcat          ( trAll , tr1 );
        CGContextConcatCTM (hdc	, trAll );
            //	  }
	  CGContextDrawImage  (hdc,bRect,[locrasterino ImgRef]);   
	  CGContextRestoreGState ( hdc );
	}	
	
	
	
	[newImage unlockFocus];

	
	locrasterino = [[[varbase DisegnoRcorrente] Listaimgraster] objectAtIndex:0];
	
    [locrasterino InitRasterImgRef :[newImage CGImageForProposedRect:NULL context:NULL hints:NULL]];  
    [locrasterino FissaOrigine     : x1L : y1L];
	[locrasterino ruota            : 0];

	
	CGImageRef imageorigine = [newImage CGImageForProposedRect:NULL context:NULL hints:NULL];
	NSString * newUTType = [saveOptions imageUTType];
	NSURL *               url2 = [NSURL fileURLWithPath: [savePanel filename]];
	CGImageDestinationRef dest = CGImageDestinationCreateWithURL((CFURLRef)url2, (CFStringRef)newUTType, 1, NULL);
	if (dest)
	{
		CGImageDestinationAddImage(dest, imageorigine, (CFDictionaryRef)[saveOptions imageProperties]);
		CGImageDestinationFinalize(dest);
		CFRelease(dest);
	}
	
		// -----------------  salvataggio file collaterale
	NSString *nomefile;
	nomefile =[savePanel filename];
	nomefile = 	[nomefile stringByPaddingToLength:([nomefile length]-1) withString: @"w" startingAtIndex:0];
		// Results in "ab"
	nomefile = [nomefile stringByAppendingString:@"w"];
	
	double xornew=x1L;
	double yornew=y1L;
	NSString *Str;
	double _angolo=0.0;
	Str = @"";                                 	Str = [Str stringByAppendingFormat:	 @"%12f",xornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",yornew];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalL];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",scalL];
	Str = [Str stringByAppendingString:@"\n"];	Str = [Str stringByAppendingFormat:	 @"%12f",_angolo];
	[Str writeToFile :nomefile atomically:YES encoding:NSASCIIStringEncoding error:NULL];
	
	
}





- (IBAction) CmoveRaster                                    : (id)sender   {
	[self  comandobottone : kStato_spostaRaster_uno ];
}

- (IBAction) CmoveRaster2Pt                                 : (id)sender   {
	[self  comandobottone : kStato_spostaRaster2pt_uno ];
}

- (IBAction) CScalRasRig                                    : (id)sender   {
	[self  comandobottone : kStato_scalarighello ];
}

- (IBAction) CRotScalRas                                    : (id)sender   {
	[self  comandobottone : kStato_rotoscalaraster ];
}

- (IBAction) RotateRaster0                                  : (id)sender   { 
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	[[varbase DisegnoRcorrente] impostaUndoCorrenteAngolo: [varbase MUndor]];
	[RasterCorrente setangolorotindice          :0 Indice:[RasterCorrente indiceSubRastercorrente] ];
	[progetto display];
}

- (IBAction) ScaleRaster1                                   : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	[[varbase DisegnoRcorrente] impostaUndoCorrenteScala: [varbase MUndor]];
	[RasterCorrente setscalaraster1 : NO: [RasterCorrente indiceSubRastercorrente] ];
	[self CambioSubRaster : [RasterCorrente indiceSubRastercorrente]];
	[progetto display];
}



	// Gruppo Raster Fine

- (IBAction) CFixCentroRot                                  : (id)sender   {
	[self  comandobottone : kStato_FixCentroRot ];
}

- (IBAction) CCentroRot                                     : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	if (RasterCorrente==nil) return;
	if ((varbase.xcentrorot ==0) & (varbase.ycentrorot ==0)) {	NSBeep(); return; }
	[RasterCorrente FissaUndoSeNonRotScaSubcorrente:[varbase MUndor]];
	[RasterCorrente RuotaconCentro  :varbase.xcentrorot : varbase.ycentrorot : [sender doubleValue] : [RasterCorrente indiceSubRastercorrente ]  ];
	[progetto display];
}

- (IBAction) CCentroScal                                    : (id)sender   {
	DisegnoR *RasterCorrente = [varbase DisegnoRcorrente];
	if (RasterCorrente==nil) return;
	if ((varbase.xcentrorot ==0) & (varbase.ycentrorot ==0)) {	NSBeep(); return; }
	[RasterCorrente FissaUndoSeNonRotScaSubcorrente:[varbase MUndor]];
	[RasterCorrente ScalaconCentro  :varbase.xcentrorot : varbase.ycentrorot :  [[interface RSceltaAsse] selectedSegment]  : [sender doubleValue] : [RasterCorrente indiceSubRastercorrente ]  ];
	[progetto display];
}

- (IBAction) RSet0RotCen                                    : (id)sender {
	if ( [ sender isEqual:[interface RB0Rot ]]) [varbase Set0SlRotScaXYRas   : 1];
	if ( [ sender isEqual:[interface RB0Sca ]]) [varbase Set0SlRotScaXYRas   : 2];
}

- (IBAction) RSetscalCambioMod                              : (id)sender {
	NSBeep();
}



- (IBAction) RSetMinMaxRotCen                               : (id)sender {
	BOOL condup =NO;
	if ([sender doubleValue]>50) condup=YES; else condup =NO;
	if ( [ sender isEqual:[interfacewindow StepImgRot  ]]) [varbase SetMinMaxSlRas   : 1:condup];
	if ( [ sender isEqual:[interfacewindow StepImgSca  ]]) [varbase SetMinMaxSlRas   : 2:condup];	
	[sender setDoubleValue:50.0];
}

	// ----------------------    azioni Bottoni alti Raster


- (IBAction) salvaCalibCorrente       : (id)sender{
	[[varbase DisegnoRcorrente]  SalvaInfoRasterUno :  [[varbase DisegnoRcorrente] indiceSubRastercorrente]   ];
}


- (IBAction) salvaCalibTutte          : (id)sender{
	[[varbase DisegnoRcorrente] SalvaInfoRaster];
}


- (IBAction) salvaCalibTutteCaricate  : (id)sender {
    DisegnoR * locras;
    for(int i=0; i<[varbase Listaraster].count; i++)	{
		locras = [[varbase Listaraster] objectAtIndex:i];
        [locras SalvaInfoRaster];
	}
}





- (IBAction) TarquiniaPRG            : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgA_Nord.gif" : info];  
				[[varbase Listaraster] addObject:Locdisraster];
				[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgA_Centro.gif"]  ;
    [Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgA_Sud.gif"]  ;
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
		//	[progetto display]; 
		//	[varbase upinterfaceraster];
	
}

- (IBAction) TarquiniaPRGPart        : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgB_Nord.gif" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgB_Centro.gif"]  ;
    [Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/PRG/PrgB_Sud.gif"]  ;
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}

- (IBAction) orbetelloDemo           : (id) sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/UsoSuolo.jpg" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) orbetelloDemo2          : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_6.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:1.0];
	
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_5.tiff"]  ;
/*	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_3.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_4.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_5.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav1/TAV1_6.tiff"]  ;
*/	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}

- (IBAction) orbetelloDemo3          : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_6.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:1.0];
	
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_7.tiff"]  ;
/*	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_3.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_4.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_5.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_6.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_7.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav2/TAV2_8.tiff"]  ;
*/	
	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}

- (IBAction) orbetelloDemo4          : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_1.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:1.0];
	
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_2.tiff"]  ;

    [Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_3.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_4.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_5.tiff"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Orbetello/Tav3/TAV3_6.tiff"]  ;

	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}



- (IBAction) LaDispoliDemo           : (id) sender {
	DisegnoR  *Locdisraster;
	/*	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/AREE_PUBBLICHE.jpg" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster setvisibile:0];
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/DIM-PIANO_1.jpg" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/DIM-PIANO_2.jpg"]  ;
	[Locdisraster setvisibile:0];
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/K1.jpg" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/K2.jpg"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/K3.jpg"]  ;
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/K4.jpg"]  ;

	[Locdisraster setvisibile:0];
	
*/	
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/PROGRAMMATICHE.jpg" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	
	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
}

- (IBAction) CivitavecchiaPRG        : (id)sender{
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Civitavecchia/prg_CV.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) CivitavecchiaPRG69      : (id)sender{
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Civitavecchia/prgCV_69.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
		
}

- (IBAction) LaDispoliPaesagistico           : (id) sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/Tav_Ladispoli_A.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:1.0];
	
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/Tav_Ladispoli_B.tiff"]  ;
	[Locdisraster setvisibileindice:1:NO];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/Tav_Ladispoli_C.tiff"]  ;
	[Locdisraster setvisibileindice:2:NO];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/LaDispoli/Tav_Ladispoli_D.tiff"]  ;
	[Locdisraster setvisibileindice:3:NO];

	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
}

- (IBAction) CerveteriPaesagistico           : (id) sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_A.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_B1.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR  :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_B2.tiff"]  ;
	[Locdisraster setvisibile:0];

	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_C1.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR  :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_C2.tiff"]  ;
	[Locdisraster setvisibile:0];
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Cerveteri/Tav_Cerveteri_D.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster setvisibile:0];
	
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}

- (IBAction) TarquiniaPaesagistico           : (id) sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/Paesagistico/Tav_13_354_A.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}


- (IBAction) ViterboPaesA            : (id)sender {
DisegnoR  *Locdisraster;
Locdisraster = [ DisegnoR alloc];  	  
[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/Paesagistico/Viterbo_Tav_A.tiff" : info];  
[[varbase Listaraster] addObject:Locdisraster];
[Locdisraster setalpha:0.7];
[varbase DoNomiRasPop];
[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
[progetto ZoomAllRaster:self];
[interface setRckVisRas:YES];
[interface setRSlAlphRas   : [Locdisraster alpha ] ];
if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
	[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) ViterboPaesB            : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/Paesagistico/Viterbo_Tav_B.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) ViterboPaesC            : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/Paesagistico/Viterbo_Tav_C.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) ViterboPaesD            : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/Paesagistico/Viterbo_Tav_D.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:0]; //[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) ViterboPRGQU            : (id)sender {
	DisegnoR  *Locdisraster;
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/PRG/QuadroUnione/NordEst.tiff" : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/PRG/QuadroUnione/NordOvest.tiff"]  ;
    [Locdisraster addDisegnoR :@"/Users/carlomacor/Desktop/DatiCartografici/Viterbo/PRG/QuadroUnione/sud.tiff"]  ;
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
}




- (IBAction) BottoneComune_01R       : (id)sender {
    NSString *nomefillo = @"Immagini/prg_p1.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else 
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
        [progetto display];            // renderlo invisibile
        return;
    }
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) BottoneComune_02R       : (id)sender {
    NSString *nomefillo = @"Immagini/prg_p3.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else 
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) BottoneComune_03R       : (id)sender {
    NSString *nomefillo = @"/Immagini/F23_24_25.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
   
    
    
}

- (IBAction) BottoneComune_04R       : (id)sender {
    NSString *nomefillo = @"Immagini/E_1_5.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) BottoneComune_05R       : (id)sender {
    NSString *nomefillo = @"/Immagini/E_3_5.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) BottoneComune_06R       : (id)sender {
    NSString *nomefillo = @"/Immagini/Carta.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
}

- (IBAction) BottoneComune_07R       : (id)sender {
    NSString *nomefillo = @"/Immagini/Paes_A210_A.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];

}

- (IBAction) BottoneComune_08R       : (id)sender {
    NSString *nomefillo = @"/Immagini/Paes_A210_B.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];

}

- (IBAction) BottoneComune_09R       : (id)sender {
    NSString *nomefillo = @"/Immagini/Paes_A210_C.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else 
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];

}

- (IBAction) BottoneComune_10R       : (id)sender {
    NSString *nomefillo = @"/Immagini/Paes_A210_D.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];

}

- (IBAction) BottoneComune_11R       : (id)sender {
    NSString *nomefillo = @"/Immagini/PAI.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
    DisegnoR  *Locdisraster;
	if ([varbase IndiceSepresenteRaster: nomefilloTutto ]>=0) {
        Locdisraster = [[varbase Listaraster] objectAtIndex:[varbase IndiceSepresenteRaster   : nomefilloTutto ]];
        if ([Locdisraster isvisibleRaster]) [Locdisraster setvisibile:NSOffState]; else
		{	[Locdisraster setvisibile:NSOnState];  
			[varbase setindiceRasterCorrente: [varbase IndiceSepresenteRaster   : nomefilloTutto ]];
			[varbase DoNomiRasPop];
		}
		[varbase DoNomiRasPop];
        [progetto display];            // renderlo invisibile
        return;
    }
	
	Locdisraster = [ DisegnoR alloc];  	  
	[Locdisraster InitDisegnoR :nomefilloTutto : info];  
	[[varbase Listaraster] addObject:Locdisraster];
	[Locdisraster setalpha:0.7];
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
    
}

- (IBAction) BottoneComune_12R       : (id)sender {
	unichar      ilcar;		
	
	NSString *nomefillo = @"Immagini/CTR_5000NORD/"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	bool primodiser = YES;
	DisegnoR  *Locdisraster;
	
	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomefilloTutto error:NULL];
	for (int i=0; i<contentsAtPath.count; i++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:i];
		ilcar = [nomf characterAtIndex:0];
		if (ilcar==46) continue; // 46 = '.'
		
		
		NSString *estensioneFile = [nomf pathExtension];
		NSString *upestensione =  [estensioneFile uppercaseString];
		if (![upestensione isEqualToString:@"TIFF"])   continue;
		NSString *nomedacaricare = [[NSString alloc] initWithFormat:@"%@%@",nomefilloTutto,nomf   ];

		
		
		if (primodiser) {	primodiser=NO;	
			if ([self giapresenteImmagine:nomedacaricare]>=0) { 
				Locdisraster = 	[[varbase Listaraster] objectAtIndex:[self giapresenteImmagine:nomedacaricare]];
			    [Locdisraster setvisibile : ![Locdisraster isvisibleRaster ]];
				[progetto display];		return;
			}
		
			Locdisraster = [ DisegnoR alloc];  	  
			[Locdisraster InitDisegnoR :nomedacaricare : info];  
			[[varbase Listaraster] addObject:Locdisraster]; 			[Locdisraster setalpha:0.7];

			[[[varbase interface] LevelIndicatore] setIntValue: 1];
			[[[varbase interface] LevelIndicatore] setHidden:NO];
			[[[varbase interface] LevelIndicatore] display];

			
		} else {	[Locdisraster addDisegnoR :nomedacaricare]  ;		}
	
		int newind = (int)( (i*200)/contentsAtPath.count);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	
			[[[varbase interface] LevelIndicatore] setIntValue: newind ];	[[[varbase interface] LevelIndicatore] display];	}
	}
	
	[[[varbase interface] LevelIndicatore] setHidden:YES];
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	

 }

- (IBAction) BottoneComune_13R       : (id)sender {
	unichar      ilcar;		
	
	NSString *nomefillo = @"UniversitaAgraria/"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	bool primodiser = YES;
	DisegnoR  *Locdisraster;
	
	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomefilloTutto error:NULL];
	for (int i=0; i<contentsAtPath.count; i++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:i];
		ilcar = [nomf characterAtIndex:0];
		if (ilcar==46) continue; // 46 = '.'
		
		
		NSString *estensioneFile = [nomf pathExtension];
		NSString *upestensione =  [estensioneFile uppercaseString];
		if (![upestensione isEqualToString:@"TIF"])   continue;
		NSString *nomedacaricare = [[NSString alloc] initWithFormat:@"%@%@",nomefilloTutto,nomf   ];
		
		
		
		if (primodiser) {	primodiser=NO;	
			if ([self giapresenteImmagine:nomedacaricare]>=0) { 
				Locdisraster = 	[[varbase Listaraster] objectAtIndex:[self giapresenteImmagine:nomedacaricare]];
			    [Locdisraster setvisibile : ![Locdisraster isvisibleRaster ]];
				[progetto display];
				return;
			}
			
			Locdisraster = [ DisegnoR alloc];  	  
			[Locdisraster InitDisegnoR :nomedacaricare : info];  
			[[varbase Listaraster] addObject:Locdisraster]; 			[Locdisraster setalpha:0.7];
			
			[[[varbase interface] LevelIndicatore] setIntValue: 1];
			[[[varbase interface] LevelIndicatore] setHidden:NO];
			[[[varbase interface] LevelIndicatore] display];
			
			
		} else {	[Locdisraster addDisegnoR :nomedacaricare]  ;		}
		
		int newind = (int)( (i*200)/contentsAtPath.count);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	
			[[[varbase interface] LevelIndicatore] setIntValue: newind ];	[[[varbase interface] LevelIndicatore] display];	}
	}
	
	[[[varbase interface] LevelIndicatore] setHidden:YES];
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}


- (IBAction) BottoneComune_14R       : (id)sender {
	unichar      ilcar;		
	
	NSString *nomefillo = @"Immagini/CTR_5000SUD/"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@",[varbase Dir_basedati],nomefillo   ];
	bool primodiser = YES;
	DisegnoR  *Locdisraster;
	
	
	NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomefilloTutto error:NULL];
	for (int i=0; i<contentsAtPath.count; i++) {  
		NSString *nomf = [contentsAtPath objectAtIndex:i];
		ilcar = [nomf characterAtIndex:0];
		if (ilcar==46) continue; // 46 = '.'
		
		
		NSString *estensioneFile = [nomf pathExtension];
		NSString *upestensione =  [estensioneFile uppercaseString];
		if (![upestensione isEqualToString:@"TIFF"])   continue;
		NSString *nomedacaricare = [[NSString alloc] initWithFormat:@"%@%@",nomefilloTutto,nomf   ];
		
		
		
		if (primodiser) {	primodiser=NO;	
			if ([self giapresenteImmagine:nomedacaricare]>=0) { 
				Locdisraster = 	[[varbase Listaraster] objectAtIndex:[self giapresenteImmagine:nomedacaricare]];
			    [Locdisraster setvisibile : ![Locdisraster isvisibleRaster ]];
				[progetto display];		return;
			}
			
			Locdisraster = [ DisegnoR alloc];  	  
			[Locdisraster InitDisegnoR :nomedacaricare : info];  
			[[varbase Listaraster] addObject:Locdisraster]; 			[Locdisraster setalpha:0.7];
			
			[[[varbase interface] LevelIndicatore] setIntValue: 1];
			[[[varbase interface] LevelIndicatore] setHidden:NO];
			[[[varbase interface] LevelIndicatore] display];
			
			
		} else {	[Locdisraster addDisegnoR :nomedacaricare]  ;		}
		
		int newind = (int)( (i*200)/contentsAtPath.count);
		if (newind > [[[varbase interface] LevelIndicatore] intValue]) {	
			[[[varbase interface] LevelIndicatore] setIntValue: newind ];	[[[varbase interface] LevelIndicatore] display];	}
	}
	
	[[[varbase interface] LevelIndicatore] setHidden:YES];
	
	[Locdisraster updateLimiti];
	[varbase DoNomiRasPop];
	[varbase setrastercorrente:[varbase Listaraster].count-1];  // cosi faccio anche il sottoimmagini
	[progetto ZoomAllRaster:self];
	[interface setRckVisRas:YES];
	[interface setRSlAlphRas   : [Locdisraster alpha ] ];
	if (![Locdisraster isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[Locdisraster isMaskabianca]];	}
	[interface setRckVisSubRas :	 [Locdisraster visibleRasterIndice:[Locdisraster indiceSubRastercorrente] ] ];
	[self CambioSubRaster      :     [Locdisraster indiceSubRastercorrente] ];
	
	
}



- (IBAction) BotLegComune_01R       : (id)sender {
	NSString *nomefillo = @"Legenda_P1.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_02R       : (id)sender {
	NSString *nomefillo = @"Legenda_P3.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_03R       : (id)sender {
	
}

- (IBAction) BotLegComune_04R       : (id)sender {
	NSString *nomefillo = @"Legenda_E1_5.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_05R       : (id)sender {
	NSString *nomefillo = @"Legenda_E3_5.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_06R       : (id)sender {
}

- (IBAction) BotLegComune_07R       : (id)sender {
	NSString *nomefillo = @"Paesagistico_A.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_08R       : (id)sender {
    NSString *nomefillo = @"Paesagistico_B.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_09R       : (id)sender {
    NSString *nomefillo = @"Paesagistico_C.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_10R       : (id)sender {
    NSString *nomefillo = @"Paesagistico_D.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
}

- (IBAction) BotLegComune_11R       : (id)sender {
	NSString *nomefillo = @"Legenda_PAI.tiff"; 	NSString *nomefilloTutto;
	nomefilloTutto = [[NSString alloc] initWithFormat:@"%@%@%@",[varbase Dir_basedati],@"Legende/",nomefillo   ];
	[[bariledlg legendaView]    LoadImg  :nomefilloTutto];
	[[bariledlg dlgLegenda] orderFront:self];
	
}





@end
