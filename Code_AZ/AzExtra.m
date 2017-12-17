//
//  AzExtra.m
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "AzExtra.h"


@implementation AzExtra


- (void) InitAzExtra       {
		//	varbase   = _varbase;
		//	progetto  = _progetto;
		//	info      = _info;
		//	interface = _interface;
	[seg_satelliteStrada  setAlphaValue:0.3];
	[Indicaframeloaded   setFloatValue:0.0];
	carvis =0;  // usata per il decode del pdf
				//		[self caricaDatiCAT:self];
}


static NSArray *openFilesRaster()                                       { 
	NSOpenPanel *panel;
    panel = [NSOpenPanel openPanel];        
    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
	[panel setAllowsMultipleSelection:YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects: @"pdf",nil ] ];
	int i = [panel runModal];
	if(i == NSOKButton){ return [panel filenames];   }
    return nil;
}    


- (IBAction) SalvaImmobili                  : (id)sender {
    [[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];

}



- (IBAction) UndoMUndo                      : (id)sender                {
	[[varbase MUndor] undo];
    
        // riaggiornare le slide movimenti
    [self riaggiornaslidetutte ];
	[progetto display];
}

- (void) riaggiornaslidetutte                                           {
        //  Usata se faccio undo e rimette a posto le slide raster e vettoriali
    [varbase aggiornaslideCalRaster];
    [varbase aggiornaslideCalVector];
    
}


- (IBAction) GoogleVisibile                 : (id)sender				{
	[ [progetto googleno] setVisibile:[ckVisibileGoogle state]];
	if ([ckVisibileGoogle state]==NSOnState) {  [progetto Google_action:self];	} 
	[Slide_alphaWEB       setEnabled:[ckVisibileGoogle state]];
	[seg_satelliteStrada  setEnabled:[ckVisibileGoogle state]];
	if ([ckVisibileGoogle state]==NSOnState)  [seg_satelliteStrada  setAlphaValue:1.0]; else [seg_satelliteStrada  setAlphaValue:0.3];
	[progetto display];
}

- (IBAction) SwitchGoogleVisibile           : (id)sender                {
	if ([ckVisibileGoogle state] == NSOnState)  [ckVisibileGoogle setState : NSOffState]; else  [ckVisibileGoogle setState : NSOnState];
	[ [progetto googleno] setVisibile:[ckVisibileGoogle state]];
	if ([ckVisibileGoogle state]==NSOnState) {  [progetto Google_action:self];	} 
	[Slide_alphaWEB       setEnabled:[ckVisibileGoogle state]];
	[seg_satelliteStrada  setEnabled:[ckVisibileGoogle state]];
	if ([ckVisibileGoogle state]==NSOnState)  [seg_satelliteStrada  setAlphaValue:1.0]; else [seg_satelliteStrada  setAlphaValue:0.3];
	[progetto display];
	
}

- (IBAction) SwitchGoogleStrada             : (id)sender                {
	if ([seg_satelliteStrada selectedSegment]==0) [seg_satelliteStrada setSelectedSegment:1]; else [seg_satelliteStrada setSelectedSegment:0];
	if ([seg_satelliteStrada selectedSegment]==0) [[progetto googleno] setSatellite:YES]; else [[progetto googleno] setSatellite:NO];
	[progetto Google_action:self];
	[progetto display];
}

- (IBAction) setalphagoogle                 : (id)sender                {
	float alp;
	alp = [Slide_alphaWEB floatValue];	[[progetto googleno] setalpha:alp];
	[progetto display];
}

- (IBAction) Google_satellitestrada         : (id)sender                {
	if ([sender selectedSegment]==0) [[progetto googleno] setSatellite:YES]; else [[progetto googleno] setSatellite:NO];
	[progetto Google_action:self];
	[progetto display];
}

- (IBAction) CVistaZoom                     : (id)sender                {
    [progetto updatescala: [sender selectedSegment]];     
}



- (NSString *) valorerenditastr             : ( NSString *) str         {
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=0; i<[str length]; i++) {   c=	[str characterAtIndex:i];	
		if (c!=46) 	{if (c==44) c=46;[risulta appendFormat:	 @"%C", c];	}
	}	
	return risulta;	
}

- (NSString *) viastr                       : ( NSString *) str         {
	NSRange rg;
	rg = [str rangeOfString:@","];
		//			NSLog(@"rg %d %d ",rg.length,rg.location);
	if (rg.length==0) return @"";
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=0; i<rg.location; i++) {   c=	[str characterAtIndex:i];	[risulta appendFormat:	 @"%C", c];	}	
	return risulta;	
}

- (NSString *) civicostr                    : ( NSString *) str         {
	NSRange rg,rg2;
	rg = [str rangeOfString:@","];
	rg2 = [str rangeOfString:@"Piano"];
		//	NSLog(@"rg1 %d %d ",rg.length,rg.location);
		//	NSLog(@"rg2 %d %d ",rg2.length,rg2.location);
	if (rg2.location==-1) rg2.location = [str length];
	if (rg.length==0) return @"";
	if (rg2.length==0) return @"";
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=rg.location+1; i<rg2.location; i++) {   c=	[str characterAtIndex:i];	[risulta appendFormat:	 @"%C", c];	}	
	return risulta;	
}

- (NSString *) pianoedifstr                 : ( NSString *) str         {
	NSRange rg;
	rg = [str rangeOfString:@"Piano"];
	if (rg.length==0) return @"";
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=(rg.location+rg.length+1); i<[str length]; i++) { 
		c=	[str characterAtIndex:i];  if (c!=32) {	[risulta appendFormat:	 @"%C", c];	 }	}	
	return risulta;	
}

- (NSString *) ripuliscistr                 : ( NSString *) str         {
	NSMutableString *risulta = [[NSMutableString alloc] initWithCapacity:40];
	[risulta autorelease];    unichar c=0;
	for (int i=0; i<[str length]; i++) { 
		c=	[str characterAtIndex:i];  
		if ((c!=32) & (c!=9)) {	
		[risulta appendFormat:	 @"%C", c];
				//	NSLog(@"P %c %d",c,c);
		}	
	}	
	return risulta;
}




- (IBAction) CInfoEdificio                  : (id) sender               { 
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	if ([varbase comando]== kStato_InfoEdificio) {[[varbase ListaSelezEdifici] removeAllObjects]; [progetto display];	}
	[progetto chiusuracomandoprecedente];
	[varbase  comandodabottone : kStato_InfoEdificio ];

		//	[self  comandobottone : kStato_InfoEdificio ];
}






- (IBAction) CInfoTerreno                   : (id)sender                { 
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	if ([varbase comando]== kStato_InfoTerreno) {[[varbase ListaSelezTerreni] removeAllObjects]; [progetto display];	}
	[progetto chiusuracomandoprecedente];
	[varbase  comandodabottone : kStato_InfoTerreno ];
		//	[self  comandobottone : kStato_InfoTerreno ];
}





- (int)      giacaricatodisegno             : (NSString *) str  {
	int risulta = -1;
    if (! [[NSFileManager defaultManager]  fileExistsAtPath:str]) return risulta;
	DisegnoV *locdis;
	for (int i=0; i<[varbase ListaVector].count; i++) {  
		locdis = [[varbase ListaVector] objectAtIndex:i];
		if ([[locdis nomedisegno] isEqualToString: str]) { risulta=i; break; }
	}
	if (risulta<0) {	// qui caricare forzatamente il disegno
		locdis = [DisegnoV  alloc];    
		[locdis InitDisegno:info];
		[[varbase ListaVector] addObject:locdis]; 
		[locdis setpianocorrente:0];
		[varbase DoNomiVectorPop];	
		[locdis apriDisegnoCxf: str : [varbase ListaDefSimboli]  ]; 
		[varbase DoNomiVectorPop];
		risulta = [varbase ListaVector].count-1;
	}
	
	
		//	[locdis updateInfoConLimiti];  	
		//	[[progetto InfoPro] setZoomAllVector];  
		//	[progetto Google_action:self]; 
	
	return risulta;
}




- (void)     AddinListaParticella           : (int) inddis       : (NSMutableArray *)  lista  : (NSString *) nompart           {
	DisegnoV * Locdis;
	Locdis = [[varbase ListaVector] objectAtIndex:inddis];
    NSString *SP1;
	NSRange rg,rg2;
	rg = [nompart rangeOfString:@","];
    if (rg.length>0) {	rg2.location=0; rg2.length=rg.location;	SP1 = [nompart substringWithRange:rg2];	} else
	{		SP1 = [NSString stringWithString:nompart];	}
			// NSLog(@"np %d",[Locdis damminumpiani]);	NSLog(@"np %@",nompart);

	NSString * nompartp = [NSString stringWithFormat:@"%@+",SP1];
	Piano * locpiano;
	Vettoriale * locobvet;
	for (int i=0; i<[Locdis damminumpiani]; i++) {
 	  locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
	  if (([[locpiano givemenomepiano] isEqualToString: SP1]) | ([[locpiano givemenomepiano] isEqualToString: nompartp]) ) {
  		  for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
  				locobvet = [[locpiano Listavector] objectAtIndex:j];
			  if ([locobvet superficie]>0) [lista addObject:locobvet];
		  }
	 	}
	  }
   [self zoommaEdifSelected];
   [progetto display];
}

- (void)     AddinListaParticellaNoDisplay           : (int) inddis       : (NSMutableArray *)  lista  : (NSString *) nompart           {
	DisegnoV * Locdis;
	Locdis = [[varbase ListaVector] objectAtIndex:inddis];
    NSString *SP1;
	NSRange rg,rg2;
	rg = [nompart rangeOfString:@","];
    if (rg.length>0) {	rg2.location=0; rg2.length=rg.location;	SP1 = [nompart substringWithRange:rg2];	} else
	{		SP1 = [NSString stringWithString:nompart];	}
		// NSLog(@"np %d",[Locdis damminumpiani]);	NSLog(@"np %@",nompart);
	
	NSString * nompartp = [NSString stringWithFormat:@"%@+",SP1];
	Piano * locpiano;
	Vettoriale * locobvet;
	for (int i=0; i<[Locdis damminumpiani]; i++) {
		locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
		if (([[locpiano givemenomepiano] isEqualToString: SP1]) | ([[locpiano givemenomepiano] isEqualToString: nompartp]) ) {
			for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
  				locobvet = [[locpiano Listavector] objectAtIndex:j];
				if ([locobvet superficie]>0)
				{ bool inlistapres=NO;
					for (int k=0; k<lista.count; k++) {
						if (locobvet==[lista objectAtIndex:k]) { inlistapres=YES; break;	}
					}
					if (!inlistapres) [lista addObject:locobvet];
				}
			}
	 	}
	}
}



- (void)     AddinListaGruppoSuber          : (NSArray *) Subers : (NSMutableArray *)  lista                                   {
	NSString *SP2; NSString *SP3;
	int indo;		DisegnoV * Locdis; 
	unichar ilcar;	 NSRange rg,rg2;
    bool Aggiunto;
	for (int i=0; i<[Subers count]; i++) {
		Subalterno * suber = [Subers objectAtIndex:i];
        NSString *st1;	
        NSString * nompartp;
		NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
		for (int j=0; j<[[suber Foglio] length]; j++) {
			ilcar = [ [suber Foglio] characterAtIndex:j];
			if (ilcar==44) { break;	} else { [ParteSt appendFormat:	 @"%C", ilcar];	}
		}		
		indo = [self aproFoglio : ParteSt];
        if (indo<0) continue;
		Aggiunto =NO;
		SP2 = [NSString stringWithString:[suber Particella]];
		BOOL ultima = YES;
		while (ultima) {
		 rg = [SP2 rangeOfString:@","];
			if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
			          else   {	st1 = [NSString stringWithString:SP2];	}
		 if (rg.length>0) {
			 rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
			 SP2 = [NSString stringWithString:SP3];   ultima = YES;
		  } else { ultima = NO; };
		 nompartp = [NSString stringWithFormat:@"%@+",st1];
		 if (indo>=0) {
			Piano * locpiano;
			Vettoriale * locobvet;
			Locdis = [[varbase ListaVector] objectAtIndex:indo];
			for (int i=0; i<[Locdis damminumpiani]; i++) {
				locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
				if (([[locpiano givemenomepiano] isEqualToString: st1]) | ([[locpiano givemenomepiano] isEqualToString: nompartp]) ) {
                    Aggiunto = YES;
					for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
						locobvet = [[locpiano Listavector] objectAtIndex:j];
						if ([locobvet superficie]>0) { 
							BOOL presente =NO;
							presente = [lista containsObject:locobvet];
							if (!presente) 	[lista addObject:locobvet]; 
						}
					}
				}
			}
		 }
		}
        
			//       NSLog(@"Giro %@ ",[suber Foglio]);

        if (!Aggiunto) {
            indo = [self aproFoglioA : ParteSt];
            if (indo>=0) {
            SP2 = [NSString stringWithString:[suber Particella]];
                //            NSLog(@"1 %@ ",[suber Foglio]);
            BOOL ultima = YES;
            while (ultima) {
                rg = [SP2 rangeOfString:@","];
                if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
                else   {	st1 = [NSString stringWithString:SP2];	}
                if (rg.length>0) {
                    rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
                    SP2 = [NSString stringWithString:SP3];   ultima = YES;
                } else { ultima = NO; };
                nompartp = [NSString stringWithFormat:@"%@+",st1];
                if (indo>=0) {
                    Piano * locpiano;
                    Vettoriale * locobvet;
                    Locdis = [[varbase ListaVector] objectAtIndex:indo];
                    for (int i=0; i<[Locdis damminumpiani]; i++) {
                        locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
                        if (([[locpiano givemenomepiano] isEqualToString: st1]) | ([[locpiano givemenomepiano] isEqualToString: nompartp]) ) {
                            Aggiunto = YES;
                            for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
                                locobvet = [[locpiano Listavector] objectAtIndex:j];
                                if ([locobvet superficie]>0) { 
                                    BOOL presente =NO;
                                    presente = [lista containsObject:locobvet];
                                    if (!presente) 	[lista addObject:locobvet]; 
                                }
                            }
                        }
                    }
                }
 			}
           }
        }  // fine tentativo foglioA
		
		if (!Aggiunto) {
            indo = [self aproFoglio0A : ParteSt];
            if (indo>=0) {
            SP2 = [NSString stringWithString:[suber Particella]];
                //            NSLog(@"1 %@ ",[suber Foglio]);
            BOOL ultima = YES;
            while (ultima) {
                rg = [SP2 rangeOfString:@","];
                if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
                else   {	st1 = [NSString stringWithString:SP2];	}
                if (rg.length>0) {
                    rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
                    SP2 = [NSString stringWithString:SP3];   ultima = YES;
                } else { ultima = NO; };
                nompartp = [NSString stringWithFormat:@"%@+",st1];
                if (indo>=0) {
                    Piano * locpiano;
                    Vettoriale * locobvet;
                    Locdis = [[varbase ListaVector] objectAtIndex:indo];
                    for (int i=0; i<[Locdis damminumpiani]; i++) {
                        locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
                        if (([[locpiano givemenomepiano] isEqualToString: st1]) | ([[locpiano givemenomepiano] isEqualToString: nompartp]) ) {
                            Aggiunto = YES;
                            for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
                                locobvet = [[locpiano Listavector] objectAtIndex:j];
                                if ([locobvet superficie]>0) { 
                                    BOOL presente =NO;
                                    presente = [lista containsObject:locobvet];
                                    if (!presente) 	[lista addObject:locobvet]; 
                                }
                            }
                        }
                    }
                }
            }
			}
        }  // fine tentativo foglioA
		
		

 	}
        //    NSLog(@" %@ ",[suber Foglio]);

    
    if ([lista count]>0) { [self zoommaEdifSelected];[progetto display];	}
}

- (void)     AddinListaGruppoTerer          : (NSArray *) Subers : (NSMutableArray *)  lista                                   {
	NSString *SP2; NSString *SP3;
	int indo;		DisegnoV * Locdis; 
	unichar ilcar;	 NSRange rg,rg2;
    bool Aggiunto;

	for (int i=0; i<[Subers count]; i++) {
		Terreno * terer = [Subers objectAtIndex:i];
        NSString *st1;	
		NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
		for (int j=0; j<[[terer Foglio] length]; j++) {
			ilcar = [ [terer Foglio] characterAtIndex:j];
			if (ilcar==44) { break;	} else { [ParteSt appendFormat:	 @"%C", ilcar];	}
		}		
		indo = [self aproFoglio : ParteSt];

        Aggiunto =NO;
		SP2 = [NSString stringWithString:[terer Particella]];
		BOOL ultima = YES;
		while (ultima) {
			rg = [SP2 rangeOfString:@","];
			if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
			else   {	st1 = [NSString stringWithString:SP2];	}
			if (rg.length>0) {
				rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
				SP2 = [NSString stringWithString:SP3];   ultima = YES;
			} else { ultima = NO; };
				//			NSString * nompartp = [NSString stringWithFormat:@"%@+",st1];
			if (indo>=0) {
				Piano * locpiano;
				Vettoriale * locobvet;
				Locdis = [[varbase ListaVector] objectAtIndex:indo];
				for (int i=0; i<[Locdis damminumpiani]; i++) {
					locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
					if ([[locpiano givemenomepiano] isEqualToString: st1]) {
                        Aggiunto = YES;
						for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
							locobvet = [[locpiano Listavector] objectAtIndex:j];
							if ([locobvet superficie]>0) { 
								BOOL presente =NO;
								presente = [lista containsObject:locobvet];
								if (!presente) 	[lista addObject:locobvet]; 
							}
						}
					}
				}
			}
		
            if (!Aggiunto) {
                indo = [self aproFoglioA : ParteSt];
                SP2 = [NSString stringWithString:[terer Particella]];
                BOOL ultima = YES;
                while (ultima) {
                    rg = [SP2 rangeOfString:@","];
                    if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
                    else   {	st1 = [NSString stringWithString:SP2];	}
                    if (rg.length>0) {
                        rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
                        SP2 = [NSString stringWithString:SP3];   ultima = YES;
                    } else { ultima = NO; };
                        //			NSString * nompartp = [NSString stringWithFormat:@"%@+",st1];
                    if (indo>=0) {
                        Piano * locpiano;
                        Vettoriale * locobvet;
                        Locdis = [[varbase ListaVector] objectAtIndex:indo];
                        for (int i=0; i<[Locdis damminumpiani]; i++) {
                            locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
                            if ([[locpiano givemenomepiano] isEqualToString: st1]) {
                                Aggiunto = YES;
                                for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
                                    locobvet = [[locpiano Listavector] objectAtIndex:j];
                                    if ([locobvet superficie]>0) { 
                                        BOOL presente =NO;
                                        presente = [lista containsObject:locobvet];
                                        if (!presente) 	[lista addObject:locobvet]; 
                                    }
                                }
                            }
                        }
                    }

                }
            }
			if (!Aggiunto) {
                indo = [self aproFoglio0A : ParteSt];
                SP2 = [NSString stringWithString:[terer Particella]];
                BOOL ultima = YES;
                while (ultima) {
                    rg = [SP2 rangeOfString:@","];
                    if (rg.length>0) {	rg2.location=0; rg2.length=rg.location; st1 = [SP2 substringWithRange:rg2];	} 
                    else   {	st1 = [NSString stringWithString:SP2];	}
                    if (rg.length>0) {
                        rg2.location=rg.location+1; rg2.length=[SP2 length]-(rg.location+1); SP3 = [SP2 substringWithRange:rg2]; 
                        SP2 = [NSString stringWithString:SP3];   ultima = YES;
                    } else { ultima = NO; };
                        //			NSString * nompartp = [NSString stringWithFormat:@"%@+",st1];
                    if (indo>=0) {
                        Piano * locpiano;
                        Vettoriale * locobvet;
                        Locdis = [[varbase ListaVector] objectAtIndex:indo];
                        for (int i=0; i<[Locdis damminumpiani]; i++) {
                            locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
                            if ([[locpiano givemenomepiano] isEqualToString: st1]) {
                                Aggiunto = YES;
                                for (int j=0; j<[locpiano givemeNumObjpiano]; j++) { 
                                    locobvet = [[locpiano Listavector] objectAtIndex:j];
                                    if ([locobvet superficie]>0) { 
                                        BOOL presente =NO;
                                        presente = [lista containsObject:locobvet];
                                        if (!presente) 	[lista addObject:locobvet]; 
                                    }
                                }
                            }
                        }
                    }
					
                }
            }
			
			
                    //            NSLog(@"da fare %@ ",nompartp);

        
        }
	}
		//	NSLog(@"N %d",[lista count]);
	
	if ([lista count]>0) { [self zoommaTerraSelected];[progetto display];	}
}

- (void)     AddinListaTerreno              : (int) inddis       : (NSMutableArray *)  lista  : (NSString *) nompart           {
	DisegnoV * Locdis;
	Locdis = [[varbase ListaVector] objectAtIndex:inddis];
	
		//	NSLog(@"np %d",[Locdis damminumpiani]);	NSLog(@"np %@",nompart);
	
	Piano * locpiano;
	Vettoriale * locobvet;
	for (int i=0; i<[Locdis damminumpiani]; i++) {
		locpiano = [[Locdis ListaPiani] objectAtIndex: i ];
		if ([[locpiano givemenomepiano] isEqualToString: nompart])  {
			for (int j=0; j<[locpiano givemeNumObjpiano]; j++) {
  				locobvet = [[locpiano Listavector] objectAtIndex:j];
				if ([locobvet superficie]>0) [lista addObject:locobvet];
			}
	 	}
	}
	[self zoommaTerraSelected];
	[progetto display];
}


- (void)     zoommaEdifSelected                                 {
	Vettoriale * locobvet;
	double xct,yct,dxt,dyt;
	double x1,y1,x2,y2;
	double parazo=5.5;
	for (int i=0; i<[[varbase ListaSelezEdifici] count]; i++) {
	  locobvet = [[varbase ListaSelezEdifici] objectAtIndex:i];
	  if (i==0) {
		  x1 = [locobvet limx1];	  y1 = [locobvet limy1];
		  x2 = [locobvet limx2];	  y2 = [locobvet limy2];
	  } else {
		  if ([locobvet limx1]<x1) {x1 = [locobvet limx1];}	  if ([locobvet limy1]<y1) {y1 = [locobvet limy1];}
		  if ([locobvet limx2]>x2) {x2 = [locobvet limx2];}	  if ([locobvet limy2]>y2) {y2 = [locobvet limy2];}
	  }
	}
	if ([[varbase ListaSelezEdifici] count]<=0) return; 
	xct = (x1+x2)/2;	yct = (y1+y2)/2;
	dxt = parazo*(x2-x1) / [info dimxVista];  dyt = parazo*(y2-y1) / [info dimyVista];
	[info set_scalaVista2:dxt : dyt];
	[progetto ZoomC :xct:yct];
}

- (void)     zoommaTerraSelected                                {
	Vettoriale * locobvet;
	double xct,yct,dxt,dyt;
	double x1,y1,x2,y2;
	for (int i=0; i<[[varbase ListaSelezTerreni] count]; i++) {
		locobvet = [[varbase ListaSelezTerreni] objectAtIndex:i];
		if (i==0) {
			x1 = [locobvet limx1];	  y1 = [locobvet limy1];
			x2 = [locobvet limx2];	  y2 = [locobvet limy2];
		} else {
			if ([locobvet limx1]<x1) {x1 = [locobvet limx1];}	  if ([locobvet limy1]<y1) {y1 = [locobvet limy1];}
			if ([locobvet limx2]>x2) {x2 = [locobvet limx2];}	  if ([locobvet limy2]>y2) {y2 = [locobvet limy2];}
		}
	}
	if ([[varbase ListaSelezTerreni] count]<=0) return; 
	xct = (x1+x2)/2;	yct = (y1+y2)/2;
    
		//    float parzo=1.2;
    float parzo=5.5;
    
	dxt = parzo*(x2-x1) / [info dimxVista];  dyt = parzo*(y2-y1) / [info dimyVista];
	[info set_scalaVista2:dxt : dyt];
	[progetto ZoomC :xct:yct];
	
	
/*	
	Vettoriale * locobvet;
	int numobj = [[varbase ListaSelezTerreni] count];
	if (numobj<=0) return;
	locobvet = [[varbase ListaSelezTerreni] objectAtIndex:0];
	double xct = ([locobvet limx1] +  [locobvet limx2]) /2;
	double yct = ([locobvet limy1] +  [locobvet limy2]) /2;
	double dxt = 8*([locobvet limx2] -  [locobvet limx1]) / [[progetto InfoPro] dimxVista];
	double dyt = 8*([locobvet limy2] -  [locobvet limy1]) / [[progetto InfoPro] dimyVista];
	[[progetto InfoPro] set_scalaVista2:dxt : dyt];
	
	[progetto ZoomC :xct:yct];
*/
	
	 //	[[progetto InfoPro] setZoomC:xct:yct];  
}


- (int)      aproFoglio                     : (NSString *) st   {
    int risulta =-1;
	NSString * secpartnomfile; 
	if ([st length]==0) return risulta;
	if ([st length]==1) secpartnomfile = [NSString stringWithFormat:@"000%@",st];
	if ([st length]==2) secpartnomfile = [NSString stringWithFormat:@"00%@" ,st];
	if ([st length]==3) secpartnomfile = [NSString stringWithFormat:@"0%@"  ,st];
	if ([st length]>3) return risulta;
	NSString * potezfile = [NSString stringWithFormat:@"%@%@_%@00.CXF",[varbase Dir_Catastali],[varbase COD_Comune],secpartnomfile ];
	risulta = [self giacaricatodisegno : potezfile];
	return risulta;
}

- (int)      aproFoglioA                     : (NSString *) st   {
    int risulta =-1;
	NSString * secpartnomfile; 
	if ([st length]==0) return risulta;
	if ([st length]==1) secpartnomfile = [NSString stringWithFormat:@"000%@",st];
	if ([st length]==2) secpartnomfile = [NSString stringWithFormat:@"00%@" ,st];
	if ([st length]==3) secpartnomfile = [NSString stringWithFormat:@"0%@"  ,st];
	if ([st length]>3) return risulta;
	NSString * potezfile = [NSString stringWithFormat:@"%@%@_%@0A.CXF",[varbase Dir_Catastali],[varbase COD_Comune],secpartnomfile ];
	risulta = [self giacaricatodisegno : potezfile];
	return risulta;
}

- (int)      aproFoglio0A                     : (NSString *) st   {
    int risulta =-1;
	NSString * secpartnomfile; 
	if ([st length]==0) return risulta;
	if ([st length]==1) secpartnomfile = [NSString stringWithFormat:@"000%@",st];
	if ([st length]==2) secpartnomfile = [NSString stringWithFormat:@"00%@" ,st];
	if ([st length]==3) secpartnomfile = [NSString stringWithFormat:@"0%@"  ,st];
	if ([st length]>3) return risulta;
	NSString * potezfile = [NSString stringWithFormat:@"%@%@_%@A0.CXF",[varbase Dir_Catastali],[varbase COD_Comune],secpartnomfile ];
	risulta = [self giacaricatodisegno : potezfile];
	return risulta;
}

- (IBAction) VediBoxTarquinia               : (id)sender        {
			[boxTarquinia setHidden:![boxTarquinia isHidden]]; 
}


- (IBAction) RepaintMain                    : (id)sender        {
	[progetto display];
}

- (IBAction) TrovaTerreniSenzaCatasto       : (id)sender        {
    DisegnoV * locdisV;
    Piano    * locpiano;
    bool trovato;
    int conta=0;
    for (int i=0; i<[[varbase ListaVector] count]; i++) {
       locdisV =  [[varbase ListaVector] objectAtIndex: i];
        if (![[[locdisV  nomedisegno] pathExtension] isEqualToString:@"CXF"]) continue;
        
        for (int j=2; j<[locdisV damminumpiani]; j++) {
            locpiano = [[locdisV ListaPiani] objectAtIndex:j];
            if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Fiduciale"]) continue;
            
            if ([[locpiano givemenomepiano] isEqualToString:@"Linea"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"LineaExt"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Simboli"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Testo"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"TestoExt"]) continue;
            
            
            if ([locpiano pianoPlus]) continue;
            
            trovato = NO;
            
            if (!trovato) {
                trovato = [[varbase TuttiImmobili]  EsisteTerreno:[locdisV nomeFoglioCXF]    : [locpiano givemenomepiano] ];
                    //                if (trovato)  NSLog(@"Trovata %@ %@",[locpiano givemenomepiano],[locdisV nomeFoglioCXF]);
            }
   

			if (!trovato) {
				 trovato = [locdisV esistenomepiano:[locpiano nomepianoNoPlus] ];
			}
			
            if (!trovato) {
                                 trovato = [[varbase TuttiImmobili]  EsisteFabbricato:[locdisV nomeFoglioCXF]    : [locpiano nomepianoNoPlus] ];
                if (trovato) {
                    conta = conta+1;
						//                NSLog(@"Trovata %@ %@",[locpiano givemenomepiano],[locdisV nomeFoglioCXF]);
                }
            }
            
            if (!trovato) {
                Terreno    * terer;
                terer = [Terreno alloc]; [terer svuota]; 
                [terer SetFoglio:[locdisV nomeFoglioCXF]];
                [terer SetParticella  :  [locpiano givemenomepiano]];
					        [terer SetQualita     : @"?"];
				terer.CorrTabelle =2 ;
				terer.Superficie = (int)[locpiano SupPoligoni];

					            [[[varbase TuttiImmobili] LTer ] addObject:terer] ;  
					                   NSLog(@"NP Fg:%@ Part:%@",[locdisV nomeFoglioCXF],[locpiano givemenomepiano]);
            }

            
            
            
        }
    }
    NSLog(@"Conta %d ",conta);

}

- (IBAction) TrovaEdificiSenzaCatasto       : (id)sender        {
    DisegnoV * locdisV;
    Piano    * locpiano;
    bool trovato;
    for (int i=0; i<[[varbase ListaVector] count]; i++) {
        locdisV =  [[varbase ListaVector] objectAtIndex: i];
        if (![[[locdisV  nomedisegno] pathExtension] isEqualToString:@"CXF"]) continue;
        
        for (int j=2; j<[locdisV damminumpiani]; j++) {
            locpiano = [[locdisV ListaPiani] objectAtIndex:j];
            if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Fiduciale"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Linea"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"LineaExt"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Simboli"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Testo"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"TestoExt"]) continue;
            
            if (![locpiano pianoPlus]) continue;
            
            trovato = NO;
            if (!trovato) {
                trovato = [[varbase TuttiImmobili]  EsisteFabbricato:[locdisV nomeFoglioCXF]    : [locpiano nomepianoNoPlus] ];
            }
            
				//            if (!trovato) { trovato = [[varbase TuttiImmobili]  EsisteTerreno   :[locdisV nomeFoglioCXF]    : [locpiano givemenomepiano] ];   }
            
            if (!trovato) {
                Subalterno    * suber;
                suber = [Subalterno alloc]; [suber svuota]; 
                [suber setFoglio:[locdisV nomeFoglioCXF]];
                [suber setParticella  :  [locpiano nomepianoNoPlus]];
                [suber  setSub           : @"?"];
                [suber  setCategoria     : @""];
                [suber  setClasse        : @""];
                [suber  setConsistenza   : @""];
                [suber  setPianoEdificio : @""];
                [suber  setCivico        : @""];
                [suber  setInterno       : @""];
                [suber  setVia           : @""];
                [[[varbase TuttiImmobili] ListaSubalterni ] addObject:suber] ;  
				NSLog(@"Conta %d ",j);

            }
        }
    }
    
}

- (IBAction) TrovaRecordSenzaTerreno        : (id)sender        {
    int conta=0;
    bool trovato;
    NSLog(@"Tutti sono :  %lu ",[[[varbase TuttiImmobili] LTer] count] );

    
    for (int i=0; i<[[[varbase TuttiImmobili] LTer] count]; i++) {
        trovato = NO;
               NSLog(@"-  %d ",i);

        Terreno    * terer = [[[varbase TuttiImmobili] LTer] objectAtIndex:i];
        
        for (int j=0; j<[[varbase ListaVector] count]; j++) {
          DisegnoV * locdisV  =  [[varbase ListaVector] objectAtIndex: j];
            if (![[[locdisV  nomedisegno] pathExtension] isEqualToString:@"CXF"]) continue;
            for (int k=2; k<[locdisV damminumpiani]; k++) {
                Piano    * locpiano = [[locdisV ListaPiani] objectAtIndex:k];
                if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"Fiduciale"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"Linea"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"LineaExt"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"Simboli"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"Testo"]) continue;
                if ([[locpiano givemenomepiano] isEqualToString:@"TestoExt"]) continue;
                
                if ([locpiano pianoPlus]) continue;
                if ([[locdisV nomeFoglioCXF] isEqualToString:[terer Foglio]]) {
                    if ([[locpiano givemenomepiano] isEqualToString:[terer Particella]]) {
                    trovato=YES;
                    break;
                    }
                }
            }
        
        }
        
        if (!trovato )  {
            conta ++;
            NSLog(@"NotDeter %d Fg:%@ Part:%@",conta,[terer Foglio],[terer Particella]);
			terer.CorrTabelle =1;
        }
			//      NSLog(@"- %d ",i);
    }
    
}

- (IBAction) TrovaRecordSenzaEdificio       : (id)sender        {
Subalterno    * suber;
DisegnoV * locdisV;
Piano    * locpiano;
int conta=0;
bool trovato;
NSLog(@"Tutti sono :  %lu ",[[[varbase TuttiImmobili] ListaSubalterni] count] );


for (int i=0; i<[[[varbase TuttiImmobili] ListaSubalterni] count]; i++) {
    trovato = NO;
        //     NSLog(@"-  %d ",i);
    
    suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:i];
    
    if (![[suber Foglio] isEqualToString:@"24"]) continue;
    
    
    for (int j=0; j<[[varbase ListaVector] count]; j++) {
        locdisV =  [[varbase ListaVector] objectAtIndex: j];
        
            //      NSLog(@"CXF Fg %d %@",j,[locdisV nomeFoglioCXF] );  
        
        if (![[[locdisV  nomedisegno] pathExtension] isEqualToString:@"CXF"]) continue;
        for (int k=2; k<[locdisV damminumpiani]; k++) {
            locpiano = [[locdisV ListaPiani] objectAtIndex:k];
            if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Fiduciale"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Linea"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"LineaExt"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Simboli"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Testo"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"TestoExt"]) continue;
            
				//           if (![locpiano pianoPlus]) continue;
            if ([[locdisV nomeFoglioCXF] isEqualToString:[suber Foglio]]) {
                if ([[locpiano nomepianoNoPlus] isEqualToString:[suber Particella]]) { trovato=YES;   break;   }
                if ([[locpiano givemenomepiano] isEqualToString:[suber Particella]]) { trovato=YES;   break;   }
            }
        }
        
    }
    
    if (!trovato )  {
        conta ++;
        NSLog(@"NotDeter %d Fg:%@ Part:%@ Sub:%@",conta,[suber Foglio],[suber Particella],[suber Sub] );
               [suber setClasse:@"KK"];
    }

}
}

- (IBAction) QuantificaTerreni              : (id)sender        {
    DisegnoV * locdisV;
    Piano    * locpiano;
    int conta=0;
    for (int i=0; i<[[varbase ListaVector] count]; i++) {
        locdisV =  [[varbase ListaVector] objectAtIndex: i];

        if (![[[locdisV  nomedisegno] pathExtension] isEqualToString:@"CXF"]) continue;
        NSLog(@"Disegno : %@ Ind:%d",[locdisV nomeFoglioCXF],i+1 );
        
        for (int j=2; j<[locdisV damminumpiani]; j++) {
            locpiano = [[locdisV ListaPiani] objectAtIndex:j];
            if ([[locpiano givemenomepiano] isEqualToString:@"ACQUA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Fiduciale"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Linea"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"LineaExt"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"STRADA"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Simboli"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"Testo"]) continue;
            if ([[locpiano givemenomepiano] isEqualToString:@"TestoExt"]) continue;
            if ([locpiano pianoPlus]) continue;
            conta++;

            NSLog(@"- : %d %d %@",conta ,i,[locpiano givemenomepiano]);

        }
        NSLog(@"Conto : %d",conta );
    }
}

- (IBAction) QuantificaEdifici              : (id)sender        {
    
}

- (IBAction) RecordTerreni2Destinazioni     : (id)sender        {
    int conta=0;
    NSLog(@"Tutti sono :  %lu ",[[[varbase TuttiImmobili] LTer] count] );
    
    for (int i=1; i<[[[varbase TuttiImmobili] LTer] count]; i++) {
        Terreno    * terer2 = [[[varbase TuttiImmobili] LTer] objectAtIndex:i];
        Terreno    * terer1 = [[[varbase TuttiImmobili] LTer] objectAtIndex:i-1];
           if (([[terer1 Foglio] isEqualToString:[terer2 Foglio]]) & ([[terer1 Particella] isEqualToString:[terer2 Particella] ]  ))
               conta = conta+1;
        
        
    }
    
    NSLog(@"- %d ",conta);

    
}

- (IBAction) CopiaPdfSelezinModed           : (id)sender {
/*
	for (int kj=0; kj<[[[[interface ContrPatrimonio] Intestatario] ListaPatrimonio] count]; kj++) {
	
	NSString * Nomecompleto = nil;
	NSString *nomedirro;
		Patrimonio *patrdaVeder =   [[[[interface ContrPatrimonio] Intestatario] ListaPatrimonio]  objectAtIndex:kj];
	NSMutableString *ParteSt = [[NSMutableString alloc] initWithCapacity:40];
	
	if ([patrdaVeder TipoEdiTerra]==0) 	{  // edificio
		[ParteSt appendFormat:	 @"_%@_%@_%@.",[patrdaVeder Foglio],[patrdaVeder Particella],[patrdaVeder Sub] ];
		nomedirro = @"/MacOrMap/Catasto/Fabbricati_pdf/"; 	
		NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
		bool trovato = NO;
		for (int j=0; j<contentsAtPath.count; j++) {  
			NSString *nomf = [contentsAtPath objectAtIndex:j];
			NSRange rg;
			rg = [nomf rangeOfString:ParteSt];
			if (rg.length>0) {	Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];trovato = YES;		break;		}
	    }
			// eccezione per il fatto che la proprieta' e' indicata con mulitparticlla sub mentre a visura e' su un singolo
		if (!trovato) {
			NSMutableString *ParteSt2 = [[NSMutableString alloc] initWithCapacity:40];
			[ParteSt2 appendFormat:	 @"_%@_%@_%@.",[patrdaVeder FoglioSingolo],[patrdaVeder ParticellaSingola],[patrdaVeder SubSingolo] ];
			for (int j=0; j<contentsAtPath.count; j++) {  
				NSString *nomf = [contentsAtPath objectAtIndex:j];
				NSRange rg;
				rg = [nomf rangeOfString:ParteSt2];
				if (rg.length>0) {
					Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
					trovato = YES;		break;
				}
			}
				// lo cerco con un solo part, sub ma e' in nome multipart e multi sub
			if (!trovato) {
					// trovare l'immobile in lista immobili e da li trovare il pdf
				Subalterno * subero = [[interface CtrEdi] SubaltConFgPartSub : [patrdaVeder FoglioSingolo] : [patrdaVeder ParticellaSingola] : [patrdaVeder SubSingolo]  ] ;
				if (subero !=nil) {
					NSMutableString *ParteSt2 = [[NSMutableString alloc] initWithCapacity:40];
					[ParteSt2 appendFormat:	 @"_%@_%@_%@.",[subero Foglio],[subero Particella],[subero Sub] ];
					for (int j=0; j<contentsAtPath.count; j++) {  
						NSString *nomf = [contentsAtPath objectAtIndex:j];
						NSRange rg;
						rg = [nomf rangeOfString:ParteSt2];
						if (rg.length>0) {
							Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
							trovato = YES;		break;
						}
					}
				}
			}
				// lo cerco con un solo part, sub ma e' in nome multipart e multi sub  FINE
		}
		
	}  else {  // terreno
		[ParteSt appendFormat:	 @"_%@_%@.",[patrdaVeder Foglio],[patrdaVeder Particella] ];
		nomedirro = @"/MacOrMap/Catasto/Terreni_pdf/"; 	
		NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:nomedirro error:NULL];
		for (int j=0; j<contentsAtPath.count; j++) {  
			NSString *nomf = [contentsAtPath objectAtIndex:j];
			NSRange rg;
			rg = [nomf rangeOfString:ParteSt];
			if (rg.length>0) {
				Nomecompleto = [[NSString alloc] initWithFormat:@"%@%@",nomedirro,nomf];
				break;
			}
			
		}	
		
		
	 }
	
	 if (Nomecompleto!=nil) NSLog(@"- %@ ",Nomecompleto); else  NSLog(@"Not Deter ");
 	 NSMutableString *nom2 = [[NSMutableString alloc] initWithCapacity:60];
	 [nom2 appendString: @"/MacOrMap/Moved/"];
	 [nom2 appendString: [Nomecompleto lastPathComponent]];

		NSLog(@". %@ ",nom2 );
		[[NSFileManager defaultManager] copyItemAtPath:Nomecompleto toPath:nom2 error:NULL];
		
	}

	
	
	
	/*
	NSMutableString *nom1 = [[NSMutableString alloc] initWithCapacity:60];
	[nom1 appendString: @"/Users/carlomacor/OldDownLoaded/DOC_Pippo.pdf"];

	
	
	
*/
	
}


- (IBAction) FormaAnagrafe           : (id)sender {
	[[varbase anagrafe] FormaAnagrafe];
	[[[varbase barilectr] ctrAnagrafe]   passaAnagrafe:[varbase anagrafe]] ;   
}

- (IBAction) InterpretazioneDirittiOneri : (id)sender {
	Proprietari * proper;
	Patrimonio * patrim;
	for (int i=0; i<[varbase Listaproprietari].count; i++) {
		proper = [[varbase Listaproprietari] objectAtIndex:i];
		for (int j=0; j<[proper	ListaPatrimonio].count; j++) {
			patrim = [[proper	ListaPatrimonio] objectAtIndex:j];
			[patrim InterpretaDirittiOneri];
		}
	}
	[varbase salvaListaProprietari:self];
}

- (IBAction) TrovaCasa               : (id)sender {

	Famiglia * family;
	Residente * resider;
		//	Subalterno * suber;
	Patrimonio  * patr;
	Proprietari *proper;
	int conta =0;
	int contaab =0;

	bool trovatacasa = NO;
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		trovatacasa = NO;
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		if ([family associatoedif]) continue;

			//	NSLog(@"-%@-",[family Via]);
		for (int j=0; j<[[family ListaComponenti] count]; j++) {
			resider = [[family ListaComponenti] objectAtIndex:j];
			for (int k=0; k<[[varbase Listaproprietari] count]; k++) {
				proper = [[varbase Listaproprietari] objectAtIndex:k];
		
				if ([[resider codFis] isEqualToString:[proper Codfis]]) {
					for (int k2=0; k2<[[proper ListaPatrimonio] count]; k2++) {
					
						patr  = [[proper ListaPatrimonio] objectAtIndex:k2];
						if ([patr TipoEdiTerra]==0)  {
								Subalterno * locsub = [ [[varbase barilectr] ctrEdi ]   SubaltConFgPartSub : [patr  Foglio ] : [patr  ParticellaSingola ] :[patr  SubSingolo ] ];
								if (locsub != nil) {
									if (![locsub iscasa]) continue;
									if ([locsub FlagAbitato]>0) continue;

									if ([[resider via] isEqualToString:[locsub  Via]]) {
											if ([[resider nr] isEqualToString:[locsub  Civico]]) {
											conta++;		//	NSLog(@"-%@-",[family Via]);
											contaab = contaab + [[family ListaComponenti] count];
										    [family setassociatoedif: YES];
												[family setFoglio:[locsub Foglio]];
												[family setParticella:[locsub ParticellaSingola]];
												[family setSub:[locsub SubSingolo]];
												
												[locsub setVia:[family Via]];
												[locsub setCivico:[family nr]];
												[locsub setConferma:6];
												
												
												locsub.FlagAbitato=1; // primacasa
											trovatacasa = YES;
											break ; //k2
											
											}										
									} 
										//								,[locsub Civico]]] ;		
								}
						}
					}
				}
				if (trovatacasa) break; // k
			}
			if (trovatacasa) break; // j
		}
	}
	NSLog(@"In Tutto Famiglie : %d",conta);
	NSLog(@"In Tutto Abitanti : %d",contaab);


	[[varbase anagrafe] salva: @"/MacOrMap/Catasto/Anafrafe.AnMap"];
	[[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];
	[[varbase TuttaTax] salva];
}  // TrovaCasa               

- (IBAction) TrovaCasa2              : (id)sender {
	Famiglia * family;
	Residente * resider;
	Subalterno * suber;
		//	Patrimonio  * patr;
	Tax_ele *taxer;
	int conta =0;
	int contaab =0;
	
	bool trovatacasa = NO;
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		trovatacasa = NO;
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		if ([family associatoedif]) continue;

		
			//		bool intest=NO;
			//	NSLog(@"-%@-",[family Via]);
		for (int j=0; j<[[family ListaComponenti] count]; j++) {
			resider = [[family ListaComponenti] objectAtIndex:j];
				//		    if (j==0) {	if ([[resider Cognome] isEqualToString:@"PIERAGOSTINI"]) intest=YES;}
				//			if (intest) {	NSLog(@"Via %@",[resider via]);	}
			
			
			for (int k=0; k<[[[varbase TuttaTax] ListaTarsuEle] count]; k++) {
				taxer = [[[varbase TuttaTax] ListaTarsuEle] objectAtIndex:k];
				
				if ([[resider codFis] isEqualToString:[taxer CodFis]]) {
					
								
					
				  for (int k2=0; k2<[[[varbase TuttiImmobili] ListaSubalterni] count]; k2++) {
					suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:k2];
					if (![suber iscasa]) continue;
 				    if ([suber FlagAbitato]>0) continue;
  
					if ([[resider via] isEqualToString:[suber  Via]]) {
						
							
					  if ([[resider nr] isEqualToString:[suber  Civico]]) {
	                    if ([suber FlagAbitato]==0  )  {
							if (![[taxer Foglio] isEqualToString:@""]) {
							  if ([[suber Foglio] isEqualToString:[taxer Foglio]]) {
								
							    if([suber IndSePresente : [taxer Foglio] :[taxer Particella] :[taxer Sub]]>=0) {
									conta++;		//	NSLog(@"-%@-",[family Via]);
									contaab = contaab + [[family ListaComponenti] count];
									trovatacasa = YES;
									
									[family setassociatoedif: YES];
									[family setFoglio:[suber Foglio]];
									[family setParticella:[suber ParticellaSingola]];
									[family setSub:[suber SubSingolo]];
									suber.FlagAbitato=2; // primacasa
									break ; //k2
					
								}
/*
								  
							   if ([[suber ParticellaSingola] isEqualToString:[taxer Particella]]) {
								if ([[suber SubSingolo] isEqualToString:[taxer Sub]]) {
										//		         NSLog(@"-%@-",[resider codFis]);
						         conta++;		//	NSLog(@"-%@-",[family Via]);
						         contaab = contaab + [[family ListaComponenti] count];
						         trovatacasa = YES;
									
									[family setassociatoedif: YES];
									[family setFoglio:[suber Foglio]];
									[family setParticella:[suber ParticellaSingola]];
									[family setSub:[suber SubSingolo]];
									suber.FlagAbitato=2; // primacasa
									
									
						         break ; //k2
								}
							   }
*/								  
								  
								  
							  }
							}
						}
					  }
					}
				  }
				}
				if (trovatacasa) break; // k
			}
			if (trovatacasa) break; // j
		}
	}
	NSLog(@"In Tutto Famiglie : %d",conta);
	NSLog(@"In Tutto Abitanti : %d",contaab);
	conta = 0;
	contaab = 0;
	int abitantinum=0;
	
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		abitantinum = abitantinum+[[family ListaComponenti] count];
		if ([family associatoedif]) {
			conta ++;
			contaab = contaab+[[family ListaComponenti] count];
 	    }
	}		
	NSLog(@"-------------------");
	NSLog(@"Famiglie casate: %d",conta);
	NSLog(@"Abitanti casati: %d",contaab);
	NSLog(@"Famiglie  in tutto: %d",[[[varbase anagrafe] ListaFamiglie] count]);
	NSLog(@"Residenti in tutto: %d",abitantinum);

/*
	 [[varbase anagrafe] salva: @"/MacOrMap/Catasto/Anafrafe.AnMap"];
	 [[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];
	 [[varbase TuttaTax] salva];
 */
} // TrovaCasa2

- (IBAction) TrovaCasaQ               : (id)sender {
/*
 Famiglia * family;
	Residente * resider;
		//	Subalterno * suber;
	Patrimonio  * patr;
	Proprietari *proper;
	int conta =0;
	int contaab =0;
	NSMutableArray *loclistaCase = [[NSMutableArray alloc] initWithCapacity:40];
	
	bool trovatacasa = NO;
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		trovatacasa = NO;
		
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		if ([family associatoedif]) continue;
		[loclistaCase removeAllObjects];
			//	NSLog(@"-%@-",[family Via]);
		for (int j=0; j<[[family ListaComponenti] count]; j++) {
			resider = [[family ListaComponenti] objectAtIndex:j];
			for (int k=0; k<[[varbase Listaproprietari] count]; k++) {
				proper = [[varbase Listaproprietari] objectAtIndex:k];
				
				if ([[resider codFis] isEqualToString:[proper Codfis]]) {
					for (int k2=0; k2<[[proper ListaPatrimonio] count]; k2++) {
						
						patr  = [[proper ListaPatrimonio] objectAtIndex:k2];
						if ([patr TipoEdiTerra]==0)  {
							Subalterno * locsub = [ [interface CtrEdi]  SubaltConFgPartSub : [patr  Foglio ] : [patr  ParticellaSingola ] :[patr  SubSingolo ] ];
							if ([locsub FlagAbitato]!=0)  continue;
							if (locsub != nil) {
								if (![locsub iscasa]) continue;
								if ([locsub FlagAbitato]>0) continue;

								if ([[resider via] isEqualToString:[locsub  Via]]) {
									bool giamessa=NO;
									Subalterno * locsubtest; 
									for (int h=0; h<[loclistaCase count]; h++) {
										locsubtest =[loclistaCase objectAtIndex:h];
										if ([locsub isEqual:locsubtest]) giamessa=YES;
									}
									if (!giamessa) [loclistaCase addObject:locsub];
									} 
									//								,[locsub Civico]]] ;		
							}
						}
					}
				}
				if (trovatacasa) break; // k
			}
			if (trovatacasa) break; // j
		}
		
		if ([loclistaCase count]==1) { conta ++; contaab = contaab+[family ListaComponenti].count;
			Subalterno * locsub = [loclistaCase objectAtIndex:0];
			[family setassociatoedif: YES];
			[family setFoglio:[locsub Foglio]];
			[family setParticella:[locsub ParticellaSingola]];
			[family setSub:[locsub SubSingolo]];
			[locsub setVia:[family Via]];
			[locsub setCivico:[family nr]];
			[locsub setConferma:6];
			locsub.FlagAbitato=1; // primacasa
			
		}
			//		NSLog(@"Tot Case : %d",[loclistaCase count]);
	}  // i
	NSLog(@"In Tutto Famiglie : %d",conta);
	NSLog(@"In Tutto Abitanti : %d",contaab);
	NSLog(@"-------------------");

	 [[varbase anagrafe] salva: @"/MacOrMap/Catasto/Anafrafe.AnMap"];
	 [[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];
	 [[varbase TuttaTax] salva];
	*/
} // TrovaCasaQ


- (IBAction) TrovaCasa2Q              : (id)sender {
	Famiglia * family;
	Residente * resider;
	Subalterno * suber;
		//	Patrimonio  * patr;
	Tax_ele *taxer;
	int conta =0;
	int contaab =0;
	NSMutableArray *loclistaCase = [[NSMutableArray alloc] initWithCapacity:40];

	bool trovatacasa = NO;
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		trovatacasa = NO;
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		if ([family associatoedif]) continue;
		[loclistaCase removeAllObjects];

			//	NSLog(@"-%@-",[family Via]);
		for (int j=0; j<[[family ListaComponenti] count]; j++) {
			resider = [[family ListaComponenti] objectAtIndex:j];
			for (int k=0; k<[[[varbase TuttaTax] ListaTarsuEle] count]; k++) {
				taxer = [[[varbase TuttaTax] ListaTarsuEle] objectAtIndex:k];
				if ([[resider codFis] isEqualToString:[taxer CodFis]]) {
					for (int k2=0; k2<[[[varbase TuttiImmobili] ListaSubalterni] count]; k2++) {
						suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:k2];
						if (![suber iscasa]) continue;
						if ([suber Conferma]>=2) continue;

						if ([[resider via] isEqualToString:[suber  Via]]) {
							bool giamessa=NO;
							Subalterno * locsubtest; 
							for (int h=0; h<[loclistaCase count]; h++) {
								locsubtest =[loclistaCase objectAtIndex:h];
								if ([suber isEqual:locsubtest]) giamessa=YES;
							}
							if (!giamessa) [loclistaCase addObject:suber];
						}
					}
				}
				if (trovatacasa) break; // k
			}
			if (trovatacasa) break; // j
		}
		NSLog(@"%d",[loclistaCase count]);			
		
		if ([loclistaCase count]==1) { conta++;
			NSLog(@"%d",conta);			
			conta ++; contaab = contaab+[family ListaComponenti].count;
			Subalterno * locsub = [loclistaCase objectAtIndex:0];
			[family setassociatoedif: YES];
			[family setFoglio:[locsub Foglio]];
			[family setParticella:[locsub ParticellaSingola]];
			[family setSub:[locsub SubSingolo]];
			locsub.FlagAbitato=5; // primacasa
		}
	}
	NSLog(@"In Tutto Famiglie : %d",conta);
	NSLog(@"In Tutto Abitanti : %d",contaab);
	conta = 0;
	contaab = 0;
	int abitantinum=0;
	
	for (int i=0; i<[[[varbase anagrafe] ListaFamiglie] count]; i++) {
		family = [[[varbase anagrafe] ListaFamiglie] objectAtIndex:i];
		abitantinum = abitantinum+[[family ListaComponenti] count];
		if ([family associatoedif]) {
			conta ++;
			contaab = contaab+[[family ListaComponenti] count];
 	    }
	}		
	NSLog(@"-------------------");
	NSLog(@"Famiglie casate: %d",conta);
	NSLog(@"Abitanti casati: %d",contaab);
	NSLog(@"Famiglie  in tutto: %d",[[[varbase anagrafe] ListaFamiglie] count]);
	NSLog(@"Residenti in tutto: %d",abitantinum);
/*	
	[[varbase anagrafe] salva: @"/MacOrMap/Catasto/Anafrafe.AnMap"];
	[[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];
	[[varbase TuttaTax] salva];
*/	
	
}


- (IBAction) ToglispaziCiviciEdi     : (id)sender {
    
	Subalterno    * suber;
	char c ; 
	NSMutableString * momciv = [[NSMutableString alloc] initWithCapacity:10];
	for (int i=0; i<[[[varbase TuttiImmobili] ListaSubalterni] count]; i++) {
		suber = [[[varbase TuttiImmobili] ListaSubalterni] objectAtIndex:i];
        [momciv setString:@""];
		for (int i=0; i<[[suber Civico] length ]; i++) {
			c = [[suber Civico] characterAtIndex:i];
			if (c!=32) {
				[momciv	appendFormat:@"%c",c];
			}
		}
		NSString * momerciv = [[NSString alloc] initWithString:momciv];
		
			//	[[suber Civico] release];
			//		[[suber Civico] initWithString:momciv];
			//		[[suber Civico] retain];
		[suber setCivico:momerciv];

		
			//		[suber setCivico:momciv];
			//		NSLog(@"-%@-%@-",[suber Civico],momciv);
		
	}
				[[varbase TuttiImmobili] salva:@"/MacOrMap/Catasto/Immobili.CATMacorMap"];
} 


- (IBAction) CInfoTaxTerreno          : (id)sender {
	if (!varbase.giacaricatoCat) {   [varbase caricaDatiCAT]; }
	if ([varbase comando]== kStato_InfoTaxTerreno) {[[varbase ListaSelezTerreni] removeAllObjects]; [progetto display];	}
	[progetto chiusuracomandoprecedente];
	[varbase  comandodabottone : kStato_InfoTaxTerreno ];
}



@end
