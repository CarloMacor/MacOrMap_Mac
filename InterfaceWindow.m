//
//  InterfaceWindow.m
//  MacOrMap
//
//  Created by Carlo Macor on 25/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import "InterfaceWindow.h"
#import "Varbase.h"


@implementation InterfaceWindow


- (void) AggiornamentoNuovoProgetto                                   {
	[ButConfiniComunali setState:0];
	[ButTemaTerreni setState:0];
	
		// Bottoni del Comune gestiscono Vettoriale
	[ButComuneV01 setState:0];
	[ButComuneV02 setState:0];
	[ButComuneV03 setState:0];
	[ButComuneV04 setState:0];
	[ButComuneV05 setState:0];
	[ButComuneV06 setState:0];
	[ButComuneV07 setState:0];
	[ButComuneV08 setState:0];

		// Bottoni del Comune gestiscono Immagini

	
	
		// Bottoni del Comune gestiscono Immagini Comune
	[ButComuneR01 setState:0];
	[ButComuneR02 setState:0];
	[ButComuneR03 setState:0];
	[ButComuneR04 setState:0];
	[ButComuneR05 setState:0];
	[ButComuneR06 setState:0];
	[ButComuneR07 setState:0];
	[ButComuneR08 setState:0];
	[ButComuneR09 setState:0];
	[ButComuneR10 setState:0];
	[ButComuneR11 setState:0];
	[ButComuneR12 setState:0];
	[ButComuneR13 setState:0];
	[ButComuneR14 setState:0];
	[ButComuneR15 setState:0];
	[ButComuneR16 setState:0];
	[ButComuneR17 setState:0];
}

- (void) AggiornaInterfaceComandoAzione     : (int) com : (int) fase  {


	[ButFabbri                   setState:0];
	[ButFabbriFloat              setState:0];
	[ButTerra                    setState:0];
	[ButTerraFloat               setState:0];
	
		// bottoni Raster
	[ButImgCentroRotoscala       setState:0];
	[ButImg2PtCentrato           setState:0];

	
	switch (com) {
		case kStato_FixCentroRot             : [ButImgCentroRotoscala   setState:1]; break;
		case kStato_InfoEdificio             : [ButFabbri               setState:1]; [ButFabbriFloat setState:1];  break;
		case kStato_InfoTerreno              : [ButTerra                setState:1]; [ButTerraFloat  setState:1];  break;
	}
}

- (void) AggiornaInterfacciaRaster          : (bool) stat             {
	float alp =1.0;
	if (stat==NSOffState) { alp=0.3; // [RKVisRas         setState:stat];	[RKVisSubRas         setState:stat];	
	}

	[ButImgCentroRotoscala   setEnabled:stat];     [ButImgCentroRotoscala   setAlphaValue:alp];
	[ButImg2PtCentrato       setEnabled:stat];     [ButImg2PtCentrato       setAlphaValue:alp];
	[SlidImgCentroRot        setEnabled:stat];     [SlidImgCentroRot        setAlphaValue:alp];
	[SlidImgCentroSca        setEnabled:stat];     [SlidImgCentroSca        setAlphaValue:alp];
	[StepImgRot              setEnabled:stat];     [StepImgRot              setAlphaValue:alp];
	[StepImgSca              setEnabled:stat];     [StepImgSca              setAlphaValue:alp];

}
	


- (void) setSlidCentroRot                   : (float) value           {
	[SlidImgCentroRot setMaxValue: value+1 ];
	[SlidImgCentroRot setMinValue: value-1 ];
	[SlidImgCentroRot setFloatValue: value ];
}

- (void) setSlidCentroSca                   : (float) value           {
	double minimo = value-1; if (minimo <0.01) minimo= 0.01;
	[SlidImgCentroSca setMaxValue   : value+1 ];	
	[SlidImgCentroSca setMinValue   : minimo ];
	[SlidImgCentroSca setFloatValue : value ];
}


- (NSSlider  *) SlidImgCentroRot                                         {
	return SlidImgCentroRot;	
}

- (NSSlider  *) SlidImgCentroSca                                         {
	return SlidImgCentroSca;
}

- (NSStepper *) StepImgRot                                            {
	return StepImgRot;	
	
}

- (NSStepper *) StepImgSca                                            {
	return StepImgSca;	
}



@end
