//
//  CtrEdiFiltro.h
//  MacOrMap
//
//  Created by Carlo Macor on 02/03/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Immobili.h"


@interface CtrEdiFiltro : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	
	IBOutlet NSTableView    * TavolaSubalterni;
	
	IBOutlet NSTableView    * TavFogli;
	IBOutlet NSTableView    * TavParticelle;
	IBOutlet NSTableView    * TavVie;
	IBOutlet NSTableView    * TavCategorie;
	IBOutlet NSTableView    * TavCivici;

	NSMutableArray          * ListaCtrSuber;
	NSMutableArray          * ListaCtrSuberFiltrata;

	NSMutableArray          * LstFogli;
	NSMutableArray          * LstPart;
	NSMutableArray          * LstVie;
	NSMutableArray          * LstCat;
	NSMutableArray          * LstCivici;

	
}

- (void)     impostaTuttiSubalterni : (Immobili  *) imb : (Immobili  *) imbFilt;

- (void)     inizTavole;

- (IBAction) ClickOnTable          : (id)sender;

- (IBAction) ResetTavole           : (id)sender;


@end
