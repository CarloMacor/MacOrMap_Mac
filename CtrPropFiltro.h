//
//  CtrPropFiltro.h
//  MacOrMap
//
//  Created by Carlo Macor on 21/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Proprietari.h"


@interface CtrPropFiltro : NSViewController <NSTableViewDelegate, NSTableViewDataSource>  {
	IBOutlet NSTableView    * TavolaProprietari;
	IBOutlet NSTableView    * TavIniziali;
	NSMutableArray          * LstIniziali;
	NSMutableArray          * ListaProprietari;
	NSMutableArray          * ListaProprietariFiltrata;

}

- (void)     passaListaproprietari  : (NSMutableArray *)  lista : (NSMutableArray *)  listaFiltrata ;


- (IBAction) ClickOnTable          : (id)sender;

- (IBAction) ResetTavole           : (id)sender;


@end
