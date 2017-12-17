//
//  AzExtra.h
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"
#import "Progetto.h"
#import "Interface.h"


@interface AzExtra : NSObject {
	IBOutlet Varbase                * varbase;
	IBOutlet Progetto               * progetto;
    IBOutlet InfoObj                * info;
	IBOutlet Interface              * interface;
	IBOutlet NSButton             * ckVisibileGoogle;
	IBOutlet NSSegmentedControl   * seg_satelliteStrada;
	IBOutlet NSSlider             * Slide_alphaWEB;
	IBOutlet NSLevelIndicator     * Indicaframeloaded;
	int carvis ;
	IBOutlet NSBox         * boxTarquinia;
	
}

- (IBAction) SalvaImmobili                : (id)sender;

- (void) InitAzExtra      ;

- (IBAction) UndoMUndo                     : (id)sender;

- (void) riaggiornaslidetutte ;

- (IBAction) GoogleVisibile                : (id)sender;
- (IBAction) setalphagoogle                : (id)sender;
- (IBAction) Google_satellitestrada        : (id)sender;

- (IBAction) SwitchGoogleVisibile          : (id)sender;
- (IBAction) SwitchGoogleStrada            : (id)sender;
- (IBAction) CVistaZoom                    : (id)sender;

- (NSString *) valorerenditastr            : (NSString *) str ;
- (NSString *) viastr                      : (NSString *) str ;
- (NSString *) civicostr                   : (NSString *) str ;
- (NSString *) pianoedifstr                : (NSString *) str ;

- (NSString *) ripuliscistr                : (NSString *) str ;

- (int)      aproFoglio                    : (NSString *) st ;
- (int)      aproFoglioA                   : (NSString *) st ;  
- (int)      aproFoglio0A                  : (NSString *) st ;

- (IBAction) CInfoEdificio           : (id)sender; 

- (IBAction) CInfoTerreno            : (id)sender; 


- (int)      giacaricatodisegno      : (NSString *) str;

- (void)     AddinListaParticella    : (int) inddis : (NSMutableArray *)  lista  : (NSString *) nompart;
- (void)     AddinListaParticellaNoDisplay           : (int) inddis       : (NSMutableArray *)  lista  : (NSString *) nompart;
- (void)     AddinListaGruppoSuber   : (NSArray *) Subers : (NSMutableArray *)  lista ;
- (void)     AddinListaTerreno       : (int) inddis : (NSMutableArray *)  lista  : (NSString *) nompart;
- (void)     AddinListaGruppoTerer   : (NSArray *) Subers : (NSMutableArray *)  lista ;

- (void)     zoommaEdifSelected ;
- (void)     zoommaTerraSelected;


- (IBAction) VediBoxTarquinia        : (id)sender;


- (IBAction) RepaintMain             : (id)sender;

- (IBAction) TrovaTerreniSenzaCatasto: (id)sender;

- (IBAction) TrovaEdificiSenzaCatasto: (id)sender;

- (IBAction) TrovaRecordSenzaTerreno : (id)sender;

- (IBAction) TrovaRecordSenzaEdificio: (id)sender;

- (IBAction) QuantificaTerreni       : (id)sender;

- (IBAction) RecordTerreni2Destinazioni  : (id)sender;

- (IBAction) QuantificaEdifici       : (id)sender;


- (IBAction) CopiaPdfSelezinModed    : (id)sender;


- (IBAction) FormaAnagrafe           : (id)sender;

- (IBAction) InterpretazioneDirittiOneri : (id)sender;

- (IBAction) TrovaCasa               : (id)sender; 

- (IBAction) TrovaCasa2              : (id)sender;

- (IBAction) TrovaCasaQ              : (id)sender;

- (IBAction) TrovaCasa2Q             : (id)sender; 

- (IBAction) ToglispaziCiviciEdi     : (id)sender; 


- (IBAction) CInfoTaxTerreno          : (id)sender; 


@end
