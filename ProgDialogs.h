//
//  ProgDialogs.h
//  MacOrMap
//
//  Created by Carlo Macor on 25/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Varbase.h"
#import "InterfaceDlg.h"
#import "BarileDlg.h"
#import "Vettoriale.h"
#import "ComandiPro.h"


@interface ProgDialogs : NSObject {
	IBOutlet Varbase                * varbase;
	IBOutlet InterfaceDlg           * interfacedlg;
	IBOutlet BarileDlg              * bariledlg;
	IBOutlet ComandiPro             * comandipro;

}


- (void) Passaprogettochiamante : (id) prog;

	// dlg info oggetto vettoriale
- (void)     ApriDlgInfoVet                 ;
- (IBAction) OKdlgInfoVet                   : (id)  sender;
- (void)     updatedlginfoVet               : (int) indice;
- (IBAction) upindiceinfoVet                : (id)  sender;
- (IBAction) downindiceinfoVet              : (id)  sender;


	// dlg info area
- (void)     ApriDlgInfoArea                ;
- (IBAction) OKdlgInfoArea                  : (id)  sender;
- (void)     updatedlginfoArea              : (int) indice;
- (IBAction) upindiceinfoArea               : (id)  sender;
- (IBAction) downindiceinfoArea             : (id)  sender;

	// dlg Griglia
- (IBAction) CambiaGriglia                  : (id)  sender;

	// dlg appunti
- (void)     ImpostaAppuntiTerrenoPRG       ;
- (IBAction) ApriDlgAppunti                 : (id)  sender;


- (IBAction) TogliRettangoloStampa          : (id)  sender; 

@end
