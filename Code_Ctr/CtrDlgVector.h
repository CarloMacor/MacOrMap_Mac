//
//  Control_dlgVector.h
//  GIS2010
//
//  Created by Carlo Macor on 24/05/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DisegnoV.h"


@interface CtrDlgVector : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             *TavolaDisegni;
	IBOutlet NSTableView             *TavolaPiani;

	IBOutlet NSScrollView            *_scrollview;
	IBOutlet NSPanel                 *_dlgNomePiano;
	IBOutlet NSTextField             *FieldTestoPiano;
	NSMutableArray                   *CopiaListaDisegni;
	DisegnoV                         *Disvetcorrente;
	int                              correntevet;
		// dall adialog piano	
	IBOutlet NSSlider                *slidedimpunto;
	IBOutlet NSButton                *butvttutti;
	IBOutlet NSButton                *butvtfinali;
	IBOutlet NSComboBox              *comboTratti;
}



- (void)     passaListavector        : (NSMutableArray *)  _vectorList ;
- (void)     updaterighe;

- (void)     setdisegnoCorrente      : (DisegnoV *)  mydisvector;
- (void)     aggiorna                : (int) _corrente;

- (void)     setrowpianocorrente     : (int) indice;


- (IBAction) MostraDialogPiano       : (id)sender;

- (IBAction) OKNomePiano             : (id)sender;
- (IBAction) CancelNomePiano         : (id)sender;






- (IBAction) cambioEditiabilePiano : (id)sender;
- (IBAction) cambioSnappabilePiano : (id)sender;

	// dalla dialog del piano
	// - (IBAction) setdimpt

- (IBAction) eliminapianodeldisegno  : (id)  sender;

- (IBAction) setpallitutti           : (id)  sender;

- (IBAction) setpallifinale          : (id)  sender;

- (int)      pianoDlgSelezionato                   ;

- (int)      DisegnoDlgSelezionato                 ;

- (void)     cambiaselezionatopiano  : (int) passo ;

- (void)     cambiaselezionatodisegno  : (int) passo ;




@end
