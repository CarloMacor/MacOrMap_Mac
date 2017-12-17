//
//  Varbase.m
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Varbase.h"


@implementation Varbase

@synthesize  xcentrorot ;
@synthesize  ycentrorot ;
@synthesize  xcentrorotV ;
@synthesize  ycentrorotV ;
@synthesize  rispostaconferma ;

@synthesize  d_x1coord;
@synthesize  d_y1coord;
@synthesize  d_x2coord;
@synthesize  d_y2coord;		
@synthesize  d_x3coord;
@synthesize  d_y3coord;
@synthesize  d_x4coord;
@synthesize  d_y4coord;	
@synthesize  d_lastdist;	


@synthesize  x1virt;
@synthesize  y1virt;
@synthesize  x2virt;
@synthesize  y2virt;
@synthesize  d_xcoordLast;
@synthesize  d_ycoordLast;

@synthesize  inGriglia;
@synthesize  giacaricatoCat;
@synthesize  intematerreni;

@synthesize	AutorizzatoDatiSensibili;
@synthesize	TipoProiezione;



- (void) InitVarbase                               {
		//	interface = _interface;
	ListaRaster      = [[NSMutableArray alloc] init];
	ListaVector      = [[NSMutableArray alloc] init];
	ListaDefSimboli  = [[NSMutableArray alloc] init];
	ListaSelezionati = [[NSMutableArray alloc] init];
    ListaInformati   = [[NSMutableArray alloc] init];
	
	TipoProiezione   =0;  // 0 = UTM    ; 1 : catastale   ; 2 Lat-Long

    anagrafe          = [Anagrafe  alloc];  [anagrafe initAnagrafe]; 
    
	ListaSelezEdifici     = [[NSMutableArray alloc] init];
    ListaSelezTerreni     = [[NSMutableArray alloc] init];
	Listaproprietari      = [[NSMutableArray alloc] initWithCapacity:40000];
	ListaEditvt           = [[NSMutableArray alloc] init];

		// carico la lista delle icone per le categorie edifici
	IconeEdificiLista     = [[NSMutableArray alloc] init];	[self caricaIconeEdifici];
	[[barilectr ctrEdi] ImpostaIcone:IconeEdificiLista];
	[[barilectr ctrPatrimonio] ImpostaIcone:IconeEdificiLista];
	[[barilectr ctrDlgGriglia] initgriglia];
		//	NSBeep();

	
	indicecurrentsimbolo  = 0;
	
	TuttiImmobili         = [Immobili alloc];	 [TuttiImmobili initimmobili];
	TuttiImmobiliFiltrati = [Immobili alloc];    [TuttiImmobiliFiltrati initimmobili];
	
	TuttaTax              = [Tax    alloc];    [TuttaTax          initTax];
	TuttaTaxFiltrata      = [Tax    alloc];    [TuttaTaxFiltrata  initTax];
	
	
	inGriglia = NO;
	
	NomeFileImmobiliCatOrmap = @"/MacOrMap/Catasto/Immobili.CATMacorMap";
	
	
  	Dir_Catastali = @"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/catastali/";
    COD_Comune = @"D024";  // Tarquinia
    if ([ COD_Comune isEqualToString:@"D024"]) nomequadronione = @"/Users/carlomacor/Desktop/DatiCartografici/Tarquinia/Quadro di Unione/AD024_5591QU.MoM";

		//    COD_Comune = @"A210"; // Allumiere
		//    Dir_Catastali = @"/MacOrMap/Allumiere/CXF/";
		//    if ([ COD_Comune isEqualToString:@"A210"]) nomequadronione = @"/MacOrMap/Allumiere/QU/A210_3846QU.OrMap";
	giacaricatoCat = NO;
	intematerreni = NO;
	
		///                    ////                       /////
	AutorizzatoDatiSensibili = YES;

	rettangoloStampa = nil;

}

- (IBAction) switchStatoDatiSensibili : (id)  sender {
	bool stato =![barilectr ctrAnagrafe].demoSensibili;
	[barilectr ctrAnagrafe].demoSensibili = stato;
	[barilectr ctrTax].demoSensibili = stato;
	[barilectr ctrPossessori].demoSensibili = stato;
	[barilectr ctrProprietari].demoSensibili = stato;
	[barilectr ctrPatrimonio].demoSensibili = stato;
}

- (BarileDlg   *) bariledlg {
	return bariledlg; 	
}

- (BarileCtr   *) barilectr {
	return barilectr;
}

- (Interface   *) interface {
	return interface;
}


- (NSUndoManager  *) MUndor {
	return [interface MUndor];
}

- (void) setnomeQUnione : (NSString *) nome  {
	[nomequadronione release];	nomequadronione =[[NSString alloc] initWithString:nome]; [nomequadronione retain];
}

- (void) setcod_comune : (NSString *) nome  {
	[nome retain]; [COD_Comune release];	COD_Comune = nome;
}

- (void) setdircatastali : (NSString *) nome  {
	[Dir_Catastali release];	Dir_Catastali =[[NSString alloc] initWithString:nome]; 	[Dir_Catastali retain];
}

- (void) setdirbasedati : (NSString *) nome  {
	[nome retain]; [Dir_basedati release];	Dir_basedati = nome;
}



- (void) caricaIconeEdifici   {
	[IconeEdificiLista addObject:[NSImage imageNamed:@"E_Nulla.png"]  ];
	
	for (int i=1; i<=11; i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_A%i.png",i]]]; }
	for (int i=1; i<=8;  i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_B%i.png",i]]]; }
    for (int i=8; i<=8;  i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_B%i.png",i]]]; }

	for (int i=1; i<=7;  i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_C%i.png",i]]]; }
	for (int i=1; i<=10; i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_D%i.png",i]]]; }
	for (int i=1; i<=9;  i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_E%i.png",i]]]; }
	for (int i=1; i<=11; i++) {	[IconeEdificiLista addObject:[NSImage imageNamed: [NSString stringWithFormat:@"E_F%i.png",i]]]; }
	
	[IconeEdificiLista addObject:[NSImage imageNamed: @"Sem1.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"Sem2.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"uliveto.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"vigneto.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"frutteto.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"orticello.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"Pascolo.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"Pasc.png"]];

	[IconeEdificiLista addObject:[NSImage imageNamed: @"bosco.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"castagneto.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"stagno.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"incolt.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"incoltster.png"]];

	[IconeEdificiLista addObject:[NSImage imageNamed: @"ferrSP.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"fabb.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"cava.png"]];

	[IconeEdificiLista addObject:[NSImage imageNamed: @"cimitero.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"costrnoab.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"areafabb.png"]];

	[IconeEdificiLista addObject:[NSImage imageNamed: @"fudaccert.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"relitstrad.png"]];
	[IconeEdificiLista addObject:[NSImage imageNamed: @"pv.png"]];

}

- (int) IndiceSepresenteDisegno             : (NSString *) nomefile {
	int resulta =-1;
	DisegnoV *dis;
	for(int i=0; i<ListaVector.count; i++)	{
		dis = [ListaVector objectAtIndex:i];
		if ([nomefile isEqualToString:[dis nomedisegno] ]) {resulta = i;	break;	}
	}
	return resulta;
}



- (int) presenteDisegno             : (NSString *) nomefile {
	int resulta =-1;
	DisegnoV *dis;
	for(int i=0; i<ListaVector.count; i++)	{
		dis = [ListaVector objectAtIndex:i];
		
		if ([nomefile isEqualToString:[dis nomedisegno] ]) {
			[dis setvisibile :1];
			[self setindiceVectorCorrente   : i];
			resulta = i;
			break;
		}
	}
	return resulta;
}

- (int) IndiceSepresenteRaster     : (NSString *) nomefile {
	int resulta =-1;
	DisegnoR *ras;
	for(int i=0; i<ListaRaster.count; i++)	{
		ras = [ListaRaster objectAtIndex:i];
		if ([ras IndiceSepresenteSubRaster: nomefile ]>=0){resulta = i;	break;	}
	}
	return resulta;
}


- (void) AggiornaInterfaceComandoAzione                                       {
	[interface AggiornaInterfaceComandoAzione:Comando :FaseComando];
}

- (void) txtInterfaceComandoAzione                     :(NSString *) msg      {
	[interface txtInterfaceComandoAzione : msg];
}


- (void) upinterfacevector                                                    {
	bool activVecor =NO;
	if ( [self DisegnoVcorrente] != nil ) activVecor = YES;
	[interface upinterfacevector:activVecor];
}

- (void) upinterfaceraster                                                    {
	bool activRaster =NO;
	if ( [self DisegnoRcorrente] != nil ) activRaster = YES;
	[interface upinterfaceraster:activRaster];
}


	// su comando e fasecomnado

- (void) setcomando              : (NSInteger ) com                           {
	Comando=com;
	[self AggiornaInterfaceComandoAzione];
} 

- (void) setfasecomando          : (NSInteger) fascom                         {
	FaseComando=fascom;
	[self AggiornaInterfaceComandoAzione];
} 

- (void) setfasecomandopiu1                                                   {
	FaseComando++;	[self AggiornaInterfaceComandoAzione];
} 

- (void) comando00                                                            {
    Comando = kStato_nulla;
	FaseComando=0;
	[self AggiornaInterfaceComandoAzione];
} 


- (void) setcomandofasecomando   : (NSInteger) com    : (NSInteger ) fascom   {
	Comando=com;	      FaseComando=fascom;
	[self AggiornaInterfaceComandoAzione];
}

- (void) comandodabottone        : (NSInteger) com                            {
	if (Comando==com)  [self setcomando:kStato_nulla];  else   [self setcomando:com];  
}    // proviene dai bottoni di Az


- (void) passatogliinformati     : (bool) modo : (int) indice                 {
	

	
	Vettoriale * locvet = [ ListaInformati objectAtIndex:indice];
	
		// se gia' presente dalla lista e a che indice;
	
	if ([ListaSelezionati containsObject:locvet]) NSBeep();
	
	
	
	
}



- (NSInteger) comando                                                         {
	return Comando;
}

- (NSInteger) fasecomando                                                     {
	return FaseComando;
} 

- (DisegnoR *)  DisegnoRcorrente                                              {
	if (indiceRasterCorrente >= [ListaRaster count]) return nil;
    if ([ListaRaster count]<=0) return nil;
	return [ListaRaster objectAtIndex: indiceRasterCorrente];
}

- (DisegnoV *)  DisegnoVcorrente                                              {
	if ([ListaVector count]<=0) return nil;
	if (indiceVectorCorrente >= [ListaVector count])return nil;
		
	return [ListaVector objectAtIndex: indiceVectorCorrente];
}

- (void)     aggiornaslideCalRaster  {
    DisegnoR *RasterCorrente = [self DisegnoRcorrente];
   	[interfacewindow setSlidCentroRot     :  [RasterCorrente angoloindice:[RasterCorrente indiceSubRastercorrente ] ]];
	[interfacewindow setSlidCentroSca     :  [RasterCorrente scalaindice:[RasterCorrente indiceSubRastercorrente  ] ]];
}

- (void)     aggiornaslideCalVector  {
    DisegnoV *LocVector = [self DisegnoVcorrente];
    double spes = ([[interface vtlrotcen ] maxValue ]- [[interface vtlrotcen ] minValue ])/2.0;
    [[interface vtlrotcen ] setMaxValue: [LocVector eventuale_ang ]+spes ];
    [[interface vtlrotcen ] setMinValue: [LocVector eventuale_ang ]-spes ];
    [[interface vtlrotcen ] setDoubleValue: [LocVector eventuale_ang ]];
    
    spes = ([[interface vtlscacen ] maxValue ]- [[interface vtlscacen ] minValue ])/2.0;
    [[interface vtlscacen ] setMaxValue: [LocVector eventuale_scala ]+spes ];
    [[interface vtlscacen ] setMinValue: [LocVector eventuale_scala ]-spes ];
    [[interface vtlscacen ] setDoubleValue: [LocVector eventuale_scala ]];

    spes = ([[interface vtloffx ] maxValue ]- [[interface vtloffx ] minValue ])/2.0;
    [[interface vtloffx ] setMaxValue: [LocVector eventuale_offx ]+spes ];
    [[interface vtloffx ] setMinValue: [LocVector eventuale_offx ]-spes ];
    [[interface vtloffx ] setDoubleValue: [LocVector eventuale_offx ]];

    spes = ([[interface vtloffy ] maxValue ]- [[interface vtloffy ] minValue ])/2.0;
    [[interface vtloffy ] setMaxValue: [LocVector eventuale_offy ]+spes ];
    [[interface vtloffy ] setMinValue: [LocVector eventuale_offy ]-spes ];
    [[interface vtloffy ] setDoubleValue: [LocVector eventuale_offy ]];

}


	// liste raster

- (NSMutableArray *) Listaraster                                              {
	return ListaRaster;
}

- (void) RifareNomiRasPop                                                     {
	DisegnoR  *locmydisraster;
	[[interface PopLRas] removeAllItems];
	NSString *STR_loc = @"";    
	NSString *STR_comp = @""; 
	STR_loc = @"Gruppo Immagini";
	if (ListaRaster.count==0)     { 
		[interface UpStateRasterBut:NO];	
	    [[interface PopLRas] addItemWithTitle:STR_loc];  	 
	 	[[interface PopLSubRas] removeAllItems];	
		[[interface PopLSubRas] addItemWithTitle:@"Immagine"];	
 	    [self Disegnarasterino];
		return;
	} 
	else [interface UpStateRasterBut:YES];	
	for (int i=0; i<ListaRaster.count; i++) {
		locmydisraster = [ListaRaster objectAtIndex:i];
		STR_loc = @"∼";		STR_loc = [STR_loc stringByAppendingString:	 [locmydisraster damminomefile:0]];
		for (int j=0 ; j<i; j++) {
			STR_comp = [[interface PopLRas] itemTitleAtIndex:j];
			if ([STR_loc isEqualToString:STR_comp]) STR_loc = [STR_loc stringByAppendingString:@"#"];		}
		[[interface PopLRas] addItemWithTitle:STR_loc];    
	}
}

- (void) DoNomiRasPop                                                         {
	[self upinterfaceraster ];

	 DisegnoR  *locmydisraster;
	 [[interface PopLRas] removeAllItems];
	 NSString *STR_loc = @"";    
	 NSString *STR_comp = @""; 
	 STR_loc = @"Gruppo Immagini";
	 if (ListaRaster.count==0)     { 
		[interface UpStateRasterBut:NO];	
	    [[interface PopLRas] addItemWithTitle:STR_loc];  	 
	 	[[interface PopLSubRas] removeAllItems];	
		[[interface PopLSubRas] addItemWithTitle:@"Immagine"];	
 	    [self Disegnarasterino];
		return;
	 } 
	 else [interface UpStateRasterBut:YES];	

	for (int i=0; i<ListaRaster.count; i++) {
	 locmydisraster = [ListaRaster objectAtIndex:i];
	 STR_loc = @"∼";		STR_loc = [STR_loc stringByAppendingString:	 [locmydisraster damminomefile:0]];
	 // per recuperare i doppi nomi
	 for (int j=0 ; j<i; j++) {
	 STR_comp = [[interface PopLRas] itemTitleAtIndex:j];
	 if ([STR_loc isEqualToString:STR_comp]) STR_loc = [STR_loc stringByAppendingString:@"#"];		}
	 [[interface PopLRas] addItemWithTitle:STR_loc];    
	}
	
	[self Disegnarasterino];

	[self DoNomiSubRasPop];
}



- (void) DoNomiSubRasPop                                                      {
	DisegnoR  *locmydisraster;
	if (indiceRasterCorrente> [ListaRaster count]) return;
     locmydisraster = [ListaRaster objectAtIndex:indiceRasterCorrente];

	 if ([locmydisraster numimg]>0)	[[interface PopLSubRas] setEnabled:YES];
	 NSString *STR_loc = @"";	NSString *STR_comp = @""; 
	 [[interface PopLSubRas] removeAllItems];
	 for (int i=0; i<[locmydisraster numimg]; i++) {
	 STR_loc = [locmydisraster damminomefile:i];
	 // per recuperare i doppi nomi
	 for (int j=0 ; j<i; j++) {
	 STR_comp = [[interface PopLSubRas] itemTitleAtIndex:j];
	 if ([STR_loc isEqualToString:STR_comp]) STR_loc = [STR_loc stringByAppendingString:@"#"];		}
	 
	 [[interface PopLSubRas] addItemWithTitle:STR_loc];
	}
	if ([locmydisraster numimg]>0)	[[interface PopLSubRas]  selectItemAtIndex:[locmydisraster indiceSubRastercorrente  ]];
}

- (void) DoNomiVectorPop                                                      {
	NSString *STR_comp = @"";
	[self upinterfacevector];

	DisegnoV  *locdisvet;
	[[interface PopLVect] removeAllItems];

	NSString *STR_loc = @"Disegni";
	 if (ListaVector.count==0)     { 
		 [interface UpStateVectorBut :NO];
		 [[interface PopLVect]  addItemWithTitle:STR_loc];  	 
		 return;
	 } 
	 else [interface UpStateVectorBut :YES];

	for (int i=0; i<ListaVector.count; i++) {
	   locdisvet= [ListaVector objectAtIndex:i];
	   STR_loc = [locdisvet nomedisegno];
	   if ([STR_loc length]>0) {  STR_loc = [STR_loc lastPathComponent];	}
	  if ([STR_loc length]==0) {  STR_loc = @"";	STR_loc = [STR_loc stringByAppendingFormat:	 @" dis %d", i+1];  }
			 //
		 for (int j=0 ; j<i; j++) {
			 STR_comp = [[interface PopLVect] itemTitleAtIndex:j];
			 if ([STR_loc isEqualToString:STR_comp]) STR_loc = [STR_loc stringByAppendingString:@"#"];		}
		 
	  [[interface PopLVect] addItemWithTitle:STR_loc];
	 }
    
	[[interface PopLVect]   selectItemAtIndex :indiceVectorCorrente];
	[self DoNomiSubVectPop];
}

- (void) DoNomiSubVectPop                                                     {
	DisegnoV  *locdisvet;
	if (indiceVectorCorrente> [ListaVector count]) return;
	locdisvet = [ListaVector objectAtIndex:indiceVectorCorrente];
	[[interface PopLSubVect] removeAllItems];
	int npiani = [locdisvet damminumpiani];
	for (int i=0; i<npiani; i++) { [[interface PopLSubVect] addItemWithTitle:[locdisvet givemenomepianoindice:i ]];	}
	[[interface PopLSubVect]  selectItemAtIndex :[locdisvet IndicePianocorrente]];
	[self CambioSubVector : [locdisvet IndicePianocorrente] ];
		//	[self comando00];
}

- (void) RimuovituttiRasters                                                  {
	DisegnoR  *locmydisraster;
	for (int i=ListaRaster.count-1; i>=0; i--) {
	  locmydisraster = [ListaRaster objectAtIndex:i];
	  [locmydisraster RemoveDisegnoR];
	}
	[ListaRaster removeAllObjects];
	[self DoNomiRasPop];
}

- (void) AggiornaParametriListeRaster                                         {
	if ( ListaRaster.count==0) return;
	DisegnoR *RasterCorrente = [self DisegnoRcorrente];

	[interface setRckVisRas:[RasterCorrente isvisibleRaster]];
	[self RifareNomiRasPop];
	[[interface PopLRas]  selectItemAtIndex: indiceRasterCorrente];
	[self DoNomiSubRasPop];
	[interface setRckVisSubRas : [RasterCorrente visibleRasterIndice:[RasterCorrente indiceSubRastercorrente] ] ];
	[interface setRSlAlphRas   : [RasterCorrente alpha ] ];
	if (![RasterCorrente isMaskableRaster]) {	[interface setRckBackRas : -1];	} else {
		[interface setRckBackRas :[RasterCorrente isMaskabianca]];	}
	NSString *STR_loc = @"";
	if (RasterCorrente==nil) { [self Disegnarasterino]; STR_loc = @"Dimensione";[[self txtDimxyraster] setStringValue:STR_loc];	return;		}
		// [RasterCorrente setindiceSubRasterCorrente   : indice];
	[interface setRckVisSubRas    :	[RasterCorrente visibleRasterIndice:[RasterCorrente indiceSubRastercorrente] ] ];
	[interface setRSlAlphSubRas   : [RasterCorrente  alphaindice        :[RasterCorrente indiceSubRastercorrente] ] ];
	
	STR_loc = [STR_loc stringByAppendingFormat: @"%d : %d", [ RasterCorrente	getdimx_indrast:[RasterCorrente indiceSubRastercorrente ]] ,
			   [ RasterCorrente	getdimy_indrast:[RasterCorrente indiceSubRastercorrente ]] ];
	[[self txtDimxyraster] setStringValue:STR_loc];
	
	
	[interfacewindow setSlidCentroRot     :  [RasterCorrente angoloindice:[RasterCorrente indiceSubRastercorrente ] ]];
	[interfacewindow setSlidCentroSca     :  [RasterCorrente scalaindice:[RasterCorrente indiceSubRastercorrente  ] ]];
	
	[self Disegnarasterino];

}



- (void) RimuovituttiVettoriali                                               {
	DisegnoV  *locmydisVector;
	for (int i=ListaVector.count-1; i>=0; i--) {
		locmydisVector = [ListaVector objectAtIndex:i];
		[self RimuoviSelezionatiDelDisegno:locmydisVector];

		[locmydisVector RemoveDisegno];
	}
    indiceVectorCorrente =0;
	[ListaVector removeAllObjects];
	[self DoNomiVectorPop];

}


- (void) setindsimbcorrente     : (int) indice                                {
	indicecurrentsimbolo = indice;
}


- (int)  indicecurrentsimbolo                                                 {
	return indicecurrentsimbolo;
}




- (NSView*)     ViewRasterino                                                 {
	return [interface ViewRasterino];
}

- (NSView*)     ViewVettorino                                                 {
	return [interface ViewVettorino];
}

	// Vettoriale
- (NSMutableArray *) ListaVector                                              {
	return ListaVector;
}
- (NSMutableArray *) ListaDefSimboli                                          {
	return ListaDefSimboli;
}

- (NSMutableArray *) ListaSelezionati                                         {
	return ListaSelezionati;
}
- (NSMutableArray *) ListaInformati                                           {
	return ListaInformati;
}

- (NSMutableArray *) ListaSelezEdifici                                        {
	return ListaSelezEdifici;	
}

- (NSMutableArray *) ListaSelezTerreni                                        {
	return ListaSelezTerreni;
}

- (NSMutableArray *) Listaproprietari                                         {
	return Listaproprietari;
}

- (NSMutableArray *) ListaproprietariFiltrata                                 {
	return ListaproprietariFiltrata;
}
- (NSMutableArray *) ListaEditvt                                              {
	return ListaEditvt;
}




- (int)   indiceVectorCorrente                                                {
	return indiceVectorCorrente;	
}

- (void)  setindiceVectorCorrente   : (int) indice                            {
	if ([ListaVector count]<=0 ) return;
	if (indice<0) indice=0;
	if (indice >= [ListaVector count]) indice = [ListaVector count]-1;
	indiceVectorCorrente = indice;
	[ [interface PopLVect]  selectItemAtIndex : indice ];
	[self DoNomiSubVectPop];
	[[ barilectr   ctrDlgVector] aggiorna:indiceVectorCorrente];

}

- (void)  CambioSubVector           : (int)indice                             {
	
	DisegnoV * VectorCorrente = [self DisegnoVcorrente];
	if (VectorCorrente==nil) return;
    [VectorCorrente setpianocorrente : indice ];
	[interface setRckVisSubVet        : [VectorCorrente visibilepiano :[VectorCorrente IndicePianocorrente]] ];
	[interface setRSlAlphLSubVet      : [VectorCorrente alphalinepiano:[VectorCorrente IndicePianocorrente]]];
	[interface setRSlAlphSSubVet      : [VectorCorrente alphasuppiano :[VectorCorrente IndicePianocorrente]]];
	
	NSSegmentedControl   *segSnapPia = [interface VSegSnapPiano];
	if ([VectorCorrente snappabilepiano   : [VectorCorrente IndicePianocorrente] ]) 
		[segSnapPia   setSelected:NSOnState  forSegment:1]; else [segSnapPia   setSelected:NSOffState  forSegment:1];
	if ([VectorCorrente editabilepiano    : [VectorCorrente IndicePianocorrente]]) 
		[segSnapPia   setSelected:NSOnState  forSegment:0]; else [segSnapPia   setSelected:NSOffState  forSegment:0];
	[self Disegnailpianino];
	[self paintboxcolorepiano];
	
	 NSString * locstrot = [[NSString alloc] initWithFormat:@"%2.4f",VectorCorrente.eventuale_ang*180/M_PI  ];
	 [[interface FtxtRot] setStringValue:locstrot]; 
 	 NSString * locstsca = [[NSString alloc] initWithFormat:@"%2.4f",VectorCorrente.eventuale_scala  ];
	 [[interface FtxtScala] setStringValue:locstsca]; 
	 NSString * locstx = [[NSString alloc] initWithFormat:@"%2.2f",[VectorCorrente eventuale_offx]  ];
	 [[interface Ftxoffx] setStringValue:locstx]; 
	 NSString * locsty = [[NSString alloc] initWithFormat:@"%2.2f",[VectorCorrente eventuale_offy]  ];
 	[[interface Ftxoffy] setStringValue:locsty]; 

	
	
    [ [interface vtlrotcen] setDoubleValue: VectorCorrente.eventuale_ang   ];	   
	[ [interface vtlscacen] setDoubleValue: VectorCorrente.eventuale_scala   ];	   
	[ [interface vtloffx  ] setDoubleValue: VectorCorrente.eventuale_offx   ];	   
	[ [interface vtloffy  ] setDoubleValue: VectorCorrente.eventuale_offy   ];	   
	

} 

- (void)  CambioVector              : (int)indice                             {
	[self   setindiceVectorCorrente : indice];
	DisegnoV * VectorCorrente = [self DisegnoVcorrente];
	[interface setRckVisVet:[VectorCorrente visibile]];
    [interface setRSlAlphLVet   : [VectorCorrente alphaline ] ];
    [interface setRSlAlphSVet   : [VectorCorrente alphasup ] ];
	NSSegmentedControl   *segSnapDis = [interface VSegSnapDis];
	if ([VectorCorrente snappabile]) [segSnapDis   setSelected:NSOnState  forSegment:1]; else [segSnapDis   setSelected:NSOffState  forSegment:1];
	if ([VectorCorrente editabile])  [segSnapDis   setSelected:NSOnState  forSegment:0]; else [segSnapDis   setSelected:NSOffState  forSegment:0];
		// [progetto aggiornamentodlgVet];
	[self CambioSubVector :[VectorCorrente IndicePianocorrente]];
}


- (void)  Disegnailpianino                                                    { 
	DisegnoV *DisVCor = [self DisegnoVcorrente];
	NSView * Thumvector = [self ViewVettorino];
	NSRect fondo =[Thumvector bounds];
	[Thumvector lockFocus];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClearRect (hdc, fondo );
	CGContextSetRGBFillColor (hdc, 0.43 ,0.51, 0.58 ,1.0 );
	CGContextFillRect (hdc, fondo);
			if (DisVCor!=nil) [DisVCor disegnailpianino:hdc:fondo];
	[Thumvector unlockFocus];
}

- (void)  paintboxcolorepiano                                                 {
	NSBox              *  Box_colorPiano = [self bcolPiano];
	[Box_colorPiano lockFocus];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	if ([self DisegnoVcorrente]==nil) {
		CGContextSetRGBFillColor (hdc, 0.43 ,0.51, 0.58 ,1.0 );
	}
	else	
		CGContextSetRGBFillColor   (hdc, [[self DisegnoVcorrente] colorepianoind_r:[[self DisegnoVcorrente] IndicePianocorrente]],
									[[self DisegnoVcorrente] colorepianoind_g:[[self DisegnoVcorrente] IndicePianocorrente]],
									[[self DisegnoVcorrente] colorepianoind_b:[[self DisegnoVcorrente] IndicePianocorrente]] ,1 ) ;
	NSRect ilframe;
	ilframe = [Box_colorPiano frame];
	CGContextBeginPath(hdc);
	CGContextMoveToPoint   (hdc, 0, 0);
	CGContextAddLineToPoint(hdc, 0, ilframe.size.height);
	CGContextAddLineToPoint(hdc, ilframe.size.width,  ilframe.size.height);
	CGContextAddLineToPoint(hdc, ilframe.size.width, 0);
	CGContextClosePath(hdc);	
	CGContextEOFillPath(hdc);
	if ([self DisegnoVcorrente]==nil) { } else {
		CGContextSetRGBStrokeColor (hdc, 0, 0, 0, 1);
		CGContextBeginPath(hdc);
		CGContextMoveToPoint   (hdc, 0, 0);
		CGContextAddLineToPoint(hdc, 0, ilframe.size.height);
		CGContextAddLineToPoint(hdc, ilframe.size.width,  ilframe.size.height);
		CGContextAddLineToPoint(hdc, ilframe.size.width, 0);
		CGContextClosePath(hdc);	
		CGContextStrokePath(hdc);
	}
	[Box_colorPiano unlockFocus];
		//	NSBeep();
}

- (void)  Disegnarasterino                                                    {
	DisegnoR *RasterCorrente = [self DisegnoRcorrente];
	NSView * thumb = [self ViewRasterino];
	[thumb lockFocus];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	NSRect fondo =[thumb bounds];
	CGContextSetRGBFillColor (hdc, 0.588 ,0.66,0.745 ,1.0 );
	CGContextFillRect (hdc, fondo);
	if (RasterCorrente !=nil)  [RasterCorrente disegnarasterino:hdc:fondo];
	[thumb unlockFocus];
	thumb = nil; 
}




- (void)  setrastercorrente         : (int) indice                            {
	if (indice<0) indice=0;
	if (indice>= [ListaRaster count]) return;
	indiceRasterCorrente = indice;
	[[interface PopLRas]  selectItemAtIndex:indice];
	[self DoNomiSubRasPop];
}

- (int)   indiceRasterCorrente                                                {
	return indiceRasterCorrente;	
}

- (void)  setindiceRasterCorrente   : (int) indice                            {
	indiceRasterCorrente = indice;	
}



- (void)  updateInfoPanel {
		//
		//	NSBeep();
}





	// raffinamento cal raster

- (void)     SetMinMaxSlRas         : (int) slind  :(bool) condup {
	[self  Set0SlRotScaXYRas   : slind ];
	NSSlider * locslide;
	switch (slind) {
		case 1:   locslide = [interfacewindow SlidImgCentroRot];	   break;
		case 2:   locslide = [interfacewindow SlidImgCentroSca];	   break;
		default:		                               break;
	}
	double differ;
	if (condup)	differ = ([locslide maxValue]-[locslide minValue]);
	else	differ = ([locslide maxValue]-[locslide minValue])/4;
	[locslide setMaxValue:([locslide  doubleValue]+differ)   ];
	[locslide setMinValue:([locslide  doubleValue]-differ)  ];
}

- (void)     SetupminMaxRotCen   : (bool) seup  minmax : (bool) seminimo rotsca : (bool) serot{
	NSSlider * locslide;  double valo;
	if (serot) 	{ locslide = [interfacewindow SlidImgCentroRot];
		if (seminimo) {
			valo = [locslide doubleValue] - [locslide minValue];
			if (seup)  valo = valo*2; else  valo = valo/2;
			valo=[locslide doubleValue]-valo;
			[locslide setMinValue:valo];
		}
		else {
			valo = -([locslide doubleValue] - [locslide maxValue]);
			if (seup)  valo = valo*2; else  valo = valo/2;
			valo=[locslide doubleValue]+valo;
			[locslide setMaxValue:valo];
		}
	}
	 else 	
	{ locslide = [interfacewindow SlidImgCentroSca]; 
		if (seminimo) {
			valo = [locslide doubleValue] - [locslide minValue];
			if (seup)  valo = valo*3/2; else  valo = valo/2;
			if (valo<0.001) valo=0.001;
			valo=[locslide doubleValue]-valo;
			[locslide setMinValue:valo];
		}
		else {
			valo = -([locslide doubleValue] - [locslide maxValue]);
			if (seup)  valo = valo*3/2; else  valo = valo/2;
			valo=[locslide doubleValue]+valo;
			[locslide setMaxValue:valo];
		}
	};
		
}

- (void)             Set0SlRotScaXYRas   : (int) slind {
	NSSlider * locslide;
	switch (slind) {
		case 1:   locslide = [interfacewindow SlidImgCentroRot];	   break;
		case 2:   locslide = [interfacewindow SlidImgCentroSca];	   break;
		default:		                                   break;
	}
	double differ;
	differ = ([locslide maxValue]-[locslide minValue])/2.0;
	[locslide setMaxValue:([locslide  doubleValue]+differ)   ];
	[locslide setMinValue:([locslide  doubleValue]-differ)  ];
	
}



- (void)             Set0SlRotScaXYVet   : (int) slind {
	NSSlider * locslide;
   switch (slind) {
	   case 1:   locslide = [interface vtlrotcen];	   break;
	   case 2:   locslide = [interface vtlscacen];	   break;
	   case 3:   locslide = [interface vtloffx];	   break;
	   case 4:   locslide = [interface vtloffy];	   break;
	   default:		                                   break;
   }
	double differ;
	differ = ([locslide maxValue]-[locslide minValue])/2.0;
	[locslide setMaxValue:([locslide  doubleValue]+differ)   ];
	[locslide setMinValue:([locslide  doubleValue]-differ)  ];
}	

- (void)             SetMinMaxSlVet         : (int) slind  :(bool) condup {
	[self  Set0SlRotScaXYVet   : slind ];
	NSSlider * locslide;
	switch (slind) {
		case 1:   locslide = [interface vtlrotcen];	   break;
		case 2:   locslide = [interface vtlscacen];	   break;
		case 3:   locslide = [interface vtloffx];	   break;
		case 4:   locslide = [interface vtloffy];	   break;
		default:		                               break;
	}
	double differ;
	if (condup)	differ = ([locslide maxValue]-[locslide minValue]);
	       else	differ = ([locslide maxValue]-[locslide minValue])/4;
	[locslide setMaxValue:([locslide  doubleValue]+differ)   ];
	[locslide setMinValue:([locslide  doubleValue]-differ)  ];
}





- (void)     updatedlgEdifici                       : (int) indice {
		//	Control_Immobili   * Ctrimmobili  = [interface Controlimmobili];
		//	[Ctrimmobili passaimmobili:[ [self DisegnoVcorrente] ImmobiliDisegno]];
		//		[Ctrimmobili updaterighe];
}

- (void)     updatedlgTerreni                       : (int) indice{
		//	Control_Terreni   * Ctrterreni    = [interface ControlTerreni];
		//		[Ctrterreni passaimmobili:[ [self DisegnoVcorrente] ImmobiliDisegno]];
		//		[Ctrterreni updaterighe];
}



- (NSSegmentedControl *)  ESxcord                                 {
	return [interface ESxcord];
}

- (NSSegmentedControl *)  ESycord                                 {
	return [interface ESycord];	
}

- (NSSegmentedControl *)  ESFuso                                 {
	return [interface ESFuso];
}

- (NSSegmentedControl *)  ESSnap                                  {
	return [interface ESSnap];
}

- (NSTextField        *)  txtDimxyraster                          {
	return [interface txtDimxyraster];
}

- (NSBox              *)  bcolPiano                               {
	return [interface bcolPiano];
}

- (NSPanel            *)  dlcalRas                                {return [bariledlg dlcalRas];}

- (NSPanel            *)  dlcalRasF                               {
	return [bariledlg dlcalRasF];
}

- (NSPanel            *)  dlrighello                              {
	return [bariledlg dlrighello];
}

- (NSTextField        *)  FieldAltezzaTesto                       {
	return [interface FieldAltezzaTesto];
}

- (NSTextField        *)  FieldTxtTesto                           {
	return [interface FieldTxtTesto];
}

- (NSView             *)  viewsimb                                {
	return [interface viewsimb];
}



- (Immobili           *) TuttiImmobili                            {
	return TuttiImmobili;
}

- (Immobili           *) TuttiImmobiliFiltrati                    {
	return TuttiImmobiliFiltrati;
}

- (Tax              *) TuttaTax                               {
	return TuttaTax;
}

- (Tax              *) TuttaTaxFiltrata                       {
	return TuttaTaxFiltrata;
}



- (void)                  RimuoviSelezionatiDelDisegno :(DisegnoV *) Dis    {
	Vettoriale * locvet;
	for (int i=ListaSelezionati.count-1; i>=0; i--) {  
		locvet = 	[ListaSelezionati objectAtIndex:i];
		if ([locvet disegno] == Dis  ) {[ListaSelezionati  removeObjectAtIndex:i];	}
	}

	for (int i=ListaSelezEdifici.count-1; i>=0; i--) {  
		locvet = 	[ListaSelezEdifici objectAtIndex:i];
		if ([locvet disegno] == Dis  ) {[ListaSelezEdifici  removeObjectAtIndex:i];	}
	}	
	
	
	for (int i=ListaSelezTerreni.count-1; i>=0; i--) {  
		locvet = 	[ListaSelezTerreni objectAtIndex:i];
		if ([locvet disegno] == Dis  ) {[ListaSelezTerreni  removeObjectAtIndex:i];	}
	}	
}



- (NSMutableArray *) ListTerreCatFoglio                           {
	return [TuttiImmobili LTer];
}

- (void)     MostraEdifInfo                                       {
	[[bariledlg dlgEdifici]	orderOut:self];
    bool trovato = NO;
	Subalterno * suber;
	Vettoriale * locvet; DisegnoV   * dis; Piano      * pia;
	NSMutableArray * ListSub;
	NSString   * nompartic;  
	NSString   * nomfoglio;  
	NSRange myrange;
	for (int j=0; j<ListaSelezEdifici.count; j++) {
	 locvet = [ListaSelezEdifici objectAtIndex:j];
	 dis  = [locvet disegno];
 	 nomfoglio = [dis nomeFoglioCXF];
			//	 NSLog(@"D %@",nomfoglio);
	 ListSub = [TuttiImmobili ListaSubalterni];
	 pia     = [locvet piano];
	 myrange.location=0;    
	 if ([pia  pianoPlus]) { myrange.length = [[pia givemenomepiano] length]-1;	}
	                  else { myrange.length = [[pia givemenomepiano] length];	}
     nompartic = [[pia givemenomepiano] substringWithRange:myrange];
		
		
	 for (int i=0; i<ListSub.count; i++) {
		suber = [ListSub objectAtIndex:i];
 	    if ([suber inlistanomesub:nompartic])
		{	if ([nomfoglio isEqualToString:[suber Foglio]] ) {	trovato = YES;	}		}
	 }
	 if (trovato) {
	    [[barilectr ctrEdi]  ImpostaFoglioPart  :nomfoglio : nompartic  ];
		[[bariledlg dlgEdifici]	orderFront:self];
		 break;  // potrebbero essere piu aree selezionate ma trovato l'edificio e' ok.
	 }
	}
	
}

- (void)     MostraTerraInfo                                      {
	Terreno * terer;
    bool trovato = NO;
 	NSMutableArray * ListTer = [TuttiImmobili LTer];
	NSString   * nompartic;  
	NSString   * nomfoglio;  
	Vettoriale * locvet; DisegnoV   * dis; Piano      * pia;
	if (ListaSelezTerreni.count <=0)  {[[bariledlg dlgTerreni]	orderOut:self]; return; }
	for (int j=0; j<ListaSelezTerreni.count; j++) {
		locvet = [ListaSelezTerreni objectAtIndex:j];
		dis  = [locvet disegno];
		pia     = [locvet piano];
		nomfoglio = [dis nomeFoglioCXF];
	    nompartic = [pia givemenomepiano];
		for (int i=0; i<ListTer.count; i++) {
			terer = [ListTer objectAtIndex:i];
				if ([terer inlistanomepart:nompartic] ) {
				if ([nomfoglio isEqualToString:[terer Foglio]] ) {	trovato = YES;
				}
			}
		}
		if (trovato) {
			[[barilectr ctrTer]  ImpostaTerraFoglio : nomfoglio :nompartic];
			[[bariledlg dlgTerreni]	orderFront:self]; break; // se trovo il terreno evito di ripeter il giro
		}
	}		
}

- (int)      pianoDlgSelezionato                                  {
	return [[barilectr ctrDlgVector] pianoDlgSelezionato];
}


- (IBAction)     salvaListaProprietari   : (id)  sender           {
	NSMutableData *lodata; 	lodata = [NSMutableData dataWithCapacity:10000000];
	
	VersioneImmobili = @"Prima";
	CodiceComune     = @"A210";
	nomecomune       = @"Allumiere";

	[self addstringaData2 : lodata : VersioneImmobili];
	[self addstringaData2 : lodata : CodiceComune];
	[self addstringaData2 : lodata : nomecomune];
	
	int numele ;	numele = Listaproprietari.count;
	[lodata appendBytes:(const void *)&numele              length:sizeof(numele)            ];
	Proprietari * proprier;
	for (int i=0; i<Listaproprietari.count; i++)    { 
		proprier = [Listaproprietari    objectAtIndex:i]; 
		[proprier salva : lodata];  
	}
	[lodata writeToFile:@"/MacOrMap/Catasto/Proprietari.ProMacorMap" atomically:NO];
}

- (void)     apriListaProprietari                                 {
	[Listaproprietari removeAllObjects];
	NSData * Datadafile ;
	int PosData =0;
	int numobj;
	Datadafile = [NSData dataWithContentsOfFile:@"/MacOrMap/Catasto/Proprietari.ProMacorMap"];
	
	if (Datadafile==nil) return;
	[VersioneImmobili release];	    VersioneImmobili =  [self GetStringaData2:Datadafile:&PosData];
	[CodiceComune     release];		CodiceComune     =  [self GetStringaData2:Datadafile:&PosData];
	[nomecomune       release];		nomecomune       =  [self GetStringaData2:Datadafile:&PosData];
	[Datadafile getBytes:&numobj  range:NSMakeRange (PosData,  sizeof(numobj)) ];       PosData +=sizeof(numobj);
	Proprietari * proprier;
		for (int i=0; i<numobj; i++) {  
		     proprier = [Proprietari alloc];	[proprier initProprietario]; 
			[proprier	apri : Datadafile :&PosData];  [proprier retain];
			[Listaproprietari addObject:proprier]; 
	}

 
}

- (void)        SetNomeFileImmobiliCatOrmap : (NSString * ) nome {
	[NomeFileImmobiliCatOrmap release]; NomeFileImmobiliCatOrmap = [[NSString alloc] initWithString:nome]; 
	[NomeFileImmobiliCatOrmap retain];
	
}


- (void)     apriImmobili                                         {

    [TuttiImmobili apri:NomeFileImmobiliCatOrmap];
}

- (void)     apriResidenti                                        {
    [anagrafe apri : @"/MacOrMap/Catasto/Anafrafe.AnMap"];
}

- (void)     apriTarsu                                            {
	[TuttaTax apri];
}

- (NSString  *) Dir_Catastali {
	return Dir_Catastali;
}

- (NSString  *) COD_Comune {
	return COD_Comune;
}

- (NSString  *) Dir_basedati {
	return Dir_basedati;
}


- (IBAction) alternasporcademo {
	
}

- (void) addstringaData   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	unichar ilcar;	
	for (int i=0; i<lungstr; i++) {
		ilcar = [ str characterAtIndex:i];
		[dat appendBytes:(const void *)&ilcar  length:sizeof(ilcar)];
	}
}


- (void) addstringaData2   : (NSMutableData *) dat : (NSString *) str     {
	int lungstr = [str length];	
	NSData *myData = [NSData dataWithBytes: [str UTF8String] length:  lungstr];
	[dat appendBytes:(const void *)&lungstr  length:sizeof(lungstr)];
	[dat appendData:myData];
}



- (NSString *) GetStringaData : (NSFileHandle  *) fileHandle {
	int lungstr;
	unichar ilcar;		
	NSData *_data;
	NSMutableString *locres = [[NSMutableString alloc] initWithCapacity:40];
	_data = [fileHandle readDataOfLength:   sizeof(lungstr)];    [_data getBytes:&lungstr];	
	for (int i=0; i<lungstr; i++) {
		_data = [fileHandle readDataOfLength:   sizeof(ilcar)];    [_data getBytes:&ilcar];	
		[locres   appendFormat:	 @"%c",ilcar];	}
	return locres;
}

- (NSString *) GetStringaData2 : (NSData  *) data : (int *) pos {
	int lungstr;	NSString *resulta;
	[data getBytes:&lungstr  range:NSMakeRange (*pos,  sizeof(lungstr)) ];       *pos +=sizeof(lungstr);
		//	NSLog(@"L %d",lungstr);
	if (lungstr>0) resulta =  [NSString stringWithUTF8String:[[data subdataWithRange:NSMakeRange (*pos,lungstr ) ]  bytes]];  else resulta = @"";
	*pos +=lungstr;
		//   	NSLog(@"st2 -%@-",resulta);
	return resulta;
}

- (int)      indiceinformato {
	return indiceinformato;
}

- (void)     setindiceInformato : (int) ind {
	indiceinformato = ind;
}

- (NSString *) nomequadronione {
    return nomequadronione;   
}

- (NSArray  *) righetestofile : (NSString *) nomefile {

	NSFileHandle *fileHandle;
	NSMutableString *buffer;
	fileHandle = [NSFileHandle fileHandleForReadingAtPath:nomefile];
	if (fileHandle==nil) return nil;
	NSData *data = [fileHandle availableData];
        //	NSLog(@"Data %lu",[data length]);
	
	NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // 	NSLog(@"str %lu",[str length]);

	buffer =[[NSMutableString alloc] init];
	[buffer appendString:str];
	[str release];
	return [buffer componentsSeparatedByString:@"\n"];
}

- (Anagrafe *) anagrafe {
    return anagrafe;
}

- (void)       iniziarettangolostampa {
	rettangoloStampa = [Polilinea alloc]; 	
	[rettangoloStampa Init:nil : nil];  
	[rettangoloStampa InitPolilinea:YES]; 
}

- (void)       setnilrettangolostampa {
	rettangoloStampa = nil;
}

- (Polilinea *) rettangoloStampa {
	return rettangoloStampa;
}


- (void) aprodatiSensibili {
	if (AutorizzatoDatiSensibili) {
		[self apriListaProprietari];
		if ([self Listaproprietari]!=nil) {
			ListaproprietariFiltrata = [[NSMutableArray alloc] initWithCapacity:Listaproprietari.count ];
			[[barilectr ctrProprietari]   passaListaproprietari  :[self Listaproprietari] : [self ListaproprietariFiltrata]] ;
			[[barilectr ctrPropFiltro]   passaListaproprietari  :[self Listaproprietari] : [self ListaproprietariFiltrata]] ;

			[[barilectr ctrPossessori ]   passaListaPossessori   :[self Listaproprietari]] ;
		}
	}
		//	else NSLog(@"pippo");
	
}

- (void) caricaDatiCAT   {
	

	
	if (giacaricatoCat) return;
		//	NSLog(@"Inizio");
	[self apriImmobili];
	if ([self TuttiImmobili]!=nil) {   // passo tutti gli gli immobili ma copiera' solo i subalterni
		[[barilectr ctrEdi]         impostaTuttiSubalterni: [self TuttiImmobili]  : [self TuttiImmobiliFiltrati] ]; 
		[[barilectr ctrEdiFiltro] impostaTuttiSubalterni: [self TuttiImmobili]  : [self TuttiImmobiliFiltrati] ]; 
		[[barilectr ctrEdi] AttivaFiltro:NO];
		[[barilectr ctrTer]         impostaTuttiTerreni   : [self TuttiImmobili]  : [self TuttiImmobiliFiltrati] ];
		[[barilectr ctrTerFiltro] impostaTuttiTerreni   : [self TuttiImmobili]  : [self TuttiImmobiliFiltrati] ];
		[[barilectr ctrTer] AttivaFiltro:NO];
	}
		//	NSLog(@"Immobili");
    [self aprodatiSensibili];
		//	NSLog(@"Sensibili");
	[self apriTarsu];
	if ([self TuttaTax]!=nil)
	{  
		[[barilectr ctrTax]     impostaListe : TuttaTax   : TuttaTaxFiltrata ];
	}
		//	NSLog(@"Tarsu");
	[self apriResidenti];
    if ([self anagrafe]!=nil) { 
        [[barilectr ctrAnagrafe]   passaAnagrafe:[self anagrafe]] ;   
		  [[barilectr ctrAnagFiltro]  passaAnagrafe:[self anagrafe]] ;  
			//        [[interface CtrEdi]         impostaElencoViaAnagrafe: [[self anagrafe] listaVie] ]; 
    }
		//	NSLog(@"Residenti");
	giacaricatoCat = YES;
	
	
		//		[self switchStatoDatiSensibili:self];
}



- (IBAction)  TestTogliCivicoTarsu   : (id) sender  {
	Tax_ele * tarser;
	NSString * locvia;
	NSString * viasecco;
	NSString * civicoAmpio;

    NSRange rg;
	for (int i=0; i<[TuttaTax ListaTarsuEle].count; i++) {
		tarser = [[TuttaTax ListaTarsuEle] objectAtIndex:i];
		locvia = [tarser Via];
		rg = [locvia rangeOfString:@","];
		if (rg.length>0) {
				//			NSLog(@"Via %@",locvia);
			viasecco = [locvia substringToIndex:rg.location];
				//			NSLog(@"V -%@-",viasecco);
			civicoAmpio = [locvia substringFromIndex:rg.location+1];
			NSLog(@"c -%@-",civicoAmpio);
			[tarser SetVia:viasecco];
			NSMutableString *stciv = [[NSMutableString  alloc] initWithCapacity:40];
            bool prespace = YES;
			char cc;
			for (int j=0; j<[civicoAmpio length]; j++) {
				cc = [civicoAmpio characterAtIndex:j];
				if (cc==32) {if (prespace) continue; else break;}
				else {prespace=NO; [stciv appendFormat:@"%c",cc];}
			}
			[tarser SetCivico:stciv];
			
		}
		
			//        [tarser logga];
	}
			[TuttaTax salva];
}



@end
