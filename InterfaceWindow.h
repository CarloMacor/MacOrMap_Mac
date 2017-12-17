//
//  InterfaceWindow.h
//  MacOrMap
//
//  Created by Carlo Macor on 25/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>


@interface InterfaceWindow : NSObject {

	IBOutlet NSButton      *  ButConfiniComunali;
	IBOutlet NSButton      *  ButQuadroUnione;
	IBOutlet NSButton      *  ButFoglioPt;
	IBOutlet NSButton      *  ButTemaTerreni;

	
	
		// Bottoni del Comune gestiscono Vettoriale
	IBOutlet NSButton      *  ButComuneV01;
	IBOutlet NSButton      *  ButComuneV02;
	IBOutlet NSButton      *  ButComuneV03;
	IBOutlet NSButton      *  ButComuneV04;
	IBOutlet NSButton      *  ButComuneV05;
	IBOutlet NSButton      *  ButComuneV06;
	IBOutlet NSButton      *  ButComuneV07;
	IBOutlet NSButton      *  ButComuneV08;

		// Bottoni gestiscono Immagini
	IBOutlet NSButton      *  ButImgCentroRotoscala;
	IBOutlet NSButton      *  ButImg2PtCentrato;

		// Slider gestiscono Immagini
	IBOutlet NSSlider      * SlidImgCentroRot;
	IBOutlet NSSlider      * SlidImgCentroSca;
		// Stepper gestiscono Immagini
	IBOutlet NSStepper     * StepImgRot;
	IBOutlet NSStepper     * StepImgSca;

	
		// Bottoni del Comune gestiscono Immagini
	IBOutlet NSButton      *  ButComuneR01;
	IBOutlet NSButton      *  ButComuneR02;
	IBOutlet NSButton      *  ButComuneR03;
	IBOutlet NSButton      *  ButComuneR04;
	IBOutlet NSButton      *  ButComuneR05;
	IBOutlet NSButton      *  ButComuneR06;
	IBOutlet NSButton      *  ButComuneR07;
	IBOutlet NSButton      *  ButComuneR08;
	IBOutlet NSButton      *  ButComuneR09;
	IBOutlet NSButton      *  ButComuneR10;
	IBOutlet NSButton      *  ButComuneR11;
	IBOutlet NSButton      *  ButComuneR12;
	IBOutlet NSButton      *  ButComuneR13;
	IBOutlet NSButton      *  ButComuneR14;
	IBOutlet NSButton      *  ButComuneR15;
	IBOutlet NSButton      *  ButComuneR16;
	IBOutlet NSButton      *  ButComuneR17;

	
	IBOutlet NSButton      *  ButFabbri;
	IBOutlet NSButton      *  ButFabbriFloat;
	IBOutlet NSButton      *  ButTerra;
	IBOutlet NSButton      *  ButTerraFloat;

}


- (void) AggiornamentoNuovoProgetto  ;

- (void) AggiornaInterfaceComandoAzione : (int) com : (int) fase  ;

- (void) AggiornaInterfacciaRaster      :(bool) stat              ;



	// - (void) setRSlrotcen                   : (float) value ;
//- (void) setRSlscacen                   : (float) value ;
- (void) setSlidCentroRot                   : (float) value          ;
- (void) setSlidCentroSca                   : (float) value          ;

- (NSSlider *) SlidImgCentroRot;
- (NSSlider *) SlidImgCentroSca;
- (NSStepper *) StepImgRot;
- (NSStepper *) StepImgSca;



@end
