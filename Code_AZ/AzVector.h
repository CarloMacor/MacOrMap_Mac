//
//  AzVector.h
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"
#import "Progetto.h"
#import "Interface.h"
#import "InterfaceDlg.h"
#import "AzDialogs.h"


@interface AzVector : NSObject {
	IBOutlet Varbase                * varbase;
	IBOutlet Progetto               * progetto;
    IBOutlet InfoObj                * info;
	IBOutlet BarileDlg              * bariledlg;
	IBOutlet AzDialogs              * azdialogs;
	IBOutlet Interface              * interface;
	IBOutlet InterfaceDlg           * interfacedlg;

    bool rotoscalatutti;
}

- (void) InitAzVector      ;

	// dlg Info
- (IBAction) MatchdaInfo                    : (id)  sender;
- (IBAction) MettiInfoinSelezionati         : (id)  sender;
- (IBAction) TogliInfoinSelezionati         : (id)  sender;

- (IBAction) AlfabPianiDisCorrente          : (id)  sender;


- (void) testinters ;

- (void) macroiniziale;

- (void) CaricaDefsimboli;

- (void) comandobottone    : (NSInteger) com ; 



- (IBAction) CNuovoDisegno           : (id)sender;
- (IBAction) SaveDisegno             : (id)sender;
- (IBAction) SaveDisegnoDXF          : (id)sender;


- (IBAction) CambioVectorPop         : (id)sender;
- (void)     CambioSubVector         : (int)indice;
- (IBAction) CambioSubVectorPop      : (id)sender;

- (IBAction) addVettoriale           : (id)sender;
- (IBAction) removeVettoriale        : (id)sender;


- (IBAction) UpVisVector             : (id)sender;
- (IBAction) UpVisSubvector          : (id)sender;

- (IBAction) SnapEditDisegno         : (id)sender;
- (IBAction) SnapEditPiano           : (id)sender;

- (IBAction) UpAlpDisLine            : (id)sender;
- (IBAction) UpAlpDisSup             : (id)sender;
- (IBAction) UpAlpPianoLine          : (id)sender;
- (IBAction) UpAlpPianoSup           : (id)sender;
- (IBAction) UpAlpDisLineCXF         : (id)sender;
- (IBAction) UpAlpDisSupCXF          : (id)sender;
- (IBAction) UpVisCXF                : (id)sender;

- (IBAction) addPiano                : (id)sender;

- (IBAction) CatCVtoUtm              : (id)sender;
- (IBAction) CatCVtoUtmTutti         : (id)sender;



- (IBAction) Com_Vector1             : (id)sender;
- (IBAction) Com_Vector2             : (id)sender;
- (IBAction) CPunto                  : (id)sender;
- (IBAction) CPolilinea              : (id)sender;
- (IBAction) CPoligono               : (id)sender;
- (IBAction) CRegione                : (id)sender;
- (IBAction) CRettangolo             : (id)sender;
- (IBAction) CSimbolo                : (id)sender; 
- (IBAction) CSimboloRot             : (id)sender; 
- (IBAction) CSimboloRotSca          : (id)sender; 
- (IBAction) CSimboloFisso           : (id)sender; 
- (IBAction) CSplinea                : (id)sender;
- (IBAction) CSpoligono              : (id)sender;
- (IBAction) CSregione               : (id)sender;
- (IBAction) CCerchio                : (id)sender;
- (IBAction) CTesto                  : (id)sender;
- (IBAction) CTestoRot               : (id)sender;
- (IBAction) CTestoRotSca            : (id)sender;
- (IBAction) CCatPoligono            : (id)sender;
- (IBAction) CToPolToCat             : (id)sender;
- (IBAction) CPuntoTastiera          : (id)sender;

- (IBAction) CRettangoloStampa       : (id)sender;
- (IBAction) CRettangoloDoppioStampa : (id)sender;


- (IBAction) Com_Edit1               : (id)sender;
- (IBAction) CSeleziona              : (id)sender;
- (IBAction) CInfo                   : (id)sender;
- (IBAction) CInfoSup                : (id)sender; 
- (IBAction) CMatch                  : (id)sender;
- (IBAction) CDeseleziona            : (id)sender;



- (IBAction) Com_EditVt              : (id)sender;
- (IBAction) CSpostaVertice          : (id)sender;
- (IBAction) CInserisciVertice       : (id)sender;
- (IBAction) CCancellaVertice        : (id)sender;
- (IBAction) CEditVtSp               : (id)sender;

- (IBAction) Com_EditObj             : (id)sender;
- (IBAction) CSpostaSelezionati      : (id)sender;
- (IBAction) CCopiaselezionati       : (id)sender;
- (IBAction) CRuotaSelezionati       : (id)sender;
- (IBAction) CScalaSelezionati       : (id)sender;
- (IBAction) CCancellaSelezionati    : (id)sender;

- (IBAction) CopiaTerreniSelPiaCor   : (id)sender;
- (IBAction) CopiaEdificiSelPiaCor   : (id)sender;


- (IBAction) CspostaDisegno          : (id)sender;

	// Gruppo vector fine
- (IBAction) VFixCentroRot           : (id)sender;
- (IBAction) VCentroRot              : (id)sender;
- (IBAction) VCentroScal             : (id)sender;
- (IBAction) VCentroX                : (id)sender;
- (IBAction) VCentroY                : (id)sender;

- (IBAction) VSet0RotCen             : (id)sender;
- (IBAction) VSetMinMaxRotCen        : (id)sender;


	// - (IBAction) VSetmaxRotCen            : (id)sender;
	// - (IBAction) VSetminScaCen            : (id)sender;
	// - (IBAction) VSetmaxScaCen            : (id)sender;



- (IBAction) AzBotColorePiano        : (id)sender;
- (void)     colorpianochanged :(NSColorPanel *) pancol;

- (IBAction) Apri_Dlgvector          : (id)sender;
- (void)     aggiornamentodlgVet                 ;
- (IBAction) Chiudi_Dlgvector        : (id)sender;
- (void)     mandaDisegnoCorrenteaDlg            ;
- (IBAction) PianoCorrentedaDlgvector: (id)sender;

- (IBAction) FondiTuttiDisegni       : (id)sender;


- (IBAction) cambiasimbolo           : (id)sender;

- (IBAction) InfoDisegnoCorrente     : (id)sender;
- (IBAction) InfoPianoCorrente       : (id)sender;

- (IBAction) EliminaPianiVuoti       : (id)sender;

- (IBAction) EliminaPianoCorrente    : (id)sender;

- (IBAction) ApridlgTesto            : (id)sender;
- (IBAction) ChiudidlTesto           : (id)sender;


- (IBAction) TaglioPoligoni          : (id)sender;

- (IBAction) CopiaSelPiaCor          : (id)sender;

- (IBAction) SpostaSelPiaCor         : (id)sender;


- (IBAction) SpostaPianoDis1         : (id)sender;

- (IBAction) PolytoPoligoni          : (id)sender;

- (IBAction) CambiaRegioneSel1polig  : (id)sender;


- (IBAction) TarquiniaQuadroUnione   : (id)sender;
- (IBAction) AproFoglioconPt         : (id)sender;

- (IBAction) BackPlineaAdded         : (id)sender;

- (IBAction) PallozziCatOnOff        : (id)sender;


- (IBAction) PoligoniSelRegione      : (id)sender;


- (IBAction) initwork                : (id)sender;

- (IBAction) CivitavecchiaFotogrammetrico     : (id)sender;

- (IBAction) TestoAltoQuadroUCatasto : (id)sender;


- (IBAction) testwork                : (id)sender;

- (IBAction) VedoTestiQuadroUnione   : (id)sender;


- (IBAction) BottoneCatasto_1        : (id)sender;

- (IBAction) BottoneCatasto_2        : (id)sender;

- (IBAction) TemaTerreni             : (id)sender; 

- (IBAction) BotInfoIntersezionePolygoni       : (id)sender ;

- (void) TematizzaTerreni        ;
- (void) NoTematizzaTerreni      ;

- (IBAction) DisegnoCatastoTematizzato  : (id)sender ;





- (IBAction) BottoneComune_01V       : (id)sender;
- (IBAction) BottoneComune_02V       : (id)sender;
- (IBAction) BottoneComune_03V       : (id)sender;
- (IBAction) BottoneComune_04V       : (id)sender;
- (IBAction) BottoneComune_05V       : (id)sender;
- (IBAction) BottoneComune_06V       : (id)sender;
- (IBAction) BottoneComune_07V       : (id)sender;
- (IBAction) BottoneComune_08V       : (id)sender;
- (IBAction) BottoneComune_09V       : (id)sender;
- (IBAction) BottoneComune_10V       : (id)sender;

- (IBAction) BotLegComune_01V        : (id)sender;

- (IBAction) PulisciRoma             : (id)sender;


@end
