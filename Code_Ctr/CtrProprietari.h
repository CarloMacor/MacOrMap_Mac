//
//  CtrProprietari.h
//  MacOrMap
//
//  Created by Carlo Macor on 14/10/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Proprietari.h"


@interface CtrProprietari  : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView             * TavolaProprietari;
	bool                             NomeCresce;
	bool                             CognomeCresce;
	bool                             LuogoCresce;
	bool                             DataCresce;
	bool                             CfisCresce;
	bool                             nrPropCresce;
	bool                             demoSensibili;

	bool                             filtroattivo;
	NSMutableArray                   * ListaProprietari;
	NSMutableArray                   * ListaProprietariFiltrata;

}

@property(nonatomic) bool	demoSensibili;


- (void)     passaListaproprietari  : (NSMutableArray *)  lista : (NSMutableArray *)  listaFiltrata ;

- (void)     AttivaFiltro        : (bool ) bol;

- (Proprietari *) subselezionato ;

- (void)      setPropselezionato : (Proprietari *) prop;


- (IBAction)     FondiProprietariStessoNome : (id)sender;


- (IBAction)     switcheditabiletavola : (id)sender;

- (void)     updaterighe ;
@end
