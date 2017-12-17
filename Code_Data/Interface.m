//
//  Interface.m
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "Interface.h"
#import "Varbase.h"
#import "DisegnoR.h"
#import <Cocoa/Cocoa.h>


@implementation Interface

- (void) InitInterface                                            {
	MUndor = [NSUndoManager alloc]; [MUndor init];

	NSRect actionrect = [ESComandoFase frame];		// actionrect.origin.x += 30;
	NSRect zoomrect   = [ESZoom1 frame];
	actionrect.size.width = (zoomrect.origin.x- actionrect.origin.x)-10 ;
	
	[ESComandoFase setFrame: actionrect];
	[ESComandoFase setWidth:actionrect.size.width*270/800.0   forSegment:0];
	[ESComandoFase setWidth:(actionrect.size.width*530/800.0-10)   forSegment:1];
	
	
	[self UpStateRasterBut : NO];
	[self UpStateVectorBut : NO];
	attivomenu = NO;
		//	[bCalVet  setHidden:YES];
	
		//	if 	[ESZoom1 setFrame:];

}

- (NSUndoManager  *) MUndor {
	return MUndor;
}


- (NSTextField    *) txtdlgQuantificatori {
	return txtdlgQuantificatori;
}








- (NSTextField    *) txtPassword {
	return txtPassword;
}


- (void) setlabelComando : (NSString *) msgstr                    {
			[ESComandoFase setLabel:msgstr forSegment:0];
}

- (void) setlabelAzione  : (NSString *) msgstr                    {
			[ESComandoFase setLabel:msgstr forSegment:1];
}


- (void) AggiornamentoNuovoProgetto {
	[interfacewindow AggiornamentoNuovoProgetto];
}

- (void) AggiornaInterfaceComandoAzione : (int) com : (int) fase  {
	
	[interfacewindow AggiornaInterfaceComandoAzione:com:fase];
	
		// gruppo Raster
	[RBZoomRasAll      setState:0];
	[RBAddRas          setState:0];
	[RBLessRas         setState:0];
	[RBMovOrRasAll     setState:0];
	[RBMovOrR2ptAll    setState:0];
	
		// singolo Raster
	[RBZoomRas         setState:0];
	[RBAddSubRas       setState:0];
	[RBLessSubRas      setState:0];

	[RBMovOrRas        setState:0];
	[RBMovOrR2pt       setState:0];
	[RBRigRas          setState:0];
	[RBRotScaRas       setState:0];
	[RBRas0gr          setState:0];
	[RBCalRasBar       setState:0];
    [RBCalRasBarFix    setState:0];
	[RBCropRas         setState:0];
	[RBMaskRas         setState:0];

    [VBMoveDis         setState:0];
        //   [VBRotDis          setState:0];
        //    [VBScaDis          setState:0];
	
	
		// calibrazione fine
		//	[RBCenCalRas       setState:0];
	[VBCenCalVet       setState:0];
	
		// Catasto
	[BFoglio       setState:0];


	for (int i=0; i<4; i++) { [VSegDis1 setSelected:NO  forSegment:i];  }
	for (int i=0; i<4; i++) { [VSegDis2 setSelected:NO  forSegment:i];  }
	for (int i=0; i<6; i++) { [ESZoom1  setSelected:NO  forSegment:i];  }
	for (int i=0; i<6; i++) { [ESZoom2  setSelected:NO  forSegment:i];  }

	for (int i=0; i<5; i++) { [SVEdit1  setSelected:NO  forSegment:i];  }
	for (int i=0; i<5; i++) { [SVEdit2  setSelected:NO  forSegment:i];  }
	for (int i=0; i<4; i++) { [SVEdit3  setSelected:NO  forSegment:i];  }
	
	[VBInfoLeg setState:0];
	[VBInfoInt2Polyg setState:0];

	[LevelIndicatore setHidden:YES];
	
	
	[self setlabelComando:@"Comando"];
	[self setlabelAzione :@"Azione"];
	
	switch (com) {
				// vista
	  case kStato_zoomWindow             : [ESZoom1  setSelected:YES  forSegment:2];	[ESZoom2  setSelected:YES   forSegment:2];	break;
	  case kStato_zoomC                  : [ESZoom1  setSelected:YES  forSegment:3];	[ESZoom2  setSelected:YES   forSegment:3];	break;
	  case kStato_Pan                    : [ESZoom1  setSelected:YES  forSegment:6];	[ESZoom2  setSelected:YES   forSegment:6];	break;

			
				// gruppo Raster
	  case kStato_spostaRaster_tutti       : [RBMovOrRasAll    setState:1];	  break;	
	  case kStato_spostaRaster2pt_tutti    : [RBMovOrR2ptAll   setState:1];	  break;
				// singolo Raster
 	  case kStato_spostaRaster_uno         : [RBMovOrRas       setState:1];	  break;	
	  case kStato_spostaRaster2pt_uno      : [RBMovOrR2pt      setState:1];	  break;	
	  case kStato_scalarighello	           : [RBRigRas         setState:1];	  break;
	  case kStato_rotoscalaraster          : [RBRotScaRas      setState:1];	  break;
	  case kStato_calibra8click            : [RBcal8pt         setState:1];   break;
	  case kStato_Calibraraster			   : [RBCalRasBar      setState:1];   break;
 	  case kStato_CalibrarasterFix		   : [RBCalRasBarFix   setState:1];   break;
				//	  case kStato_FixCentroRot             : [RBCenCalRas      setState:1];   break;

	  case kStato_FixVCentroRot            : [VBCenCalVet      setState:1];   break;

				// vettoriale
		case kStato_Punto      			   : [VSegDis1         setSelected:YES forSegment:0]; break;
		case kStato_Polilinea              : [VSegDis1         setSelected:YES forSegment:1]; break;
		case kStato_Poligono               : [VSegDis1         setSelected:YES forSegment:2]; break;
		case kStato_Regione                : [VSegDis1         setSelected:YES forSegment:3]; break;

		case kStato_Rettangolo             : [VSegDis2         setSelected:YES forSegment:1]; break;
		case kStato_Cerchio                : [VSegDis2         setSelected:YES forSegment:2]; break;
		case kStato_Testo                  : [VSegDis2         setSelected:YES forSegment:3]; break;
		case kStato_Simbolo                : [VSegDis2         setSelected:YES forSegment:0]; break;
				//		case kStato_Splinea                : [VSegDis2         setSelected:YES forSegment:1]; break;
				//		case kStato_Spoligono              : [VSegDis2         setSelected:YES forSegment:2]; break;
				//		case kStato_Sregione               : [VSegDis2         setSelected:YES forSegment:3]; break;

	    case kStato_SpostaDisegno          : [VBMoveDis        setState:1];  break;
                //		case kStato_RuotaDisegno           : [VBRotDis         setState:1];  break;
                //		case kStato_ScalaDisegno           : [VBScaDis         setState:1];  break;

		case kStato_Seleziona              : [SVEdit1          setSelected:YES forSegment:0]; break;
		case kStato_Match                  : [SVEdit1          setSelected:YES forSegment:2]; break;
		case kStato_Info                   : [SVEdit1          setSelected:YES forSegment:3]; break;
		case kStato_InfoSup                : [SVEdit1          setSelected:YES forSegment:4]; break;
            
		case kStato_CancellaSelected       : [SVEdit2          setSelected:YES forSegment:4]; break;
		case kStato_SpostaSelected         : [SVEdit2          setSelected:YES forSegment:0]; break;
		case kStato_CopiaSelected          : [SVEdit2          setSelected:YES forSegment:1]; break;
		case kStato_RuotaSelected          : [SVEdit2          setSelected:YES forSegment:2]; break;
		case kStato_ScalaSelected          : [SVEdit2          setSelected:YES forSegment:3]; break;
		case kStato_SpostaVertice 		   : [SVEdit3          setSelected:YES forSegment:0]; break;
		case kStato_InserisciVertice       : [SVEdit3          setSelected:YES forSegment:1]; break;
		case kStato_CancellaVertice        : [SVEdit3          setSelected:YES forSegment:2]; break;
		case kStato_EditSpVt               : [SVEdit3          setSelected:YES forSegment:3]; break;

			
				// Catasto
		case kStato_TarquiniaFogliopt        : [BFoglio      setState:1];   break;
			
			
		case kStato_InfoLeg                  : [VBInfoLeg      setState:1];   break;

		case kStato_InfoIntersezione2Poligoni: [VBInfoInt2Polyg      setState:1];   break;

			
	}
	
		//////////////////////////////////////////////////////////
	
	
	switch (com) {
				// Viste
	  case kStato_zoomWindow               : [self setlabelComando:@"Zoom Finestra"];
			if (fase==0)	[self setlabelAzione:@"Inserire 1^ Angolo"];	else [self setlabelAzione:@"Inserire 2^ Angolo"]; 	
	    break;
	  case kStato_zoomC                    : [self setlabelComando:@"Zoom Centro"];
                            [self setlabelAzione:@"Indica Nuovo Centro della Vista"];
		break;
	  case kStato_Pan                      : [self setlabelComando:@"Pan"];
			if (fase==0)	[self setlabelAzione:@"Inserire 1^ Posizione"];	else [self setlabelAzione:@"Inserire 2^ Posizione"]; 	
		break;
			
  	  // comandi raster
 	  case kStato_spostaRaster_tutti     : [self setlabelComando:@"Sposta Gruppo Immagini"];
	  	    if (fase==0)	[self setlabelAzione:@"Inserire 1^ Posizione"];	else [self setlabelAzione:@"Inserire 2^ Posizione"]; 	
		break;
	  case kStato_spostaRaster2pt_tutti  : [self setlabelComando:@"Sposta Gruppo"];
			                [self setlabelAzione:@"Inserire 1^ Posizione e dare coordinate in dialog"];
		break;
	  case kStato_spostaRaster_uno       : [self setlabelComando:@"Sposta Immagine"];
			if (fase==0)	[self setlabelAzione:@"Inserire 1^ Posizione"];	else [self setlabelAzione:@"Inserire 2^ Posizione"]; 	
		break; 
	  case kStato_rotoScal2PtCentrato  : [self setlabelComando:@"Calibra Centrato con 2^ Punto"];
			[self setlabelAzione:@"Inserire Posizione e dare coordinate in dialog"];
		break;
			
	  case kStato_spostaRaster2pt_uno    : [self setlabelComando:@"Sposta Immagine"];
			                [self setlabelAzione:@"Inserire 1^ Posizione e dare coordinate in dialog"];
		break;
	  case kStato_scalarighello          : [self setlabelComando:@"Righello"];
			switch (fase) { 
				  case 0 :  [self setlabelAzione:@"Inserisci 1^ Punto"];                 break;
				  case 1 :  [self setlabelAzione:@"Inserisci 2^ Punto"];                 break;
				  case 2 :  [self setlabelAzione:@"Inserisci Nuova Distanza in dialog"]; break;
			}
		break;
	  case kStato_rotoscalaraster        : [self setlabelComando:@"Ruota e Scala Immagine con 2 segmenti"];
			switch (fase) {
				  case 0 :  [self setlabelAzione:@"1^ Punto Attuale"];  break;
				  case 1 :  [self setlabelAzione:@"2^ Punto Attuale"];  break;
				  case 2 :  [self setlabelAzione:@"1^ Punto Futuro"];   break;
				  case 3 :  [self setlabelAzione:@"2^ Punto Futuro"];   break;
			}
		break;	
	  case kStato_calibra8click          : [self setlabelComando:@"Calibra a 8 Punti"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ Punto Attuale"]; break;
				case 1 :[self setlabelAzione:@"1^ Punto Futuro"];  break;
				case 2 :[self setlabelAzione:@"2^ Punto Attuale"]; break;
				case 3 :[self setlabelAzione:@"2^ Punto Futuro"];  break;
				case 4 :[self setlabelAzione:@"3^ Punto Attuale"]; break;
				case 5 :[self setlabelAzione:@"3^ Punto Futuro"];  break;
				case 6 :[self setlabelAzione:@"4^ Punto Attuale"]; break;
				case 7 :[self setlabelAzione:@"4^ Punto Futuro"];  break;
			}		
	    break;	
	  case kStato_Calibraraster          : [self setlabelComando:@"Calibra Raster"];
			switch (fase) { 
				case 0 :  [self setlabelAzione:@"completare la dialog"]; break;
				case 1 :  [self setlabelAzione:@"Inserisci X1 a schermo "]; break;
				case 2 :  [self setlabelAzione:@"Inserisci X2 a schermo "]; break;
				case 3 :  [self setlabelAzione:@"Inserisci Y1 a schermo "]; break;
				case 4 :  [self setlabelAzione:@"Inserisci Y2 a schermo "]; break;
			}
		break;
			
		case kStato_CalibrarasterFix	 : [self setlabelComando:@"Calibra Raster"];
			switch (fase) { 
				case 0 :  [self setlabelAzione:@"completare la dialog"]; break;
				case 1 :  [self setlabelAzione:@"Inserisci X1 a schermo "]; break;
				case 2 :  [self setlabelAzione:@"Inserisci Y1 a schermo "]; break;
			}
		break;
	  case kStato_FixCentroRot           : [self setlabelComando:@"Centro di Rotazione"];
			                 [self setlabelAzione:@"Inserire Posizione del centro"];
		break;
			
			
  		       // comandi vettoriali
	  case kStato_Punto                  : [self setlabelComando:@"Punto"]; 
			                 [self setlabelAzione:@"Click mouse"];	
		break;
	  case kStato_Polilinea              : [self setlabelComando:@"Polilinea"]; 
			                 [self setlabelAzione:@"Inserire vertice"];	
		break;
	  case kStato_Poligono               : [self setlabelComando:@"Poligono"]; 
			                 [self setlabelAzione:@"Inserire vertice"];	
		break;
 	  case kStato_Regione                : [self setlabelComando:@"Regione"]; 
			                 [self setlabelAzione:@"Inserire vertice"];	
		break;
			
	  case kStato_Cerchio                : [self setlabelComando:@"Cerchio"]; 
			                 [self setlabelAzione:@"Centro e Raggio"];	
		break;
	  case kStato_Testo                  : [self setlabelComando:@"Testo"]; 
							 [self setlabelAzione:@"Indica Posizione"];	 
		break;
	  case kStato_TestoRot               : [self setlabelComando:@"Testo Ruotato"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"Indica Posizione"];	 break;
				case 1 :[self setlabelAzione:@"Indica Angolo"];	     break;
			}
			break;
	  case kStato_TestoRotSca            : [self setlabelComando:@"Testo ruota e scala"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"Indica Posizione"];	 break;
				case 1 :[self setlabelAzione:@"Indica Angolo"];	     break;
				case 2 :[self setlabelAzione:@"Indica Altezza"];	 break;
			}
			break;
			
	  case	kStato_PtTastiera : [self setlabelComando:@"Punto da Tastiera"];
		                        [self setlabelAzione:@"Inserire Posizione in Dialog"];	
			break;
  	  case kStato_Simbolo                : [self setlabelComando:@"Simbolo"]; 
			[self setlabelAzione:@"inserire  posizione"];	
		break;
		case kStato_SimboloFisso         : [self setlabelComando:@"Simbolo dimensione fissa"]; 
			[self setlabelAzione:@"inserire  posizione"];	
			break;
		case kStato_SimboloRot           : [self setlabelComando:@"Simbolo ruotato"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"inserire  posizione"];	 break;
				case 1 :[self setlabelAzione:@"Indica Angolo"];	     break;
			}
			break;
		case kStato_SimboloRotSca        : [self setlabelComando:@"Simbolo ruotato scalato"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"inserire  posizione"];	         break;
				case 1 :[self setlabelAzione:@"Indica Angolo"];	     break;
				case 2 :[self setlabelAzione:@"Indica ingrandimento"];	     break;
			}
			break;
			
			
	  case kStato_Splinea                : [self setlabelComando:@"Splinea"]; 
			[self setlabelAzione:@"1^ vertice"];	
		break;
	  case kStato_Spoligono              : [self setlabelComando:@"Splinea chiusa"]; 
			[self setlabelAzione:@"1^ vertice"];	
		break;
	  case kStato_Sregione               : [self setlabelComando:@"Regione Spline"]; 
			[self setlabelAzione:@"1^ vertice"];	
		break;
	  case kStato_Rettangolo             : [self setlabelComando:@"Rettangolo"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ vertice"];	 break;
				case 1 :[self setlabelAzione:@"2^ vertice"];	 break;
			}
		break;
  	  case kStato_CatPoligono               : [self setlabelComando:@"Costruzione Poligono"]; 
			[self setlabelAzione:@"Inserire vertice"];	
			break;
		case kStato_Righello             : [self setlabelComando:@"Righello"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"Punto di partenza"];	 break;
			}
		break;
		case kStato_SpostaDisegno        : [self setlabelComando:@"Sposta Disegno"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"Posizione Iniziale"];	 break;
				case 1 :[self setlabelAzione:@"Posizione Finale"];	 break;
			}
		break;
			
		case kStato_FixVCentroRot           : [self setlabelComando:@"Centro di Rotazione Disegno"];
			[self setlabelAzione:@"Inserire Posizione del centro"];
			break;
			
			
			
		case kStato_Seleziona            :	[self setlabelComando:@"Seleziona"]; 
			[self setlabelAzione:@"Seleziona oggetti"];
			break;
		case kStato_Deseleziona          :	[self setlabelComando:@"Deseleziona"]; 
			[self setlabelAzione:@""];
			break;
			
		case kStato_CancellaSelected     :	[self setlabelComando:@"Cancella"]; 
			[self setlabelAzione:@"cancella i selezionati"];
			break;
		case kStato_SpostaSelected       :	[self setlabelComando:@"Sposta Selezionati"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ vertice"];	 break;
				case 1 :[self setlabelAzione:@"2^ vertice"];	 break;
			}
			break;
		case kStato_CopiaSelected        :	[self setlabelComando:@"Copia selezionati"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ vertice"];	 break;
				case 1 :[self setlabelAzione:@"2^ vertice"];	 break;
			}
			break;
		case kStato_RuotaSelected        :	[self setlabelComando:@"Ruota selezionati"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ vertice"];	 break;
				case 1 :[self setlabelAzione:@"2^ vertice"];	 break;
			}
			break;
		case kStato_ScalaSelected        :	[self setlabelComando:@"Scala Selezionati"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"1^ vertice"];	 break;
				case 1 :[self setlabelAzione:@"2^ vertice"];	 break;
			}
			break;
		case kStato_SpostaVertice        :	[self setlabelComando:@"Sposta Vertice"]; 
				//	[self dispallinispline];
			switch (fase) {
				case 0 :[self setlabelAzione:@"seleziona vertice "];	 break;
				case 1 :[self setlabelAzione:@"nuova posizione"];	 break;
			}
			break;
		case kStato_InserisciVertice     :	[self setlabelComando:@"Inserisci Vertice"]; 
				//			[self dispallinispline];
			switch (fase) {
				case 0 :[self setlabelAzione:@"seleziona segmento polilinea"];	 break;
				case 1 :[self setlabelAzione:@"nuova posizione"];	 break;
			}
			break;
		case kStato_CancellaVertice      :	[self setlabelComando:@"Cancella Vertice"]; 
				//			[self dispallinispline];
            [self setlabelAzione:@"seleziona vertice di una polilinea"];
			break;
	
		case kStato_EditSpVt             :	[self setlabelComando:@"Edit Spline"]; 
				//		[progetto dispallinispline];
            [self setlabelAzione:@"seleziona vertice di una spline"];
			break;
		case kStato_Info                 :	[self setlabelComando:@"Info"]; 
            [self setlabelAzione:@"seleziona elemento"];
			break;
		case kStato_InfoSup                 :	[self setlabelComando:@"Info Superficie"]; 
            [self setlabelAzione:@"Indicare punto interno"];
			break;
			
		case kStato_InfoLeg                 :	[self setlabelComando:@"Info Area del Disegno"]; 
            [self setlabelAzione:@"Indicare punto interno"];
			break;

		case kStato_InfoIntersezione2Poligoni:	[self setlabelComando:@"Info Area Intersezione due Poligoni"]; 
            [self setlabelAzione:@"Indicare punto interno ai due Poligoni"];
			break;
			
			
			
		case kStato_InfoEdificio                 :	[self setlabelComando:@"Info Edificio"]; 
            [self setlabelAzione:@"Indicare punto interno"];
			break;			
			
		case kStato_Match:
				//			[Seg_edit1 setSelected:YES  forSegment:2];
			[self setlabelComando:@"Vai al piano"]; 
            [self setlabelAzione:@"seleziona elemento"];
			break;
			
			
		case kStato_TarquiniaFogliopt :
			[self setlabelComando:@"Apri foglio catastale"];           [self setlabelAzione:@"indica punto interno QuadroUnione"];
			break;
		
			
		case kStato_RettangoloStampa     :
		case kStato_RettangoloDoppioStampa :
			[self setlabelComando:@"Definisci la zona da stampare"]; 
			switch (fase) {
				case 0 :[self setlabelAzione:@"Inserire primo angolo Rettangolo"];	 break;
				case 1 :[self setlabelAzione:@"Inserire opposto angolo del Rettangolo"];	 break;
			}
		break;
			
			
			
		default :	[self setlabelComando:@""];   [self setlabelAzione:@""];             break;  
			
			
			
	}
	
	
	
	
}

- (void) txtInterfaceComandoAzione:(NSString *) msg{
	 [self setlabelAzione:msg]; 
}

- (void) upinterfacevector  :  (bool) activVecor                  {
	[mnewpiano   setEnabled:activVecor];
	[mclosedis   setEnabled:activVecor];
	[msavedis    setEnabled:activVecor];
	[mexpdis     setEnabled:activVecor];
	[mdisegna    setEnabled:activVecor];
	[mgesdis     setEnabled:activVecor];
	[meditdis    setEnabled:activVecor];
	[meditsel    setEnabled:activVecor];
	[meditvt     setEnabled:activVecor];
	[minfo       setEnabled:activVecor];
	[FtxtRot     setHidden :!activVecor];
	[FtxtScala   setHidden :!activVecor];
	[FtxtRot     setHidden :!activVecor];
	[Ftxoffx     setHidden :!activVecor];
	[Ftxoffy     setHidden :!activVecor];
}


- (void) upinterfaceraster  :  (bool) activRaster                 {
	[mapriimg      setEnabled:activRaster];
	[mchiudigruppo setEnabled:activRaster];
	[mchiudiimg    setEnabled:activRaster];
	[maddimg       setEnabled:activRaster];
	[mspostarast   setEnabled:activRaster];
	[mcalibra      setEnabled:activRaster];
	[msalvaraster  setEnabled:activRaster];
}



- (void) UpStateRasterBut               :(bool) stat              {
		// gruppo  Raster
	float alp =1.0;
	if (stat==NSOffState) { alp=0.3; [RKVisRas         setState:stat];	[RKVisSubRas         setState:stat];	}
	[RBMovOrRasAll       setEnabled:stat]; [RBMovOrRasAll        setAlphaValue:alp]; 
	[RBMovOrR2ptAll      setEnabled:stat]; [RBMovOrR2ptAll       setAlphaValue:alp];
	[RBZoomRasAll        setEnabled:stat]; [RBZoomRasAll       setAlphaValue:alp];
	
		//	[RBAddRas            setEnabled:stat];
	[RBLessRas           setEnabled:stat];	[RBLessRas           setAlphaValue:alp];
	[RKVisRas            setEnabled:stat];
	[rslras              setEnabled:stat];  // [rslras           setAlphaValue:alp];
	[RPopListRas         setEnabled:stat]; 	[RPopListRas         setAlphaValue:alp*3/2];
	[rckback             setEnabled:stat];	[rckback             setAlphaValue:alp];
	[RBZoomRas           setEnabled:stat];	[RBZoomRas           setAlphaValue:alp];
	[RBAddSubRas         setEnabled:stat];	[RBAddSubRas         setAlphaValue:alp];
	[RBLessSubRas        setEnabled:stat];	[RBLessSubRas        setAlphaValue:alp];
	[RKVisSubRas         setEnabled:stat];	
	[RPopListSubRas      setEnabled:stat];	[RPopListSubRas      setAlphaValue:alp*3/2];
	[RBcolrast           setEnabled:stat];  [RBcolrast           setAlphaValue:alp];


	
		//	[Thumraster  setEnabled:stat];
	[RBMovOrRas          setEnabled:stat];  [RBMovOrRas          setAlphaValue:alp];
	[RBMovOrR2pt         setEnabled:stat];  [RBMovOrR2pt         setAlphaValue:alp];
	[RBRigRas            setEnabled:stat];  [RBRigRas            setAlphaValue:alp];
	[RBRotScaRas         setEnabled:stat];  [RBRotScaRas         setAlphaValue:alp];
	[RBRas0gr            setEnabled:stat];  [RBRas0gr            setAlphaValue:alp];
	[RBCalRasBar         setEnabled:stat];  [RBCalRasBar         setAlphaValue:alp];
	[RBCropRas           setEnabled:stat];  [RBCropRas           setAlphaValue:alp];
	[RBMaskRas           setEnabled:stat];  [RBMaskRas           setAlphaValue:alp];
	[rslsubras           setEnabled:stat];  [rslsubras           setAlphaValue:alp];
	[RBRas1Sca           setEnabled:stat];  [RBRas1Sca           setAlphaValue:alp];
	[RBcal8pt            setEnabled:stat];  [RBcal8pt            setAlphaValue:alp];
		//	[RBCenCalRas         setEnabled:stat];  [RBCenCalRas         setAlphaValue:alp];
	[RB0Rot              setEnabled:stat];  [RB0Rot              setAlphaValue:alp];
	[RB0Sca              setEnabled:stat];  [RB0Sca              setAlphaValue:alp];

	
	
	
	[RBCalRasBarFix      setEnabled:stat];  [RBCalRasBarFix      setAlphaValue:alp];
	[RBCropRectRas       setEnabled:stat];  [RBCropRectRas       setAlphaValue:alp];
	
	[txtDimxyraster  setAlphaValue:alp];
	
	
	[interfacewindow AggiornaInterfacciaRaster:stat];
	
}	
	
- (void) UpStateVectorBut               :(bool) stat              {
	float alp =1.0;
	if (stat==NSOffState) { alp=0.3; [VckVisDis         setState:stat];	[VckVisPiano         setState:stat];	}
		//	VBNewDis;
		//	VBAddDis;

	[VBTogliDis            setEnabled:stat];  [VBTogliDis            setAlphaValue:alp];
	[VBNewPiano            setEnabled:stat];  [VBNewPiano            setAlphaValue:alp];
	[VBSaveDis             setEnabled:stat];  [VBSaveDis             setAlphaValue:alp];

	
	[VSlAlphLineDis        setEnabled:stat];  [VSlAlphLineDis        setAlphaValue:alp];
	[VSlAlphSupDis         setEnabled:stat];  [VSlAlphSupDis         setAlphaValue:alp];
	[VBzoomDis             setEnabled:stat];  [VBzoomDis             setAlphaValue:alp];
	[VSegSnapDis           setEnabled:stat];  [VSegSnapDis           setAlphaValue:alp];
	[VBDlgVect             setEnabled:stat];  [VBDlgVect             setAlphaValue:alp];
	[VckVisDis             setEnabled:stat];  
	[VPopListDis           setEnabled:stat];  [VPopListDis           setAlphaValue:alp];
	[img1l             setAlphaValue:alp]; 
	[img1s             setAlphaValue:alp];  
	[img2l             setAlphaValue:alp];
	[img2s             setAlphaValue:alp];  
	[VSlAlphLinePiano       setEnabled:stat];  [VSlAlphLinePiano     setAlphaValue:alp];
	[VSlAlphSupPiano        setEnabled:stat];  [VSlAlphSupPiano      setAlphaValue:alp];
        //                               [Thumvector           setAlphaValue:alp];
	[VckVisPiano            setEnabled:stat];  
	[VBzoomPiano            setEnabled:stat];  [VBzoomPiano          setAlphaValue:alp];
	[VSegSnapPiano          setEnabled:stat];  [VSegSnapPiano        setAlphaValue:alp];

	
	[VPopListPiani          setEnabled:stat];  [VPopListPiani        setAlphaValue:alp];

	//	[VBColPiano             setEnabled:stat];	[VBColPiano           setAlphaValue:alp];
	
	[VSegDis1               setEnabled:stat];  [VSegDis1             setAlphaValue:alp];
	[VSegDis2               setEnabled:stat];  [VSegDis2             setAlphaValue:alp];

	[SVEdit1                setEnabled:stat];  [SVEdit1              setAlphaValue:alp];
	[SVEdit2                setEnabled:stat];  [SVEdit2              setAlphaValue:alp];
	[SVEdit3                setEnabled:stat];  [SVEdit3              setAlphaValue:alp];
	[VBMoveDis              setEnabled:stat];  [VBMoveDis            setAlphaValue:alp];
        //	[VBRotDis               setEnabled:stat];  [VBRotDis             setAlphaValue:alp];
        //	[VBScaDis               setEnabled:stat];  [VBScaDis             setAlphaValue:alp];
	
	[txtDisegnoBianco       setAlphaValue:alp];
	[txtEditBianco          setAlphaValue:alp];

	
	
	[VBCenCalVet         setEnabled:stat];  [VBCenCalVet         setAlphaValue:alp];
	[vtlrotcen           setEnabled:stat];  [vtlrotcen           setAlphaValue:alp];
	[vtlscacen           setEnabled:stat];  [vtlscacen           setAlphaValue:alp];
	[vtloffx             setEnabled:stat];  [vtloffx             setAlphaValue:alp];
	[vtloffy             setEnabled:stat];  [vtloffy             setAlphaValue:alp];
		//	[vtminRot            setEnabled:stat];  [vtminRot            setAlphaValue:alp];
	[vtmaxRot            setEnabled:stat];  [vtmaxRot            setAlphaValue:alp];
		//	[vtminSca            setEnabled:stat];  [vtminSca            setAlphaValue:alp];
	[vtmaxSca            setEnabled:stat];  [vtmaxSca            setAlphaValue:alp];
	[VB0Rot              setEnabled:stat];  [VB0Rot              setAlphaValue:alp];
	[VB0Sca              setEnabled:stat];  [VB0Sca              setAlphaValue:alp];
	[VB0Xoff             setEnabled:stat];  [VB0Xoff             setAlphaValue:alp];
	[VB0Yoff             setEnabled:stat];  [VB0Yoff             setAlphaValue:alp];
	[vtSt0Xoff           setEnabled:stat];  [vtSt0Xoff           setAlphaValue:alp];
	[vtSt0Yoff           setEnabled:stat];  [vtSt0Yoff           setAlphaValue:alp];


	
}



- (NSView*)                             ViewRasterino             {
	return Thumraster;
}

- (NSView*)                             ViewVettorino             {
	return Thumvector;
}






- (NSPopUpButton *) PopLRas                                       { return RPopListRas;    }

- (NSPopUpButton *) PopLSubRas                                    { return RPopListSubRas; }

- (NSPopUpButton *) PopLVect                                      { return VPopListDis;    }

- (NSPopUpButton *) PopLSubVect                                   { return VPopListPiani;  }




- (void) SetminRotCen                 : (bool) up : (bool) minimo {
	
}

- (void) setRckBackRas                  : (int) state             {
	for (int i=0; i<2; i++) { [rckback setSelected:NO  forSegment:i];  }

	if (state>=0) {
		[rckback setSelected:YES  forSegment:state]; 
	}


}


- (void) setRckVisRas                   : (bool) state            {
		if (state) [RKVisRas  setState: NSOnState]; else [RKVisRas  setState: NSOffState];
}

- (void) setRckVisSubRas                : (bool) state            {
	if (state) [RKVisSubRas  setState: NSOnState]; else [RKVisSubRas  setState: NSOffState];
}

- (void) setRckVisVet                   : (bool) state            {
	if (state) [VckVisDis  setState: NSOnState]; else [VckVisDis  setState: NSOffState];

}

- (void) setRckVisSubVet                : (bool) state            {
	if (state) [VckVisPiano  setState: NSOnState]; else [VckVisPiano  setState: NSOffState];

}



- (void) setRSlAlphRas                  : (float) value           {
	[rslras setFloatValue: value ];
}

- (void) setRSlAlphSubRas               : (float) value           {
	[rslsubras setFloatValue: value ];
}


- (void) setRSlAlphLVet                 : (float) value           {
	[VSlAlphLineDis setFloatValue: value ];
}

- (void) setRSlAlphLSubVet              : (float) value           {
	[VSlAlphLinePiano setFloatValue: value ];
}

- (void) setRSlAlphSVet                 : (float) value           {
	[VSlAlphSupDis setFloatValue: value ];
}

- (void) setRSlAlphSSubVet              : (float) value           {
	[VSlAlphSupPiano setFloatValue: value ];
}





	// calibrazione fine raster



/*
- (void) setRSlscacen                   : (float) value           {
	[rslscacen setMaxValue: value+1 ];
	double minimo = value-1;
	if (minimo <0.01) minimo= 0.01;
	[rslscacen setMinValue: minimo ];
	[rslscacen setFloatValue: value ];
}
*/
 
- (NSButton *) RB0Rot                                             {
	return RB0Rot;	
}

- (NSButton *) RB0Sca                                             {
	return RB0Sca;	
}



- (NSSegmentedControl *)  RSceltaAsse                             {
	return RSceltaAsse;
}

- (NSTextField   *)  newXdlgSpostaRaster {
	return newXdlgSpostaRaster;
}
- (NSTextField   *)  newYdlgSpostaRaster {
	return newYdlgSpostaRaster;
	
}


- (NSBox         *)  BoxNuovaCoordutm {
	return BoxNuovaCoordutm;
}

- (NSBox         *)  BoxNuovaCoordGeo {
	return BoxNuovaCoordGeo;
}

- (NSTextField   *)  newXdlgSpRasterGra {
	return newXdlgSpRasterGra;
}

- (NSTextField   *)  newXdlgSpRasterMin {
	return newXdlgSpRasterMin;
}

- (NSTextField   *)  newXdlgSpRasterPri {
	return newXdlgSpRasterPri;
}

- (NSTextField   *)  newYdlgSpRasterGra {
	return newYdlgSpRasterGra;
}

- (NSTextField   *)  newYdlgSpRasterMin {
	return newYdlgSpRasterMin;
}

- (NSTextField   *)  newYdlgSpRasterPri {
	return newYdlgSpRasterPri;
}


- (void) cambiataproiezione: (int) indproiezione {
		// int      TipoProiezione;          // 0 = UTM    ; 1 : catastale   ; 2 Lat-Long

	switch (indproiezione) {
		case 0:	case 2:	case 4:	case 5:
			[BoxNuovaCoordutm setHidden:NO];
			[BoxNuovaCoordGeo setHidden:YES];
			break;
		case 1:	case 3:
			[BoxNuovaCoordutm setHidden:YES];
			[BoxNuovaCoordGeo setHidden:NO];
			break;
		default:
			break;
	}
	
}

- (NSTextField   *)  FtxtScala {
	return FtxtScala;
}

- (NSTextField   *)  FtxtRot {
	return FtxtRot;
}

- (NSTextField   *)  Ftxoffx {
	return Ftxoffx;
}

- (NSTextField   *)  Ftxoffy {
	return Ftxoffy;
}


	// calibrazione fine vettoriale
- (NSSlider *) vtlrotcen                                          {
	return vtlrotcen;	
}

- (NSSlider *) vtlscacen                                          {
	return vtlscacen;	
}

- (NSSlider *) vtloffx                                            {
	return vtloffx;	
}

- (NSSlider *) vtloffy                                            {
	return vtloffy;	
}



- (NSButton *) VB0Rot                                             {
	return VB0Rot;	
}

- (NSButton *) VB0Sca                                             {
	return VB0Sca;	
}

- (NSButton *) VB0Xoff                                            {
	return VB0Xoff;	
}

- (NSButton *) VB0Yoff                                            {
	return VB0Yoff;	
}

- (NSStepper *) vtSt0Xoff                                         {
	return vtSt0Xoff;	
}

- (NSStepper *) vtSt0Yoff                                         {
	return vtSt0Yoff;	
}

- (NSStepper *) vtmaxRot                                          {
	return vtmaxRot;	
}

- (NSStepper *) vtmaxSca                                          {
	return vtmaxSca;	
}




- (NSSegmentedControl *)  VSegSnapDis                             {
	return VSegSnapDis;
}

- (NSSegmentedControl *)  VSegSnapPiano                           {
	return VSegSnapPiano;
}

- (NSSegmentedControl *)  ESxcord                                 {
	return ESxcord;
}

- (NSSegmentedControl *)  ESycord                                 {
	return ESycord;	
}

- (NSSegmentedControl *)  ESFuso                                  {
	return ESFuso;
}

- (NSSegmentedControl *)  ESSnap                                  {
	return ESSnap;
}

- (NSSegmentedControl *)  ESGriglia {
	return ESGriglia;
}


- (NSTextField        *)  txtDimxyraster                          {
	return txtDimxyraster;
}

- (NSBox              *)  bcolPiano                               {
	return bcolPiano;
}


- (NSTextField        *)  FieldTxtTesto                           {
	return FieldTxtTesto;
}

- (NSTextField        *)  FieldAltezzaTesto                       {
	return FieldAltezzaTesto;
}

- (NSPopUpButton      *)  lisnomsimb                              {
	return lisnomsimb;	
}

	// gestione vettoriale




- (NSPopUpButton      *)  nomdispop                               {
	return nomdispop;
}

	// gestione raster











- (NSButton           *)  VBInfoLeg                               {
	return VBInfoLeg;
}

- (NSButton           *)  VBInfoInt2Polyg   {
	return VBInfoInt2Polyg;
}


- (NSView             *)  viewsimb                                {
	return viewsimb;
}


- (NSPopUpButton      *)  FinderFgPart                    {
	return FinderFgPart;
}

- (NSPopUpButton      *)  FinderFgPart2                   {
	return FinderFgPart2;
}

- (NSPopUpButton      *)  FinderViaCiv                    {
	return FinderViaCiv;
}

- (NSPopUpButton      *)  FinderViaCiv2                   {
	return FinderViaCiv2;
}



- (IBAction) VediScalaxy_xy    : (id)sender {
    [RSceltaAsse setHidden:![RSceltaAsse isHidden]];
}

- (IBAction) VediCalibVett     : (id)sender {

    [bCalVet setHidden: ![bCalVet isHidden]];

}


- (NSLevelIndicator   *) LevelIndicatore {
	return LevelIndicatore;
}



- (PDFView            *)  PdfViewVisura {
	return PdfViewVisura;
}

- (NSTextField        *)  stringa_conferma {
	return stringa_conferma;
}


	// Griglia




- (NSBox   *) boxComune {
	return boxComune;
}

- (NSBox   *) boxDisegni {
	return boxDisegni;
}

- (NSBox   *) boxImmagini {
	return boxImmagini;
}





@end
