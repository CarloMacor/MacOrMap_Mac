//
//  CtrTerFiltro.h
//  MacOrMap
//
//  Created by Carlo Macor on 04/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Immobili.h"


@interface CtrTerFiltro :NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView    * TavolaTerreni;
	
	IBOutlet NSTableView    * TavFogli;
	IBOutlet NSTableView    * TavParticelle;
	IBOutlet NSTableView    * TavQualita;
	IBOutlet NSTableView    * TavClasse;
	
	NSMutableArray          * ListaCtrTer;
	NSMutableArray          * ListaCtrTerFiltrata;
	
	NSMutableArray          * LstFogli;
	NSMutableArray          * LstPart;
	NSMutableArray          * LstQual;
	NSMutableArray          * LstClasse;
}


- (void)     impostaTuttiTerreni : (Immobili  *) imb : (Immobili  *) imbFilt;

- (void)     inizTavole;

- (IBAction) ClickOnTable          : (id)sender;

- (IBAction) ResetTavole           : (id)sender;


@end
