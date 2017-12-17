//
//  Interface.h
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "InterfaceWindow.h"




@interface Interface : NSObject {
	NSUndoManager  * MUndor;
	IBOutlet   InterfaceWindow   * interfacewindow;

	IBOutlet  NSBox *boxComune;
	IBOutlet  NSBox *boxDisegni;
	IBOutlet  NSBox *boxImmagini;

	
	bool     attivomenu;

	IBOutlet NSTextField         *  txtPassword;
	
	IBOutlet NSTextField         *  txtdlgQuantificatori;

		// gestione vettoriale
	IBOutlet NSPopUpButton       *  nomdispop;

		// gestione raster

	IBOutlet NSLevelIndicator * LevelIndicatore;
	
	IBOutlet NSPopUpButton *  lisnomsimb;
	IBOutlet NSView        *  viewsimb;

	IBOutlet NSTextField   *  FieldTxtTesto;
	IBOutlet NSTextField   *  FieldAltezzaTesto;

		// gruppo  Raster
	IBOutlet NSButton      * RBMovOrRasAll;
	IBOutlet NSButton      * RBMovOrR2ptAll;
	IBOutlet NSButton      * RBZoomRasAll;
	IBOutlet NSButton      * RBAddRas;
	IBOutlet NSButton      * RBLessRas;
	IBOutlet NSButton      * RKVisRas;
	IBOutlet NSSlider      * rslras;
	IBOutlet NSPopUpButton * RPopListRas;
	IBOutlet NSSegmentedControl * rckback;

	IBOutlet NSTextField   *  newXdlgSpostaRaster;
	IBOutlet NSTextField   *  newYdlgSpostaRaster;
	IBOutlet NSBox         *  BoxNuovaCoordutm;
	IBOutlet NSBox         *  BoxNuovaCoordGeo;
	IBOutlet NSTextField   *  newXdlgSpRasterGra;
	IBOutlet NSTextField   *  newXdlgSpRasterMin;
	IBOutlet NSTextField   *  newXdlgSpRasterPri;
	IBOutlet NSTextField   *  newYdlgSpRasterGra;
	IBOutlet NSTextField   *  newYdlgSpRasterMin;
	IBOutlet NSTextField   *  newYdlgSpRasterPri;

		// singolo Raster
	IBOutlet NSButton      * RBZoomRas;
	IBOutlet NSButton      * RBAddSubRas;
	IBOutlet NSButton      * RBLessSubRas;
	IBOutlet NSButton      * RKVisSubRas;
	IBOutlet NSPopUpButton * RPopListSubRas;
	IBOutlet NSView        * Thumraster;
	IBOutlet NSButton      * RBcolrast;

	
	IBOutlet NSButton      * RBMovOrRas;
	IBOutlet NSButton      * RBMovOrR2pt;
	IBOutlet NSButton      * RBRigRas;
	IBOutlet NSButton      * RBRotScaRas;
	IBOutlet NSButton      * RBRas0gr;
	IBOutlet NSButton      * RBCalRasBar;
	IBOutlet NSButton      * RBCalRasBarFix;
	IBOutlet NSButton      * RBCropRas;
	IBOutlet NSButton      * RBCropRectRas;
	IBOutlet NSButton      * RBMaskRas;
	IBOutlet NSSlider      * rslsubras;
	IBOutlet NSButton      * RBRas1Sca;
	IBOutlet NSButton      * RBcal8pt;
	IBOutlet NSTextField   * txtDimxyraster;
	
		// calibrazione fine raster
		//	IBOutlet NSButton      * RBCenCalRas;
	IBOutlet NSButton      * RB0Rot;
	IBOutlet NSButton      * RB0Sca;
	IBOutlet NSSegmentedControl *  RSceltaAsse;
	IBOutlet NSTextField   *  FtxtScala;
	IBOutlet NSTextField   *  FtxtRot;
	IBOutlet NSTextField   *  Ftxoffx;
	IBOutlet NSTextField   *  Ftxoffy;

		// calibrazione fine vector
	IBOutlet NSButton      * VBCenCalVet;
	IBOutlet NSSlider      * vtlrotcen;
	IBOutlet NSSlider      * vtlscacen;
	IBOutlet NSSlider      * vtloffx;
	IBOutlet NSSlider      * vtloffy;
	IBOutlet NSButton      * VB0Rot;
	IBOutlet NSButton      * VB0Sca;
	IBOutlet NSButton      * VB0Xoff;
	IBOutlet NSButton      * VB0Yoff;

	
	IBOutlet NSStepper     * vtSt0Xoff;
	IBOutlet NSStepper     * vtSt0Yoff;
	IBOutlet NSStepper     * vtmaxRot;
	IBOutlet NSStepper     * vtmaxSca;
	
	
		// Vector
	IBOutlet NSButton      *  VBTogliDis;
	IBOutlet NSButton      *  VBNewDis;
	IBOutlet NSButton      *  VBAddDis;
	IBOutlet NSButton      *  VBNewPiano;
	IBOutlet NSButton      *  VBSaveDis;
	IBOutlet NSButton      *  VBInfoLeg;

	IBOutlet NSButton      *  VBInfoInt2Polyg;
	IBOutlet NSButton      *  RKVisCXF;

		// disegno
	IBOutlet NSSlider      *  VSlAlphLineDis;
	IBOutlet NSSlider      *  VSlAlphSupDis;
	IBOutlet NSButton      *  VckVisDis;
	IBOutlet NSButton      *  VBzoomDis;
	IBOutlet NSSegmentedControl   *  VSegSnapDis;
	IBOutlet NSPopUpButton *  VPopListDis;
	IBOutlet NSButton      *  VBDlgVect;
	
		// piano
	IBOutlet NSSlider      *  VSlAlphLinePiano;
	IBOutlet NSSlider      *  VSlAlphSupPiano;
	IBOutlet NSView        *  Thumvector;
	IBOutlet NSButton      *  VckVisPiano;
	IBOutlet NSButton      *  VBzoomPiano;
	IBOutlet NSSegmentedControl   *  VSegSnapPiano;
	IBOutlet NSPopUpButton *  VPopListPiani;
	IBOutlet NSButton      *  VBColPiano;
	IBOutlet NSBox         *  bcolPiano;
	
	IBOutlet NSTextField   * txtDisegnoBianco;
	IBOutlet NSTextField   * txtEditBianco;

		// disegno	in realizzazione
	IBOutlet NSSegmentedControl * VSegDis1;
	IBOutlet NSSegmentedControl * VSegDis2;
	
		// Edit vector
	IBOutlet NSSegmentedControl * SVEdit1;
	IBOutlet NSSegmentedControl * SVEdit2;
	IBOutlet NSSegmentedControl * SVEdit3;
	IBOutlet NSButton           * VBMoveDis;

	IBOutlet NSBox              * bCalVet;

		//	IBOutlet NSButton           * VBRotDis;
        //	IBOutlet NSButton           * VBScaDis;

		// Extra interface alto
	IBOutlet NSSegmentedControl   * ESxcord;
	IBOutlet NSSegmentedControl   * ESycord;
	IBOutlet NSSegmentedControl   * ESFuso;
	IBOutlet NSSegmentedControl   * ESproiec;
	IBOutlet NSSegmentedControl   * ESComandoFase;
    IBOutlet NSSegmentedControl   * ESGriglia;

		// comandi Extra
	IBOutlet NSSegmentedControl * ESSnap;
	IBOutlet NSSegmentedControl * ESZoom1;
	IBOutlet NSSegmentedControl * ESZoom2;
	
	IBOutlet NSButton      *  img1l;
	IBOutlet NSButton      *  img1s;
	IBOutlet NSButton      *  img2l;
	IBOutlet NSButton      *  img2s;


		// raster
	IBOutlet NSMenuItem    *  mapriimg;
	IBOutlet NSMenuItem    *  mchiudigruppo;
	IBOutlet NSMenuItem    *  mchiudiimg;


	
	
	IBOutlet NSMenuItem    *  maddimg;
	IBOutlet NSMenuItem    *  mspostarast;
	IBOutlet NSMenuItem    *  mcalibra;
	IBOutlet NSMenuItem    *  msalvaraster;

		// vettoriale	
	IBOutlet NSMenuItem    *  mnewpiano;
	IBOutlet NSMenuItem    *  mclosedis;
	IBOutlet NSMenuItem    *  msavedis;
	IBOutlet NSMenuItem    *  mexpdis;
	IBOutlet NSMenuItem    *  mdisegna;
	IBOutlet NSMenuItem    *  mgesdis;
	IBOutlet NSMenuItem    *  meditdis;
	IBOutlet NSMenuItem    *  meditsel;
	IBOutlet NSMenuItem    *  meditvt;
	IBOutlet NSMenuItem    *  minfo;


		// Catasto 
	IBOutlet NSButton      *  BFoglio;

	IBOutlet NSPopUpButton *  FinderFgPart;
	IBOutlet NSPopUpButton *  FinderFgPart2;
	IBOutlet NSPopUpButton *  FinderViaCiv;
	IBOutlet NSPopUpButton *  FinderViaCiv2;

	IBOutlet PDFView       *  PdfViewVisura;

	IBOutlet NSTextField   *  stringa_conferma;

}

- (void) InitInterface;

- (NSUndoManager  *) MUndor;

- (NSTextField    *) txtdlgQuantificatori;





- (NSTextField    *) txtPassword;


- (void) setlabelComando                : (NSString *) msgstr;
- (void) setlabelAzione                 : (NSString *) msgstr;

- (void) AggiornamentoNuovoProgetto ;
- (void) AggiornaInterfaceComandoAzione : (int) com : (int) fase   ;
- (void) txtInterfaceComandoAzione:(NSString *) msg;

- (void) upinterfacevector  :  (bool) activVecor                  ;
- (void) upinterfaceraster  :  (bool) activRaster                 ;


- (void) UpStateRasterBut               :(bool) stat;
- (void) UpStateVectorBut               :(bool) stat;



- (NSView*)          ViewRasterino;
- (NSView*)          ViewVettorino;

- (void) SetminRotCen                   : (bool) up : (bool) minimo;

- (void) setRckBackRas                  : (int)  state ;
- (void) setRckVisRas                   : (bool) state ;
- (void) setRckVisSubRas                : (bool) state ;

- (void) setRckVisVet                   : (bool) state ;
- (void) setRckVisSubVet                : (bool) state ;


- (void) setRSlAlphRas                  : (float) value ;
- (void) setRSlAlphSubRas               : (float) value ;


- (void) setRSlAlphLVet                  : (float) value ;
- (void) setRSlAlphLSubVet               : (float) value ;
- (void) setRSlAlphSVet                  : (float) value ;
- (void) setRSlAlphSSubVet               : (float) value ;







	// calibrazione fine raster   // o vettoriale
- (NSTextField   *)  newXdlgSpostaRaster;
- (NSTextField   *)  newYdlgSpostaRaster;
- (NSBox         *)  BoxNuovaCoordutm;
- (NSBox         *)  BoxNuovaCoordGeo;
- (NSTextField   *)  newXdlgSpRasterGra;
- (NSTextField   *)  newXdlgSpRasterMin;
- (NSTextField   *)  newXdlgSpRasterPri;
- (NSTextField   *)  newYdlgSpRasterGra;
- (NSTextField   *)  newYdlgSpRasterMin;
- (NSTextField   *)  newYdlgSpRasterPri;
- (void)             cambiataproiezione: (int) indproiezione;

- (NSTextField   *)  FtxtScala;
- (NSTextField   *)  FtxtRot;
- (NSTextField   *)  Ftxoffx;
- (NSTextField   *)  Ftxoffy;


- (NSButton *) RB0Rot;
- (NSButton *) RB0Sca;

	// - (NSSlider *) rslrotcen;
	// - (NSSlider *) rslscacen;

- (NSSlider *) vtlrotcen;
- (NSSlider *) vtlscacen;
- (NSSlider *) vtloffx;
- (NSSlider *) vtloffy;
- (NSSegmentedControl *)  RSceltaAsse;

	// calibrazione fine vettoriale
- (NSButton *) VB0Rot;
- (NSButton *) VB0Sca;
- (NSButton *) VB0Xoff;
- (NSButton *) VB0Yoff;
- (NSStepper *) vtSt0Xoff;
- (NSStepper *) vtSt0Yoff;
- (NSStepper *) vtmaxRot;
- (NSStepper *) vtmaxSca;

- (NSPopUpButton *) PopLRas;
- (NSPopUpButton *) PopLSubRas;
- (NSPopUpButton *) PopLVect;
- (NSPopUpButton *) PopLSubVect;

- (NSSegmentedControl *)  VSegSnapDis;
- (NSSegmentedControl *)  VSegSnapPiano;

- (NSSegmentedControl *)  ESxcord;
- (NSSegmentedControl *)  ESycord;
- (NSSegmentedControl *)  ESFuso;
- (NSSegmentedControl *)  ESSnap;
- (NSSegmentedControl *)  ESGriglia;

- (NSTextField        *)  txtDimxyraster;

- (NSBox              *)  bcolPiano;

- (NSTextField        *)  FieldTxtTesto;
- (NSTextField        *)  FieldAltezzaTesto;

- (NSPopUpButton      *)  lisnomsimb;
- (NSView             *)  viewsimb;

	// gestione vettoriale
- (NSPopUpButton      *)  nomdispop;
- (NSButton           *)  VBInfoLeg;
- (NSButton           *)  VBInfoInt2Polyg;

	// gestione raster


- (NSPopUpButton      *)  FinderFgPart;
- (NSPopUpButton      *)  FinderFgPart2;
- (NSPopUpButton      *)  FinderViaCiv;
- (NSPopUpButton      *)  FinderViaCiv2;




- (IBAction) VediScalaxy_xy    : (id)sender;
- (IBAction) VediCalibVett     : (id)sender;

- (NSLevelIndicator   *) LevelIndicatore;

- (PDFView            *)  PdfViewVisura;


- (NSTextField        *)  stringa_conferma;



- (NSBox   *) boxComune;

- (NSBox   *) boxDisegni;
- (NSBox   *) boxImmagini;




@end
