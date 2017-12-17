//
//  ComandiDlg.h
//  MacOrMap
//
//  Created by Carlo Macor on 11/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Raster.h"
#import "DisegnoR.h"
#import "Varbase.h"
#import "Progetto.h"
#import "Interface.h"

@interface ComandiDlg : NSObject {
	IBOutlet Varbase                * varbase;
	IBOutlet Progetto               * progetto;
    IBOutlet InfoObj                * info;
	IBOutlet Interface              * interface;
    
	IBOutlet NSTableView            * TavolaDisegni;
    IBOutlet NSTableView            * TavolaPiani;

	
}

- (void) initComandiDlg ;

- (IBAction) daDlgCorrenteRaster       : (id)sender;

- (IBAction) daDlgsetOnRaster          : (id)sender;

- (IBAction) daDlgAlphaRaster          : (id)sender;

- (IBAction) daDlgBWRaster             : (id)sender;

- (IBAction) daDlgTitoloRaster         : (id)sender;

- (IBAction) daDlgColoreRaster         : (id)sender;

- (IBAction) daDlgUpRaster             : (id)sender;

- (IBAction) daDlgDownRaster           : (id)sender;


- (void)     cambColRastutti :(NSColorPanel *) pancol;


    // Vettoriale
- (IBAction) cambioVisibilePiano       : (id)sender;

- (IBAction) cambioEditPiano           : (id)sender;

- (IBAction) cambioSnapPiano           : (id)sender;

- (IBAction) cambioAlphaLinePiano      : (id)sender;

- (IBAction) cambioAlphaLineDisegno    : (id)sender; 

- (IBAction) cambioAlphaSupPiano       : (id)sender;

- (IBAction) cambioAlphaSupDisegno     : (id)sender;

- (IBAction) cambioSpessorePiano       : (id)sender;

- (IBAction) cambiatratteggio          : (id)sender;

- (IBAction) cambiacampitura           : (id)sender;


- (IBAction) daDlgUpPiano              : (id)sender;

- (IBAction) daDlgDownPiano            : (id)sender;

- (IBAction) daDlgUpDisegno            : (id)sender;

- (IBAction) daDlgDownDisegno          : (id)sender;

- (IBAction) daDlgsetOnDisegno         : (id)sender;

- (IBAction) daDlgsetEditDisegno       : (id)sender;

- (IBAction) daDlgsetSnapDisegno       : (id)sender;

- (IBAction) daDlgCorrenteDisegno      : (id)sender;


- (void)     colorpianochangdlg        : (NSColorPanel *) pancol ;

- (IBAction) cambioColorePianoTavola   : (id)sender;



- (Raster *) rasterinoInd              : (int) ind ;

- (DisegnoR *) rasterDisInd            : (int) ind ;


@end
