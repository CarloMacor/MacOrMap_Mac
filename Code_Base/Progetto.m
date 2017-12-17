//  Progetto.m
//  GIS2010
//
//  Created by Carlo Macor on 01/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Progetto.h"
#import "MacOrMapAppDelegate.h"
#import "DisegnoV.h"
#import "DisegnoR.h"
#import "InfoObj.h"
#import "Vettoriale.h"
#import "funzioni.h"

	// #import "Subalterno.h"
	// #import "Terreno.h"


@implementation Progetto

@synthesize  rettangoloStampaSingolo;

- (void) InitProgetto                                                                               {
	
	InConfermaSoftware =NO;
	VersioneSoftware = @"100";
	incomandotrasparente        = NO;
	LastComandotrasparente      = kStato_nulla;
	LastFaseComandotrasparente  = 0;
	[varbase setcomandofasecomando:kStato_nulla :0];
	trackingArea = [[NSTrackingArea alloc] initWithRect:self.frame 
	  options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow ) owner:self userInfo:nil ];
	[self addTrackingArea:trackingArea];
	[LeInfo setpdf   : _mypdf ];
	[_mypdf setHidden:YES];
	CGRect    loc_bound  = [self  bounds];
	[LeInfo set_dimVista :loc_bound.size.width: loc_bound.size.height];
	b_limitisetted=NO;
	[self display]; 
    [[self window] setAcceptsMouseMovedEvents: YES];
		//   [_dlgRighello setTitle:@"Scala con Righello"];
	[varbase DoNomiRasPop];	 
	[_myweb setAlphaValue:1.0];
    
    
    
	googleterreno  = [ googleno alloc];  
    [googleterreno   init: LeInfo :YES] ;
	[googleterreno setZoomGoogle_w:15];
	[googleterreno setZoomGoogle_r:15];
	[googleterreno setalpha:0.8];

    
    
		//	[self ZoomDisegno:self ];
    [self Google_action:self];
	modoaperturavet =1;
	[varbase upinterfacevector];
	[varbase upinterfaceraster];


    
		//	NSRect frweb = [_myweb frame];
		//	frweb.origin.x = 	frweb.origin.x+frweb.size.width;
		//	[_myweb setFrame:frweb];
		// [LayerVirtuale setFrame:[self frame]];

  
  
        // non funziona ?
        [self configurazioneDaFileEsterno];
	
    
    

    
    sfondobianco = NO;
        //	[self apriprogetto];
        //	[progdialogs Passaprogettochiamante:self];
        //DealyGoogleWegGet = 0.2;
        //googletimer = nil;

}

- (void) configurazioneDaFileEsterno                                                                {
	NSArray * righe;
	NSString * st;
	righe = [varbase  righetestofile:@"/MacOrMap/config.txt"];
    
    
    
	for (int i=0; i<[righe count]; i++) {
	
               st= [righe objectAtIndex:i];
        
        
        
        
 	    if (i==3)  { [varbase setcod_comune   : st];  	}
 	    
        
        if (i==5)  { [varbase setnomeQUnione  : st]; }
		
        if (i==7)  { [varbase setdircatastali : st]; }
        if (i==9)  { [varbase setdirbasedati  : st]; }

        
		if (i==11)  { [LeInfo  set_origineVistax:[st doubleValue] ]; }
		if (i==13) { [LeInfo  set_origineVistay:[st doubleValue] ]; }
		
		if (i==15) { [LeInfo  setoffxGoogleMaps:[st doubleValue] ]; }
		if (i==17) { [LeInfo  setoffyGoogleMaps:[st doubleValue] ]; }

		if (i==19) { [LeInfo  setoffcxfx:[st doubleValue] ]; }
		if (i==21) { [LeInfo  setoffcxfy:[st doubleValue] ]; }
	
	}
     
     
	
	    /*
    NSLog(@"yo %1.2f",[LeInfo yorigineVista]);
    NSLog(@"xo %1.2f",[LeInfo offsetCxfX]);
    NSLog(@"yo %1.2f",[LeInfo offsetCxfY]);
	*/
}

- (bool) isRettangoloStampa                                                                         {
	bool resulta;
	if ([varbase rettangoloStampa]==nil) resulta=NO; else resulta=YES;
	return resulta;
}


- (IBAction) apriprogetto                                                                           {

	
	
}


- (void) riposizionapannellibox {
	NSRect rectBoxDis=[[[varbase interface] boxDisegni] frame];
	NSRect rectBoxIma=[[[varbase interface] boxImmagini] frame];
	NSRect rectBoxCom=[[[varbase interface] boxComune] frame];

	NSRect rectProgetto=[self bounds];

    rectBoxDis.origin.x = [mainwindow frame].size.width-rectBoxDis.size.width;
 
    rectBoxIma.origin.x = [mainwindow frame].size.width-(rectBoxDis.size.width+rectBoxIma.size.width);
	
	rectBoxCom.origin.x = [mainwindow frame].size.width-(rectBoxIma.size.width+rectBoxCom.size.width+rectBoxDis.size.width);
	
	
	rectProgetto.size.width=[mainwindow frame].size.width-(rectBoxIma.size.width+rectBoxCom.size.width+rectBoxDis.size.width);

/*
	NSLog(@"-%1.2f",rectProgetto.size.width);
	NSLog(@"01-%1.2f",rectProgetto.origin.x);


	NSLog(@"+%1.2f",rectProgetto.size.width);
	NSLog(@"01+%1.2f",rectProgetto.origin.x);

	
	NSLog(@"...%1.2f",[mainwindow frame].size.width);
*/
	
	[[[varbase interface] boxDisegni] setFrame:rectBoxDis];
	[[[varbase interface] boxImmagini] setFrame:rectBoxIma];
	[[[varbase interface] boxComune] setFrame:rectBoxCom];
	[ViewContenitore setFrame:rectProgetto];
		//[self setBounds:rectProgetto];
		//			[self setFrame:rectProgetto];

		//	[self  bounds];
		//	[[[varbase interface] boxDisegni]
		//	 [[[varbase interface] boxImmagini]
	[self display];

}

- (IBAction )  vediBoxImmagini : (id) sender {
	int offerbox=184;
	NSRect rectBoxIma=[[[varbase interface] boxImmagini] frame];
	if (rectBoxIma.size.width>100) { rectBoxIma.size.width=rectBoxIma.size.width-offerbox;	}
	                          else { rectBoxIma.size.width=rectBoxIma.size.width+offerbox;	}
	[[[varbase interface] boxImmagini] setFrame:rectBoxIma];
	[self riposizionapannellibox ];
}




- (IBAction )  vediBoxDisegni  : (id) sender {
	int offerbox=180;
	NSRect rectBoxDis=[[[varbase interface] boxDisegni] frame];
	if (rectBoxDis.size.width>100) { rectBoxDis.size.width=rectBoxDis.size.width-offerbox;	}
	                          else { rectBoxDis.size.width=rectBoxDis.size.width+offerbox;	}
	[[[varbase interface] boxDisegni] setFrame:rectBoxDis];
	[self riposizionapannellibox ];
}


- (int)  modoaperturavet                                                                            {
	return modoaperturavet;   // se 1 distingue catasto
}

- (IBAction) SvuotaRasVet                   : (id) sender                                           {
	[varbase RimuovituttiRasters];
	[varbase RimuovituttiVettoriali];
	[[varbase interface] AggiornamentoNuovoProgetto];
	[self display];
}

// Disegna

- (void) drawRect                           : (NSRect) dirtyRect                                    {
	LeInfo.instampa = ![[NSGraphicsContext currentContext] isDrawingToScreen];
	
	// controllo qui se si e' cambiata la dim finestra
	CGRect    loc_bound  = [self  bounds];
	if (([LeInfo dimxVista]!= loc_bound.size.width) | ([LeInfo dimyVista]!= loc_bound.size.height))
	{
		[LeInfo set_dimVista :loc_bound.size.width: loc_bound.size.height];
		[self Google_action:self]; 
	}
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetInterpolationQuality (hdc,  kCGInterpolationNone  );
	CGContextSetAllowsAntialiasing (hdc, NO);
	CGContextSetShouldAntialias(hdc, NO);
	
			CGContextSetAllowsAntialiasing (hdc, YES);
			CGContextSetShouldAntialias(hdc, YES);
	
	[self Disegna:hdc];
	
	[self DisegnaSelezionati        ];
	[self DisegnaInformati          ];

	[self DisegnaListaSelezEdifici  ];
	[self DisegnaListaSelezTerreni  ];
	[self DisegnarettangoloStampa];
	
	if (LeInfo.instampa) {
		[self DisegnaExtraStampa :hdc ];
	}
	
}

- (void) DisegnaPan                         : (double) dx   : (double) dy                           {
		//			return;
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClearRect (hdc, [self visibleRect] );
	CGContextSetRGBFillColor (hdc, 0.5 ,0.5,0.5 ,1);
	CGContextFillRect (hdc, [self visibleRect]);
	_inrectPan.origin.x=_inrectPan.origin.x+dx;
	_inrectPan.origin.y=_inrectPan.origin.y+dy;
	CIContext* ciContext = [CIContext contextWithCGContext:hdc options:nil];
    [ciContext drawImage:SfondoCIImage inRect:_inrectPan fromRect:[self visibleRect]];
}	

- (void) Disegna                            : (CGContextRef) hdc                                    {
	
	
		//				return;
	CGRect    loc_bound  = [self  bounds];
	[LeInfo set_dimVista :loc_bound.size.width: loc_bound.size.height];
	CGContextSetRGBFillColor (hdc, 0.61 ,0.688,0.766 ,1.0 );
	if ([varbase rettangoloStampa]!=nil) CGContextSetRGBFillColor (hdc, 1.0 ,1.0,1.0 ,1.0 ); 	
		/// qui bianco
	if (sfondobianco) CGContextSetRGBFillColor (hdc, 1.0 ,1.0,1.0 ,1.0 ); 	
	CGContextFillRect (hdc, [self visibleRect]);
	[googleterreno   Disegna:hdc] ;
	DisegnoR *locdisras;
	CGContextSetAlpha (hdc,1.0);
	for (int i=0; i<[varbase Listaraster].count; i++) {  
		locdisras= [[varbase Listaraster] objectAtIndex:i];	if (locdisras!=nil) { [locdisras Disegna:hdc]; }
	}
	DisegnoV  *locdisvet;
	CGContextSetAlpha (hdc,1.0);
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i]; [locdisvet Disegna:hdc ];
	}
	
		// disegnare i pallini 
	Vettoriale *objvector;
	objvector=nil;
	CGContextSetRGBStrokeColor (hdc, 0.0,0,1.0,1.0);
	if (( varbase.comando ==  kStato_SpostaVertice) | ( varbase.comando ==  kStato_InserisciVertice)  | ( varbase.comando ==  kStato_CancellaVertice) ) {
		for (int i=0; i<[varbase ListaVector].count; i++) {  
			locdisvet= [[varbase ListaVector] objectAtIndex:i];
			[locdisvet disVtTutti:hdc ];
		}
	}
	if ( varbase.comando ==  kStato_EditSpVt)  {
		for (int i=0; i<[varbase ListaVector].count; i++) {  
			locdisvet= [[varbase ListaVector] objectAtIndex:i];
			[locdisvet dispallinispline:hdc ];
		}
	}
	if ([varbase inGriglia])  [self DisegnaGriglia :hdc];
}

- (void) DisegnaSelezionati                                                                         {
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
		// i selezionati
    CGContextSetRGBStrokeColor (hdc, 255.0,0,0,1.0);
    CGContextSetRGBFillColor   (hdc, 0.5,0.0,0.0, 0.2  );
    Vettoriale *objvector;
    for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
	    objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		if ([objvector dimmitipo]==6) 
			[objvector DisegnaSelected:hdc : LeInfo];
		else [objvector Disegna:hdc : LeInfo];
	}
}

- (void) DisegnaInformati                                                                           {
	Vettoriale *objvector;
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextSetRGBStrokeColor (hdc, 1.0,0.5,0,1.0);
	CGContextSetRGBFillColor   (hdc, 1.0,0.5,0.0, 0.2  );
	CGContextSetLineWidth      (hdc, 1.0 );
	for (int i=0; i<[varbase ListaInformati].count; i++) {  
		objvector= [[varbase ListaInformati] objectAtIndex:i];
		if ([objvector dimmitipo]==6) [objvector DisegnaSelected:hdc : LeInfo ];	else [objvector Disegna:hdc : LeInfo];
	}
	
	CGContextSetRGBStrokeColor (hdc, 1.0,0.5,0,1.0);
	CGContextSetRGBFillColor   (hdc, 1.0,0.5,0.0, 0.4  );
	CGContextSetLineWidth      (hdc, 3.0 );
	if (([varbase indiceinformato]>=0) & ([varbase indiceinformato]<[varbase ListaInformati].count) & ( [varbase ListaInformati].count>0 )  )
	{	objvector= [[varbase ListaInformati] objectAtIndex:[varbase indiceinformato]];
		if ([objvector dimmitipo]==6) [objvector DisegnaSelected:hdc : LeInfo]; else [objvector Disegna:hdc : LeInfo];
	}
	
}

- (void) DisegnaListaSelezEdifici                                                                   {
	Vettoriale *objvector;
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextSetRGBStrokeColor (hdc, 0.0,0.0,1.0,1.0);	
	CGContextSetRGBFillColor (hdc, 0.0,0.0,0.7, 0.2); 
	CGContextSetLineWidth (hdc, 1.0 );
	for (int i=0; i<[varbase ListaSelezEdifici].count; i++) {  
		objvector= [[varbase ListaSelezEdifici] objectAtIndex:i];
		if ([objvector dimmitipo]==6) [objvector DisegnaSelected:hdc : LeInfo];	else [objvector Disegna:hdc : LeInfo];
	}
	
}

- (void) DisegnaListaSelezTerreni                                                                   {
	Vettoriale *objvector;
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextSetRGBStrokeColor (hdc, 0.0,1.0,0.0 ,1.0);	
	CGContextSetRGBFillColor (hdc, 0.0,0.5,0.0 ,0.2); 
	CGContextSetLineWidth (hdc, 1.0 );
	for (int i=0; i<[varbase ListaSelezTerreni].count; i++) {  
		objvector= [[varbase ListaSelezTerreni] objectAtIndex:i];
		if ([objvector dimmitipo]==6) [objvector DisegnaSelected:hdc : LeInfo];	else [objvector Disegna:hdc : LeInfo];
	}
}

- (void) DisegnarettangoloStampa                                                                    {
	if ([varbase rettangoloStampa]==nil) return;
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextSetRGBStrokeColor (hdc, 0.0,0.0,0.0 ,1.0);	
	CGContextSetRGBFillColor (hdc, 0.2,0.2,0.2 ,0.0); 
		//	const CGFloat mypar[2] = {4,2 };    CGContextSetLineDash ( hdc , 0, mypar, 2 );
	CGContextSetLineWidth (hdc, 0.4 );
	[[varbase rettangoloStampa] Disegna:hdc : LeInfo];
	if (!rettangoloStampaSingolo) {
		double x1,y1,y2;
		[[varbase rettangoloStampa] faiLimiti];
		x1 = ([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2]) /2.0;
		y1 = [[varbase rettangoloStampa] limy1];
		y2 = [[varbase rettangoloStampa] limy2];
		x1 = (x1-[LeInfo xorigineVista])/[LeInfo scalaVista];
		y1 = (y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
		y2 = (y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
		CGContextBeginPath(hdc);
		CGContextMoveToPoint(hdc, x1, y1);	  CGContextAddLineToPoint(hdc, x1, y2);
		CGContextStrokePath(hdc);
	}
	
}

- (void) DisegnaVirtuale                    : (int) x1      : (int) y1  : (int) x2    : (int) y2    {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 0.0, 0.0, 0.0, 0.7); CGContextSetLineWidth(hdc,1.0 );
		//			CGContextSetBlendMode (hdc,kCGBlendModeDifference);  // con il bianco fai inverso dello sfondo ( lo lanci due volte e ottieni il precedente)
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, x1, y1);	CGContextAddLineToPoint(hdc, x2, y2);
	CGContextStrokePath(hdc);
}

- (void) DisegnaVerticale                   : (int) xv                                              {
	[self display];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0,0.0, 0.0, 0.5); CGContextSetLineWidth(hdc, 0.6 );
	CGContextBeginPath(hdc);
		CGContextMoveToPoint(hdc, xv, 0);	CGContextAddLineToPoint(hdc, xv, [LeInfo dimyVista]);
	CGContextStrokePath(hdc);
} 

- (void) DisegnaOrizzontale                 : (int) yv                                              {
	[self display];
		CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
		CGContextClipToRect ( hdc, [self frame]  );
		CGContextSetRGBStrokeColor (hdc, 1.0,0.0, 0.0, 0.5); CGContextSetLineWidth(hdc, 0.6 );
		CGContextBeginPath(hdc);
		CGContextMoveToPoint(hdc, 0, yv);	CGContextAddLineToPoint(hdc, [LeInfo dimxVista],yv);
		CGContextStrokePath(hdc);
} 

- (void) DisegnaSplineVirtuale              : (int) x1      : (int) y1                              {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, varbase.x1virt, varbase.y1virt);	CGContextAddLineToPoint(hdc, x1, y1);
	CGContextStrokePath(hdc);
	[[varbase DisegnoVcorrente] DisegnaSplineVirtuale:hdc:x1:y1];
}

- (void) DisegnaCerchioVirtuale             : (int) x1      : (int) y1  : (int) x2    : (int) y2    {
	[self ridisegnasfondo ];

	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1, 1, 1, 1.0); CGContextSetLineWidth(hdc, 1.0 );
	double rag = hypot((y2-y1), (x2-x1));
	CGContextBeginPath(hdc);
    CGContextAddArc (hdc, x1, y1 , rag, 0, 2*M_PI, 0);
	CGContextStrokePath(hdc);
}

- (void) DisegnaquadroVirtuale              : (int) x1      : (int) y1  : (int)    x2 : (int) y2    {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1, 1, 1, 1.0); CGContextSetLineWidth(hdc, 1.0 );
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, x1, y1);	  CGContextAddLineToPoint(hdc, x1, y2);
	CGContextAddLineToPoint(hdc, x2, y2); CGContextAddLineToPoint(hdc, x2, y1);
	CGContextAddLineToPoint(hdc, x1, y1);
	CGContextStrokePath(hdc);
	varbase.x2virt=x2;	varbase.y2virt=y2;
}

- (void) DisegnaRettangoloStampaVirtuale    : (double) x1 : (double) y1 : (double) x2 : (double) y2 {
	[self ridisegnasfondo ];
	double dxs= fabs(x2-x1);	double dys= fabs(y2-y1);
	if ((dxs/dys)>(297.0/210.0)) { dys = (210.0/297.0)*dxs;	if (y2>y1) y2=y1+dys; 	else   y2=y1-dys;	} 
	else { dxs = (297.0/210.0)*dys;	if (x2>x1) x2=x1+dxs; 	else   x2=x1-dxs;	}
	x1 = (x1-[LeInfo xorigineVista])/[LeInfo scalaVista];
	y1 = (y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
	x2 = (x2-[LeInfo xorigineVista])/[LeInfo scalaVista];
	y2 = (y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1, 1, 1, 1.0); CGContextSetLineWidth(hdc, 1.0 );
	CGContextBeginPath(hdc);
	CGContextMoveToPoint(hdc, x1, y1);	  CGContextAddLineToPoint(hdc, x1, y2);
	CGContextAddLineToPoint(hdc, x2, y2); CGContextAddLineToPoint(hdc, x2, y1);
	CGContextAddLineToPoint(hdc, x1, y1);
	CGContextStrokePath(hdc);
	
	if ([varbase comando]==kStato_RettangoloDoppioStampa) {
		CGContextBeginPath(hdc);
		CGContextMoveToPoint(hdc, (x2+x1)/2, y1);	  CGContextAddLineToPoint(hdc, (x2+x1)/2, y2);
		CGContextStrokePath(hdc);
	}
	
	varbase.x2virt=x2;	varbase.y2virt=y2;
}

- (void) DisSpostaVirtuale                  : (double) x1 : (double) y1 : (double) xm : (double) ym {
	
	double dx,dy;
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );

	dx=xm-x1;	dy=ym-y1;		
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector DisegnaAffineSpo:hdc:LeInfo :dx :dy ];
	}
}

- (void) DisegnaExtraStampa                 : (CGContextRef) hdc                                    {
	double offymasc = 2.0;
	
	NSColor *colore = [NSColor blackColor] ;
	NSFont *fonte = [NSFont fontWithName:@"Arial" size:8.0];
    NSPoint pt;	
	
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								fonte ,NSFontAttributeName, colore ,NSForegroundColorAttributeName, nil] ;
	
	NSString *macorMapstr = @"Stampato con MacOrMap ©" ;
	NSSize strsize = [macorMapstr sizeWithAttributes:attributes];
	if (NumPaginaInStampa==1) {pt.x=pageRect.size.width/2.0;} else {pt.x=pageRect.size.width*3.0/2.0;}
      pt.y=0.2;	  pt.x = pt.x-strsize.width/2;
	NSRect rt; rt.size=strsize; rt.origin=pt;	CGContextSetRGBFillColor (hdc, 1.0 ,1.0,1.0 ,1.0 );   CGContextFillRect (hdc, rt);
    [macorMapstr drawAtPoint:pt withAttributes:attributes];
	
	
		//		NSLog(@"dim carta %1.2f %1.2f ",pageRect.size.width,pageRect.size.height);
		//  783x559 297x210   72dpi ?
	double hcartaterreno = [[varbase rettangoloStampa] limy2]-[[varbase rettangoloStampa] limy1];
	double parahterreno  = hcartaterreno / pageRect.size.height;
	
	double parRighello = parahterreno*((72.0/2.54)*1.01);
		//	NSLog(@"Parametro %1.2f ",parRighello);

	
	NSString *strparRighello = [[NSString alloc] initWithFormat:@"Un Centimetro Carta = %1.2f Metri Terreno",parRighello];
	NSSize strsizeRig = [strparRighello sizeWithAttributes:attributes];
	if (NumPaginaInStampa==1) {pt.x=pageRect.size.width/2.0;} else {pt.x=pageRect.size.width*3.0/2.0;}
	pt.y=pageRect.size.height-(strsizeRig.height+offymasc*3);	  pt.x = pt.x-strsizeRig.width/2;
	NSRect rt2; rt2.size=strsizeRig; rt2.origin=pt;	CGContextSetRGBFillColor (hdc, 1.0 ,1.0,1.0 ,1.0 );   CGContextFillRect (hdc, rt2);
    [strparRighello drawAtPoint:pt withAttributes:attributes];
	
	
	
		//	NumPaginaInStampa;
		// rettangoloStampaSingolo
	  for (int i=0; i<4; i++) {
	  double xc,yc;	  NSString * stx, *sty;
	  if (rettangoloStampaSingolo) {
		  switch (i) {
			  case 0:  pt.x =offymasc; pt.y=offymasc;                        xc = [[varbase rettangoloStampa] limx1];
				                                                             yc = [[varbase rettangoloStampa] limy1];	break;
			  case 1:  pt.x =pageRect.size.width; pt.y=offymasc;             xc = [[varbase rettangoloStampa] limx2];	
				                                                             yc = [[varbase rettangoloStampa] limy1];	break;
			  case 2:  pt.x =offymasc; pt.y=pageRect.size.height-offymasc;   xc = [[varbase rettangoloStampa] limx1];	
				                                                             yc = [[varbase rettangoloStampa] limy2];	break;
			  case 3:  pt.x =pageRect.size.width; pt.y=pageRect.size.height-offymasc;
				                                                             xc = [[varbase rettangoloStampa] limx2];	
				                                                             yc = [[varbase rettangoloStampa] limy2];	break;
		  }
	  }
	  else {
		  switch (i) {
			  case 0:  pt.x =offymasc; pt.y=offymasc;                                     
				  if (NumPaginaInStampa==1) { xc =  [[varbase rettangoloStampa] limx1];  } else 
				                            { xc = ([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2])/2.0;  }
				  yc = [[varbase rettangoloStampa] limy1];	break;
			  case 1:  pt.x =pageRect.size.width-offymasc; pt.y=offymasc;                    
				  if (NumPaginaInStampa==1) { xc = ([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2])/2.0;  } else 
				                            { xc =  [[varbase rettangoloStampa] limx2]; }
               	  yc = [[varbase rettangoloStampa] limy1];	break;
			  case 2:  pt.x =offymasc; pt.y=pageRect.size.height;                   
				  if (NumPaginaInStampa==1) { xc =  [[varbase rettangoloStampa] limx1];  } else 
				                            { xc = ([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2])/2.0;  }
				  yc = [[varbase rettangoloStampa] limy2];	break;
			  case 3:  pt.x =pageRect.size.width-offymasc; pt.y=pageRect.size.height; 
				  if (NumPaginaInStampa==1) { xc = ([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2])/2.0;  } else 
				                            { xc =  [[varbase rettangoloStampa] limx2]; }
				  yc = [[varbase rettangoloStampa] limy2];	break;
		  }
	  }

	 
	 [LeInfo traformacord : &xc : &yc : [varbase TipoProiezione]];
	  switch ([varbase TipoProiezione]) {
		case 0: case 2 : case 4: case 5:	stx = [LeInfo invirgcoord:xc];	sty = [LeInfo invirgcoord:yc];	break;
		case 1:	case 3:		                stx = [LeInfo ingradi:xc];	    sty = [LeInfo ingradi:yc];	    break;
	  }
	  NSString * strco;
	  strco = [[NSString alloc] initWithFormat:@"%@  %@",stx,sty];	
	  NSSize strsize2 = [macorMapstr sizeWithAttributes:attributes];
		switch (i) {
			case 1:  pt.x =pageRect.size.width-strsize2.width-offymasc;                     break;
			case 2:  pt.y=pageRect.size.height-(strsize2.height+offymasc*3);                   break;
			case 3:  pt.x =pageRect.size.width-strsize2.width-offymasc; pt.y=pageRect.size.height-(strsize2.height+offymasc*3); break;
		}
	  if (NumPaginaInStampa==2) {pt.x = pt.x+pageRect.size.width;}

		  
		  NSRect rt; rt.size=strsize2; rt.origin=pt;
		  CGContextSetRGBFillColor (hdc, 1.0 ,1.0,1.0 ,1.0 ); 
		  CGContextFillRect (hdc, rt);
	  [strco drawAtPoint:pt withAttributes:attributes];
	 }
	
	
	


	
}

- (void) DisCopiaVirtuale                   : (double) x1 : (double) y1 : (double) xm : (double) ym {
	double dx,dy;
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	dx=xm-x1;	dy=ym-y1;		
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector DisegnaAffineSpo:hdc:LeInfo :dx :dy ];
	}
}

- (void) DisRuotaVirtuale                   : (double) x1 : (double) y1 : (double) xm : (double) ym {
	double angrot;	double dx,dy;
	dx = xm-x1;	dy = ym-y1; 
	if ((dx==0)  & (dy==0)) return;
	if (dx==0) { angrot = M_PI/2;             if (dy<0) angrot += M_PI;  } else 
	{ angrot = atan( dy / dx );    if (dx<0) angrot = M_PI+angrot; if (angrot<0) angrot += 2*M_PI;	}

	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector DisegnaAffineRot:hdc:LeInfo :x1 :y1 :angrot];
	}
}

- (void) DisScalaVirtuale                   : (double) x1 : (double) y1 : (double) xm : (double) ym {
	double scal;         double dx,dy,dd;
	dx = xm-x1;	dy = ym-y1; 
    dd = hypot(dx, dy);
	if (dd==0) return;
	dd   = (dd / [LeInfo scalaVista]);
	scal = (dd / [LeInfo dimyVista])*10;
	
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	Vettoriale *objvector;
	for (int i=0; i<[varbase ListaSelezionati].count; i++) {  
		objvector= [[varbase ListaSelezionati] objectAtIndex:i];
		[objvector DisegnaAffineSca:hdc:LeInfo :x1 :y1 :scal];
	}
}

- (void) DisDoppiaVirtual                   : (int)  modo : (double) xm : (double) ym               {
	double x1,y1;
	Vertice *Vm;
	Vm = [[varbase ListaEditvt] objectAtIndex:1];
	double dx,dy;
	dx = xm-[Vm xpos];	dy = ym-[Vm ypos];
	
	Vertice *a, *b;
	if (modo==1){	a=[[varbase ListaEditvt] objectAtIndex:2]; b=[[varbase ListaEditvt] objectAtIndex:3];	} else 
	            {	a=[[varbase ListaEditvt] objectAtIndex:4]; b=[[varbase ListaEditvt] objectAtIndex:5];	}
	Polilinea *Pl;
	Pl = [[varbase ListaEditvt] objectAtIndex:0];
	[self ridisegnasfondo ];
	
	if ([Pl isspline]) {
		double xc1,yc1;
		double xc2,yc2;
		Vertice *e;		int indice1=0;
		Vertice *p1,*t1,*t2;
		for (int i=0; i<[Pl numvt]; i++) { e= [[Pl Spezzata ] objectAtIndex:i];	if (a==e) { indice1=i;	break; } }
		CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
		CGContextClipToRect ( hdc, [self frame]  );
		CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
		CGContextBeginPath(hdc);
	
		if (modo==1){
         // dipende se il comando sia edit vertexcontroll			
		 if ([varbase comando] == kStato_EditSpVt) {
		
			 [a moveto:hdc :  LeInfo];
			 x1 = ([Vm xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 y1 = ([Vm ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
			 t1 = [[Pl VertControlList] objectAtIndex:indice1]; 
			 if ((indice1+2)<[Pl numvt]) t2= [[Pl VertControlList] objectAtIndex:(indice1+2)];
			 else  t2= [[Pl VertControlList] objectAtIndex:indice1+1];
			 
			 xc1=([a xpos]*2-[t1 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 yc1=([a ypos]*2-[t1 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
			 xc2=(xm-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 yc2=(ym-[LeInfo yorigineVista])/[LeInfo scalaVista];
			 
			 CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
			 
			 x1  = ([b xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 y1  = ([b ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
			 xc1 = ([Vm xpos]*2-xm-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 yc1 = ([Vm ypos]*2-ym-[LeInfo yorigineVista])/[LeInfo scalaVista];
			 xc2 = ([t2 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			 yc2 = ([t2 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];

			 
			 CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);

			 CGContextStrokePath(hdc);

//			 		 CGContextMoveToPoint(hdc, xc2, yc2);	
	//		 		 CGContextAddLineToPoint(hdc, xc1, yc1);
    //	 		     CGContextAddLineToPoint(hdc, xc2, yc2);	
	//		  		 CGContextAddLineToPoint(hdc, 0, 0);

//			 CGContextStrokePath(hdc);	
			 
			 
			 
			// fine  (Comando == kStato_EditSpVt) 

			 
		 } else {

		 if (Vm!=a)	[a moveto:hdc :  LeInfo];
		 x1=(xm-[LeInfo xorigineVista])/[LeInfo scalaVista];
		 y1=(ym-[LeInfo yorigineVista])/[LeInfo scalaVista];
	  	 t1= [[Pl VertControlList] objectAtIndex:indice1]; 
		 if ((indice1+1)<[Pl numvt]) t2= [[Pl VertControlList] objectAtIndex:(indice1+1)];
		                             else  t2= [[Pl VertControlList] objectAtIndex:indice1];
	
		 xc1=([a xpos]*2-[t1 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
		 yc1=([a ypos]*2-[t1 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
		 xc2=(([t2 xpos]+dx)-[LeInfo xorigineVista])/[LeInfo scalaVista];
		 yc2=(([t2 ypos]+dy)-[LeInfo yorigineVista])/[LeInfo scalaVista];
		
		 if (Vm!=a) CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1); else CGContextMoveToPoint(hdc, x1, y1);
			
		 t1= [[Pl VertControlList] objectAtIndex:indice1]; 
		 if ((indice1+1)<[Pl numvt]) t2= [[Pl VertControlList] objectAtIndex:(indice1+1)];
		                             else  t2= [[Pl VertControlList] objectAtIndex:indice1];
		
		 if ((indice1+2)<[Pl numvt]) {
			if (Vm!=a) {
				p1= [[Pl Spezzata] objectAtIndex:(indice1+1)]; 		
				x1=([b xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
				y1=([b ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
				
				t1= [[Pl VertControlList] objectAtIndex:(indice1+1)];
				t2= [[Pl VertControlList] objectAtIndex:(indice1+2)];	
			}else {
				p1= Vm; 		
				x1=([b xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
				y1=([b ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
				t1= [[Pl Spezzata] objectAtIndex:0];
				t2= [[Pl VertControlList] objectAtIndex:1];
			}
			
			xc1=(dx+([p1 xpos]*2-[t1 xpos])-[LeInfo xorigineVista])/[LeInfo scalaVista];
		    yc1=(dy+([p1 ypos]*2-[t1 ypos])-[LeInfo yorigineVista])/[LeInfo scalaVista];
		    xc2=([t2 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
		    yc2=([t2 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
		    CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1);
		  }
		 CGContextStrokePath(hdc);
//		 CGContextMoveToPoint(hdc, xc1, yc1);	
//		 CGContextAddLineToPoint(hdc, xc2, yc2);	
//		 CGContextStrokePath(hdc);	
				}
		} else {
			double locofx, locofy;
			t1  = [[Pl VertControlList] objectAtIndex:indice1]; 
			t2  = [[Pl VertControlList] objectAtIndex:indice1+1]; 
			locofx=(([a xpos]-[t1 xpos])/2) + (([b xpos]-[t2 xpos])/2) ;
			locofy=(([a ypos]-[t1 ypos])/2) + (([b ypos]-[t2 ypos])/2) ;
			CGContextBeginPath(hdc);
			x1  = (xm -          [LeInfo xorigineVista])/[LeInfo scalaVista];
			y1  = (ym -          [LeInfo yorigineVista])/[LeInfo scalaVista];
			xc1 = (xm + locofx - [LeInfo xorigineVista])/[LeInfo scalaVista];
			yc1 = (ym + locofy - [LeInfo yorigineVista])/[LeInfo scalaVista];
 		    xc2 = ([t2 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			yc2 = ([t2 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];

			CGContextBeginPath(hdc);
			[a moveto : hdc : LeInfo];
			CGContextAddLineToPoint(hdc, x1, y1);	
			[b lineto : hdc : LeInfo];
			CGContextStrokePath(hdc);				
/*
			
			CGContextMoveToPoint(hdc, xc1, yc1);
			CGContextAddLineToPoint(hdc, x1, y1);	
			CGContextAddLineToPoint(hdc, xc2, yc2);	
			CGContextStrokePath(hdc);				
			
			
			CGContextBeginPath(hdc);
  		    [a moveto : hdc : LeInfo];
			CGContextAddCurveToPoint(hdc, xc1, yc1, xc2, yc2, x1, y1); 
			
			x1  = ([b xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			y1  = ([b ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
			xc1 = (xm-[LeInfo xorigineVista])/[LeInfo scalaVista];
			yc1 = (ym-[LeInfo yorigineVista])/[LeInfo scalaVista];
			xc2 = ([t2 xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			yc2 = ([t2 ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
			
			CGContextAddCurveToPoint(hdc, xc1,yc1,xc2,yc2,x1,y1); 

			
			
			CGContextStrokePath(hdc);
			
			CGContextMoveToPoint(hdc, xc1, yc1);	
			CGContextAddLineToPoint(hdc, xc2, yc2);	
			CGContextStrokePath(hdc);	
*/			
		}

		
	} else 
	{
	 CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	 CGContextClipToRect ( hdc, [self frame]  );
	 CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	 CGContextBeginPath(hdc);
	 x1 = ([a xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
	 y1 = ([a ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
	 CGContextMoveToPoint(hdc, x1, y1);	
	 x1 = (xm-[LeInfo xorigineVista])/[LeInfo scalaVista];
	 y1 = (ym-[LeInfo yorigineVista])/[LeInfo scalaVista];
	 CGContextAddLineToPoint(hdc, x1, y1);	
	 x1 = ([b xpos]-[LeInfo xorigineVista])/[LeInfo scalaVista];
	 y1 = ([b ypos]-[LeInfo yorigineVista])/[LeInfo scalaVista];
	 CGContextAddLineToPoint(hdc, x1, y1);	
	 CGContextStrokePath(hdc);
	} // spezzata normale fine
}

- (void) dispallinispline                                                                           {
	[self lockFocus];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextSetRGBStrokeColor (hdc, 0.1 , 0.1, 0.1, 0.7);
	DisegnoV  *locdisvet;
	CGContextSetAlpha (hdc,1.0);
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [locdisvet dispallinispline:hdc ];
	}
	[self unlockFocus];
}

- (void) DisSpostaDisegno                   : (double) x1 : (double) y1 : (double) xm : (double) ym {
	DisegnoV  *DisVectCorrente = [varbase DisegnoVcorrente];	
    if (DisVectCorrente==nil) return;
	double dx,dy;
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	dx=xm-x1;	dy=ym-y1;		
		//	DisegnoV  *locdisvet;
	CGContextSetAlpha (hdc,1.0);
		//	for (int i=0; i<[varbase ListaVector].count; i++) {  
		//		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [DisVectCorrente DisSpostaDisegno :hdc:dx:dy ];
		//	}
}

- (void) DisRuotaDisegno                    : (double) xc : (double) yc : (double) xm : (double) ym {
	DisegnoV  *DisVectCorrente = [varbase DisegnoVcorrente];	
    if (DisVectCorrente==nil) return;

	double angrot;	double dx,dy;
	dx = xm-xc;	dy = ym-yc; 
	if ((dx==0)  & (dy==0)) return;
	if (dx==0) { angrot = M_PI/2;             if (dy<0) angrot += M_PI;  } else 
	{ angrot = atan( dy / dx );    if (dx<0) angrot = M_PI+angrot; if (angrot<0) angrot += 2*M_PI;	}
	
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
		//	DisegnoV  *locdisvet;
	CGContextSetAlpha (hdc,1.0);
		//	for (int i=0; i<[varbase ListaVector].count; i++) {  
		//		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [DisVectCorrente DisRuotaDisegno :hdc:xc:yc:angrot ];
		//	}
	
}

- (void) DisScalaDisegno                    : (double) xc : (double) yc : (double) xm : (double) ym {
	DisegnoV  *DisVectCorrente = [varbase DisegnoVcorrente];	
    if (DisVectCorrente==nil) return;

	double scal;         double dx,dy,dd;
	dx = xm-xc;	dy = ym-yc; 
    dd = hypot(dx, dy);
	if (dd==0) return;
	
	scal = dd / 100;
	
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
		//	DisegnoV  *locdisvet;
	CGContextSetAlpha (hdc,1.0);
		//	for (int i=0; i<[varbase ListaVector].count; i++) {  
		//		locdisvet= [[varbase ListaVector] objectAtIndex:i];
        [DisVectCorrente DisScalaDisegno :hdc:xc:yc:scal ];
		//	}
	
}

- (void) DisSimbolovirtualeang              : (double) angrot                                       {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	[[varbase DisegnoVcorrente] ruotasimbolo  :hdc : angrot];
}
	
- (void) DisSimbolovirtualesca              : (double) parscal                                      {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	[[varbase DisegnoVcorrente] scalasimbolo:hdc : parscal];
}

- (void) DisTestoVirtuale                   : (double) xc : (double) yc : (double) sc : (double)ang {
	[self ridisegnasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	CGContextSetRGBStrokeColor (hdc, 1.0, 1.0, 1.0, 0.5); CGContextSetLineWidth(hdc, 1.0 );
	[[varbase DisegnoVcorrente] Distxtvirtual : hdc   : xc : yc : ang : sc];
}

- (bool) SnappaGriglia                      : (double) xc : (double) yc                             {
	bool resulta =NO;
	int troppebarre=100;
    bool locres = NO;
	double off  =  [LeInfo give_offsetmirino ];
	
	if (([[[[varbase barilectr] ctrDlgGriglia] Gr_B1] state] ) & (!locres)) {
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S1] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
			default:offerGr=1000;		    break;
		}
		xstart = (double)((int)(xstart/offerGr)*offerGr);	
		ystart = (double)((int)(ystart/offerGr)*offerGr);
		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		while (xstart<xend) {
		    double locystart = ystart;	
			while (locystart<yend) {
				double dx   =  (xc-xstart); 	double dy   =  (yc-locystart); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : xstart : locystart];  locres=YES; break;}	
				
				locystart=locystart+offerGr;
			}
			if (locres) break;
			xstart=xstart+offerGr;
		}
	} // gr_b1 utmwgs84
	
	if (([[[[varbase barilectr] ctrDlgGriglia] Gr_B2] state] ) & (!locres)) { // globo
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S2] selectedSegment] ) {
			case 0:	offerGr = 10.0/3600.0;	break;
			case 1:	offerGr = 30.0/3600.0; 	break;
			case 2:	offerGr = 1.0/60.0;	break;
			case 3:	offerGr = 5.0/60.0;	break;
			default:offerGr = 1.0/60.0;	break;
		}
		[LeInfo utmtolatlon  : &xstart : &ystart ];
		[LeInfo utmtolatlon  : &xend   : &yend   ];
		xstart = (double)((int)(xstart/offerGr)*offerGr) ;	
		ystart = (double)((int)(ystart/offerGr)*offerGr);
		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		double x1,y1;
		double xstartwhile = xstart;
		double ystartwhile = ystart;

		while (xstartwhile<xend) {
			ystartwhile = ystart;
			while (ystartwhile<yend) {
				y1=ystartwhile; x1=xstartwhile;		[LeInfo latlonToUtm  : &x1 : &y1] ;
				double dx   =  (xc-x1); 	double dy   =  (yc-y1); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : x1 : y1];  locres=YES; break;}	
				ystartwhile = ystartwhile+offerGr;
			}
			if (locres) break;
			xstartwhile = xstartwhile+offerGr;
		}
	} // gr_b2 globo wgs

	
	if (([[[[varbase barilectr] ctrDlgGriglia] Gr_B3] state] ) & (!locres)) {  // D50
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S3] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
			default:offerGr=1000;		    break;
		}
		
		xstart = (double)((int)(xstart/offerGr)*offerGr);	ystart = (double)((int)(ystart/offerGr)*offerGr);
		xstart = xstart-69;		ystart = ystart-192;  // qui la modifica tra wgs84 e D50

		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		while (xstart<xend) {
		    double locystart = ystart;	
			while (locystart<yend) {
				double dx   =  (xc-xstart); 	double dy   =  (yc-locystart); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : xstart : locystart];  locres=YES; break;}	
				
				locystart=locystart+offerGr;
			}
			if (locres) break;
			xstart=xstart+offerGr;
		}
	} // gr_b3 50
	
	if (([[[[varbase barilectr] ctrDlgGriglia] Gr_B4] state] ) & (!locres)) { // globo D50
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S4] selectedSegment] ) {
			case 0:	offerGr = 10.0/3600.0;	break;
			case 1:	offerGr = 30.0/3600.0; 	break;
			case 2:	offerGr = 1.0/60.0;	break;
			case 3:	offerGr = 5.0/60.0;	break;
			default:offerGr = 1.0/60.0;	break;
		}
		
		[LeInfo utmtolatlon50  : &xstart : &ystart ];		[LeInfo utmtolatlon50  : &xend   : &yend   ];
 	    xstart = (double)((int)(xstart/offerGr)*offerGr) ;	
		ystart = (double)((int)(ystart/offerGr)*offerGr);
		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		
		double x1,y1;
		double xstartwhile = xstart;
		double ystartwhile = ystart;
		
		while (xstartwhile<xend) {
			ystartwhile = ystart;
			while (ystartwhile<yend) {
				y1=ystartwhile; x1=xstartwhile;		[LeInfo latlon50ToUtm  : &x1 : &y1] ;
				double dx   =  (xc-x1); 	double dy   =  (yc-y1); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : x1 : y1];  locres=YES; break;}	
				ystartwhile = ystartwhile+offerGr;
			}
			if (locres) break;
			xstartwhile = xstartwhile+offerGr;
		}
	} // gr_b4 globo D50
	
		////////////////////////////////////////////////////////////////	

	
	if ([[[[varbase barilectr] ctrDlgGriglia] Gr_B5] state] ) {  // Cassini-Soldner
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S5] selectedSegment] ) {
			case 0:	offerGr = 10;   break;
			case 1:	offerGr = 100; 	break;
			case 2:	offerGr = 1000;	break;
			default:offerGr=1000;		    break;
		}
		
		[LeInfo utmtocatasto  : &xstart : &ystart ];	[LeInfo utmtocatasto  : &xend   : &yend   ];
 	    xstart = (double)((int)(xstart/offerGr)*offerGr) ;	
		ystart = (double)((int)(ystart/offerGr)*offerGr);
		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		
		double x1,y1;
		double xstartwhile = xstart;
		double ystartwhile = ystart;
		
		while (xstartwhile<xend) {
			ystartwhile = ystart;
			while (ystartwhile<yend) {
				y1=ystartwhile; x1=xstartwhile;		[LeInfo catastotoutm  : &x1 : &y1] ;
				double dx   =  (xc-x1); 	double dy   =  (yc-y1); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : x1 : y1];  locres=YES; break;}	
				ystartwhile = ystartwhile+offerGr;
			}
			if (locres) break;
			xstartwhile = xstartwhile+offerGr;
		}
	}  // Cassini-Soldner
	
	
	  //////////////////////////////////////////////////	
	
	if ([[[[varbase barilectr] ctrDlgGriglia] Gr_B6] state] ) {  // Gauss-Boaga
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_S6] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
			default:offerGr=1000;		    break;
		}
		
		
		xstart = (double)((int)(xstart/offerGr)*offerGr);	ystart = (double)((int)(ystart/offerGr)*offerGr);
		xstart = xstart-12;		ystart = ystart-10;  // qui la modifica tra wgs84 e Gauss Boaga
		int numbarre = (int)((xend-xstart)/offerGr);	if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		
		while (xstart<xend) {
		    double locystart = ystart;	
			while (locystart<yend) {
				double dx   =  (xc-xstart); 	double dy   =  (yc-locystart); 
				if (dx<0) dx=-dx; 	    if (dy<0) dy=-dy;
				if ((dx<off) & (dy<off)) {	[LeInfo setxysnap : xstart : locystart];  locres=YES; break;}	
				locystart=locystart+offerGr;
			}
			if (locres) break;
			xstart=xstart+offerGr;
		}
	} // gr_b1 utmwgs84
	
	if (locres) {
		resulta=YES;  
		varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];  
		varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
		varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
		
	}
	return resulta;
}

- (void) DisegnaGriglia                     : (CGContextRef) hdc                                    {
		//return;
	int troppebarre=100;
	
	
	if ([[[[varbase barilectr] ctrDlgGriglia] Gr_B1] state] ) {
 	  CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes1]     intValue]);
	  CGContextSetRGBStrokeColor (hdc, [[[[[varbase barilectr] ctrDlgGriglia] Gr_Col1]  color] redComponent] 
								     , [[[[[varbase barilectr] ctrDlgGriglia] Gr_Col1]  color] greenComponent] 
								     , [[[[[varbase barilectr] ctrDlgGriglia] Gr_Col1]  color] blueComponent] , 1.0);
	  const CGFloat para1[2] = {4 ,6};	              const CGFloat para2[4] = {6 ,6,1,6};   
	  const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
	  const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
	  switch ([[[[varbase barilectr] ctrDlgGriglia] Gr_Trat1] indexOfSelectedItem] ) {
		  case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
		  case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
		  case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
		  case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
		  case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
		  case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
		  default : break;
	  }		
	  double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
	  double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
 	  double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S1] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
		default:offerGr=1000;		    break;
		}
	  xstart = (double)((int)(xstart/offerGr)*offerGr);	ystart = (double)((int)(ystart/offerGr)*offerGr);

		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
			//	xstart = xstart-69;
			//	ystart = ystart-192;
	  while (xstart<xend) {
		double x1=(xstart-[LeInfo xorigineVista])/[LeInfo scalaVista];
		CGContextMoveToPoint   (hdc, x1 , 0);		CGContextAddLineToPoint(hdc, x1 , [self bounds].size.height);
		CGContextStrokePath(hdc);		            xstart=xstart+offerGr;
	  }
      while (ystart<yend) {
		double y1=(ystart-[LeInfo yorigineVista])/[LeInfo scalaVista];
		CGContextMoveToPoint   (hdc, 0, y1);		CGContextAddLineToPoint(hdc, [self bounds].size.width , y1);
		CGContextStrokePath(hdc);		            ystart=ystart+offerGr;
	  }
	} // gr_b1 utmwgs84
	
	if ([[[[varbase  barilectr] ctrDlgGriglia] Gr_B2] state] ) { // globo
		CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes2]     intValue]);
		CGContextSetRGBStrokeColor (hdc, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col2]  color] redComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col2]  color] greenComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col2]  color] blueComponent] , 1.0);
		const CGFloat para1[2] = {4 ,6};	              const CGFloat para2[4] = {6 ,6,1,6};   
		const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
		const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_Trat2] indexOfSelectedItem] ) {
			case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
			case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
			case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
			case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
			case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
			case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
			default : break;
		}		
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S2] selectedSegment] ) {
			case 0:	offerGr = 10.0/3600.0;	break;
			case 1:	offerGr = 30.0/3600.0; 	break;
			case 2:	offerGr = 1.0/60.0;	break;
			case 3:	offerGr = 5.0/60.0;	break;
			default:offerGr = 1.0/60.0;	break;
		}
		
    
		[LeInfo utmtolatlon  : &xstart : &ystart ];
		[LeInfo utmtolatlon  : &xend   : &yend   ];
		
			 	    xstart = (double)((int)(xstart/offerGr)*offerGr) ;	
					ystart = (double)((int)(ystart/offerGr)*offerGr);
		
			//		xstart = (double)((int)(xstart/offerGr)*offerGr) -offerGr;	
			//		ystart = (double)((int)(ystart/offerGr)*offerGr) -offerGr;
			//		xend = xend+offerGr;  yend=yend+offerGr;

		
			//	[LeInfo utmtolatlon  : &xstart : &ystart ];
			//		[LeInfo utmtolatlon  : &xend   : &yend   ];

		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}

 
		
		double x1, y1,x2,y2;
		double xstartwhile = xstart;
		while (xstartwhile<xend) {
			x1=xstartwhile; y1=ystart;  x2=xstartwhile;   y2=yend;
			[LeInfo latlonToUtm  : &x1 : &y1] ;
			[LeInfo latlonToUtm  : &x2 : &y2] ;
			double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		            
			xstartwhile = xstartwhile+offerGr;
		}
		double ystartwhile = ystart;
		while (ystartwhile<yend) {
			y1=ystartwhile; x1=xstart;  y2=ystartwhile;   x2=xend;
			[LeInfo latlonToUtm  : &x1 : &y1] ;
			[LeInfo latlonToUtm  : &x2 : &y2] ;
			double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		           			
			ystartwhile = ystartwhile+offerGr;
		}
		
	} // gr_b2 globo wgs
	
	
	if ([[[[varbase  barilectr] ctrDlgGriglia] Gr_B3] state] ) {  // D50
		CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes3]     intValue]);
		CGContextSetRGBStrokeColor (hdc, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col3]  color] redComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col3]  color] greenComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col3]  color] blueComponent] , 1.0);
		const CGFloat para1[2] = {4 ,6};	          const CGFloat para2[4] = {6 ,6,1,6};   
		const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
		const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_Trat3] indexOfSelectedItem] ) {
			case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
			case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
			case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
			case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
			case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
			case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
			default : break;
		}		
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S3] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
			default:offerGr=1000;		    break;
		}
		xstart = (double)((int)(xstart/offerGr)*offerGr);	ystart = (double)((int)(ystart/offerGr)*offerGr);
		xstart = xstart-69;		ystart = ystart-192;  // qui la modifica tra wgs84 e D50
		
		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}

		
		while (xstart<xend) {
			double x1=(xstart-[LeInfo xorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1 , 0);		CGContextAddLineToPoint(hdc, x1 , [self bounds].size.height);
			CGContextStrokePath(hdc);		            xstart=xstart+offerGr;
		}
		while (ystart<yend) {
			double y1=(ystart-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, 0, y1);		CGContextAddLineToPoint(hdc, [self bounds].size.width , y1);
			CGContextStrokePath(hdc);		            ystart=ystart+offerGr;
		}
	} // gr_b3 utmwgs50
	
	
	if ([[[[varbase  barilectr] ctrDlgGriglia] Gr_B4] state] ) { // globo D50
		CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes4]     intValue]);
		CGContextSetRGBStrokeColor (hdc, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col4]  color] redComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col4]  color] greenComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col4]  color] blueComponent] , 1.0);
		const CGFloat para1[2] = {4 ,6};	              const CGFloat para2[4] = {6 ,6,1,6};   
		const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
		const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_Trat4] indexOfSelectedItem] ) {
			case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
			case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
			case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
			case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
			case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
			case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
			default : break;
		}		
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+([self bounds].size.width+100)*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S4] selectedSegment] ) {
			case 0:	offerGr = 10.0/3600.0;	break;
			case 1:	offerGr = 30.0/3600.0; 	break;
			case 2:	offerGr = 1.0/60.0;	break;
			case 3:	offerGr = 5.0/60.0;	break;
			default:offerGr = 1.0/60.0;	break;
		}
		
		
		
		
		[LeInfo utmtolatlon50  : &xstart : &ystart ];
		[LeInfo utmtolatlon50  : &xend   : &yend   ];
   
		
 	    xstart = (double)((int)(xstart/offerGr)*offerGr)-offerGr;	
		ystart = (double)((int)(ystart/offerGr)*offerGr);

				
		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}
		
        double dimxMonitor = [self bounds].size.width;
        double dimyMonitor = [self bounds].size.height;
		
		double x1, y1,x2,y2;
		double xstartwhile = xstart;
			//		while (xstartwhile<xend) {
			while (YES) {

			x1=xstartwhile; y1=ystart;  x2=xstartwhile;   y2=yend;
				//					NSLog(@"X %@  ",[LeInfo ingradi:x1] );
			[LeInfo latlon50ToUtm  : &x1 : &y1] ;
			[LeInfo latlon50ToUtm  : &x2 : &y2] ;
			
		    double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			
					//				if (y2g<dimyMonitor) NSBeep();
				
				
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		            
			xstartwhile = xstartwhile+offerGr;
			
			if ((x1g>dimxMonitor) & (x2g>dimxMonitor)) break;
		}
		
		
		double ystartwhile = ystart;
			//		while (ystartwhile<yend) {
			while (YES) {

			y1=ystartwhile; x1=xstart;  y2=ystartwhile;   x2=xend;
			[LeInfo latlon50ToUtm  : &x1 : &y1] ;
			[LeInfo latlon50ToUtm  : &x2 : &y2] ;
			double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		           			
			ystartwhile = ystartwhile+offerGr;
			if ((y1g>dimyMonitor) & (y2g>dimyMonitor)) break;

		}
		
	} // gr_b4 globo D50
	
	

	if ([[[[varbase  barilectr] ctrDlgGriglia] Gr_B5] state] ) {  // Cassini-Soldner
		CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes5]     intValue]);
		CGContextSetRGBStrokeColor (hdc, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col5]  color] redComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col5]  color] greenComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col5]  color] blueComponent] , 1.0);
		const CGFloat para1[2] = {4 ,6};	              const CGFloat para2[4] = {6 ,6,1,6};   
		const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
		const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_Trat5] indexOfSelectedItem] ) {
			case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
			case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
			case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
			case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
			case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
			case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
			default : break;
		}		
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S5] selectedSegment] ) {
			case 0:	offerGr = 10;   break;
			case 1:	offerGr = 100; 	break;
			case 2:	offerGr = 1000;	break;
			default:offerGr=1000;		    break;
		}

		[LeInfo utmtocatasto  : &xstart : &ystart ];
		[LeInfo utmtocatasto  : &xend   : &yend   ];

		double x1, y1,x2,y2;
		xstart = (double)((int)(xstart/offerGr)*offerGr)-offerGr;	ystart = (double)((int)(ystart/offerGr)*offerGr)-offerGr;
		xend = xend+offerGr;  yend=yend+offerGr;
		
		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}

		
		double xstartwhile = xstart;
		while (xstartwhile<xend) {
			x1=xstartwhile; y1=ystart;  x2=xstartwhile;   y2=yend;
			[LeInfo catastotoutm  : &x1 : &y1] ;
			[LeInfo catastotoutm  : &x2 : &y2] ;
			double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		            
			xstartwhile = xstartwhile+offerGr;
		}
		double ystartwhile = ystart;
		while (ystartwhile<yend) {
			y1=ystartwhile; x1=xstart;  y2=ystartwhile;   x2=xend;
			[LeInfo catastotoutm  : &x1 : &y1] ;
			[LeInfo catastotoutm  : &x2 : &y2] ;
			double x1g=(x1-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y1g=(y1-[LeInfo yorigineVista])/[LeInfo scalaVista];
			double x2g=(x2-[LeInfo xorigineVista])/[LeInfo scalaVista];			double y2g=(y2-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1g , y1g);		CGContextAddLineToPoint(hdc, x2g , y2g);
			CGContextStrokePath(hdc);		           			
			ystartwhile = ystartwhile+offerGr;
	}
		
		
	}  // Cassini-Soldner
	
	if ([[[[varbase  barilectr] ctrDlgGriglia] Gr_B6] state] ) {  // Gauss-Boaga
		CGContextSetLineWidth  (hdc,[[[[varbase  barilectr] ctrDlgGriglia] Gr_Spes6]     intValue]);
		CGContextSetRGBStrokeColor (hdc, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col6]  color] redComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col6]  color] greenComponent] 
									, [[[[[varbase  barilectr] ctrDlgGriglia] Gr_Col6]  color] blueComponent] , 1.0);
		const CGFloat para1[2] = {4 ,6};	              const CGFloat para2[4] = {6 ,6,1,6};   
		const CGFloat para3[6] = {6 ,6,1,6,1,6};   	  const CGFloat para4[2] = {1 ,4};   
		const CGFloat para5[10] = {6 ,6,1,6,1,6,1,6,1,6}; 
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_Trat6] indexOfSelectedItem] ) {
			case 0 : CGContextSetLineDash ( hdc , 0, nil, 0 );	 break;
			case 1 : CGContextSetLineDash ( hdc , 0, para1, 2 );	 break;
			case 2 : CGContextSetLineDash ( hdc , 0, para2, 4 );	 break;
			case 3 : CGContextSetLineDash ( hdc , 0, para3, 6 );	 break;
			case 4 : CGContextSetLineDash ( hdc , 0, para4, 2 );	 break;
			case 5 : CGContextSetLineDash ( hdc , 0, para5, 10 );	 break;
			default : break;
		}		
		double xstart = [LeInfo xorigineVista]; 	  double xend   = [LeInfo xorigineVista]+[self bounds].size.width*[LeInfo scalaVista];
		double ystart = [LeInfo yorigineVista]; 	  double yend   = [LeInfo yorigineVista]+[self bounds].size.height*[LeInfo scalaVista];
		double offerGr;
		switch ([[[[varbase  barilectr] ctrDlgGriglia] Gr_S6] selectedSegment] ) {
			case 0:	offerGr = 100;	    break;
			case 1:	offerGr = 1000; 	break;
			case 2:	offerGr = 10000;	break;
			default:offerGr=1000;		    break;
		}
		xstart = (double)((int)(xstart/offerGr)*offerGr);	ystart = (double)((int)(ystart/offerGr)*offerGr);
		xstart = xstart-12;		ystart = ystart-10;  // qui la modifica tra wgs84 e Gauss Boaga
		
		int numbarre = (int)((xend-xstart)/offerGr);
		if (numbarre>troppebarre) { xstart= xend; ystart=yend;	}

		
		while (xstart<xend) {
			double x1=(xstart-[LeInfo xorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, x1 , 0);		CGContextAddLineToPoint(hdc, x1 , [self bounds].size.height);
			CGContextStrokePath(hdc);		            xstart=xstart+offerGr;
		}
		while (ystart<yend) {
			double y1=(ystart-[LeInfo yorigineVista])/[LeInfo scalaVista];
			CGContextMoveToPoint   (hdc, 0, y1);		CGContextAddLineToPoint(hdc, [self bounds].size.width , y1);
			CGContextStrokePath(hdc);		            ystart=ystart+offerGr;
		}
	} // gr_b6 catastali
	
	
	
	
}

- (void) cursorUpdate                       : (NSEvent *)    theEvent                               {
//   [[NSCursor crosshairCursor] set];
}

- (void) updateTrackingAreas                                                                        {
    [self removeTrackingArea:trackingArea];
    [trackingArea release];
    trackingArea = [[NSTrackingArea alloc] initWithRect:self.frame
												options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow)
												  owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}

// comandi di vista

- (IBAction) Vista_Zoommeno                 : (id) sender                                           { [self updatescala:0];   }

- (IBAction) Vista_Zoompiu                  : (id) sender                                           { [self updatescala:1];   }

- (IBAction) Vista_ZoomFinestra             : (id) sender                                           { [self updatescala:2];   }

- (IBAction) Vista_ZoomCentro               : (id) sender                                           { [self updatescala:3];   }

- (IBAction) Vista_ZoomUltima               : (id) sender                                           { [self updatescala:4];   }

- (IBAction) Vista_ZoomTutto                : (id) sender                                           { [self updatescala:5];   }

- (IBAction) Vista_Pan                      : (id) sender                                           { [self updatescala:6];   }

- (void)     Zoom_Weel                      : (float) para :  (float) xcp  :  (float) ycp           {
	if (para==0) return;
	para = para/10;
	double oldxpos = (double)([LeInfo xorigineVista]+xcp*[LeInfo scalaVista]);
	double oldypos = (double)([LeInfo yorigineVista]+ycp*[LeInfo scalaVista]);
	
	float parametrozoom=1;
	if (para<0) parametrozoom=1+para; else parametrozoom=1/(1-para);

	
	[LeInfo set_scalaVista : [LeInfo scalaVista]*parametrozoom];	
	
	double newxpos = (double)([LeInfo xorigineVista]+xcp*[LeInfo scalaVista]);
	double newypos = (double)([LeInfo yorigineVista]+ycp*[LeInfo scalaVista]);
    double offdx = newxpos - oldxpos;
	double offdy = newypos - oldypos;

	
	[LeInfo set_origineVista:[LeInfo xorigineVista]-offdx  : [LeInfo yorigineVista]-offdy];
	[self Google_action :self];
	[self display]; 
	[self ricordasfondo ];
	
	varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista] ;
	varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista] ;

	
}

- (void)     updatescala                    : (int) modo                                            {
	CGRect sRect = [self  bounds];
    if ((modo==0) | (modo==1)) {
		double exdx=sRect.size.width *[LeInfo scalaVista];
		double exdy=sRect.size.height*[LeInfo scalaVista];
		double parametrozoom=1.41;
		if (modo==0) { [LeInfo set_scalaVista : [LeInfo scalaVista]*parametrozoom];	}
		if (modo==1) { [LeInfo set_scalaVista : [LeInfo scalaVista]/parametrozoom]; }
		double newdx=sRect.size.width *[LeInfo scalaVista];
		double newdy=sRect.size.height*[LeInfo scalaVista];
		double offdx=(newdx-exdx)/2;
		double offdy=(newdy-exdy)/2;
		[LeInfo set_origineVista:[LeInfo xorigineVista]-offdx  : [LeInfo yorigineVista]-offdy];
  	    [self Google_action :self];
		[self display]; 
		[self ricordasfondo ];
	}
	if (modo==2) {  incomandotrasparente       =   YES;  
		            LastComandotrasparente     =   [varbase comando]; 
		            LastFaseComandotrasparente =   [varbase fasecomando];
		            if ([varbase comando] ==  kStato_nulla) {		Lastcomando = kStato_zoomWindow;}
		            [varbase setcomando: kStato_zoomWindow];  
		            [varbase setfasecomando:  0]; 
		            [varbase AggiornaInterfaceComandoAzione];
	             }
	if (modo==3) { 
		incomandotrasparente       =   YES;  
		LastComandotrasparente     =   [varbase comando]; 
		LastFaseComandotrasparente =   [varbase fasecomando];
		if ([varbase comando] ==  kStato_nulla) {	Lastcomando = kStato_zoomC;}
		[varbase setcomando: kStato_zoomC];  
		[varbase setfasecomando :0]; 
		[varbase AggiornaInterfaceComandoAzione];
	}	
	
	if (modo==4) { 
		if (f_sprezoomw==0) return;
		[LeInfo set_origineVista:l_xprezoomw :l_yprezoomw ];
		[LeInfo set_scalaVista:f_sprezoomw ];
		
		[self display]; 
		[self ricordasfondo ];

		[self Google_action:self]; 
	} // Ultima vista da ricordare prima di zoom window
	if (modo==5) { 
		[self ZoomAll:self];
	}  
	if (modo==6) {  incomandotrasparente       =   YES;  
		            LastComandotrasparente     =   [varbase comando]; 
		            LastFaseComandotrasparente =   [varbase fasecomando ];	
		            if ([varbase comando] ==  kStato_nulla) {	Lastcomando = kStato_Pan;}
		      		[varbase setcomando: kStato_Pan];  
		            [varbase setfasecomando:0]; 
		[varbase AggiornaInterfaceComandoAzione];
	             }
	
	
	if (modo==7) {
		[self ZoomAllRaster:self ];  [self ricordasfondo ]; 
		[self Google_action:self]; 
	}  
	x1spazialevirt=varbase.d_xcoordLast; 
	y1spazialevirt=varbase.d_ycoordLast;
	varbase.x1virt = ((varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista]);
	varbase.y1virt = ((varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista]);
}

- (void)     ricordaposultimavista                                                                  {
	l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
}

- (IBAction) ZoomAllRaster                  : (id) sender                                           {
    [self ricordaposultimavista];
	[[varbase DisegnoRcorrente] updateInfoConLimiti];  	
	[LeInfo setZoomAllRaster];  
	[self Google_action:self]; 
	[self display];
}

- (IBAction) ZoomLocRaster                  : (id) sender                                           {
	l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
	[[varbase DisegnoRcorrente] updateInfoConLimitiSubraster];  	
	[LeInfo setZoomLocRaster];  
	[self Google_action:self]; 
	[self display];
}

- (IBAction) ZoomDisegno                    : (id) sender                                           {
	l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
			[[varbase DisegnoVcorrente] updateInfoConLimiti];  	
			[LeInfo setZoomAllVector];  
			[self Google_action:self]; 
			[self display];
}

- (IBAction) ZoomPianoCorrente              : (id) sender                                           {
	// ricordiamo per il zoom previous
    l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
	[[varbase DisegnoVcorrente] updateInfoConLimitiPianoCorrente];  	
	[LeInfo setZoomPianoVector];  
   	[self Google_action:self]; 
	[self display];
}

- (IBAction) ZoomAll                        : (id) sender                                           {
	double      Rx1,Ry1,Rx2,Ry2;
	bool apted=NO;
	DisegnoR *locdisras;
	for (int i=0; i<[varbase Listaraster].count; i++) {  
		locdisras= [[varbase Listaraster] objectAtIndex:i];
		if (![locdisras isvisibleRaster]) continue;
		[locdisras updateLimiti];
		if (!apted) {
			Rx1 = [locdisras limitex1];			Ry1 = [locdisras limitey1];
			Rx2 = [locdisras limitex2];			Ry2 = [locdisras limitey2];
			apted=YES;
		}
		else {
			if (Rx1 >[locdisras limitex1])      Rx1 =[locdisras limitex1];
			if (Ry1 >[locdisras limitey1])      Ry1 =[locdisras limitey1];
			if (Rx2 <[locdisras limitex2])      Rx2 =[locdisras limitex2];
			if (Ry2 <[locdisras limitey2])      Ry2 =[locdisras limitey2];

		}
	}
 
	
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i]; 		
		if (![locdisvet visibile]) continue;

		[locdisvet faiLimiti];
		if (!apted) {
			if ([locdisvet limx1]<[locdisvet limx2]) {
			 Rx1 = [locdisvet limx1];			Ry1 = [locdisvet limy1];
			 Rx2 = [locdisvet limx2];			Ry2 = [locdisvet limy2];
			 apted=YES;
			}
		} else {
			if ([locdisvet limx1]<[locdisvet limx2]) {
			if (Rx1 >[locdisvet limx1])      Rx1 =[locdisvet limx1];
			if (Ry1 >[locdisvet limy1])      Ry1 =[locdisvet limy1];
			if (Rx2 <[locdisvet limx2])      Rx2 =[locdisvet limx2];
			if (Ry2 <[locdisvet limy2])      Ry2 =[locdisvet limy2];
			}
		}
	}
	
	if (!apted) return;
	l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
	[LeInfo setLimitiTutto: Rx1 : Ry1 : Rx2 : Ry2];
	[LeInfo setZoomAll]; 
	
	[self Google_action:self]; 
	[self display];

}

- (void)     ZoomC                          : (double) newx : (double) newy                         {
	// ricordiamo per il zoom previous
	l_xprezoomw = [LeInfo xorigineVista];	l_yprezoomw = [LeInfo yorigineVista];	f_sprezoomw = [LeInfo scalaVista];
	[LeInfo setZoomC:newx:newy];  
	[self Google_action:self]; 
	[self display];
}

- (IBAction) MostraColoriperRaster          : (id) sender                                           {
	NSColorPanel *pancol = [NSColorPanel sharedColorPanel];
	[pancol  setContinuous:NO];
	[pancol orderFront:self];
	[pancol setTarget:self];
	[pancol setAction:@selector(colorrasterchanged:)];
}

- (void)     colorrasterchanged             : (NSColorPanel *) pancol                               {
	[[varbase DisegnoRcorrente] CambiaColore:[pancol color]];
	[self display];
}

// -----------------------   azioni vettoriale
 
- (IBAction) cancellaultimovt               : (id) sender                                           {
	if ([varbase fasecomando]<1) return;
	switch ([varbase comando]) {
		case kStato_Polilinea:		case kStato_Poligono:		case kStato_Regione:
		case kStato_Splinea:		case kStato_Spoligono:		case kStato_Sregione:
		case kStato_CatPoligono:
		[[varbase DisegnoVcorrente] cancellaultimovt]; 
			varbase.d_xcoordLast = [LeInfo xsnap];
			varbase.d_ycoordLast = [LeInfo ysnap];
			varbase.x1virt = ([LeInfo xsnap]-[LeInfo xorigineVista])/[LeInfo scalaVista];
			varbase.y1virt = ([LeInfo ysnap]-[LeInfo yorigineVista])/[LeInfo scalaVista];
		[self display]; [self ricordasfondo ];
	break;
	}
}

- (IBAction) comando_Righello               : (id) sender                                           {
	[self chiusuracomandoprecedente ];
	if ([varbase comando]==kStato_Righello) [varbase setcomando:0];   else	[varbase setcomando:kStato_Righello];    
	[varbase setfasecomando:0];  
	[varbase AggiornaInterfaceComandoAzione];
}

- (IBAction) setSfondoBianco                : (id) sender                                           {
	sfondobianco = !sfondobianco;
	[self display];
}

- (void)     attivaComando                  : (NSInteger) _comando                                  {
	if ([varbase comando]==_comando) [varbase setcomando:kStato_nulla]; else { [self chiusuracomandoprecedente ];	[varbase setcomando:_comando];  }
	[varbase setfasecomando:0];
	[varbase AggiornaInterfaceComandoAzione];
}
 



- ( void)    chiusuracomandoprecedente                                                              {
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	switch ([varbase comando]) {
		case kStato_Polilinea: [[varbase DisegnoVcorrente] finitaPolilinea:hdc:[varbase MUndor] ];		break;
		case kStato_Poligono: 
		case kStato_Regione:
			[[varbase DisegnoVcorrente] chiudipoligono:hdc:[varbase MUndor] ];
			break;
	}
	[self ricordasfondo ];
	[varbase setcomando:kStato_nulla];     [varbase setfasecomando:0];
}

// -----------------------------------------------------------------------------------------------  Mouse actions

- (void) mouseSnappe                                                                                {
	double pre_xcoordLast = varbase.d_xcoordLast;
	double pre_ycoordLast = varbase.d_ycoordLast;

		// lo snap	
	DisegnoV  *locdisvet;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdisvet= [[varbase ListaVector] objectAtIndex:i];		if ( ![locdisvet visibile] ) continue;
		bool giasnappato=NO;
		if ([comandiToolBar b_snapfine]) {
			if ([locdisvet snapFine: varbase.d_xcoordLast : varbase.d_ycoordLast ]) 
		    { varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];  
				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
				giasnappato = YES;
				NSBeep();
				break;  };    
		}    	

			// snap fine se catpoligono ed al primo inserimento
		if (([varbase comando]== kStato_CatPoligono) & 	([varbase fasecomando]==0))
			if ([locdisvet snapFine: varbase.d_xcoordLast : varbase.d_ycoordLast ]) 
		    { varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];  
				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
				giasnappato = YES;
				NSBeep();
				break;  };    
		
			
			
		if (([comandiToolBar b_snapvicino]) & (!giasnappato)) {
			if ([locdisvet snapVicino: varbase.d_xcoordLast : varbase.d_ycoordLast ]) 
			{ varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap]; 
				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
				giasnappato = YES;
				NSBeep();
				
				break;  };  
		} 
		
		
		
	}
	
	if ([comandiToolBar b_snapgriglia])  {
		bool snappata =NO;
		if ([varbase inGriglia]) {
			snappata = [self SnappaGriglia :pre_xcoordLast : pre_ycoordLast];
		}
		if (snappata)  NSBeep();
	} 
	
	
	if (([comandiToolBar b_snaporto]) & ([varbase comando]!=kStato_zoomWindow)) {
		if ([varbase fasecomando]>0)  {
			double  llx=fabs(pre_xcoordLast-varbase.d_xcoordLast);	double  lly=fabs(pre_ycoordLast-varbase.d_ycoordLast);
			if (llx>lly) {	varbase.d_ycoordLast=pre_ycoordLast;	} else { varbase.d_xcoordLast=pre_xcoordLast;	} 
			[LeInfo setxysnap : pre_xcoordLast : pre_ycoordLast];
			varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
			varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
		}
	}
	
 	if ([comandiToolBar b_snaportoseg]) {
			// solo nel caso di plinea e company
		if (([varbase comando] == kStato_Polilinea ) | ([varbase comando] == kStato_Poligono ) | ([varbase comando] == kStato_Regione ) ) {
			if ([varbase fasecomando]>1)  {
				[[varbase DisegnoVcorrente] ortosegmenta: varbase.d_xcoordLast : varbase.d_ycoordLast];
  			    varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap];
				varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
				varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
			}
	    }
	}
	
}

- (void) mouseComandiRaster                                                                         {
	NSString *STR_loc = @"";
	double xcordsh ;
	double ycordsh ;

	switch ([varbase comando]) {
		case kStato_spostaRaster_uno: 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1];
					[[varbase DisegnoRcorrente] impostaUndoCorrenteOrigine:[varbase MUndor]];
					break;
				case 1 : [varbase comando00];	[self display]; break;			
			}
			break;
		case kStato_spostaRaster_tutti: 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; 
					[[varbase DisegnoRcorrente] impostaUndoTuttiOrigine:[varbase MUndor]];
					break;
				case 1 : [varbase comando00];	[self display]; break;			
			}
		break;
			
			
		case kStato_spostaRaster2pt_uno   :
		case kStato_spostaRaster2pt_tutti :
		case kStato_rotoScal2PtCentrato   :
			 xcordsh = varbase.d_xcoordLast;
			 ycordsh = varbase.d_ycoordLast;
			[LeInfo traformacord : &xcordsh : &ycordsh : varbase.TipoProiezione];

			switch (varbase.TipoProiezione) {
				case 0 : case 2 : case 4: case 5 :			                                  
					STR_loc = @"";	STR_loc = [STR_loc stringByAppendingFormat:	 @"%1.2f",xcordsh];	
					[[[varbase interface] newXdlgSpostaRaster] setStringValue:STR_loc];
					STR_loc = @"";	STR_loc = [STR_loc stringByAppendingFormat:	 @"%1.2f",ycordsh];	
					[[[varbase interface] newYdlgSpostaRaster] setStringValue:STR_loc];
					
					break; // UTM 
					
				case 1 : case 3 : 	 
					[[[varbase interface] newXdlgSpRasterGra] setIntValue:[LeInfo GradidaCord:xcordsh]];
					[[[varbase interface] newXdlgSpRasterMin] setIntValue:[LeInfo MinutidaCord:xcordsh]];
					[[[varbase interface] newXdlgSpRasterPri] setStringValue: [LeInfo SecondiStrdaCord:xcordsh]];
					
					[[[varbase interface] newYdlgSpRasterGra] setIntValue:[LeInfo GradidaCord:ycordsh]];
					[[[varbase interface] newYdlgSpRasterMin] setIntValue:[LeInfo MinutidaCord:ycordsh]];
					[[[varbase interface] newYdlgSpRasterPri] setStringValue: [LeInfo SecondiStrdaCord:ycordsh]];
			
					break;                                                // globo 
				default: break;
			}

				// qui le coordinate in gradi
			[[varbase interface] cambiataproiezione: varbase.TipoProiezione];
			[[[varbase bariledlg] dlgNuovaCoord] setTitle:@"Nuova Posizione Immagine"];

			[[[varbase bariledlg] dlgNuovaCoord] orderFront:self];
		    break;
		case kStato_scalarighello:	
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; 
					varbase.d_lastdist = sqrt( (varbase.d_x2coord-varbase.d_x1coord)*(varbase.d_x2coord-varbase.d_x1coord) + 
											  (varbase.d_y2coord-varbase.d_y1coord)*(varbase.d_y2coord-varbase.d_y1coord)    );
					STR_loc = [STR_loc stringByAppendingFormat:	 @"%1.2f",varbase.d_lastdist];
					[oldDistdlgRighello setStringValue:STR_loc];
					[[varbase dlrighello] orderFront:self];
					break;
			}
		    break;
		case kStato_rotoscalaraster :   // ciclare poi su tutti i raster del disegnoR
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 2 : varbase.d_x3coord = varbase.d_xcoordLast;	varbase.d_y3coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 3 : varbase.d_x4coord = varbase.d_xcoordLast;	varbase.d_y4coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; 
					[[varbase DisegnoRcorrente] impostaUndoCorrenteTutto: [varbase MUndor]];
					[[varbase DisegnoRcorrente] rotoscala:varbase.d_x1coord : varbase.d_y1coord 
														 :varbase.d_x2coord : varbase.d_y2coord 
														 :varbase.d_x3coord : varbase.d_y3coord 
														 :varbase.d_x4coord : varbase.d_y4coord
														 : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ]]; 
					[varbase     aggiornaslideCalRaster ];
					[varbase comando00];	[self display]; 	
					break;
			}
			break;
		case kStato_calibra8click :
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 2 : varbase.d_x3coord = varbase.d_xcoordLast;	varbase.d_y3coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 3 : varbase.d_x4coord = varbase.d_xcoordLast;	varbase.d_y4coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 4 : d_x5coord = varbase.d_xcoordLast;	d_y5coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 5 : d_x6coord = varbase.d_xcoordLast;	d_y6coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 6 : d_x7coord = varbase.d_xcoordLast;	d_y7coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 7 : d_x8coord = varbase.d_xcoordLast;	d_y8coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			}		
			if ([varbase fasecomando]==8)	 {  
				[[[varbase interface] LevelIndicatore] setIntValue: 1];
				[[[varbase interface] LevelIndicatore] setHidden:NO];
				[[[varbase interface] LevelIndicatore] display];
					//				[[[varbase interface] LevelIndicatore]
					//				[[[varbase interface] LevelIndicatore] setHidden:NO];
				[[varbase DisegnoRcorrente]  Calibra8pt : varbase.d_x1coord : varbase.d_y1coord 
														: varbase.d_x3coord : varbase.d_y3coord : d_x5coord : d_y5coord : d_x7coord : d_y7coord 
														: varbase.d_x2coord : varbase.d_y2coord 
														: varbase.d_x4coord : varbase.d_y4coord : d_x6coord : d_y6coord : d_x8coord : d_y8coord 
														: NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] : [[varbase interface] LevelIndicatore] ];
				[varbase comando00];
				[varbase     aggiornaslideCalRaster ];
			}
			break;
			
		case kStato_Calibraraster :
			switch ([varbase fasecomando]) {
				case 1 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase dlcalRas] orderFront:self]; break;
				case 2 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase dlcalRas] orderFront:self]; break;
				case 3 : varbase.d_x3coord = varbase.d_xcoordLast;	varbase.d_y3coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase dlcalRas] orderFront:self]; break;
				case 4 : varbase.d_x4coord = varbase.d_xcoordLast;	varbase.d_y4coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase dlcalRas] orderFront:self]; break;
			}		
			break;
			
		case kStato_CalibrarasterFix :
			switch ([varbase fasecomando]) {			
				case 1 :  varbase.d_x1coord = varbase.d_xcoordLast;	 varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase  dlcalRasF] orderFront:self]; break;
				case 2 :  varbase.d_x2coord = varbase.d_xcoordLast;	 varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomando:0];	[[varbase  dlcalRasF] orderFront:self]; break;
			}
	        break;	
			
		case kStato_FixCentroRot :
			varbase.xcentrorot=varbase.d_xcoordLast; 	
			varbase.ycentrorot=varbase.d_ycoordLast;
			[varbase     aggiornaslideCalRaster ];
			[varbase comando00];
			break;
	}			
}

- (void) mouseComandiDisegno                : (CGContextRef) hdc   : (NSEvent *) theEvent           {
	double hht,hhang ;
	DisegnoV  *locdisvet;
	bool didded=NO;

	switch ([varbase comando]) {
				// vettoriali
		case kStato_Punto:	  
			[[varbase DisegnoVcorrente] faipunto   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase MUndor]];      [varbase comando00];
			break;
		case kStato_Polilinea:	  	[[varbase DisegnoVcorrente] faiplinea  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando] : [varbase MUndor]]; 
			[varbase setfasecomandopiu1]; 				[self ricordasfondo ]; 	   break;                                                                
		case kStato_Poligono:	    [[varbase DisegnoVcorrente] faipoligono:hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]]; 
			[varbase setfasecomandopiu1];				[self ricordasfondo ];     break;
		case kStato_Regione:	    [[varbase DisegnoVcorrente] fairegione :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando] : FaseRegione]; 
			[varbase setfasecomandopiu1];	 FaseRegione=0;	[self ricordasfondo ]; break;

/////
			
		case kStato_Simbolo:   
			[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ]; 
			[varbase comando00];		break;
		case kStato_SimboloFisso:   
			[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :YES: [varbase ListaDefSimboli] : [varbase MUndor] ]; 
			[varbase comando00];		break;
		case kStato_SimboloRot:  
			switch ([varbase fasecomando]) {
				case 0 :[[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ]; 
						 varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast;
						[varbase setfasecomandopiu1]; 	
					break;
			    case 1 : 
					hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast ); 
					[[varbase DisegnoVcorrente] ruotasimbolo  :hdc : hhang];
					[varbase comando00]; 	[self display]; break;
			}
			break;

		case kStato_SimboloRotSca:   
			switch ([varbase fasecomando]) {
				case 0 : [[varbase DisegnoVcorrente] faisimbolo   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase indicecurrentsimbolo] :NO: [varbase ListaDefSimboli] : [varbase MUndor] ]; 
					 varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast;
					 [varbase setfasecomandopiu1]; 	break;
			    case 1 : 
					hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast ); 
					[[varbase DisegnoVcorrente] ruotasimbolo  :hdc : hhang];
					[varbase setfasecomandopiu1];  break;
				case 2 : 
					hht = scala2verticischermo   (varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_xcoordLast , varbase.d_ycoordLast,[LeInfo dimxVista]*[LeInfo scalaVista] );
					[[varbase DisegnoVcorrente] scalasimbolo:hdc : hht];
                    [varbase comando00]; 
					[self display];           break;
			}
			break;
			
/////

			
			
		case kStato_Splinea:	    [[varbase DisegnoVcorrente] faisplinea  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]]; [varbase setfasecomandopiu1]; 	
			if ([varbase fasecomando]==1) { [[varbase DisegnoVcorrente] faisplinea  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]]; [varbase setfasecomandopiu1]; 	}
			
			varbase.x1virt = [LeInfo i_xlastspline];			varbase.y1virt = [LeInfo i_ylastspline];
			[self ricordasfondo ]; 
			break;                                  
		case kStato_Spoligono:	    [[varbase DisegnoVcorrente] faispoligono  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]]; [varbase setfasecomandopiu1]; 
			if ([varbase fasecomando]==1) { [[varbase DisegnoVcorrente] faispoligono:hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]]; [varbase setfasecomandopiu1]; 	}
			varbase.x1virt = [LeInfo i_xlastspline];			varbase.y1virt = [LeInfo i_ylastspline];
			[self ricordasfondo ]; 
			break;      
		case kStato_Sregione :	  	
			if 	(FaseRegione>0) {
				[[varbase DisegnoVcorrente] faisregione   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast :  [varbase fasecomando]: FaseRegione];
				[varbase setfasecomandopiu1];
				varbase.x1virt = [LeInfo i_xlastspline];			varbase.y1virt = [LeInfo i_ylastspline];
				varbase.x2virt = [LeInfo i_xlastspline];			varbase.y2virt = [LeInfo i_ylastspline];
				[[varbase DisegnoVcorrente] faisregione   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast :
				                            [varbase fasecomando]: 0]; [varbase setfasecomandopiu1]; 	
				FaseRegione=0;
			} else {
				[[varbase DisegnoVcorrente] faisregione   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]: FaseRegione]; [varbase setfasecomandopiu1];
				if ([varbase fasecomando]==1) {   [[varbase DisegnoVcorrente] faisregione   :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]: FaseRegione]; [varbase setfasecomandopiu1]; 	}
			}
			varbase.x1virt = [LeInfo i_xlastspline];			varbase.y1virt = [LeInfo i_ylastspline];
			[self ricordasfondo ]; 
			break;     
		case kStato_Cerchio:	    
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; 	break;
			    case 1 : [[varbase DisegnoVcorrente] faicerchio  :hdc : varbase.d_x1coord : varbase.d_y1coord: varbase.d_xcoordLast : varbase.d_ycoordLast :[varbase MUndor]]; 
					[varbase comando00];  break;
			}
			break;			
			
			
			
			
		case kStato_Testo:	    
			hht = [[varbase FieldAltezzaTesto] doubleValue];
			if (hht<=0) {hht = 10; }
 			[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : hht : 0 :[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]]; 
			[varbase comando00]; 
			[self display];
			break;
		case kStato_TestoRot:	
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : 
					hht = [[varbase FieldAltezzaTesto] doubleValue];
					double ttdx,ttdy;
					ttdx = varbase.d_xcoordLast-varbase.d_x1coord;	ttdy = varbase.d_ycoordLast-varbase.d_y1coord; 
					if ((ttdx==0)  & (ttdy==0)) return;
					if (ttdx==0) { hhang = M_PI/2;   if (ttdy <0) hhang += M_PI;  } 
					else 	{ hhang = atan( ttdy / ttdx );  if (ttdx <0) hhang = M_PI+hhang; if (hhang<0) hhang += 2*M_PI;	}
					[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_x1coord : varbase.d_y1coord : hht : hhang:[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]]; 
					[varbase comando00]; 
					[self display];
					break;
					
			}
			break;
		case kStato_TestoRotSca:	    
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 2 : 
					hht = hypot( (varbase.d_xcoordLast-varbase.d_x1coord), (varbase.d_ycoordLast-varbase.d_y1coord) );
					
					double ttdx,ttdy;
					ttdx = varbase.d_x2coord-varbase.d_x1coord;	ttdy = varbase.d_y2coord-varbase.d_y1coord; 
					if ((ttdx==0)  & (ttdy==0)) return;
					if (ttdx==0) { hhang = M_PI/2;   if (ttdy <0) hhang += M_PI;  } 
					else 	{ hhang = atan( ttdy / ttdx );  if (ttdx <0) hhang = M_PI+hhang; if (hhang<0) hhang += 2*M_PI;	}
					
					[[varbase DisegnoVcorrente] faitesto  :hdc : varbase.d_x1coord : varbase.d_y1coord : hht : hhang:[[varbase FieldTxtTesto] stringValue]: [varbase MUndor]]; 
					[varbase comando00]; 
					[self display];
					break;
			}
			break;			
			
		case kStato_Rettangolo:	    
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : [[varbase DisegnoVcorrente] fairettangolo  :hdc : varbase.d_x1coord : varbase.d_y1coord : varbase.d_xcoordLast :varbase.d_ycoordLast:[varbase MUndor]]; 
					[varbase comando00];  break;
			}
			break;
			
		case kStato_CatPoligono:	
			if (  [theEvent modifierFlags ]  & NSControlKeyMask) {
				[[varbase DisegnoVcorrente] faiplinea  :hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]: [varbase MUndor]]; 
				[varbase setfasecomandopiu1]; 			[self ricordasfondo ];  NSBeep();
			}
			else {
			 for (int i=0; i<[varbase ListaVector].count; i++) {  
				locdisvet= [[varbase ListaVector] objectAtIndex:i];
				didded= ([[varbase DisegnoVcorrente] faiCatpoligono:hdc : varbase.d_xcoordLast : varbase.d_ycoordLast : [varbase fasecomando]:locdisvet]) ;
				if (didded)	break;
			 }
				// riportare x1virt e y1virt a ultimo vertice polyincostruzione.
			 if (didded) {
				varbase.d_xcoordLast=[LeInfo xsnap];  varbase.d_ycoordLast=[LeInfo ysnap]; 
			    varbase.x1virt = (varbase.d_xcoordLast-[LeInfo xorigineVista])/[LeInfo scalaVista];
			    varbase.y1virt = (varbase.d_ycoordLast-[LeInfo yorigineVista])/[LeInfo scalaVista];
			    [varbase setfasecomandopiu1];	
			    [self ricordasfondo ]; 
			 }
			}
			
		 break;

		case kStato_RettangoloStampa:	
		case kStato_RettangoloDoppioStampa:
			switch ([varbase fasecomando]) {
			 case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			 case 1 :
					[progdialogs TogliRettangoloStampa:self]; 
					double dxs= fabs(varbase.d_xcoordLast-varbase.d_x1coord);
					double dys= fabs(varbase.d_ycoordLast-varbase.d_y1coord);
					if ((dxs/dys)>(783.0/559.0)) { dys = (559.0/783.0)*dxs;
						if (varbase.d_ycoordLast>varbase.d_y1coord) varbase.d_ycoordLast=varbase.d_y1coord+dys; 
															 else   varbase.d_ycoordLast=varbase.d_y1coord-dys;	} 
					                        else { dxs = (783.0/559.0)*dys;
						if (varbase.d_xcoordLast>varbase.d_x1coord) varbase.d_xcoordLast=varbase.d_x1coord+dxs; 
						                                     else   varbase.d_xcoordLast=varbase.d_x1coord-dxs;	}

					[varbase iniziarettangolostampa];
					 
					[[varbase rettangoloStampa] addvertexUp:varbase.d_x1coord    : varbase.d_y1coord]; 
					[[varbase rettangoloStampa] addvertex  :varbase.d_xcoordLast : varbase.d_y1coord    :0];
					[[varbase rettangoloStampa] addvertex  :varbase.d_xcoordLast : varbase.d_ycoordLast :0];
					[[varbase rettangoloStampa] addvertex  :varbase.d_x1coord    : varbase.d_ycoordLast :0];
					[[varbase rettangoloStampa] addvertex  :varbase.d_x1coord    : varbase.d_y1coord    :0];
					if ([varbase comando]==kStato_RettangoloStampa) rettangoloStampaSingolo=YES; else rettangoloStampaSingolo=NO;
					[varbase comando00]; 
					[self display];
					break;
			}
			
		break;

	}			
}

- (void) mouseComandiEditDisegno                                                                    {
		// le var di Tarquinia
	DisegnoV  *locdisvet;
		//	DisegnoV  *DisVectCorrente;
	bool trovato =NO;
	NSString * nom;
	NSString * nomtot;
	DisegnoV  *newvectordis;
		// le var di Tarquinia

	
	switch ([varbase comando]) {
				// edit vettoriale
		case kStato_SpostaDisegno:	 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : [[varbase DisegnoVcorrente] SpostaDisegnodxdy:(varbase.d_xcoordLast-varbase.d_x1coord):(varbase.d_ycoordLast-varbase.d_y1coord) ];	
					[varbase comando00]; [self display];  break;
			}
			break;
			
			
		case kStato_FixVCentroRot :
			varbase.xcentrorotV=varbase.d_xcoordLast; 	
			varbase.ycentrorotV=varbase.d_ycoordLast;
			[varbase comando00];
			break;
			
			
			
		case kStato_Righello:	    
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : [varbase comando00];  break;
			}
			break;
			
		case kStato_TarquiniaFogliopt :
			for (int i=0; i<[varbase ListaVector].count; i++) {  
			   locdisvet= [[varbase ListaVector] objectAtIndex:i];
			   if ([[locdisvet nomedisegno] isEqualToString: [varbase nomequadronione]]) {
			   trovato =YES; break;
			   }
			 }
			if (trovato) {
				nom = [locdisvet nomepoligonopt :varbase.d_xcoordLast : varbase.d_ycoordLast ];
				 if (nom==nil) break;
				 nomtot = [[varbase Dir_Catastali] stringByAppendingString: [nom stringByAppendingFormat:@".CXF"]];
				 if ([varbase presenteDisegno   : nomtot ]>=0) {
					 [varbase DoNomiVectorPop];
				 [varbase setindiceVectorCorrente   : [varbase presenteDisegno   : nomtot ]];
				 [varbase CambioVector: [varbase indiceVectorCorrente] ];	 [self display];
					 break;					 
				 }
				newvectordis = [DisegnoV  alloc];    
				 [newvectordis InitDisegno:LeInfo];
				 [[varbase ListaVector] addObject:newvectordis]; 
				 [newvectordis setpianocorrente:0];
				[varbase DoNomiVectorPop];	
				[varbase setindiceVectorCorrente   : [varbase ListaVector].count-1];
				[varbase CambioSubVector       : 0];
				[newvectordis apriDisegnoCxf :   nomtot : [varbase ListaDefSimboli]  ];
				 [newvectordis faiLimiti];

				[varbase DoNomiVectorPop];	
				 [self display];
			 }
                //			 [varbase comando00];
			break;
	}			
}

- (void) mouseComandiSelezionanti           : (CGContextRef) hdc                                    {
	switch ([varbase comando]) {
		case kStato_Seleziona    :      [comandiPro seleziona_conPt ];	      	[self	DisegnaSelezionati  ];     break;
		case kStato_Match        : 	    [comandiPro Match_conPt     ];			                           break;
		case kStato_Info         :		[comandiPro selezInfo_conPt ];	      	[self	DisegnaInformati   ]; [progdialogs ApriDlgInfoVet];	   break;
		case kStato_InfoSup      :		[comandiPro selezInfo_conPtInterno ];	[self	DisegnaInformati   ]; [progdialogs ApriDlgInfoVet];	   break;
		case kStato_InfoLeg      :		[comandiPro selezInfo_conPtInterno ];	[self	DisegnaInformati   ]; [progdialogs ApriDlgInfoArea];    break;
		
		case kStato_InfoIntersezione2Poligoni:		[comandiPro selezInfo_conPtInterno ];	
			
			if ([[varbase ListaInformati] count]==2 ) {
				[[varbase ListaSelezionati] removeAllObjects];
				[[varbase ListaSelezionati] addObjectsFromArray:[varbase ListaInformati]];
				[comandiPro Intersezione2Poligoni ];
				[[varbase ListaInformati] removeAllObjects];
				[self display];

			}
			else {
				[[varbase ListaInformati] removeAllObjects];
					// allert		
			}
			break;

		
		
		case kStato_InfoEdificio :		[comandiPro selezEdif_conPtInterno :hdc];	
			[self display];		[self  DisegnaListaSelezEdifici];	
			[varbase MostraEdifInfo];
			if ([[varbase ListaSelezEdifici] count]>0) {[[[varbase barilectr]  ctrEdi] preimpostaBackinLista ];	}
			break;
		case kStato_InfoTerreno  :		[comandiPro selezTerra_conPtInterno:hdc ];	
			[self display];		[self  DisegnaListaSelezTerreni     ];		[varbase MostraTerraInfo];
			if ([[varbase ListaSelezTerreni] count]>0) {[[[varbase barilectr]  ctrTer ] preimpostaBackinLista ];	}

			break;
		case kStato_InfoTaxTerreno:
			[comandiPro selezTerra_conPtInterno:hdc ];	[self display];	[self  DisegnaListaSelezTerreni     ];
			
			if ([[varbase ListaSelezTerreni] count]>0) {
			    [comandiPro selezInfo_conPtInterno ];
				
				[progdialogs ImpostaAppuntiTerrenoPRG];
			
				[progdialogs ApriDlgAppunti:self];
			}
			break;
			
		case kStato_SpostaSelected:	 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [comandiPro SpostaSelezionati];	
					[varbase comando00]; [self display];  break;
			}
			break;
		case kStato_CopiaSelected:	 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [comandiPro CopiaSelezionati];	
					[varbase comando00]; [self display];  break;
			}
			break;
		case kStato_RuotaSelected:	 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [comandiPro RuotaSelezionati];	
					[varbase comando00]; [self display];  break;
			}
			break;
		case kStato_ScalaSelected:	 
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
			    case 1 : varbase.d_x2coord = varbase.d_xcoordLast;	varbase.d_y2coord = varbase.d_ycoordLast; [comandiPro ScalaSelezionati];	
					[varbase comando00]; [self display]; break;
			}
			break;
	}			
}

- (void) mouseComandiVertici                                                                        {
	switch ([varbase comando]) {
		case kStato_SpostaVertice:	 
			switch ([varbase fasecomando]) {
				case 0 : if ([comandiPro selezionaVtconPt ])  [varbase setfasecomandopiu1]; break;
			    case 1 : [comandiPro SpostaVerticeSelezionato : varbase.d_xcoordLast : varbase.d_ycoordLast];  
					[varbase setfasecomando:0]; [self display];  break; // Comando=0;
			}
			break;
		case kStato_EditSpVt:	 
			switch ([varbase fasecomando]) {
				case 0 : if ([comandiPro selezionaVtspconPt ])  [varbase setfasecomandopiu1]; break;
			    case 1 : [comandiPro EditVerticeSelezionato : varbase.d_xcoordLast : varbase.d_ycoordLast];   [varbase setfasecomando:0]; [self display];  break; // Comando=0;
			}
			break;
		case kStato_InserisciVertice:	 
			switch ([varbase fasecomando]) {
				case 0 : if ([comandiPro selezionaVtconPt ])  [varbase setfasecomandopiu1]; break;
			    case 1 : [comandiPro InserisciVerticeSelezionato : varbase.d_xcoordLast : varbase.d_ycoordLast]; 
					[varbase setfasecomando:0]; [self display];  break; // Comando=0;
			}
			break;
		case kStato_CancellaVertice:	 
			if ([comandiPro selezionaVtconPt ]) [comandiPro CancellaVerticeSelezionato ];   [self display]; 
			break;
	}			
}

- (void) mouseComandiViste                                                                          {
	int dxzo, dyzo;

	switch ([varbase comando]) {
		case kStato_zoomC:	 
			[self ZoomC : varbase.d_xcoordLast : varbase.d_ycoordLast ];
			[varbase comando00];
			break;
			
		case kStato_Pan :
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : 							[varbase comando00];	break;
			}
			break;
        case kStato_zoomWindow:  
			switch ([varbase fasecomando]) {
				case 0 : varbase.d_x1coord = varbase.d_xcoordLast;	varbase.d_y1coord = varbase.d_ycoordLast; [varbase setfasecomandopiu1]; break;
				case 1 : 
					varbase.d_x2coord = varbase.d_xcoordLast;
					varbase.d_y2coord = varbase.d_ycoordLast;
					dxzo = (int) abs(d_xclickdown-varbase.d_x2coord);
					dyzo = (int) abs(d_yclickdown-varbase.d_y2coord);
					if ((dxzo<10) | (dyzo<10)) {	[self display]; 	return;}
					
					[varbase comando00];
					l_xprezoomw = [LeInfo xorigineVista];
					l_yprezoomw = [LeInfo yorigineVista];
					f_sprezoomw = [LeInfo scalaVista];
					long xmin; long xmax;
					long ymin; long ymax;
					if (varbase.d_x1coord>varbase.d_x2coord) {xmin=varbase.d_x2coord; xmax=varbase.d_x1coord;}
					else {xmin=varbase.d_x1coord; xmax=varbase.d_x2coord;};
					if (varbase.d_y1coord>varbase.d_y2coord) {ymin=varbase.d_y2coord; ymax=varbase.d_y1coord;} 
					else {ymin=varbase.d_y1coord; ymax=varbase.d_y2coord;};
					[LeInfo set_origineVista:xmin :ymin ];
					long dzx; long dzy; double f_zxscal; double f_zyscal;
					dzx=xmax-xmin;		dzy=ymax-ymin;
					NSRect _rect = [self frame];
					f_zxscal=fabs(dzx/_rect.size.width);
					f_zyscal=fabs(dzy/_rect.size.height);
					if (f_zxscal<f_zyscal) [LeInfo set_scalaVista:f_zyscal ]; else  [LeInfo set_scalaVista:f_zxscal ];
					[self Google_action:self]; 
					[self display]; 
					[self ricordasfondo ];
					
					break;
			}
		    break;
	}			
}



- (void) mouseDown                          : (NSEvent *) theEvent                                  {

 
	
	 if (!incomandotrasparente) Lastcomando=[varbase comando];
	 _inrectPan = [self visibleRect];
	[self ricordasfondo ];
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClipToRect ( hdc, [self frame]  );
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	d_xclickdown=(double)mPoint.x;  	d_yclickdown=(double)mPoint.y;
	varbase.x2virt=mPoint.x; 	        varbase.y2virt=mPoint.y;
	if ((([varbase comando]== kStato_Testo) & ([varbase fasecomando]==1)) | ([varbase comando]== kStato_CatPoligono) ) {	}
	  else {  varbase.x1virt=varbase.x2virt; varbase.y1virt=varbase.y2virt;	}
	varbase.d_xcoordLast = [LeInfo xorigineVista]+d_xclickdown*[LeInfo scalaVista];
	varbase.d_ycoordLast = [LeInfo yorigineVista]+d_yclickdown*[LeInfo scalaVista];
	[LeInfo update_offsetmirino ];
	[self mouseSnappe];
	[self mouseComandiRaster];
	[self mouseComandiDisegno : hdc :theEvent];
	[self mouseComandiEditDisegno];   // + righello
	[self mouseComandiViste];
	[self mouseComandiVertici];
    [self mouseComandiSelezionanti : hdc];
	[varbase AggiornaInterfaceComandoAzione];

		
}    

- (void) mouseMoved                         : (NSEvent *) theEvent                                  {
	double xmouse, ymouse;
    NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	double xcordsh = (double)([LeInfo xorigineVista]+(double)mPoint.x*[LeInfo scalaVista]);
	double ycordsh = (double)([LeInfo yorigineVista]+(double)mPoint.y*[LeInfo scalaVista]);
	double dx = mPoint.x-d_xclickdown;
	double dy = mPoint.y-d_yclickdown;
	
    NSString    *STR_loc = @"";	

	
	
	[LeInfo traformacord : &xcordsh : &ycordsh : varbase.TipoProiezione];
	
	switch (varbase.TipoProiezione) {
		case 0:
				if(	[[varbase ESFuso]  isSelectedForSegment:0] ) {
					NSInteger fusind=0;
					while (xcordsh>1010000) { xcordsh = xcordsh-1010000;  fusind++;	}
                    if (fusind==0)		[[varbase ESFuso] setLabel:         [LeInfo fusoStr] forSegment:0];	
				}  else { [[varbase ESFuso] setLabel:@"0°" forSegment:0];	}

			[ [varbase ESxcord] setLabel:[LeInfo invirgcoord:xcordsh] forSegment:0];
			[ [varbase ESycord] setLabel:[LeInfo invirgcoord:ycordsh] forSegment:0];
			break;
		case 1:
		case 3:
			[ [varbase ESxcord] setLabel:[LeInfo ingradi:xcordsh] forSegment:0];
			[ [varbase ESycord] setLabel:[LeInfo ingradi:ycordsh] forSegment:0];
			break;
		case 2 : case 4: case 5:  //UTM 50 // Cassini-Soldner per il Catasto
			[ [varbase ESxcord] setLabel:[LeInfo invirgcoord:xcordsh] forSegment:0];
			[ [varbase ESycord] setLabel:[LeInfo invirgcoord:ycordsh] forSegment:0];
			break;
			
		default:		break;
	}
	
	
	
	double xcord = (double)([LeInfo xorigineVista]+(double)mPoint.x*[LeInfo scalaVista]);
	double ycord = (double)([LeInfo yorigineVista]+(double)mPoint.y*[LeInfo scalaVista]);

	
	xmouse=mPoint.x; ymouse=mPoint.y;
	if ([comandiToolBar b_snaporto]) {
		if ([varbase fasecomando]>0)  {
			int  llx=abs(xmouse-varbase.x1virt);	int  lly=abs(ymouse-varbase.y1virt);
			if (llx>lly) {	ymouse=varbase.y1virt;	} else { xmouse=varbase.x1virt;	} 
		}
	}
	if ([comandiToolBar b_snaportoseg]) {
	 if (([varbase comando] == kStato_Polilinea ) | ([varbase comando] == kStato_Poligono ) | ([varbase comando] == kStato_Regione ) ) {
	  if ([varbase fasecomando]>1)  {
		  double locxcord = (double)([LeInfo xorigineVista]+(double)mPoint.x*[LeInfo scalaVista]);
		  double locycord = (double)([LeInfo yorigineVista]+(double)mPoint.y*[LeInfo scalaVista]);


 	  [ [varbase DisegnoVcorrente] ortosegmenta: locxcord : locycord];
	  xmouse = ([LeInfo xsnap] - [LeInfo xorigineVista])/[LeInfo scalaVista];
	  ymouse = ([LeInfo ysnap] - [LeInfo yorigineVista])/[LeInfo scalaVista];

	  }
	 }
	}
	
	 switch ([varbase comando]) {

		case kStato_nulla:      	    break;  
		case kStato_Pan  : if ([varbase fasecomando]>0) 
		    {
				
				[LeInfo setZoomC: (  [LeInfo xorigineVista]+ (([LeInfo dimxVista]/2)-dx) *[LeInfo scalaVista]  ) 
								: (  [LeInfo yorigineVista]+ (([LeInfo dimyVista]/2)-dy) *[LeInfo scalaVista]  )];  
      			d_xclickdown=(double)mPoint.x;	d_yclickdown=(double)mPoint.y;
				[self Google_action:self]; 

				[self display]; 	
				break;  
		    }
			break;
		case kStato_zoomWindow:
			if ([varbase fasecomando]>0)  {
				[self DisegnaquadroVirtuale:d_xclickdown : d_yclickdown : mPoint.x : mPoint.y];
//				[self AggiornaLabelComandoAzione];
			}
			break;
			
		case kStato_scalarighello:	if ([varbase fasecomando]==1)
			[self DisegnaVirtuale:d_xclickdown : d_yclickdown : xmouse : ymouse];
			break;
		case kStato_rotoscalaraster: if (([varbase fasecomando]==1) | ([varbase fasecomando]==3)) 
			[self DisegnaVirtuale:d_xclickdown : d_yclickdown : xmouse : ymouse];
			break;
		case kStato_Polilinea: 
		case kStato_Poligono: 
		case kStato_Regione :  
		case kStato_CatPoligono: 

			 if ([varbase fasecomando]>0)  [self DisegnaVirtuale        :varbase.x1virt : varbase.y1virt : xmouse : ymouse];  break;
		case kStato_Splinea : 
		case kStato_Spoligono: 
		case kStato_Sregione: 
			if ([varbase fasecomando]>1)  [self DisegnaSplineVirtuale        : xmouse : ymouse]; 
			break;			
		case kStato_Cerchio       : if ([varbase fasecomando]>0)  [self DisegnaCerchioVirtuale :varbase.x1virt : varbase.y1virt : xmouse : ymouse];  break;
		case kStato_Rettangolo    : if ([varbase fasecomando]>0)  [self DisegnaquadroVirtuale  :varbase.x1virt : varbase.y1virt : xmouse : ymouse];  break;
		case kStato_RettangoloStampa:	case kStato_RettangoloDoppioStampa:
			 if ([varbase fasecomando]>0)  [self DisegnaRettangoloStampaVirtuale:varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;
		case kStato_Testo         : 
		case kStato_TestoRot      : 
		case kStato_TestoRotSca   : 
			 
				 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			 if ([varbase fasecomando]==0)  [self DisTestoVirtuale : xcord : ycord : 1 : 0];
		     if ([varbase fasecomando]==1) {
			   double hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,xcord , ycord ); 
			   [self DisTestoVirtuale : varbase.d_x1coord :varbase.d_y1coord : 1 : hhang];
		     }
			 
				 
			 if ([varbase fasecomando]==2) 
			 {
				 double hht = (hypot( (varbase.d_x1coord -xcord), (varbase.d_y1coord-ycord)) /  [[varbase FieldAltezzaTesto] doubleValue]);

				 double hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,varbase.d_x2coord , varbase.d_y2coord ); 
				 [self DisTestoVirtuale : varbase.d_x1coord :varbase.d_y1coord : hht : hhang];
			 }
				 
		 
		 break;
			
		case kStato_SimboloRot    :
		case kStato_SimboloRotSca :
			 if ([varbase fasecomando]==1)  {
				 double hhang =  angolo2vertici   ( varbase.d_x1coord  , varbase.d_y1coord  ,xcord , ycord ); 
				 [self DisSimbolovirtualeang:hhang ];
 			 }
			 if ([varbase fasecomando]==2)  {
				 double  hht = scala2verticischermo   ( varbase.d_x1coord  , varbase.d_y1coord  ,xcord , ycord ,[LeInfo dimxVista]*[LeInfo scalaVista]); 
				 [self DisSimbolovirtualesca:hht]; 
			 
			 }
			 
			 
		break;
			 
			
		case kStato_SpostaSelected:	if ([varbase fasecomando]>0)  [self DisSpostaVirtuale      :varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;
		case kStato_CopiaSelected :	if ([varbase fasecomando]>0)  [self DisCopiaVirtuale       :varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;
		case kStato_RuotaSelected :	if ([varbase fasecomando]>0)  [self DisRuotaVirtuale       :varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;
		case kStato_ScalaSelected :	if ([varbase fasecomando]>0)  [self DisScalaVirtuale       :varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;

		case kStato_SpostaDisegno :	if ([varbase fasecomando]>0)  [self DisSpostaDisegno       :varbase.d_x1coord : varbase.d_y1coord : xcord : ycord];  break;
			
			
		case kStato_SpostaVertice    : if ([varbase fasecomando]>0)  [self DisDoppiaVirtual       :1: xcord : ycord];  break;
		case kStato_InserisciVertice : if ([varbase fasecomando]>0)  [self DisDoppiaVirtual       :2: xcord : ycord];  break;
		case kStato_EditSpVt         : if ([varbase fasecomando]>0)  [self DisDoppiaVirtual       :1: xcord : ycord];  break;

			
		case kStato_spostaRaster_uno:   
		if ([varbase fasecomando]>0) {
			[[varbase DisegnoRcorrente] SpostaOrigine :(dx*[LeInfo scalaVista]) :(dy*[LeInfo scalaVista]) : NO : [[varbase DisegnoRcorrente] indiceSubRastercorrente ]];
			d_xclickdown=(double)mPoint.x;	d_yclickdown=(double)mPoint.y;
			[self display]; 	
	 	}
			break;  
		case kStato_spostaRaster_tutti:  
			if ([varbase fasecomando]>0) {
			[[varbase DisegnoRcorrente] SpostaOrigine :(dx*[LeInfo scalaVista]) :(dy*[LeInfo scalaVista]) : YES : [[varbase DisegnoRcorrente] indiceSubRastercorrente ] ];
				d_xclickdown=(double)mPoint.x;	d_yclickdown=(double)mPoint.y;
			[self display]; 
			}
			break;  
		case kStato_calibra8click :
			if (([varbase fasecomando]==1) |  ([varbase fasecomando]==3) |([varbase fasecomando]==5) | ([varbase fasecomando]==7))
				[self DisegnaVirtuale:d_xclickdown : d_yclickdown : xmouse : ymouse];
			break;
			
		case kStato_Righello :
			if ([varbase fasecomando]==1) {
				[self DisegnaVirtuale:d_xclickdown : d_yclickdown : xmouse : ymouse];
				STR_loc = @"";	
				STR_loc = [STR_loc stringByAppendingFormat:	 @"%1.2f", 
						   hypot(varbase.d_xcoordLast-([LeInfo xorigineVista]+ xmouse*[LeInfo scalaVista])  ,
								 varbase.d_ycoordLast-([LeInfo yorigineVista]+ ymouse*[LeInfo scalaVista])  ) ];	
				
				[varbase txtInterfaceComandoAzione:STR_loc ];

				break;
			}
			break;
		case kStato_Calibraraster:
			if (([varbase fasecomando]==1) | ([varbase fasecomando]==2))  {  [self DisegnaVerticale      :xmouse ]; 	}	
			if (([varbase fasecomando]==3) | ([varbase fasecomando]==4))  {  [self DisegnaOrizzontale    :ymouse ]; 	}
		break;	
			
		 case kStato_CalibrarasterFix:
			 if ([varbase fasecomando]==1)   {  [self DisegnaVerticale      :xmouse ]; 	}	
			 if ([varbase fasecomando]==2)   {  [self DisegnaOrizzontale    :ymouse ]; 	}
		 break;	
		default :	                break;  
    }
	i_xmouselast=mPoint.x;	i_ymouselast=mPoint.y;
}

- (void) scrollWheel                        : (NSEvent *) theEvent                                  {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	double yr = [theEvent deltaY];
	if (yr<-6) yr =-6;
	if (yr>6)  yr = 6;
	[self  Zoom_Weel : yr :mPoint.x :mPoint.y];
}

- (void) mouseDragged                       : (NSEvent *) theEvent                                  {
		// NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
} 

- (void) otherMouseDown                     : (NSEvent *) theEvent                                  {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	d_xclickdown=(double)mPoint.x;  	d_yclickdown=(double)mPoint.y;
}

- (void )otherMouseDragged                  : (NSEvent *) theEvent                                  {
	NSPoint mPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	double dx = mPoint.x-d_xclickdown;
	double dy = mPoint.y-d_yclickdown;
	[LeInfo setZoomC: (  [LeInfo xorigineVista]+ (([LeInfo dimxVista]/2)-dx) *[LeInfo scalaVista]  ) 
					: (  [LeInfo yorigineVista]+ (([LeInfo dimyVista]/2)-dy) *[LeInfo scalaVista]  )];  
	d_xclickdown=(double)mPoint.x;	d_yclickdown=(double)mPoint.y;
	varbase.x1virt = varbase.x1virt + dx;
	varbase.y1virt = varbase.y1virt + dy;

	[self Google_action:self]; 
	[self display]; 
	[self ricordasfondo];
}

- (void) mouseUp                            : (NSEvent *) theEvent                                  {
	
//	[self display]; 
	
} 

- (void) rightMouseDown                     : (NSEvent *) theEvent                                  {
	bool daridisegnare = NO;
		//	NSLog(@"com %d",[varbase comando]);
	if (( varbase.comando ==  kStato_SpostaVertice) | ( varbase.comando ==  kStato_InserisciVertice)  | ( varbase.comando ==  kStato_CancellaVertice) ) 	{
		daridisegnare= YES;
	}

	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	switch ([varbase comando]) {	
		case kStato_Poligono: 
		case kStato_CatPoligono: 
		
		case kStato_Spoligono: 
			[ [varbase DisegnoVcorrente] chiudipoligono:hdc :[varbase MUndor]];
			[varbase setfasecomando:10];
			[self ridisegnasfondo ];
		break;
        case kStato_Regione:            
		case kStato_Sregione: 
			[ [varbase DisegnoVcorrente] chiudipoligono:hdc :[varbase MUndor]];
            [ [varbase DisegnoVcorrente] updateEventualeRegione:hdc :[varbase MUndor]];
			[varbase setfasecomando:10];
            [self display];
                //			[self ridisegnasfondo ];
            break;
            
            
		case kStato_Polilinea: 
		 [[varbase DisegnoVcorrente] finitaPolilinea:hdc:[varbase MUndor] ];		break;
			[self ridisegnasfondo ];

		case kStato_Splinea: 
			[self ridisegnasfondo ];
		break;

	}
	[self ricordasfondo ];
	
	if (incomandotrasparente)  {
		[varbase setcomando:LastComandotrasparente];
		[varbase setfasecomando:LastFaseComandotrasparente];
		varbase.x1virt = (long)((x1spazialevirt-[LeInfo xorigineVista])/[LeInfo scalaVista]);
		varbase.y1virt = (long)((y1spazialevirt-[LeInfo yorigineVista])/[LeInfo scalaVista]);
	} else {
		if ([varbase comando]==kStato_nulla) {[varbase setcomando:Lastcomando]; [varbase setfasecomando:0];} else
		{
			if (([varbase comando]==kStato_Regione) | ([varbase comando]==kStato_Sregione)) {
				if ([varbase fasecomando] <2) [varbase setcomando:kStato_nulla]; else 
					if (FaseRegione==1) [varbase setcomando:kStato_nulla]; else 
					   { FaseRegione=1;   // [mydisvector riaggiornaposizione virtuale
					   }
			} else 
				[varbase setcomando:kStato_nulla];
		}
	}
	incomandotrasparente=NO;
	[varbase AggiornaInterfaceComandoAzione];
	
	if (daridisegnare) [self display];
}




- (void) ricordasfondo                                                                              {
	
 NSBitmapImageRep *_fanta;
    _fanta = [self bitmapImageRepForCachingDisplayInRect:[self visibleRect]];
	[ self cacheDisplayInRect:[self visibleRect] toBitmapImageRep:_fanta];
	if (_fanta!=nil) {
		[SfondoCIImage release];
		SfondoCIImage = [CIImage alloc] ;
		[SfondoCIImage initWithBitmapImageRep:_fanta];
	}
}

- (void) ridisegnasfondo                                                                            {
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClearRect (hdc, [self visibleRect] );
	CIContext* ciContext = [CIContext contextWithCGContext:hdc options:nil];
    [ciContext drawImage:SfondoCIImage inRect:[self visibleRect] fromRect:[self visibleRect]];
}

- (void) ridisegnasfondodxdy                : (double) dx : (double) dy                             {
	CGContextRef hdc = [[NSGraphicsContext currentContext]  graphicsPort];
	CGContextClearRect (hdc, [self visibleRect] );
	CIContext* ciContext = [CIContext contextWithCGContext:hdc options:nil];
    NSRect  newinrect;
	newinrect = [self visibleRect] ;
	newinrect.origin.x = newinrect.origin.x + dx;
	newinrect.origin.y = newinrect.origin.y + dy;
    [ciContext drawImage:SfondoCIImage inRect:newinrect fromRect:[self visibleRect]];
}


- (bool)     ChiusuraSoftwareSuNome                                                                 {
	bool risulta=NO;
	CFStringRef nom =  CSCopyUserName (YES);
	NSMutableString *nomemacchina= [[NSMutableString alloc] initWithCapacity:80];
	UniChar c ;
	for (int i=0; i<CFStringGetLength(nom); i++) {  
		c = CFStringGetCharacterAtIndex (nom,i);   [nomemacchina appendFormat:	 @"%C", c];		}

	if ([nomemacchina isEqualToString:@"carlomacor"]) risulta=YES;
	if ([nomemacchina isEqualToString:@"pasqualemarrone"]) risulta=YES;
	if ([nomemacchina isEqualToString:@"ComuneAllumiere"]) risulta=YES;
	
		//	[varbase txtInterfaceComandoAzione:nomemacchina ];

	return risulta;
}

- (IBAction) ChiusuraSoftware               : (id)  sender                                          {
/*
 InConfermaSoftware =YES;
	NSHost *host;
		//	CFStringRef nom = CSCopyMachineName ();
	CFStringRef nom =  CSCopyUserName (YES);

	NSMutableString *nomemacchina= [[NSMutableString alloc] initWithCapacity:80];
	UniChar c ;
	for (int i=0; i<CFStringGetLength(nom); i++) {  
		c = CFStringGetCharacterAtIndex (nom,i);   [nomemacchina appendFormat:	 @"%C", c];		}
	
	NSLog(@"NomeMacchina name %@",nomemacchina);

	
    host = [NSHost currentHost];
    if (host) {
		NSLog(@"IP1 %@",[host name]);
		NSLog(@"IP2 %@",[host address]);
		NSLog(@"Localized name %@",[host localizedName]);

    }    
	[webusabile orderFront:self];
	NSString *Ippotest;
	NSString *Ippo;
	int poser;
	NSArray *arro =[host addresses];
	for (int i=0; i<arro.count; i++) {  
		Ippotest = [ arro objectAtIndex:i];
		poser =[Ippotest rangeOfString:@"."].location;
		if (poser>0) { Ippo = [ arro objectAtIndex:i]; break;}
	}

	NSMutableString *param = [[NSMutableString alloc] initWithCapacity:80];
	[param autorelease];
	[param appendString:@"http://www.macormap.com/Bello.php?name="];	[param appendString:nomemacchina];
	[param appendString:@"&name2="];          	                        [param appendString:[host name]];
	[param appendString:@"&ver="];        	                            [param appendString:VersioneSoftware];
	[param appendString:@"&ippo="];	                                    [param appendString:Ippo];
	[[webcondizioni  mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:param]]];
*/
}

- (void)     testChiusuraSoftware                                                                   {
	
		// prendere immagine e vedere il pixels nei punti appropriati
	
}



- (IBAction) Google_updateweb               : (id)sender                                            {
	
	qualeweb=!qualeweb;


	
		//    NSString * str3 = @"http://code.google.com/intl/it-IT/apis/maps/documentation/javascript/examples/map-simple.html";
/*		 
	NSString * str3 = @"/Users/carlomacor/Desktop/DatiCartografici/map.html";
		//    NSArray * arrstr = [varbase righetestofile : str3];	NSLog(@"%@",arrstr);	
	
		[[_myweb mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str3]]];
		[Testweb setHidden:YES];
		[_myweb setHidden:NO];
		//		[_myweb setAlphaValue:0.1];
*/

	
	
		//	NSLog(@"%@",str3);
		//	     [[_myweb  mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str3]]];
		//	     [_myweb setHidden:NO];


	

		//[ [_myweb  mainFrame] loadHTMLString:str3 baseURL:nil];

		//			return;
		//	NSLog(@"\n%@",Str_web);
	/*
 	
	
    
	
	
    
	
	
	
	
	*/
		//		NSLog(@"-------------------");
		//	[_myweb setDrawsBackground:NO];
	[Indicaframeloaded setIntValue: 1];
	[Indicaframeloaded setHidden:NO];
	NSMutableString *Str_web2= [[NSMutableString alloc] initWithCapacity:1000];
       [Str_web2 appendString:@"<html>\n" ];
       [Str_web2 appendString:@"<head>\n" ];
       
	   [Str_web2 appendString:@"<script type=\"text/javascript\"\n"  ];
			   [Str_web2 appendString:@"src=\"http://maps.google.com/maps/api/js?sensor=false\"></script>\n" ];
		//	[Str_web2 appendString:@"src=\"http://maps.google.com/maps/api/js?sensor=false&callback=initialize\"></script>\n" ];


	
	
       [Str_web2 appendString:@"<script type=\"text/javascript\">\n" ];
    
       [Str_web2 appendString:@"var map;\n" ];
		
	    [Str_web2 appendString:@"function initialize() {\n" ];
         [Str_web2 appendString:@"var myLatlng = new google.maps.LatLng(\n" ];
         [Str_web2 appendFormat:@"%1.8f",[LeInfo lat_centrogoogle_w]];
         [Str_web2 appendString:@" , "];
         [Str_web2 appendFormat:@"%1.8f",[LeInfo lon_centrogoogle_w] ];
         [Str_web2 appendString:@");\n"];
	
	      [Str_web2 appendString:@"var myOptions = {\n"];
          [Str_web2 appendString:@"zoom: "];
          [Str_web2 appendFormat:@"%d",[googleterreno ZoomGoogle_w]];
          [Str_web2 appendString:@" ,\n"];

	      [Str_web2 appendString:@"disableDefaultUI: true,\n"];

		//	      [Str_web2 appendString:@"mapTypeControl: false,\n" ];
		//          [Str_web2 appendString:@"navigationControl: false,\n"];
		//         [Str_web2 appendString:@"draggable : false,\n"];
		//     [Str_web2 appendString:@"scrollwheel : false,\n"];
		//          [Str_web2 appendString:@"scaleControl: false,\n"];
		//    [Str_web2 appendString:@"ControlBase: false,\n"];
	    //  [Str_web2 appendString:@"PositionControl: false,\n"];

		//     	  [Str_web2 appendString:@"format: \"gif\" ,\n" ];
		//	      [Str_web2 appendString:@"noClear: false,\n" ];

	        [Str_web2 appendString:@"center: myLatlng,\n"];
	       if ([googleterreno Satellite])
	            [Str_web2 appendString:@"mapTypeId: google.maps.MapTypeId.SATELLITE\n"];
	       else	[Str_web2 appendString:@"mapTypeId: google.maps.MapTypeId.ROADMAP\n"];
	     [Str_web2 appendString:@"}\n"];
	
	    [Str_web2 appendString:@"map = new google.maps.Map(document.getElementById(\"map_canvas\"), myOptions);\n"];
	
		// new di test	
		//		    [Str_web2 appendString:@"google.maps.event.addDomListener(mapDiv, 'zoom_changed', showAlert);\n"];

	
	    [Str_web2 appendString:@"}\n"];
	   
	
		// qui fine dello script
		//	    [Str_web2 appendString:@"function showAlert() { window.alert('DIV clicked');	}\n"];
			

	
	   [Str_web2 appendString:@"</script>\n"];
	   [Str_web2 appendString:@"</head>\n"];
		[Str_web2 appendString:@"<body style=\"margin:0px; padding:0px;\" onload=\"initialize()\">\n"];
		[Str_web2 appendString:@"<div id=\"map_canvas\" style=\"width:100%; height:100%\"></div>\n"];
       [Str_web2 appendString:@"</body>\n"];
	   [Str_web2 appendString:@"</html>\n"];
			[ [_myweb  mainFrame] loadHTMLString:Str_web2 baseURL:nil];
			[_myweb setHidden:YES];

	
		//	google.maps.event.addDomListener(mapDiv, 'click', showAlert);
		//	function showAlert() {        window.alert('DIV clicked');	}
	/*
	google.maps.event.addListener(map, 'zoom_changed', function() {
		zoomLevel = map.getZoom();
		infowindow.setContent("Zoom: " + zoomLevel);
		if (zoomLevel == 0) {
			map.setZoom(10);
		}      
	});
	*/
}

- (void) checkGoogletime                         : (NSTimer *) aTimer {
		//	NSLog(@"Timer %d %d %d ",Ultimoframeweb, contatuttiweb, contaframeweb);
		//			NSBeep();

	   [self Google_getwebimg:self];	
	
		//	NSLog(@"da Timer ");
	[googletimer invalidate];	[googletimer release]; googletimer=nil;

	
	
	
	return;
		NSDate * DataQui;    DataQui = [NSDate  date];	
	
	NSTimeInterval differ = [DataQui timeIntervalSinceDate:BaseDateGoogle];
		//	NSLog(@"Dataqui %1.2f",differ);
	
	if (differ>0.01)	{
	   [self Google_getwebimg:self];	
		[googletimer invalidate];	[googletimer release]; googletimer=nil;
	} else {
		if (BaseDateGoogle!=nil) { [BaseDateGoogle release]; BaseDateGoogle=nil; }
		BaseDateGoogle = [NSDate date]; [BaseDateGoogle retain];
	}

	
	if (Ultimoframeweb<contaframeweb ) {
        Ultimoframeweb=contaframeweb;
	}
      else { [googletimer invalidate];	[googletimer release]; googletimer=nil; }
	
}


- (IBAction) Google_getwebimg               : (id)sender                                            {
	NSBitmapImageRep *_fanta;
	[_myweb setHidden:NO];
	_fanta = [_myweb bitmapImageRepForCachingDisplayInRect:[_myweb visibleRect]];
	[ _myweb cacheDisplayInRect:[_myweb visibleRect] toBitmapImageRep:_fanta];
	if (_fanta!=nil) {
		[googleterreno setimageref  :[_fanta 	 CGImage]];
		[googleterreno setZoomGoogle_r:[googleterreno ZoomGoogle_w]];
		[LeInfo setlat_centrogoogle_r:[LeInfo lat_centrogoogle_w]];
		[LeInfo setlon_centrogoogle_r:[LeInfo lon_centrogoogle_w]];
		[googleterreno justriletto];   	
	}
			[_myweb setHidden:YES];
	[Indicaframeloaded setHidden:YES]; 
}

- (void)     webView:(WebView *)sender didStartProvisionalLoadForFrame :(WebFrame *)frame                                                           {
		//		NSBeep();
		// passa alla partenza;
		//	NSLog(@"start %d %d",contaframeweb,contatuttiweb);
		//		NSLog(@"Start Frame %@ %@",[frame name],[frame dataSource]);
		//	[_myweb  mainFrame]

}

- (void)     webView:(WebView *)sender resource:(id)identifier didFailLoadingWithError:(NSError *)error fromDataSource:(WebDataSource *)dataSource  {
		// se fallisce
	contaframeweb++;
	[Indicaframeloaded setIntValue: contaframeweb];
		//	NSLog(@"Fallito %d",contatuttiweb);
}


- (id)       webView:(WebView *)sender identifierForInitialRequest:(NSURLRequest *)request fromDataSource:(WebDataSource *)dataSource               {
		//			NSBeep();
		// ogni volta che riparte il caricamento di uno
    // Return some object that can be used to identify this resource
	contatuttiweb++;
    return [NSNumber numberWithInt:contatuttiweb];
}

 
- (void)     webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource                           {
	
/*	
	if 	(InConfermaSoftware) {	NSLog(@"- %@",sender);
		[self testChiusuraSoftware];
			//   qui fare il test di chiusura in base al web ricevuto
		InConfermaSoftware=NO;
	}
*/
	
	int numres=47;
	int mdx = (1+[LeInfo dimxVista]/256);
	int mdy = (1+[LeInfo dimyVista]/256);
	numres = 23 + mdx*mdy;
	contaframeweb++;
	
	[Indicaframeloaded setIntValue: contaframeweb];
	{
			//		NSLog(@"- %d ", contaframeweb);
		if (contaframeweb>=(numres-2))  
		{
				//														if (contaframeweb==numres)		NSLog(@"- - - %d",numres);
				//					NSLog(@"o.o %d %d ",contatuttiweb, contaframeweb);
			Ultimoframeweb = contaframeweb;

			if (googletimer!=nil) {	[googletimer invalidate];	[googletimer release];  googletimer=nil;}
			googletimer = [[NSTimer scheduledTimerWithTimeInterval:DealyGoogleWegGet target:self  selector:@selector(checkGoogletime:)   userInfo:nil repeats:YES] retain];
				//		NSLog(@"- %1.2f %d",DealyGoogleWegGet,contaframeweb);
				//			[self Google_getwebimg:self];
			
		}
		
	} 
}

- (void)     webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame                                                                      {
		// passa a fine caricamneto alla partenza
		//	NSBeep();
		//	[self display]; 
//	[self ricordasfondo ];
//	NSLog(@"end %d %d",contaframeweb,contatuttiweb);
//	NSLog(@"end %@",[frame name]);
//	NSLog(@"sender %@",sender);

	
	
}

- (IBAction) Google_action                  : (id)sender                                                                                            {
	[LeInfo calcola];
	if (![googleterreno Visibile]) return;
	contaframeweb=0;	contatuttiweb=0;
	// mettere limiti anche per il troppo lontano
	float scalagoog;
    scalagoog     = exp2(20-[googleterreno ZoomGoogle_w]);
	while ( [LeInfo scalaVista_g]    >scalagoog) { [googleterreno setZoomGoogleMeno_w];	scalagoog = exp2(20-[googleterreno ZoomGoogle_w]); }
	while (([LeInfo scalaVista_g]*2) <scalagoog) { [googleterreno setZoomGooglePiu_w];	scalagoog = exp2(20-[googleterreno ZoomGoogle_w]); }
	// qui scrivere le coord del centro schermo
	double xc,yc;
	xc = [LeInfo xorigineVista]+[LeInfo dimxVista]*[LeInfo scalaVista]/2;
	yc = [LeInfo yorigineVista]+[LeInfo dimyVista]*[LeInfo scalaVista]/2;
	[googleterreno setCentro_w : xc : yc];   	
    if ([googleterreno ZoomGoogle_w]>[LeInfo google_maxscala]) {
		[googleterreno setZoomGoogle_w:[LeInfo google_maxscala]];
	}
	[self Google_updateweb:self ]; 
}

- (IBAction) CambiaDelayWebGoole            : (id)sender {
	DealyGoogleWegGet = [sliderGoogletime doubleValue];
		//	NSLog(@"%1.2f",DealyGoogleWegGet);
}



- (IBAction) ComandoSpampaPdf               : (id)sender                                            {
	NSPrintPanel * prnpanel = [NSPrintPanel printPanel];
	[prnpanel setOptions:NSPrintPanelShowsPreview];
	NSPrintOperation *op = [NSPrintOperation printOperationWithView:self];
	[op setPrintPanel:prnpanel];
	[op runOperationModalForWindow:[self window] delegate:nil didRunSelector:NULL contextInfo:NULL];
    NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setRequiredFileType:@"pdf"];
	[panel beginSheetForDirectory:nil file:nil modalForWindow:[self window] modalDelegate:self
				   didEndSelector:@selector(SpampaPdf:returnCode:) contextInfo:nil];
}

- (void)     SpampaPdf                      :(NSSavePanel *) sheet  returnCode:(int)code            {

	
	if (code!= NSOKButton) return;

	NSRect r = [self bounds];
	NSData *data = [self dataWithPDFInsideRect:r];
	NSString *path = [sheet filename];
	NSError *error;
	bool successful = [data writeToFile:path options:0 error:&error];		   
    if (!successful) {
		NSAlert *a = [NSAlert alertWithError:error];
		[a runModal];
	}					   
	
}

CGContextRef MiCreoBitmapContext            (int pixelsWide,int pixelsHigh)                         {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    colorSpace          = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    bitmapData          = malloc( bitmapByteCount );
    if (bitmapData == NULL)   { return NULL;   }
    context = CGBitmapContextCreate (bitmapData,pixelsWide,pixelsHigh,8,bitmapBytesPerRow,colorSpace,kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease( colorSpace );
    return context;
}

- (IBAction) Intersezione2Poligoni          : (id)sender                                            {
	[comandiPro Intersezione2Poligoni ];
	[self display];
} 

- (googleno *) googleno                                                                             {
	return googleterreno;
}
 


- (BOOL)     windowShouldClose              : (id)sender                                            {
		//   [varbase MostraDlgConferma:0];   return varbase.rispostaconferma;
	return YES;
}

- (BOOL)     knowsPageRange                 : (NSRangePointer)range                                 {
		//	NSLog(@"QQQ");	
	if ([varbase rettangoloStampa]==nil) return NO;
	
	NSPrintOperation *po = [NSPrintOperation currentOperation];
	NSPrintInfo *printInfo = [po printInfo];
	if (rettangoloStampaSingolo) [printInfo setOrientation:NSLandscapeOrientation];
	 else	 [printInfo setOrientation:NSPortraitOrientation];
		//	[printInfo setLeftMargin:0.1];
	
	pageRect = [printInfo imageablePageBounds];
	double newscale ;
	if (rettangoloStampaSingolo)  {
		newscale = ([[varbase rettangoloStampa] limx2]-[[varbase rettangoloStampa] limx1])/pageRect.size.width;
		[LeInfo set_scalaVista:newscale];
		[LeInfo set_origineVista:[[varbase rettangoloStampa] limx1] : [[varbase rettangoloStampa] limy1] ];
	} else {
		newscale = ([[varbase rettangoloStampa] limy2]-[[varbase rettangoloStampa] limy1])/pageRect.size.height;
		[LeInfo set_scalaVista:newscale];
		[LeInfo set_origineVista:[[varbase rettangoloStampa] limx1] : [[varbase rettangoloStampa] limy1] ];
	}

	
	range->location=1;
	if (rettangoloStampaSingolo) range->length=1; else range->length=2;
	return YES;
}

- (NSRect) rectForPage                      : (NSInteger)     page                                  {
		//	NSLog(@"KKK");	
	NSRect RectStampa;
	if (rettangoloStampaSingolo) {
  	    RectStampa.origin.x     = (([[varbase rettangoloStampa] limx1]-[LeInfo xorigineVista])/[LeInfo scalaVista]);
	    RectStampa.origin.y     = (([[varbase rettangoloStampa] limy1]-[LeInfo yorigineVista])/[LeInfo scalaVista]);
	    RectStampa.size.height  = (([[varbase rettangoloStampa] limy2]-[[varbase rettangoloStampa] limy1])/[LeInfo scalaVista]); 
	    RectStampa.size.width   = (([[varbase rettangoloStampa] limx2]-[[varbase rettangoloStampa] limx1])/[LeInfo scalaVista]); 
	}
	else {
	  if (page==1) {
  	    RectStampa.origin.x     = (([[varbase rettangoloStampa] limx1]-[LeInfo xorigineVista])/[LeInfo scalaVista]);
	    RectStampa.origin.y     = (([[varbase rettangoloStampa] limy1]-[LeInfo yorigineVista])/[LeInfo scalaVista]);
	    RectStampa.size.height  = (([[varbase rettangoloStampa] limy2]-[[varbase rettangoloStampa] limy1])/[LeInfo scalaVista]); 
	    RectStampa.size.width   = (([[varbase rettangoloStampa] limx2]-[[varbase rettangoloStampa] limx1])/([LeInfo scalaVista]*2)); 
	  } else {
		RectStampa.origin.x     = (((([[varbase rettangoloStampa] limx1]+[[varbase rettangoloStampa] limx2])/2)-[LeInfo xorigineVista])/[LeInfo scalaVista]);
		RectStampa.origin.y     = (([[varbase rettangoloStampa] limy1]-[LeInfo yorigineVista])/[LeInfo scalaVista]);
		RectStampa.size.height  = (([[varbase rettangoloStampa] limy2]-[[varbase rettangoloStampa] limy1])/[LeInfo scalaVista]); 
		RectStampa.size.width   = (([[varbase rettangoloStampa] limx2]-[[varbase rettangoloStampa] limx1])/([LeInfo scalaVista]*2)); 
	  }
	}

	NumPaginaInStampa = page;
	
		//	currentpage
	return RectStampa;
}

- (IBAction) VediGooglevero                 : (id)sender {
		//	[self Google_getwebimg:self];
		//	[self display]; 
		//	return;
	[_myweb setHidden:![_myweb isHidden]];
	[self setHidden:YES];
} 

- (IBAction) VedoSliderGoogleMapsTime : (id)sender {
	[sliderGoogletime setHidden:![sliderGoogletime isHidden]];
}



@end
