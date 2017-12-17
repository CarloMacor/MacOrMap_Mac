//
//  Control_Terreni.h
//  MacOrMap
//
//  Created by Carlo Macor on 02/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Immobili.h"


@interface CtrTer : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             * TavolaTerreni;
	IBOutlet NSButton                * ButFilta;

	NSMutableArray                   * ListaCtrTer;
	NSMutableArray                   * ListaCtrTerFiltrata;
	int                              correntevet;
	NSMutableArray                   * Listebacks;
    int                              correnteback;

	bool                             FgCresce;
	bool                             PartCresce;
	bool                             QlCresce;
	bool                             ClCresce;
	bool                             SupCresce;
	bool                             DomCresce;
	bool                             AgraCresce;

	bool                             filtroattivo;

}

- (void)     impostaTuttiTerreni    : (Immobili  *) imb  : (Immobili  *) imbFilt;

- (void)     AttivaFiltro           : (bool ) bol;

- (void)     ImpostaTerraFoglio     :(NSString *) nfoglio :(NSString *) nparticel;

- (void)     updaterighe;

- (void)     AttivaFiltro           : (bool ) bol;
- (void)     AttivaSoloFiltro       : (bool ) bol;

- (void)     preimpostaBackinLista;

- (IBAction)  BachingLista   : (id) sender  ;


- (Terreno *) subselezionato ;
- (NSArray *) SubSelezionati;

- (void)      setTerselezionato : (Terreno *) ter;


@end
