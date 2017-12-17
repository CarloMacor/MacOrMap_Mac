//
//  AzRaster.h
//  GIS2010
//
//  Created by Carlo Macor on 24/08/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Progetto.h"
#import "Varbase.h"
#import "Interface.h"
#import "AzDialogs.h"


@interface AzRaster : NSObject {
	IBOutlet Varbase       * varbase;
	IBOutlet Progetto      * progetto;
	IBOutlet InfoObj       * info;
	IBOutlet BarileDlg     * bariledlg;
	IBOutlet AzDialogs     * azdialogs;
    IBOutlet Interface     * interface;
	IBOutlet InterfaceWindow * interfacewindow;

	
		// dlg calibrazione
	IBOutlet NSTextField   *  txtX1rast;
	IBOutlet NSTextField   *  txtX2rast;
	IBOutlet NSTextField   *  txtY1rast;
	IBOutlet NSTextField   *  txtY2rast;
	
	IBOutlet NSTextField   *  txtFX1rast;
	IBOutlet NSTextField   *  txtFY1rast;
	IBOutlet NSSegmentedControl   *  Csegscafix;
	
	IBOutlet NSTextField   *  txtdimrighello;

	
}

- (void) InitAzRaster     ;

- (void) comandobottone    : (NSInteger) com ; 

- (IBAction) Apri_DlgRaster          : (id)sender;
- (IBAction) Chiudi_DlgRaster        : (id)sender;

- (int)     giapresenteImmagine     : (NSString * ) nomefile;

	// dlg cal raster
- (IBAction) openCalRaster           : (id)sender;
- (IBAction) OKCalibraRaster         : (id)sender;
- (IBAction) CancCalibraRaster       : (id)sender;
- (IBAction) comx1calras             : (id)sender;
- (IBAction) comx2calras             : (id)sender;
- (IBAction) comy1calras             : (id)sender;
- (IBAction) comy2calras             : (id)sender;

- (IBAction) openFCalRaster          : (id)sender;
- (IBAction) OKFCalibraRaster        : (id)sender;
- (IBAction) CancFCalibraRaster      : (id)sender;
- (IBAction) comFx1calras            : (id)sender;
- (IBAction) comFy1calras            : (id)sender;

- (IBAction) OKRighello              : (id)sender;
- (IBAction) CancRighello            : (id)sender;

- (IBAction) CancMancaPolTaglio      : (id)sender;
- (IBAction) OkMancaPolTaglio        : (id)sender;


	// Gruppo Raster
- (IBAction) AddRaster               : (id)sender;
- (IBAction) RemoveRaster            : (id)sender;
- (IBAction) UpVisRaster             : (id)sender;
- (IBAction) UpAlphaRaster           : (id)sender;

- (IBAction) UpMaskBackRaster        : (id)sender;

- (IBAction) CmoveRasterAll          : (id)sender;
- (IBAction) CmoveRaster2PtAll       : (id)sender;
- (IBAction) CRotoScal2PtCentrato    : (id)sender;



- (IBAction) CambioRasterdaPop       : (id)sender;


- (IBAction) OKdlgNuovaCoord                : (id)sender;
- (IBAction) CanceldlgNuovaCoord            : (id)sender;


- (IBAction) salvaCalibCorrente      : (id)sender;
- (IBAction) salvaCalibTutte         : (id)sender;
- (IBAction) salvaCalibTutteCaricate : (id)sender;


	// singolo Raster
- (IBAction) AddSubRaster            : (id)sender;
- (IBAction) RemoveSubRaster         : (id)sender;
- (IBAction) UpVisSubRaster          : (id)sender;  
- (IBAction) UpAlphaSubRaster        : (id)sender;

- (void)     CambioSubRaster         : (int)indice;

- (IBAction) CambioSubRasterdaPop    : (id)sender;
- (IBAction) CCropRaster             : (id)sender;
- (IBAction) CCropRectRaster         : (id)sender;
- (IBAction) CMaskRaster             : (id)sender;
- (IBAction) CCalibra8Pt             : (id)sender;
- (IBAction) CUnisciRasters          : (id)sender;


- (IBAction) CmoveRaster             : (id)sender;
- (IBAction) CmoveRaster2Pt          : (id)sender;
- (IBAction) CScalRasRig             : (id)sender;
- (IBAction) CRotScalRas             : (id)sender;
- (IBAction) RotateRaster0           : (id)sender;
- (IBAction) ScaleRaster1            : (id)sender;

	
	// Gruppo Raster fine
- (IBAction) CFixCentroRot           : (id)sender;
- (IBAction) CCentroRot              : (id)sender;
- (IBAction) CCentroScal             : (id)sender;
	// - (IBAction) SetmaxRotCen            : (id)sender;
	// - (IBAction) SetmaxScaCen            : (id)sender;

- (IBAction) RSetMinMaxRotCen        : (id)sender;
- (IBAction) RSet0RotCen             : (id)sender;
- (IBAction) RSetscalCambioMod       : (id)sender;



- (IBAction) TarquiniaPRG            : (id)sender;
- (IBAction) TarquiniaPRGPart        : (id)sender;
- (IBAction) orbetelloDemo           : (id)sender;
- (IBAction) orbetelloDemo2          : (id)sender;
- (IBAction) orbetelloDemo3          : (id)sender;
- (IBAction) orbetelloDemo4          : (id)sender;


- (IBAction) LaDispoliDemo           : (id)sender;
- (IBAction) CivitavecchiaPRG        : (id)sender;
- (IBAction) CivitavecchiaPRG69      : (id)sender;

- (IBAction) LaDispoliPaesagistico   : (id) sender ;
- (IBAction) CerveteriPaesagistico   : (id) sender ;
- (IBAction) TarquiniaPaesagistico   : (id) sender ;

- (IBAction) ViterboPaesA            : (id)sender;
- (IBAction) ViterboPaesB            : (id)sender;
- (IBAction) ViterboPaesC            : (id)sender;
- (IBAction) ViterboPaesD            : (id)sender;

- (IBAction) ViterboPRGQU            : (id)sender;


- (IBAction) BottoneComune_01R       : (id)sender;
- (IBAction) BottoneComune_02R       : (id)sender;
- (IBAction) BottoneComune_03R       : (id)sender;
- (IBAction) BottoneComune_04R       : (id)sender;
- (IBAction) BottoneComune_05R       : (id)sender;
- (IBAction) BottoneComune_06R       : (id)sender;
- (IBAction) BottoneComune_07R       : (id)sender;
- (IBAction) BottoneComune_08R       : (id)sender;
- (IBAction) BottoneComune_09R       : (id)sender;
- (IBAction) BottoneComune_10R       : (id)sender;
- (IBAction) BottoneComune_11R       : (id)sender;
- (IBAction) BottoneComune_12R       : (id)sender;
- (IBAction) BottoneComune_13R       : (id)sender;
- (IBAction) BottoneComune_14R       : (id)sender;



- (IBAction) BotLegComune_01R       : (id)sender;
- (IBAction) BotLegComune_02R       : (id)sender;
- (IBAction) BotLegComune_03R       : (id)sender;
- (IBAction) BotLegComune_04R       : (id)sender;
- (IBAction) BotLegComune_05R       : (id)sender;
- (IBAction) BotLegComune_06R       : (id)sender;
- (IBAction) BotLegComune_07R       : (id)sender;
- (IBAction) BotLegComune_08R       : (id)sender;
- (IBAction) BotLegComune_09R       : (id)sender;
- (IBAction) BotLegComune_10R       : (id)sender;
- (IBAction) BotLegComune_11R       : (id)sender;

@end
