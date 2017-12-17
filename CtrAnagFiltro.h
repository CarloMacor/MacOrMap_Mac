//
//  CtrAnagFiltro.h
//  MacOrMap
//
//  Created by Carlo Macor on 15/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Anagrafe.h"


@interface CtrAnagFiltro : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             * TavolaAnagrafe;
	IBOutlet NSTableView             * TavolaComponentiFamiglia;

	
	IBOutlet NSTableView    * TavIniziali;
	IBOutlet NSTableView    * TavVie;
	IBOutlet NSTableView    * TavResOnoff;

	Anagrafe                * anagrafe;
	NSMutableArray          * LstIniziali;
	NSMutableArray          * LstVie;
	NSMutableArray          * LstOpzRes;

}

- (void)     passaAnagrafe  : (Anagrafe *)  an ;

- (IBAction) ClickOnTable          : (id)sender;
- (IBAction) ResetTavole           : (id)sender;


@end
